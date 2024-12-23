# README

## 1. Download the repo

Use the GitHub provided links to download the repo.

## 2. Install Ruby

The Rails app requires Ruby 3.0.0 or newer. To check which version you have installed, use:

```shell
ruby -v
```

Up-to-date instructions for installing the latest version of Ruby on any operating system are available at [ruby-lang.org](https://www.ruby-lang.org/en/documentation/installation/).

## 3. Install Node.js and Yarn

The Rails app also requires Node.js 14 or newer and Yarn. To check which versions you have installed, use:

```shell
node -v
yarn -v
```

If you're on a Mac and already using the Homebrew package manager, you can install the latest versions of Node.js and Yarn using:

```rb
brew install node yarn
```

Otherwise you can download a [pre-built Node.js installer](https://nodejs.org/en/download/) and [install Yarn](https://yarnpkg.com/lang/en/docs/install) on any platform.

## 4. Install and Start Redis

Hotwire uses [Action Cable](https://guides.rubyonrails.org/action_cable_overview.html) under the hood to broadcast real-time updates over WebSockets. And by default, Action Cable is configured to use [Redis](https://redis.io) as the publish/subscribe server.

Now, the starter app doesn't include real-time features so Redis isn't required to run the starter app. However, you'll need to have a Redis server running on your computer when we get to the broadcasting modules of the course. So we recommend setting up Redis now so it's not something you need to remember to do later. 😀

If you're on a **Mac** and using the Homebrew package manager, you can install and start the Redis server like so:

```shell
brew install redis
brew services restart redis
```

For **Linux** users, this should do the trick:

```shell
sudo apt-get install redis-server
sudo service redis-server restart
```

**Windows** users will need to install and start the Redis server in a Linux environment using the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about). Run the following commands in a Linux terminal:

```shell
sudo apt-add-repository ppa:redislabs/redis
sudo apt-get install redis-server
sudo service redis-server restart
```

## 5. Fire Up the Starter App

In the next video we'll walk through the pages of the starter app, so go ahead and get it running:

* First, change into the `starter-app/fishing` directory and setup the app:

```shell
cd /fishing

ruby bin/setup
```

* And now you're ready to start the Rails server.

* On **Mac/Linux** you can run the following command which uses [foreman](https://github.com/ddollar/foreman) to start the server and rebuild the JS bundle when necessary:

```shell
./bin/dev
```

* On **Windows** you'll need to run the following commands in two separate Terminal sessions:

```shell
rails server -p 3000
```

```shell
yarn build:css
yarn build --watch
```

* Then if you browse to [http://localhost:3000](http://localhost:3000) you should see all the baits. 🎣

* If you'd prefer to run the app in a Docker container, we have [Docker files](https://online.pragmaticstudio.com/courses/hotwire/extras/docker) to make that easy.
