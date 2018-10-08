VERSION=0.1.1
NAME="enerbot"
SLACK_API=""
SLACK_ADMINS=""
SLACK_CHANNELS=""

build:
	docker build -t $(NAME):$(VERSION) .
	docker tag $(NAME):$(VERSION) $(NAME):latest

run:
	docker rm -fv enerbot
	docker run -e $(SLACK_API) -e $(SLACK_ADMINS) -e $(SLACK_CHANNELS) --name=$(NAME) $(NAME):latest

clean:
	docker rm -fv enerbot
	docker rmi -f $(NAME):$(VERSION)
	docker rmi -f $(NAME):latest