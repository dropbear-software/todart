import 'package:todart_common/api.dart';

abstract class ProjectRepository {
  Future<List<Project>> listProjects();

  Future<Project> getProject(String id);
}
