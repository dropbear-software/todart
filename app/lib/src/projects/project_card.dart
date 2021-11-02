import 'package:flutter/material.dart';
import 'package:todart_common/api.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard(
    this.project, {
    Key? key,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(project.name),
    );
  }
}
