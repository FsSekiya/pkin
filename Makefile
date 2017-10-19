
deploy:
	bundle exec rubocop -a
	git add .
	git commit -m "add: contents `date`"
	git push origin
