import 'package:todart_common/api.dart';

class ProjectResource {
  late String name;

  ProjectResource(String name);

  factory ProjectResource.fromDataClass(Project project) {
    return ProjectResource(project.name);
  }

  Project toDataClass() {
    return Project(name: name);
  }
}
