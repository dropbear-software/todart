import 'package:grpc/grpc.dart';
import 'package:todart_server/server.dart';

Future<void> main(List<String> args) async {
  final server = Server(
    [ProjectService()],
    const <Interceptor>[],
    CodecRegistry(codecs: const [GzipCodec()]),
  );
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
