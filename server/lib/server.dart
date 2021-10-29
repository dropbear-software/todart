import 'package:grpc/grpc.dart';
// ignore: implementation_imports
import 'package:todart_common/src/generated/protos/greeter.pbgrpc.dart';

class GreeterService extends GreeterServiceBase {
  @override
  Future<HelloReply> sayHello(ServiceCall call, HelloRequest request) async {
    return HelloReply()..message = 'Hello, ${request.name}!';
  }
}
