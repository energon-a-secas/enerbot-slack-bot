ENERBOT-RUBY
========
- Website: https://www.energon.cloud
- ![This software is Blessed](https://img.shields.io/badge/blessed-100%25-770493.svg)

It's based on the bototo3000, but using the Slack Ruby Client and Ruby instead of Python. Is design for small talks and remote commands over SSH.

He also likes cubes. 

## Install
To get all dependencys you need to install [Bundler](https://bundler.io) (or stay in the dependency hell). Then under the enerbot directory execute:
```
bundler install
```

You need to configure the Slack token for Enerbot and then exported as a environment variable:
```
export SLACK_API_TOKEN=YOUR-TOKEN-03-03-456
```
And run it!
```
ruby client.rb
```

This bot will output everything for default. If you don't want this, remove the `puts data` from the `client.rb`

## SSH
We currently are not supporting the SSH feature. Stay tune for more news.

## Amazing bots

* [Huemul](https://github.com/devschile/huemul)
