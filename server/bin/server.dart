import 'package:grpc/grpc.dart';
import 'package:todart_server/server.dart' as api;

Future<void> main(List<String> args) async {
  final server = Server(
    [api.GreeterService()],
    const <Interceptor>[],
    CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
