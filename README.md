This is my personal gRPC server template.
I referred to [Tin Petric's Advent of Go Microservices book](http://leanpub.com/go-microservices) a lot for this.
Feel free to use this, and make suggestions.

## Development tools:
In order to bootstrap this project, you will need the following tools:
- [go](https://golang.org/)
- make
- [protoc](https://github.com/protocolbuffers/protobuf-go)
- [protoc-gen-go](https://github.com/protocolbuffers/protobuf-go)
- [impl](https://github.com/josharian/impl)
Be sure that all of these are installed before starting.

## Usage:
Using this library is pretty straight forward, just run `make`.
That will generate the required server files, and RPCs.
Run `make run` to jump straight into running the generated server server.

## Scaffolding:
Creating a new server requires that you create a new .proto file in the `rpc` directory.
For example, if I wanted to make another server and have it be called, `Router`
I would just copy the existing .proto file into the router directory like so:
```
cp -r rpc/proxy rpc/router
make
```
This will copy the proxy server definitions to make another router server, and then generate the new router server.

## Filling in the stubs:
The `make` command generates server stubs at `server/$SERVER_NAME`. These are created with josharian's impl tool.
Fill these implementations in with whatever logic you want. Running `make` again will not delete this file.
So if you want to regenerate this file, you have to manually delete it first, then run `make`.
