ENERBOT-RUBY
========

It's based on the bototo3000, but using the Slack Ruby Client and Ruby instead of Python. Is design for small talks and remote commands over SSH.

He also likes to put music 'recanchera' and give advices when you need them. 

## Install
It's just this:
```
cd enerbot
bundle install
```

You need to configure the Slack token for Enerbot and then exported as a environment variable:
```
export SLACK_API_TOKEN=
```

## SSH
You have to export your credentials to connect over SSH. We highly recommend connect Enerbot to a bastion host and do whatever you want from there.
```
export HOST=
export USER=
export PASS=
```

Add Enerbot to a channel and then 
```
ADMINS = %w[ABCDEFG1 ABCDE123].freeze
CHANNEL = %w[ASD123ASD ASD123123].freeze
```


## Other commands

Good luck

## Amazing bots

* [Huemul](https://github.com/devschile/huemul)