TAG := ministryofjustice/docker-tomee

build:
	docker build -t ${TAG} .

release: build
	docker push ${TAG}
