default:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  install    to install NPM packages"
	@echo "  compile    to compile contracts to Michelson"
	@echo "  test       to test contracts via LIGO"
	@echo "  deploy     to deploy compiled contracts"
	@echo "  start      to start website server"
	@echo "  clean      to clean up compiled contracts"

ifndef LIGO
LIGO=docker run --platform linux/amd64 --rm -v "$(PWD)":"$(PWD)" -w "$(PWD)" ligolang/ligo:0.57.0
endif

compile = $(LIGO) compile contract ./contracts/$(1) -o ./compiled/$(2)
test-ligo = $(LIGO) run test ./contracts/test/$(1)

install: ##@Scripts - Install NPM packages
	@npm i

compile: ##@Contracts - Compile contracts to Michelson
	@echo "Compiling Main contract..."
	@$(call compile,main.mligo,main.tz)

test: ##@Contracts - Test contracts via LIGO
	@echo "-- Upcoming feature ! --"

deploy: ##@Contracts - Deploy compiled contracts
	@echo "-- Upcoming feature ! --"

start: ##@React - Start website server
	@npm run build
	@npm run start

clean: ##@Contracts - Clean up compiled contracts
	@rm -rf compiled/*.tz
	@npm run clean
