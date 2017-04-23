###
Global App Config
###
module.exports =

  # Schema for user-defined preferences
  settings:
    units: 'imperial'

  # Local storage settings
  cache:
    # Key for reading/writing to local storage
    key: 'weather-locations'

    # Refresh period for caching updates
    # If weather data for a given unit system is younger than this time
    # the cache will be used
    period: 2*60 # 2 minutes

    # Key for saving the userunits preference
    settings: 'weather-settings'

  # OpenWeather API settings
  api:
    root: 'http://api.openweathermap.org/data/2.5/'
    key: OPENWEATHER_KEY # pulled in from .env file at root during webpack build

  # Default Unity office locations
  locations: [
    { label: 'San Francisco', slug: 'san-francisco' }
    { label: 'Seattle', slug: 'seattle' }
    { label: 'Vancouver', slug: 'vancouver' }
    { label: 'Austin', slug: 'austin' }
    { label: 'Montreal', slug: 'montreal' }
    { label: 'Pereira', slug: 'pereira' }
    { label: 'Seoul', slug: 'seoul' }
    { label: 'Shanghai', slug: 'shanghai' }
    { label: 'Singapore', slug: 'singapore' }
    { label: 'Tokyo', slug: 'tokyo' }
    { label: 'Brighton', slug: 'brighton' }
    { label: 'Bristol', slug: 'bristol' }
    { label: 'Stratford-upon-Avon', slug: 'stratford-upon-avon' }
    { label: 'London', slug: 'london' }
    { label: 'Grenoble', slug: 'grenoble' }
    { label: 'Copenhagen', slug: 'copenhagen' }
    { label: 'Berlin', slug: 'berlin' }
    { label: 'Moscow', slug: 'moscow' }
    { label: 'Helsinki', slug: 'helsinki' }
    { label: 'Kaunas', slug: 'kaunas' }
    { label: 'Odessa', slug: 'odessa' }
    { label: 'Paris', slug: 'paris' }
    { label: 'Stockholm', slug: 'stockholm' }
    { label: 'Vilnius', slug: 'vilnius' }
  ]
