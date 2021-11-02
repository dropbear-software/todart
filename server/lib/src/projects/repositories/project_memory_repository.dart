import 'package:todart_common/api.dart';
import 'project_repository.dart';

class ProjectMemoryRepository implements ProjectRepository {
  final List<Project> _projects = [];

  ProjectMemoryRepository() {
    _seedDatabase();
  }

  @override
  Future<List<Project>> listProjects() {
    return Future.value(_projects);
  }

  void _seedDatabase() {
    _projects.add(Project(name: 'Build API'));
    _projects.add(Project(name: 'Write tests'));
  }
}
