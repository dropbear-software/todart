import 'package:grpc/grpc.dart';
import 'package:todart_common/api.dart';
import 'repositories/project_memory_repository.dart';
import 'repositories/project_repository.dart';

class ProjectService extends ProjectServiceBase {
  final ProjectRepository projectRepository = ProjectMemoryRepository();

  @override
  Future<ListProjectsResponse> listProjects(
      ServiceCall call, ListProjectsRequest request) async {
    try {
      final projects = await projectRepository.listProjects();
      return ListProjectsResponse(projects: projects);
    } catch (e) {
      throw GrpcError.unknown(e.toString());
    }
  }
}
