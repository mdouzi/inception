WP_DATA = /home/mdouzi/data/wordpress/
DB_DATA = /home/mdouzi/data/mariadb/

# Default target
all: up

# Start the building process
up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d 

# Stop the containers
down:
	docker-compose -f ./srcs/docker-compose.yml down

# Stop the containers
stop:
	docker-compose -f ./srcs/docker-compose.yml stop

# Start the containers
start:
	docker-compose -f ./srcs/docker-compose.yml start

# Build the containers
build:
	docker-compose -f ./srcs/docker-compose.yml build

# Clean the containers and data
clean:
	@echo "Stopping and removing containers..."
	@docker stop $$(docker ps -q) || true
	@docker rm $$(docker ps -a -q) || true
	@docker-compose -f ./srcs/docker-compose.yml down -v || true
	@echo "Removing images..."
	@docker rmi -f $$(docker images -q) || true
	@echo "Removing volumes..."
	@docker volume rm $$(docker volume ls -q) || true
	@echo "Removing networks..."
	@docker network rm $$(docker network ls -q) || true

# Clean and start the containers
re: clean up

restart: clean remove

remove:
	@echo "Removing WordPress data..."
	@sudo rm -rf $(WP_DATA) || true
	@echo "Removing MariaDB data..."
	@sudo rm -rf $(DB_DATA) || true

# Prune the Docker system
prune: clean
	@echo "Pruning Docker system..."
	@docker system prune -a --volumes -f
