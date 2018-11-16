VERSION=0.1.1
NAME="enerbot"

API="SLACK_API_TOKEN=xoxb-"
ADMINS="SLACK_ADMINS="
CHANNELS="SLACK_CHANNELS="

build:
	docker build -t $(NAME):$(VERSION) .
	docker tag $(NAME):$(VERSION) $(NAME):latest

run:
	@docker rm -fv enerbot
	@docker run -d -it \
	 		-e $(API) \
	 		-e $(ADMINS) \
	 		-e $(CHANNELS) \
	 		--name=$(NAME) $(NAME):latest

clean:
	docker rm -fv enerbot
	docker rmi -f $(NAME):$(VERSION)
	docker rmi -f $(NAME):latest