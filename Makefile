default-context:
	docker context use default

build:	
	npm run build
	docker image build --tag asmarenas/docker-app:v0.1.0 .

upload:
	docker push asmarenas/docker-app:v0.1.0

update-container: 		
	docker container stop app
	docker pull asmarenas/docker-app:v0.1.0
	docker container run --name app -p 80:3000 --rm -d  asmarenas/docker-app:v0.1.0 

remote-context:
	- docker context create ssh-box --docker "host=ssh://root@209.246.143.43"
	docker context use ssh-box

deploy: default-context build upload remote-context update-container default-context


# Log into Docker HUB
#
# ssh login should be passwordless
# https://linuxize.com/post/how-to-setup-passwordless-ssh-login#
