install:
	virtualenv venv
	venv/bin/python setup.py install
	venv/bin/python manage.py migrate --noinput
	cp dev.env .env


deps:
	sudo apt-get install libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk 
	npm install bower
	

deps_mac:
	brew install libtiff libjpeg webp little-cms2


test:
	rm -rf .tox
	detox

clean:
	rm -rf venv

run:
	venv/bin/python manage.py runserver_plus 0.0.0.0:45000

rename:
	find . -maxdepth 1 -type f \( ! -iname "Makefile" \) -print0 | xargs -0 sed -i 's/outline/$(name)/g'
	find outline -maxdepth 1 -type f -print0 | xargs -0 sed -i 's/outline/$(name)/g'
	mv outline/manage_outline.py outline/manage_$(name).py
	mv outline $(name)
	echo "Great, you're all set! Well, you'll probably want to adjust the setup file by hand a bit."
