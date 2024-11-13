
names=NGINX MARIADB
volumes= srcs_wordpress_data srcs_mariadb_data 
path=/home/vagrant/docker_volumes
all:
	mkdir -p ${path}/data/
	mkdir -p ${path}/data/wp/
	mkdir -p ${path}/data/db/
	sudo docker-compose -f ./srcs/docker-compose.yml up  --build -d
down:
	docker-compose -f ./srcs/docker-compose.yml down
rmv:
	docker volume rm ${volumes}
clean: down rmv
	echo "mhaddaou" | sudo -S rm -rf ${path}/data
	
fclean:
	docker system prune --all -f
