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

