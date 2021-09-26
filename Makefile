help:
	@echo "Skaro project"
	@echo "-------------------------------------------------"
	@echo ""
	@echo "-build builds and pushes docker distribution to docker hub"
	@echo "-deploy builds and deploys application to production"
build:
	docker build -f Dockerfile -t altmer/skaro:latest .
	docker push altmer/skaro
deploy: build
	make -C $(DEPLOY_PATH) skaro
