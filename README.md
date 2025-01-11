# Weather Forecast Application

Weather forecasts using the WeatherAPI.com service.

Data Model Design: https://drive.google.com/file/d/1W8dUIUVQKnxtsQeSqzflGYeU3jauOvUU/view?usp=sharing

## Features

- Real-time weather data fetching
- Support for multiple US zip codes
- Display of current temperature, high/low temperatures, and weather conditions
- Docker-based development environment

## Prerequisites

- Ruby 3.1.0
- SQLite3
- Rails 7.2
- Regular Rails Dev setup or Docker Dev setup

##credentials - provided to Matthew Morales
- RAILS_MASTER_KEY=your_master_key_here 

### Standard Setup

1. Install Ruby dependencies:
- bundle install

2. Start the Rails server:
- rails db:prepare
- rails dev:cache - enables caching in memory cache store
- rails server

3. Run tests:
- bundle exec rspec

The application will be available at `http://localhost:3000`


### Docker Development Setup

1. Build and start the containers:
- docker-compose build
- docker-compose up

2. Run tests:
- docker-compose run test

The application will be available at `http://localhost:3000`

