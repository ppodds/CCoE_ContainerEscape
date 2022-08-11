.DEFAULT_GOAL=build

up:
	@$(MAKE) -s falco
	docker-compose up -d --build

down:
	docker rm -f falco_monitor
	# @$(MAKE) -s clear
	docker-compose down

.PHONY: driver
driver:
	docker run --rm -i -t --privileged -v /root/.falco:/root/.falco -v /proc:/host/proc:ro -v /boot:/host/boot:ro -v /lib/modules:/host/lib/modules:ro -v /usr:/host/usr:ro -v /etc:/host/etc:ro --security-opt apparmor:unconfined falcosecurity/falco-driver-loader:0.31.1

.PHONY: no-driver
no-driver:
	docker rm -f falco_monitor
	docker run -d -i -t --name falco_monitor -e HOST_ROOT=/ --cap-add SYS_PTRACE --pid=host $(shell ls /dev/falco* | xargs -I {} echo --device {}) -v /var/run/docker.sock:/var/run/docker.sock -v $(shell pwd | xargs -I {} echo {}/docker-compose/falco/falco_mount):/etc/falco --security-opt apparmor:unconfined falcosecurity/falco-no-driver:0.31.1




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
	--security-opt apparmor:unconfined falcosecurity/falco:0.31.1
	# -v $(shell pwd | xargs -I {} echo {}/docker-compose/falco/falco_mount):/etc/falco\
	