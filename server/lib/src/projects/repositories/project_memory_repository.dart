import 'package:todart_common/api.dart';
import 'package:todart_common/common.dart';
import 'project_repository.dart';

class ProjectMemoryRepository implements ProjectRepository {
  final Map<String, Project> _inMemoryDatabase = {};

  ProjectMemoryRepository() {
    _seedDatabase();
  }

  @override
  Future<List<Project>> listProjects() {
    final projects = _inMemoryDatabase.values.toList();
    return Future.value(projects);
  }

  void _seedDatabase() {
    final List<String> seedProjectList = ['Work', 'Coding', 'Wedding'];

    // Create a [Project] for each item in the list and add it to our "database"
    for (var item in seedProjectList) {
      final project =
          Project(name: item, resourceName: CloudResouceIdentity().toString());
      _inMemoryDatabase.putIfAbsent(project.resourceName, () => project);
      print(
          'Created project resource name: ${project.name}, id: ${project.resourceName}');
    }
  }

  @override
  Future<Project> getProject(String resourceName) {
    // If there are any dashes in the identifier remove them first
    resourceName = resourceName.replaceAll('-', '');
    return Future.value(_inMemoryDatabase[resourceName]);
  }
}
