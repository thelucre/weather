# Setup router
import Vue from 'vue'
import VueRouter from 'vue-router'
Vue.use VueRouter

###
Routing paths
`/`           - (home) app index
`/:location`  - (location) weather detail for a specific location
###
routes = [
  {
    name: 'home'
    path: '/'
    component: require '../components/template'
    children: [
      {
        name: 'location'
        path: ':slug'
        component: require '../components/weather-detail'
        props: true
      }
    ]
  }
]

export default new VueRouter routes: routes
