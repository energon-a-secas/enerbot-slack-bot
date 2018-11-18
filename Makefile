VERSION=0.1.1
NAME="enerbot"

API="SLACK_API_TOKEN=xoxb-"
ADMINS="SLACK_ADMINS="
CHANNELS="SLACK_CHANNELS="

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
	@/bin/echo -n "[ENERGON] Running $(NAME):latest"
	@docker rm -fv enerbot
	@docker run -d -it \
	 		-e $(API) \
	 		-e $(ADMINS) \
	 		-e $(CHANNELS) \
	 		--name=$(NAME) $(NAME):latest

unit-test: init
	@/bin/echo -n "[ENERGON] Running tests"
	@rspec --color spec/