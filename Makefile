default: help

# Perl Colors, with fallback if tput command not available
GREEN  := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm setaf 2 || echo "")
BLUE   := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm setaf 4 || echo "")
WHITE  := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm setaf 7 || echo "")
YELLOW := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm setaf 3 || echo "")
RESET  := $(shell command -v tput >/dev/null 2>&1 && tput -Txterm sgr0 || echo "")

# Add help text after each target name starting with '\#\#'
# A category can be added with @category
HELP_FUN = \
    %help; \
    while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
    print "usage: make [target]\n\n"; \
    for (sort keys %help) { \
    print "${WHITE}$$_:${RESET}\n"; \
    for (@{$$help{$$_}}) { \
    $$sep = " " x (32 - length $$_->[0]); \
    print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; \
    }; \
    print "\n"; }

help:
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

#######################################
#            SCRIPTS                  #
#######################################
install: ##@Scripts - Install NPM packages
	@if [ ! -f ./.env ]; then cp .env.dist .env ; fi
	@npm i


#######################################
#            CONTRACTS                #
#######################################
ifndef LIGO
LIGO=docker run --platform linux/amd64 --rm -v "$(PWD)":"$(PWD)" -w "$(PWD)" ligolang/ligo:0.47.0
endif

compile = $(LIGO) compile contract ./contracts/$(1) -o ./contracts/$(2) $(3)
# ^ Compile contract to Michelson

test-ligo = $(LIGO) run test ./contracts/$(1)
# ^ Run given test file

compile: ##@Contracts - Compile contracts to Michelson
	@echo "Compiling Main contract..."
	@$(call compile,main.mligo,main.tz)

clean: ##@Contracts - Clean up compiled contracts
	@rm -rf contracts/*.tz

deploy: ##@Contracts - Deploy compiled contracts
	@echo "-- Upcoming feature ! --"
