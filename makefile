.DEFAULT_GOAL := help

bashrc:
	./_scripts/gen_bashrc.sh

antibody:
	./_scripts/antibody.zsh

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "antibody"
	@echo "    Make the statically linked antibody packages zsh include. "
	@echo ""
	@echo "bashrc"
	@echo "    Make a single file .bashrc for use on a server. "
	@echo ""
