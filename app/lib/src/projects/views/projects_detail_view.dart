import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:todart_common/api.dart';
import 'package:todart_web/src/settings/settings_view.dart';

class ProjectDetailView extends StatelessWidget {
  const ProjectDetailView({Key? key, required this.project}) : super(key: key);

  static const screenName = 'Project Details';

  final Project project;

  AppBar _showAppBar(BuildContext context) {
    return AppBar(
      title: const Text(ProjectDetailView.screenName),
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
      body: _showProject(context),
      destinations: _allDestinations,
      selectedIndex: 3,
    );
  }

  _showProject(BuildContext context) {
    return Text(project.name);
  }
}
