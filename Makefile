VERSION=0.1.1
NAME="enerbot"

API="SLACK_API_TOKEN=xoxb-"
BOT_NAME="SLACK_NAME=ENERDOCKER"
ICON="SLACK_ICON=https://raw.githubusercontent.com/energonrocks/enerbot-slack/master/emojis/enerbot_party.png"
ADMINS="SLACK_USERS="
CHANNELS="SLACK_CHANNELS="
LOG="SLACK_LOG_CHANNEL="

build:
	@/bin/echo -n "[ENERGON] Building image for $(NAME):$(VERSION)"
	@docker build -t $(NAME):$(VERSION) .
	@docker tag $(NAME):$(VERSION) $(NAME):latest

clean:
	@docker rm -fv enerbot
	@docker rmi -f $(NAME):$(VERSION)
	@docker rmi -f $(NAME):latest

init:
	@bundle check

rubocop: init
	@/bin/echo -n "[ENERGON] Running Rubocop"
	@rubocop -a .

run:
	@/bin/echo -n "[ENERGON] Running $(BOT_NAME):latest"
	@docker rm -fv $(NAME)
	@docker run -d -it \
	 		-e $(API) \
	 		-e $(BOT_NAME) \
	 		-e $(ICON) \
	 		-e $(ADMINS) \
	 		-e $(CHANNELS) \
	 		-e $(LOG) \
	 		--name=$(NAME) $(NAME):latest

unit: init
	@/bin/echo -n "[ENERGON] Running tests"
	@rspec --color spec/