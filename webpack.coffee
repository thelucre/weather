###
This file exports the webpack configuration object.  It is designed to be
imported into the app's webpack.config.coffee where it can be hacked if changes
are needed.
###

# Inspect how webpack is being run
minify = '-p' in process.argv # Compiling for production
hmr = '--hot' in process.argv # "Hot module replacement" / using webpack-dev-server

# Get the port number after the `--port` flag, if it exists, to serve HMR assets
port = 8080 # webpack dev server default
port = process.argv[process.argv.indexOf('--port')+1] if '--port' in process.argv

# Dependencies
_                 = require 'lodash'
webpack           = require 'webpack'
autoprefixer      = require 'autoprefixer'
moment            = require 'moment'
ExtractText       = require 'extract-text-webpack-plugin'
Notify            = require 'webpack-notifier'
HtmlWebpackPlugin = require 'html-webpack-plugin'
AssetsPlugin      = require 'assets-webpack-plugin'
DashboardPlugin   = require 'webpack-dashboard/plugin'

# Read .env file
require('dotenv').config()

# ##############################################################################
# Setup - General config
# ##############################################################################
config =

  # Generate source maps.  If using HMR, the sourcemap can be cheaper (less
  # CPU required) and should be inline.  Othwerise, generate external, full
  # sourcemaps.
  devtool: if hmr then 'inline-cheap-module-eval-source-map' else 'source-map'

  # Set the dir to look for entry files
  context: "#{process.cwd()}/assets"

  # Build one bundle for public site and one for admin. If additional front end
  # entry points are added, consider using CommonsChunkPlugin to move shared
  # dependencies out.
  entry:
    app: './boot.coffee'

  # Save the entry points to the public/dist directory.  And give any chunks
  # hashed names when minifying so they can be long term cashed.  The entry
  # JS doesn't need this as it gets unique URLs via PHP.
  output:
    path:          "#{process.cwd()}/dist"
    publicPath:    if hmr then 'http://localhost:'+port+'/dist/' else '/dist/'
    filename:      '[name].js'
    chunkFilename: '[id].js'

  # Setup properties that are set later (With less indentation)
  module: {}

  # Configure what shows up in the terminal output
  stats:
    children:     false # Hides the "extract-text-webpack-plugin" messages
    assets:       true
    colors:       true
    version:      false
    hash:         false
    timings:      true
    chunks:       false
    chunkModules: false

# ##############################################################################
# Resolve - Where to find files
# ##############################################################################
config.resolve =

  # Look for modules in the vendor directory as well as npm's directory.  The
  # vendor directory is used for third party modules that are committed to the
  # repo, like things that can't be installed via npm.  For example, Modernizr.
  modules: [config.context, 'node_modules']

  # Add coffee to the list of optional extensions
  extensions: ['.js', '.coffee', '.vue', '.styl']

  # Aliases for common libraries
  alias:
    velocity: 'velocity-animate'
    underscore: 'lodash'
    vue: 'vue/dist/vue'

# ##############################################################################
# Loaders - File transmogrifying
# ##############################################################################
config.module.loaders = [

  # Coffeescript #
  { test: /\.coffee$/, loader: 'coffee-loader' }

  # Jade #
  # Jade-loader reutrns a function. Apply-loader executes the function so we
  # get a string back.
  { test: /\.jade$/, loader: 'apply-loader!jade-loader' }

  # Haml #
  { test: /\.haml$/, loader: 'haml-loader' }

  # HTML #
  { test: /\.html$/, loader: 'html-loader' }

  # Fonts #
  # Not using the url-loader because serving multiple formats of a font would
  # mean inlining multiple formats that are unncessary for a given user.
  {
    test: /\.(eot|ttf|woff|woff2)$/
    loader: 'file-loader?name=fonts/[hash:8].[ext]'
  }

  # JSON #
  { test: /\.json$/, loader: 'json-loader' }

  # CSS #
  {
    test: /\.css$/
    loader:
      if hmr
      then 'style-loader!css-loader?-autoprefixer'
      else ExtractText.extract 'css-loader?-autoprefixer'
  }

  # Stylus #
  # This also uses the ExtractText to generate a new CSS file, rather
  # than writing script tags to the DOM. This was required to get the CSS
  # sourcemaps exporting dependably. Note the "postcss" loader, that is
  # adding autoprefixer in.
  {
    test: /\.styl$/
    loader:
      if hmr
      then [
        'style-loader'
        'css-loader?sourceMap&-autoprefixer'
        'postcss-loader'
        'stylus-loader?sourceMap'
        'prepend-string-loader?string[]=@require "~definitions.styl";'
        ].join('!')
      else ExtractText.extract use: [
        'css-loader?sourceMap'
        'postcss-loader'
        'stylus-loader?sourceMap'
        'prepend-string-loader?string[]=@require "~definitions.styl";'
      ]
  }

  # Sass #
  # Including sass for Decoy support
  {
    test: /\.scss$/
    loader:
      if hmr
      then [
        'style-loader'
        'css-loader?sourceMap&-autoprefixer'
        'postcss-loader'
        'sass-loader?sourceMap'
        'import-glob-loader'
        ].join('!')
      else ExtractText.extract use: [
        'css-loader?sourceMap'
        'postcss-loader'
        'sass-loader?sourceMap'
        'import-glob-loader'
      ]
  }

  # jQuery plugins #
  # Make sure jQuery is loaded before Velocity
  {
    test: /(velocity)\.js$/,
    loader: 'imports-loader?$=jquery'
  }

  # Vue #
  {
    test: /\.vue$/
    loader: 'vue-loader'
    options:

      loaders:

        # Support the css precompilers being explicitly defined.  This should be
        # identical to the webpack loaders EXCEPT with postcss removed, because
        # the Vue loader is doing that automatically.  Also, the prepending needs
        # to be explicity done here because there is no matching test on filetype.
        # https://github.com/hedefalk/atom-vue/issues/5
        stylus:
          if hmr
          then [
              'style-loader'
              'css-loader?sourceMap&-autoprefixer'
              'stylus-loader?sourceMap'
              'prepend-string-loader?string[]=@require "~definitions.styl";'
            ].join('!')
          else ExtractText.extract use: [
            'css-loader?sourceMap&-autoprefixer'
            'stylus-loader?sourceMap'
            'prepend-string-loader?string[]=@require "~definitions.styl";'
          ]
  }
]


# ############################################################################
# Plugins - Register extra functionality
# ############################################################################
config.plugins = [

  # Required config for ExtractText to tell it what to name css files. Setting
  # "allChunks" so that CSS referenced in chunked code splits still show up
  # in here. Otherwise, we would need webpack to DOM insert the styles on
  # which doesn't play nice with sourcemaps.
  new ExtractText
    filename: (if minify then '[name].[hash:8].css' else '[name].css')
    allChunks: true

  # Show growl style notifications if not running via HMR. Wit HMR, page updates
  # automatically, so don't need to watch for compile be done.
  new Notify alwaysNotify: !hmr

  # Add add a lil note to the js build
  new webpack.BannerPlugin "📝 Made for Unity3D by Eric Howard 💾 #{moment().format('M.D.YY')} 👍"

  # Empty the build directory whenever webpack starts up, but doesn't run on
  # watch updates.  Has the added benefit of clearing out the dist directory
  # when running the dev server.
  # new Clean ['public/dist'], { root: process.cwd() }

  # Output JSON config if the compiled files which is parsed by Laravel to
  # create script and link tags.
  new AssetsPlugin
    filename:    'manifest.json'
    path:        config.output.path
    prettyPrint: true

  # Provide common utils to all modules so they don't need to be expliclity
  # required.
  new webpack.ProvidePlugin
    $:         'jquery'
    jquery:    'jquery'
    _:         'lodash'
    Modernizr: 'modernizr'
    Velocity:  'velocity'

  # Inject the asset build sources into static pages
  new HtmlWebpackPlugin
    template: 'index.ejs'
    filename: '../index.html'

  # Make a nice webpack console while developing
  new DashboardPlugin

  new webpack.DefinePlugin
    OPENWEATHER_KEY: JSON.stringify(process.env.OPENWEATHER_KEY || "{{YOUR_OPENWEATHER_KEY}}")
]

# Minify only (`webpack -p`) plugins.
if minify then config.plugins = config.plugins.concat [

  # Turn off warnings during minifcation.  They aren't particularly helpfull.
  new webpack.optimize.UglifyJsPlugin compress: warnings: false

  # Make small ids
  new webpack.optimize.OccurenceOrderPlugin()

  # Try and remove duplicate modules
  new webpack.optimize.DedupePlugin()
]

# ##############################################################################
# Export
# ##############################################################################
module.exports = config
