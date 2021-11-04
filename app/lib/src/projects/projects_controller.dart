import 'package:todart_common/api.dart';
import 'package:grpc/grpc_web.dart';

/// A class that many Widgets can interact with to work with [Project].
///
/// Controllers glue Data Services to Flutter Widgets.
class ProjectsController {
  ProjectsController({required Uri endpoint}) {
    _serviceEndpoint = GrpcWebClientChannel.xhr(endpoint);
    _serviceClient = ProjectServiceClient(_serviceEndpoint);
  }

  late final GrpcWebClientChannel _serviceEndpoint;
  late final ProjectServiceClient _serviceClient;

  Future<ListProjectsResponse> listProjects(ListProjectsRequest request) async {
    final results = await _serviceClient.listProjects(request);
    return results;
  }
}