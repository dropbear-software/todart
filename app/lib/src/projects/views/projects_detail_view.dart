import 'package:flutter/material.dart';
import 'package:todart_common/api.dart';

class ProjectDetailView extends StatelessWidget {
  const ProjectDetailView({Key? key, required this.project}) : super(key: key);

  static const screenName = 'Project Details';

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Text(project.name);
  }
}
