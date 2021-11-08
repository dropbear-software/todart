import 'package:grpc/grpc.dart';
import 'package:todart_common/api.dart';
import 'package:todart_server/src/projects/helpers/project_service_helper.dart';
import 'repositories/project_memory_repository.dart';
import 'repositories/project_repository.dart';

class ProjectService extends ProjectServiceBase {
  final ProjectRepository projectRepository = ProjectMemoryRepository();

  @override
  Future<ListProjectsResponse> listProjects(
      ServiceCall call, ListProjectsRequest request) async {
    final sanitizedRequest =
        ProjectServiceHelper.sanitizeListProjectsRequest(request);

    // Finally fetch the records from the repository and return them or throw
    // an error if something went wrong.
    try {
      final projects = await projectRepository.listProjects();
      return ListProjectsResponse(projects: projects);
    } catch (e) {
      throw GrpcError.unknown(e.toString());
    }
  }

  @override
  Future<Project> getProject(
      ServiceCall call, GetProjectRequest request) async {
    try {
      final project = await projectRepository.getProject(request.name);
      return project;
    } catch (e) {
      throw GrpcError.notFound();
    }
  }
}
