PROTOC_PATH ?= ${HOME}/.local/bin/protoc
DART_SDK_PATH ?= ${HOME}/.local/flutter/bin
PROJECT_PATH ?= /workspaces/todart
GOOGLE_COMMON_PROTOS_PATH = $(PROJECT_PATH)/third_party/github.com/googleapis/
DEFAULT_PROTOBUFS_PATH = $(PROJECT_PATH)/third_party/github.com/google/
API_DIRECTORY = $(PROJECT_PATH)/protos/
DART_GENERATED_PROTO_DIR = lib/src/generated/protos
EXE_DIST_DIR = $(PROJECT_PATH)/build

google_common_protos:
	echo "Fetching Google common proto files..."
	rm -rf /tmp/googleapis
	git clone https://github.com/googleapis/api-common-protos.git /tmp/googleapis
	mkdir -p $(GOOGLE_COMMON_PROTOS_PATH)
	cp -r /tmp/googleapis/google/ $(GOOGLE_COMMON_PROTOS_PATH)
	mkdir -p $(DEFAULT_PROTOBUFS_PATH)/
	cp -r ${HOME}/.local/include/google/protobuf/ $(DEFAULT_PROTOBUFS_PATH)

compile_protos: google_common_protos
	echo "Compiling proto files..."
	mkdir -p $(PROJECT_PATH)/$(DART_GENERATED_PROTO_DIR)
	$(PROTOC_PATH) -I $(API_DIRECTORY) -I $(GOOGLE_COMMON_PROTOS_PATH) -I $(DEFAULT_PROTOBUFS_PATH) $(API_DIRECTORY)*.proto --dart_out=grpc:$(DART_GENERATED_PROTO_DIR)
	$(DART_SDK_PATH)/dart format --fix $(PROJECT_PATH)/$(DART_GENERATED_PROTO_DIR)

server: compile_protos
	echo 'Compiling server...'
	mkdir -p $(EXE_DIST_DIR)
	$(DART_SDK_PATH)/dart compile exe $(PROJECT_PATH)/bin/server.dart
	mv $(PROJECT_PATH)/bin/server.exe $(EXE_DIST_DIR)/server

client: compile_protos
	echo 'Compiling client...'
	mkdir -p $(EXE_DIST_DIR)
	$(DART_SDK_PATH)/dart compile exe $(PROJECT_PATH)/bin/client.dart
	mv $(PROJECT_PATH)/bin/client.exe $(EXE_DIST_DIR)/client

clean:
	rm -rf /tmp/googleapis && rm -rf $(DEFAULT_PROTOBUFS_PATH) && rm -rf $(GOOGLE_COMMON_PROTOS_PATH)
	rm -rf $(PROJECT_PATH)/$(DART_GENERATED_PROTO_DIR)
	rm -rf $(EXE_DIST_DIR)