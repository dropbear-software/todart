import 'dart:html';
import 'package:grpc/grpc_web.dart';
import 'package:todart_common/api_base.dart';

void main() async {
  final channel = GrpcWebClientChannel.xhr(Uri.parse('http://localhost:1337'));
  final service = ProjectServiceClient(channel);

  try {
    var result = await service.listProjects(ListProjectsRequest());
    for (var project in result.projects) {
      window.console.log(project);
    }
  } catch (error) {
    window.console.error(error.toString());
  }
}
