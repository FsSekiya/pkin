
deploy:
	bundle exec rubocop -a
	git add .
	git commit -m "add: contents `date`"
	git push origin

.PHONY: lint
lint:
	bundle exec rubocop -D -a
