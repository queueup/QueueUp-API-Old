[[https://github.com/queueup/queueup-api/blob/master/docs/img/logo.png|alt=logo]]

[![Build Status](https://travis-ci.org/queueup/QueueUp-API.svg)](https://travis-ci.org/queueup/QueueUp-API) [![Maintainability](https://api.codeclimate.com/v1/badges/d1f2aab9042eb543b61a/maintainability)](https://codeclimate.com/github/queueup/QueueUp-API/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/d1f2aab9042eb543b61a/test_coverage)](https://codeclimate.com/github/queueup/QueueUp-API/test_coverage) [![Discord](https://img.shields.io/discord/374509692950544387.svg)](http://discord.gg/Zk2fsnN)

QueueUp is a mobile application created to help League of Legends players finding teammates. It's not about replacing Riot matchmaking, but more about
giving people the opportunity to play with people they will enjoy playing with. Users should be able to find other players to have fun and/or rank up.

League of Legends data is great, but it isn't enough to determine a player's profile. As an example, your most played champions are not always your favorites,
that's why we want our users to be able to change their champion pool whenever they want so they can find teammates aware of what they really want to play.

This project is the core of QueueUp. It handles the communication between the different clients and the database. It's working with Ruby on Rails

# Contributing

We love pull requests! In fact, that's the reason we open-sourced the project.

## Requirements

You will need an account on:

- [Riot Games Developers](https://developer.riotgames.com/) for League of Legends API usage
- [OneSignal](https://onesignal.com/) for push notifications
- [Pusher](https://pusher.com/) for websockets management
- [Sentry](https://sentry.io/welcome/) (optional) for bug reporting

You will need:

- [Ruby](https://www.ruby-lang.org/en/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Getting started

- Fork the repository and clone it locally.
- Copy `.env.example` into `.env` and update the different credentials
- Install packages: `bundle install`
- Start the database with docker-compose: `docker-compose up`
- Start Rails server: `rails server`
- Running unit tests: `bundle exec rspec`

If you have troubles starting the project, feel free to [open an issue](https://github.com/queueup/QueueUp-API/issues/new)

## Submitting a pull request

Please explain what is the pull request, and write unit tests when the feature needs it. We know our codebase isn't unit tested yet, but we will be working on it really soon.

# License

Copyright (c) 2017 QueueUp

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
