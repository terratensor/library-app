init: docker-down \
	docker-pull docker-up \
	app-init
up: docker-up
down: docker-down
restart: down up

app-init: 
	docker exec -it library-app php init-actions --interactive=0
	docker exec -it library-app php yii initial/index --interactive=0
	docker exec -it library-app php yii migrate --interactive=0	

docker-pull:
	docker compose pull

docker-up:
	docker compose up -d

docker-down:
	docker compose down --remove-orphans
