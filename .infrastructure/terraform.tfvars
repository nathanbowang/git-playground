# This should match the values in the GitHub actions workflows
ARTIFACTORY_NAME = "nathanwang.link-ui-artifactory"
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