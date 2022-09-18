# TODO
make test
terraform init -reconfigure \
    -backend-config="bucket=global-terraform-backend" \
    -backend-config="key=test.nathanwang.link" \
    -backend-config="region=ap-southeast-2"
terraform apply -var ENV="test"

make prod
terraform init -reconfigure \
    -backend-config="bucket=global-terraform-backend" \
    -backend-config="key=www.nathanwang.link" \
    -backend-config="region=ap-southeast-2"
terraform apply -var ENV="prod"
