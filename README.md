## Hi, We are FoodRescue

This is on an MIT license

This application helps people with surplus food determine how to dispose of it in accordance
with Act 148 (Vermont's Universal Recycling Law).

## Trello Board

https://trello.com/b/auY5UpJN/food-shelf-connect-act-148-food-donation-and-education-app-for-the-vermont-foodbank

## Developer Setup

### Install ruby and rails

ubuntu:

```shell
sudo apt-get install autoconf automake bison build-essential curl git-core libapr1 libaprutil1 libc6-dev libltdl-dev libreadline6 libreadline6-dev libsqlite3-0 libsqlite3-dev libssl-dev libtool libxml2-dev libxslt-dev libxslt1-dev libyaml-dev ncurses-dev openssl sqlite3 zlib1g zlib1g-dev
curl -L get.rvm.io | bash -s stable
rvm install 2.1
rvm use 2.1
gem install rails
```

### run the app

```shell
cd foodrescue
bundle install
rails s
```

then `open http://localhost:3000`

