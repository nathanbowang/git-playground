BUCKET_NAME := -backend-config="bucket=global-terraform-backend"
TEST_STATE_KEY := -backend-config="key=test.nathanwang.link"
PROD_STATE_KEY := -backend-config="key=www.nathanwang.link"
REGION := -backend-config="region=ap-southeast-2"

TEST_BACKEND := $(BUCKET_NAME) $(TEST_STATE_KEY) $(REGION)
PROD_BACKEND := $(BUCKET_NAME) $(PROD_STATE_KEY) $(REGION)

.PHONY: test $(MAKECMDGOALS)

test:
	terraform init -reconfigure $(TEST_BACKEND)
	terraform apply -var ENV="test"

prod:
	terraform init -reconfigure $(PROD_BACKEND)
	terraform apply -var ENV="prod"

destroy-prod:
	@printf "$(RED_NORMAL)%s$(NO_COLOR)\n" "Prod env estroying!"
	AWS_PROFILE=nathan terraform init -reconfigure $(PROD_BACKEND)
	AWS_PROFILE=nathan terraform destroy -var ENV="prod"