# # DATA_PATH = /home/eunjiko/data
# DATA_PATH = /Users/eunjiko/data


# all :
# 	sudo mkdir -p $(DATA_PATH)/mariadb
# 	sudo mkdir -p $(DATA_PATH)/wordpress
# 	sudo docker compose -f srcs/docker-compose.yml up --build -d

# #  컨테이너 생성 후 실행
# up:
# 	sudo docker compose -f srcs/docker-compose.yml up -d

# build:
# 	sudo docker compose -f srcs/docker-compose.yml --build
# # 도커 컨테이너 멈추는것 
# down:
# 	sudo docker compose -f srcs/docker-compose.yml down

# clean:	down

# fclean:	clean
# 		sudo rm -rf $(DATA_PATH)
# 		sudo docker system prune -a --volumes
# # 위의 것만 했을 경우 볼륨이 안지워진다 
# #		 -sudo docker rm wordpress
# #		 -sudo docker rm mariadb
# #		 -sudo docker rm nginx
# #		 -sudo docker rmi wordpress
# #		 -sudo docker rmi mariadb
# #		 -sudo docker rmi nginx
# #		 -sudo docker network rm srcs_my_network
# 		-sudo docker volume rm srcs_mariadb_volume
# 		-sudo docker volume rm srcs_wp_volume

# re:			fclean all

# .PHONY:		all clean re up down build fclean 





# DATA_PATH = /home/eunjiko/data
DATA_PATH = /Users/eunjiko/data


all :
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress
	docker-compose -f srcs/docker-compose.yml up --build -d

#  컨테이너 생성 후 실행
up:
	docker-compose -f srcs/docker-compose.yml up -d
# 수도 붙이고 짝대기빼기 
build:
	docker-compose -f srcs/docker-compose.yml --build
# 도커 컨테이너 멈추는것
down:
	docker-compose -f srcs/docker-compose.yml down

clean:	down

fclean:	clean
	 	rm -rf $(DATA_PATH)
	 	docker system prune -a --volumes
# 위의 것만 했을 경우 볼륨이 안지워진다 
#		  docker rm wordpress
#		  docker rm mariadb
#		  docker rm nginx
#		  docker rmi wordpress
#		  docker rmi mariadb
#		  docker rmi nginx
#		  docker network rm srcs_my_network
		 docker volume rm srcs_mariadb_volume
		 docker volume rm srcs_wp_volume

re:			fclean all

.PHONY:		all clean re up down build fclean 































# # DATA_PATH = /Users/eunjiko/data
# DATA_PATH = /home/eunjiko/data

# # 볼볼륨 바인드해줄 폴더 위치

# all :
# 	mkdir -p $(DATA_PATH)/mariadb
# 	mkdir -p $(DATA_PATH)/wordpress
# 	docker-compose -f srcs/docker-compose.yml up --build -d

# up:
# 	docker-compose -f srcs/docker-compose.yml up -d
# # 짝대기 지우기

# build:
# 	docker-compose -f srcs/docker-compose.yml --build

# down:
# 	docker-compose -f srcs/docker-compose.yml down

# clean:	down

# fclean:		clean
# 			rm -rf $(DATA_PATH)
# 			docker system prune -a --volumes

# re:			fclean all

# .PHONY:		all clean fclean re up down build