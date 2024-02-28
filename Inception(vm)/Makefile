DATA_PATH = /home/eunjiko/data
# DATA_PATH = /Users/eunjiko/data 
# 마운트 파일 만드느라


all :
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress
	sudo docker compose -f srcs/docker-compose.yml up --build -d

up:
	sudo docker compose -f srcs/docker-compose.yml up -d
# sudo 붙이고 - 뺴고

build:
	sudo docker compose -f srcs/docker-compose.yml --build

down:
	sudo docker compose -f srcs/docker-compose.yml down

clean:	down

fclean:	clean
	 	rm -rf $(DATA_PATH)
	 	docker system prune -a --volumes
# 볼륨 지우는...
		docker volume rm srcs_mariadb_volume
		docker volume rm srcs_wp_volume

re:			fclean all

.PHONY:		all clean re up down build fclean 
