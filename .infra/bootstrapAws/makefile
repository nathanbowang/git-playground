# [More colors](https://www.shellhacks.com/bash-colors/)
RED_NORMAL := \e[31m
NO_COLOR := \e[0m

.PHONY: bootstrap $(MAKECMDGOALS)

bootstrap:
	@printf "$(RED_NORMAL)%s$(NO_COLOR)\n" "This should be run only once!"
	terraform init
	terraform apply
