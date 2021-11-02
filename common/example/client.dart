// Dart implementation of the gRPC helloworld.Greeter client.
import 'package:grpc/grpc.dart';
import 'package:todart_common/api_base.dart';

Future<void> main(List<String> args) async {
  final channel = ClientChannel(
    'localhost',
    port: 1337,
    options: ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );
  final stub = ProjectServiceClient(channel);

  try {
    final response = await stub.listProjects(
      ListProjectsRequest(),
      options: CallOptions(compression: const GzipCodec()),
    );
    print('Projects received:');
    for (var project in response.projects) {
      print(project.name);
    }
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();
}
