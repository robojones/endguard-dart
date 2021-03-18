# EndGuard

## Generate the protocol buffers

> **Required:** Docker

```bash
# make sure the protocol submodule is up to date
git submodule init
git submodule update

# generate protocol buffer library files
docker run --rm -v `pwd`:`pwd` -w `pwd` thethingsindustries/protoc -I=./protocol/protos --dart_out=./lib/src/protos ./protocol/protos/protocol.proto
```
