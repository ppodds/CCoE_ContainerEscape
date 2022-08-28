.DEFAULT_GOAL=build

# 啟動所有container
up:
	docker-compose --env-file .docker-compose.env up -d --build
# 關閉所有container
down:
	docker-compose down

.PHONY: ubuntu_1804
ubuntu_1804:
	docker build -t="yishin-cheng/ubuntu_vun" ./docker-compose/ubuntu_1804/
	docker rm -f ubuntu_1804
	docker run -it -d --name ubuntu_1804 -p 8093:80 yishin-cheng/ubuntu_vun



# 如果docker-compose不能用或者你的falco/falco_mount裡面是空的，先用這個，之後就用docker-compose.yml裡面的就可以
.PHONY: falco
falco:
	docker rm -f falco_monitor
	docker run -d -i -t --privileged --name falco_monitor \
	-v /var/run/docker.sock:/host/var/run/docker.sock \
	-v /dev:/host/dev \
	-v /proc:/host/proc:ro \
	-v /boot:/host/boot:ro \
	-v /lib/modules:/host/lib/modules:ro \
	-v /usr:/host/usr:ro \
	-v /etc:/host/etc:ro \
	-v $(shell pwd | xargs -I {} echo {}/docker-compose/falco/falco_mount):/etc/falco\
	--security-opt apparmor:unconfined falcosecurity/falco:0.31.1
	