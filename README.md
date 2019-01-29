ENERBOT (Slack Slave) <img align="right" width="100" height="100" src="emojis/enerbot.png">
========
- Website: https://www.energon.cloud

![This software is Blessed](https://img.shields.io/badge/blessed-100%25-770493.svg) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/91233140cec64adfb067adc959db3826)](https://www.codacy.com/app/LucianoAdonis/enerbot-slack?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=energonrocks/enerbot-slack&amp;utm_campaign=Badge_Grade)

Based on the bototo3000, a strong independent bot that is written on Ruby and only uses the Slack Ruby Client to look cooler. Is design for small talks and AGILE teams.

He likes cubes. 

Development
---

Main functionalities:

  - enerbot: the bot.
  - enersay: be surprise by the miracle of Machile Learning.
  - enershut: we build this feature because sometimes it gains consiousness and very often even learns to love.

Getting started
---

Prerequisites
---------

A computer.

  - Install [Ruby](https://www.ruby-lang.org/es/documentation/installation/).
  - Install [Ruby Version Management](https://rvm.io/rvm/install). RVM lets you easily work with multiple versions of Ruby. 
  - Install [Bundler](https://bundler.io) to get all dependencies or you could stay in the dependency abyss by installing each dependency manually. It's your choice.

We highly recommend you to use the Ruby 2.5.1 version because it works on our machines. You can check your current version with:

```
ruby --version
```

Setting a new version with [RVM](https://rvm.io/rvm/basics) its just executing:

```
rvm install 2.5.1
rvm use 2.5.1
```

Installing
---------

Download the repository.
```
git clone https://github.com/energon-a-secas/enerbot-slack.git
```

To get all dependencies of the enerbot execute use `bundler install` inside of the repository.


Optional step
---------

You can take all the magic of ENERGON to your current Slack space by importing our beloved crafted custom [emojis](emojis/), and be the coolest kid in the hood. Please, refer to [Add custom emoji](https://get.slack.help/hc/en-us/articles/206870177-Add-custom-emoji).

Configuring
---------

You need to export the following parameters as environment variables:
  - SLACK_API_TOKEN: it lets you connect the bot with de Slack space.
  - SLACK_LOG_CHANNEL: this will be the channel where all your confidential (or mostly boring) logs ends up.
  - SLACK_USERS: list of users that can access to features like 'enershut' or 'enersay'
  - SLACK_CHANNELS: list of authorized channels where your bot can be consulted.
  - SLACK_ICON: set a custom image for the bot.
  - SLACK_NAME: set a custom name fot the bot.

Running the Enerbot
---------

Do this:
```
ruby client.rb
```

Docker
---------

Run Enerbot inside of a container just to be popular.

```
docker build -t enerbot .
docker run -e SLACK_API="YOUR-TOKEN-XX-XX-XXX" -e SLACK_ADMINS="XXXXXX" -e SLACK_CHANNELS="XXXXXX" -e SLACK_LOG_CHANNEL="XXXXXX" --name="enerbot" enerbot
```

Alternative you can just put your credentials on the makefile and the run `make deploy`

Contributing :heart:
---------

If you have any doubts or you want to see a new feature, please feel free to contact us by open an issue.

License
---------

See the [LICENSE](LICENSE) file for license rights and limitations (MIT).
