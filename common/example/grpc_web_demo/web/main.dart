import 'dart:html';
import 'package:grpc/grpc_web.dart';
// ignore: avoid_relative_lib_imports
import 'package:todart_common/src/generated/protos/greeter.pbgrpc.dart';

void main() async {
  final channel = GrpcWebClientChannel.xhr(Uri.parse('http://localhost:1337'));
  final service = GreeterClient(channel);

  try {
    var result = await service.sayHello(HelloRequest(name: 'World'));
    querySelector('#output')?.text = result.message;
  } catch (error) {
    querySelector('#error')?.text = error.toString();
  }
}
