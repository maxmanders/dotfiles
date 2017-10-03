.PHONY: all
all: dotfiles

.PHONY: dotfiles
dotfiles:
	for file in $(shell find . -type f -name ".*" -not -name ".gitconfig-dist" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".zshrc.d"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	ln -sfn .zshrc.d $(HOME)/.zshrc.d;
	ln -sfn .git_template $(HOME)/.git_template;

INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

.PHONY: test
test: shellcheck

.PHONY: shellcheck
shellcheck:
	docker run --rm -i $(DOCKER_FLAGS) \
		--name dotfiles-test \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		koalaman/shellcheck:latest ./test.sh

