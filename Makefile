default-context:
	docker context use default

build:	
	cd server && npm run build && cd ../client && yarn build 
	docker image build --tag asmarenas/docker-app:v0.1.0 .

upload:
	docker push asmarenas/docker-app:v0.1.0

update-container: 		
	- docker container stop app
	docker pull asmarenas/docker-app:v0.1.0
	docker container run --name app -p 443:3000 --rm -d -v /root/cert:/app/cert asmarenas/docker-app:v0.1.0 

remote-context:
	- docker context create ssh-box --docker "host=ssh://root@209.246.143.43"
	docker context use ssh-box


run-container-localy:
	- docker container stop app
	docker container run --name app -p 3000:3000 --rm -d -v /home/$(USER)/docker-app/cert:/app/cert asmarenas/docker-app:v0.1.0 

deploy: default-context build upload remote-context update-container default-context

local-deploy: default-context build run-container-localy


# Log into Docker HUB
#
# ssh login should be passwordless
# https://linuxize.com/post/how-to-setup-passwordless-ssh-login#

# Generate certificate
# openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 --nodes