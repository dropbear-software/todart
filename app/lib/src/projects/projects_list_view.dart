import 'package:flutter/material.dart';
import 'package:grpc/grpc_web.dart';
import 'package:todart_common/api.dart';
import 'project_card.dart';

import '../settings/settings_view.dart';

/// Displays a list of Projects.
class ProjectsListView extends StatelessWidget {
  const ProjectsListView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: buildProjectList(context),
    );
  }

  Widget buildProjectList(BuildContext context) {
    final channel =
        GrpcWebClientChannel.xhr(Uri.parse('http://localhost:1337'));
    final service = ProjectServiceClient(channel);

    return FutureBuilder(
      future: service.listProjects(ListProjectsRequest()),
      builder: (context, AsyncSnapshot<ListProjectsResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Project>? projects = snapshot.data!.projects;
          return (projects != null)
              ? ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to detail page here...;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: index == 0 ? 12 : 0, bottom: 12),
                        child: ProjectCard(projects[index]),
                      ),
                    );
                  },
                )
              : const Text('Something went wrong loading the data.');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
