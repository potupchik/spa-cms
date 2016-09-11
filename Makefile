build-dev: composer-install-dev init-environment-dev migrate-dev build-front-dev

composer-install-dev:
	composer install

init-environment-dev:
	./init --env=Development --overwrite=n

migrate-dev:
	./yii migrate

build-front-dev:
	cd frontend && npm install && cd ../
