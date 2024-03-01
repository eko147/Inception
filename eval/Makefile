DATA_PATH = /home/eunjiko/data

all :
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress
	sudo docker compose -f srcs/docker-compose.yml up --build -d

up:
	sudo docker compose -f srcs/docker-compose.yml up -d

build:
	sudo docker compose -f srcs/docker-compose.yml --build

down:
	sudo docker compose -f srcs/docker-compose.yml down

clean:	down

fclean:	clean
	 	sudo rm -rf $(DATA_PATH)
	 	sudo docker system prune -a --volumes
 		# -sudo docker volume rm srcs_mariadb_volume
 		# -sudo docker volume rm srcs_wp_volume

re:			fclean all

.PHONY:		all clean re up down build fclean