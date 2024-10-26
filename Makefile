SCRIPTS_DIR = scripts

targets = \
	packages \
	wsl \
	git \
	zsh \
	fzf \
	btop \
	python \
	nvim \
	docker \

.PHONY: all $(targets)

all: $(targets)

$(targets):
	@bash $(SCRIPTS_DIR)/$@.sh