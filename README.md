ENERBOT-RUBY
========
- Website: https://www.energon.cloud
- ![This software is Blessed](https://img.shields.io/badge/blessed-100%25-770493.svg)

It's based on the bototo3000, but using the Slack Ruby Client and Ruby instead of Python. Is design for small talks and remote commands over SSH.

He also likes cubes. 

## Development 

At EnergonLabs we love using the square development model, separating the main functionalities in four elements:

* enerbot: powered by enercore.
* enerssh: it's the only functionality that tries to help with something. 
* enersay: say what you feel, behind an app, like always.
* enershut: we build this feature because sometimes it gains consiousness and very often even learns to love.

Each one of this, must be the begin of the like, because yeah, why not. 

This method let us isolate the core functions in the `core.rb` file, where we put the ugly stuff that does the magic for our needs.

## Getting started

### Prerequisites

* Install [Ruby](https://www.ruby-lang.org/es/documentation/installation/). If you want to, off course.
* Install [Bundler](https://bundler.io) to get all dependencies or you could stay in the dependency abyss by installing each dependency manually. It's your choice.


### Installing
Download the repository.
```
git clone https://github.com/energonrocks/enerbot.git
```

Inside of the enerbot repository use bundler.
```
cd enerbot
bundler install
```

### Configuring

You need to export the following parameters as environment variables:
 * SLACK_API_TOKEN: it lets you connect the bot with de Slack space.
 * BOT_ADMINS: list of users that can access to features like 'enershut' or 'enersay'
 * BOT_CHANNELS: list of authorized channels where your bot can be consulted.
```
export SLACK_API_TOKEN=YOUR-TOKEN-XX-XX-XXX
export BOT_ADMINS=XXXXXX,XXXXXX,XXXXXX
export BOT_CHANNELS=XXXXXX,XXXXXX,XXXXXX
```

This prevents people using your bot to access machines with your credentials, if you have the SSH Feature enabled.

And just run it with:
```
ruby client.rb
```

## Easter Eggs


### Responses

He can response most of the time.

### Modules

A module is like a square and modules form cubes. In order to add new squares, just put your own Ruby gem or script as a method, then add it to the core... of the cube.

### Logs

Because he is 'reading' everything, just the output of responses are shown through console. It's something like this:
```
channel=XXXXXX, client_msg_id=XXXXXXX-XXXX, event_ts=XXXXXX.XXXX, team=XXXXXX, text=enerbot hola, ts=XXXXXX.XXXX, type=message, user=XXXXXX
```

This is helpful when you are wondering where "everything collapsed".

### Testing 

We want to, we are trying. Currently we can force the testing of cases in a specified channel, it's hilarious.

### Docker

Run a container with enerbot just to be popular.

```
docker build -t enerbot .
docker run -e SLACK_API="YOUR-TOKEN-XX-XX-XXX" -e SLACK_ADMINS="XXXXXX" -e SLACK_CHANNELS="XXXXXX" --name="enerbot" enerbot
```

Alternative you can just put your credentials on the makefile and the run `make deploy`


### SSH

Is intended to execute define commands in a remote host or a bastion, still in beta.
```
export HOST_SSH=XXXXXX
export USER_SSH=XXXXXX
export PASS_SSH=XXXXXX
```

How to execute a remote command:
```
enerssh bot YOUR_COMMAND
```

## Contributing :heart: 

If you have any doubts or you want to see a new feature, please feel free to contact us by open an issue.

## License

See the [LICENSE](LICENSE) file for license rights and limitations (MIT).
