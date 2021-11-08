# todart
Example full stack Dart research project of a very over engineered Todo list application.

**Note:** This project has a bunch of tooling behind it which is all abstracted away as a part of 
a VSCode devcontainer. There is nothing technically stopping you from installing the various tools yourself
to make this work on your own development machine, but I've very intentionally set this up so that you never
need to do that yourself. This project is among other things designed to explore the limits of a tightly integrated
cloud development environment and as such this project is designed to be run in the context of either Github codespaces
or locally via the VSCode devcontainer plugins.

### Getting Started
All commands should be run from the root of the project `/workspaces/todart`

**Starting the server**
```bash
dart server/bin/server.dart
```

**Starting the gRPC-web to gRPC proxy (Envoy)**
```bash
envoy -c tool/envoy-local.yaml
```

**Starting the flutter-web-client**
```bash
cd app
flutter run --web-hostname=0.0.0.0 --web-port=3000 -d web-server
```