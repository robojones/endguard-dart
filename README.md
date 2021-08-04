# EndGuard

## Generate the protocol buffers

> **Required:** Docker

```bash
# make sure the protocol submodule is up to date
git submodule init
git submodule update

# generate protocol buffer library files
docker run --rm -v=${PWD}:/project robojones/protoc-dart:latest protoc -I=protocol/protos --dart_out=lib/src/protos protocol/protos/protocol.proto
```
