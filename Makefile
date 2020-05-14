.PHONY: rpc templates

all: rpc templates

rpc: $(shell ls -d rpc/* | sed -e 's/\//./g')
rpc.%: SERVICE=$*
rpc.%: SERVICE_CAMEL=$(shell echo $(SERVICE) | sed -r 's/(^|_)([a-z])/\U\2/g')
rpc.%:
	@echo '> protoc gen for $(SERVICE)'
	@protoc -I rpc/$(SERVICE) --go_out=plugins=grpc:./rpc/$(SERVICE) rpc/$(SERVICE)/*.proto

templates: $(shell ls -d rpc/* | sed -e 's/rpc\//templates./g')
templates.%: export SERVICE=$*
templates.%: export SERVICE_CAMEL=$(shell echo $(SERVICE) | sed -r 's/(^|_)([a-z])/\U\2/g')
templates.%: export MODULE=$(shell grep ^module go.mod | sed -e 's/module //g')
templates.%:
	@echo '> templates: $(SERVICE) $(MODULE)'
	@mkdir -p cmd/${SERVICE}
	@envsubst < templates/cmd_main.go.tpl > cmd/${SERVICE}/main.go
	@./templates/server.go.sh

run: rpc templates
	go run ./cmd/proxy

clean:
	rm -rf cmd rpc/*/*.go