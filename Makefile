.DEFAULT_GOAL=build

up:
	docker-compose up -d --build

down:
	docker-compose down





# 如果第一次啟動或者你的falco/falco_mount裡面是空的，先用這個，之後就用docker-compose.yml裡面的就可以
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
	-v falco-rules:/etc/falco \
	--security-opt apparmor:unconfined falcosecurity/falco:0.31.1
	# -v $(shell pwd | xargs -I {} echo {}/docker-compose/falco/falco_mount):/etc/falco\
	