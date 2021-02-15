help:
	@echo "Skaro project"
	@echo "-------------------------------------------------"
	@echo ""
	@echo "-deploy deploys latest version to production"
deploy:
	make -C $(DEPLOY_PATH) skaro
