build:
	@gem build enerbot.gemspec
	@gem install enerbot-1.0.gem


run: build
	ruby $(CURDIR)/bin/bot.rb