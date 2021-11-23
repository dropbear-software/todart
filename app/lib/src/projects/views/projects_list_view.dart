import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todart_common/api.dart';
import '../../settings/settings_view.dart';

class ProjectsListView extends StatelessWidget {
  const ProjectsListView({Key? key, required this.apiResponse})
      : super(key: key);

  static const routeName = '/';
  static const screenName = 'Projects';

  final ListProjectsResponse apiResponse;

  Widget _showProjects(BuildContext context, List<Project> projects) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).go('/project/${projects[index].resourceName}');
          },
          child: Padding(
            padding: EdgeInsets.only(top: index == 0 ? 12 : 0, bottom: 12),
            child: _projectCard(context, project: projects[index]),
          ),
        );
      },
    );
  }

  Widget _projectCard(BuildContext context, {required Project project}) {
    return ListTile(
      title: Text(project.name),
    );
  }

  AppBar _showAppBar(BuildContext context) {
    return AppBar(
      title: const Text(ProjectsListView.screenName),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Navigate to the settings page. If the user leaves and returns
            // to the app after it has been killed while running in the
            // background, the navigation stack is restored.
            Navigator.restorablePushNamed(context, SettingsView.routeName);
            // GoRouter.of(context).go(SettingsView.routeName);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const _allDestinations = [
      AdaptiveScaffoldDestination(title: 'Home', icon: Icons.home),
      AdaptiveScaffoldDestination(title: 'Focus', icon: Icons.favorite),
      AdaptiveScaffoldDestination(title: 'Inbox', icon: Icons.email),
      AdaptiveScaffoldDestination(title: 'Projects', icon: Icons.folder),
      AdaptiveScaffoldDestination(title: 'Settings', icon: Icons.settings),
    ];
    return AdaptiveNavigationScaffold(
      appBar: _showAppBar(context),
      body: _showProjects(context, apiResponse.projects),
      destinations: _allDestinations,
      selectedIndex: 3,
    );
  }
}
