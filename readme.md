# Weather system

## Getting started
- Run `yarn` to install dependencies
- Copy `example.env` to `.env` and add your OpenWeather API key
- Setup a virtual host to serve the dev build, something like `weather.dev` pointing to the root
- Run `yarn dev` to kick off hot module reloading of assets
- Go to `weather.dev` and play around

## Features
- OpenWeather API integration
- Local Storage caching of API requests, with an configurable update time
- Weather information for the main Unity offices, including:
    - Daylight hour meter
    - Current, high, and low temperature  
    - Wind speed and direction
    - Current barometric pressure and humidity
- Toggle between imperial and metric units
