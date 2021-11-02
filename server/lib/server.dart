import 'package:grpc/grpc.dart';
import 'package:todart_common/api_base.dart';

class ProjectService extends ProjectServiceBase {
  @override
  Future<ListProjectsResponse> listProjects(
      ServiceCall call, ListProjectsRequest request) {
    // TODO: implement listProjects
    throw UnimplementedError();
  }
}
