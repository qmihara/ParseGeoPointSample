ParseGeoPointSample
===================

Requirements
------------

- [Parse.com](https://parse.com)
  - Application ID
  - Client Key
  - REST API KEY
- Station data
  - [駅データ.jp](http://www.ekidata.jp)

Setup
-----

```
$ pod install
$ cp Station/QMConstants.m.base Station/QMConstants.m

$ cd script
$ bundle install
$ cp dot.env .env
$ vi .env
$ bundle exec ruby import.rb {CSV_FILE_PATH}
```
