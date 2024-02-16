# DATA_PATH = /home/seokchoi/data

# all :
# 	sudo mkdir -p $(DATA_PATH)/wordpress
# 	sudo mkdir -p $(DATA_PATH)/mariadb
# 	sudo docker-compose -f srcs/docker-compose.yml up --build -d

# up:
# 	sudo docker-compose -f srcs/docker-compose.yml up -d

# build:
# 	sudo docker-compose -f srcs/docker-compose.yml --build

# down:
# 	sudo docker-compose -f srcs/docker-compose.yml down

# clean:	down

# fclean:		clean
# 			sudo rm -rf $(DATA_PATH)
# 			# docker system prune -a --volumes
# 			-sudo docker rm nginx
# 			-sudo docker rm mariadb
# 			-sudo docker rm wordpress
# 			-sudo docker rmi nginx
# 			-sudo docker rmi mariadb
# 			-sudo docker rmi wordpress
# 			-sudo docker volume rm srcs_wordpress_volume
# 			-sudo docker volume rm srcs_mariadb_volume
# 			-sudo docker network rm srcs_my_network

# re:			fclean all

# .PHONY:		all clean fclean re up down build

DATA_PATH = /Users/eunjiko/data

all :
	mkdir -p $(DATA_PATH)/wordpress
	mkdir -p $(DATA_PATH)/mariadb
	docker-compose -f srcs/docker-compose.yml up --build -d

up:
	docker-compose -f srcs/docker-compose.yml up -d

build:
	docker-compose -f srcs/docker-compose.yml --build

down:
	docker-compose -f srcs/docker-compose.yml down

clean:	down

fclean:		clean
			rm -rf $(DATA_PATH)
			docker system prune -a --volumes

re:			fclean all

.PHONY:		all clean fclean re up down build