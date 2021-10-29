PROTOC_PATH ?= ${HOME}/.local/bin/protoc
DART_SDK_PATH ?= ${HOME}/.local/flutter/bin
PROJECT_PATH ?= /workspaces/todart
GOOGLE_COMMON_PROTOS_PATH = $(PROJECT_PATH)/third_party/github.com/googleapis/
DEFAULT_PROTOBUFS_PATH = $(PROJECT_PATH)/third_party/github.com/google/
API_DIRECTORY = $(PROJECT_PATH)/api/
DART_GENERATED_PROTO_DIR = common/lib/src/generated/protos

fetch_google_protos:
	echo "Fetching Google common proto files..."
	rm -rf /tmp/googleapis
	git clone https://github.com/googleapis/api-common-protos.git /tmp/googleapis
	mkdir -p $(GOOGLE_COMMON_PROTOS_PATH)
	cp -r /tmp/googleapis/google/ $(GOOGLE_COMMON_PROTOS_PATH)
	mkdir -p $(DEFAULT_PROTOBUFS_PATH)/
	cp -r ${HOME}/.local/include/google/protobuf/ $(DEFAULT_PROTOBUFS_PATH)

compile_protos: fetch_google_protos
	mkdir -p $(PROJECT_PATH)/$(DART_GENERATED_PROTO_DIR)
	$(PROTOC_PATH) -I $(API_DIRECTORY) -I $(GOOGLE_COMMON_PROTOS_PATH) -I $(DEFAULT_PROTOBUFS_PATH) $(API_DIRECTORY)*.proto --dart_out=grpc:$(DART_GENERATED_PROTO_DIR)
	$(DART_SDK_PATH)/dart format --fix $(PROJECT_PATH)/$(DART_GENERATED_PROTO_DIR)

clean:
	rm -rf /tmp/googleapis && rm -rf $(DEFAULT_PROTOBUFS_PATH) && rm -rf $(GOOGLE_COMMON_PROTOS_PATH)
	rm -rf $(PROJECT_PATH)/$(DART_GENERATED_PROTO_DIR)
	rm -rf $(EXE_DIST_DIR)