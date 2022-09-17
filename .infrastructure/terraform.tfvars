# This should match the values in the GitHub actions workflows
ARTIFACTORY_BUCKET_NAME = "nathanwang.link-ui-artifactory"
LOGS_BUCKET_NAME = "nathanwang.link-logs"
LOGS_PREFIX = {
  test: "nathanwang.link-ui-test/",
  prod: "nathanwang.link-ui-prod/",
}
ROOT_DOMAIN_NAME = "nathanwang.link"
SUBDOMAIN_NAMES     = {
  test : ["test.nathanwang.link"],
  prod : ["www.nathanwang.link", "nathanwang.link"],
}
GITHUB_ACCOUNT_NAME = "natebowang"
GITHUB_REPO_NAME    = "git-playground"
AWS_DEFAULT_REGION  = "ap-southeast-2"

# TODO how to tag? Web root should be tagged with version?
COMMON_TAGS = {
  Project = "nathanwang.link-ui"
}