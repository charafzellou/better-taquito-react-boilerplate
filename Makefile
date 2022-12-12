ifndef LIGO
LIGO=docker run --platform linux/amd64 --rm -v "$(PWD)":"$(PWD)" -w "$(PWD)" ligolang/ligo:0.57.0
endif

compile = $(LIGO) compile contract ./contracts/$(1) -o ./compiled/$(2)
test-ligo = $(LIGO) run test ./contracts/test/$(1)

install: ##@Scripts - Install NPM packages
	@if [ ! -f ./.env ]; then cp .env.dist .env ; fi
	@npm i

compile: ##@Contracts - Compile contracts to Michelson
	@echo "Compiling Main contract..."
	@$(call compile,main.mligo,main.tz)

test: ##@Contracts - Test contracts via LIGO
	@echo "-- Upcoming feature ! --"

deploy: ##@Contracts - Deploy compiled contracts
	@echo "-- Upcoming feature ! --"

clean: ##@Contracts - Clean up compiled contracts
	@rm -rf contracts/*.tz
