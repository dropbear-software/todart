import 'package:flutter/material.dart';
import 'package:todart_common/api.dart';
import 'package:todart_web/src/app.dart';
import 'package:todart_web/src/projects/projects_controller.dart';
import '../settings/settings_view.dart';

class ProjectsListView extends StatefulWidget {
  const ProjectsListView({Key? key}) : super(key: key);

  static const routeName = '/';
  static const screenName = 'Projects';

  @override
  _ProjectsListViewState createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  late final ProjectsController _projectsController =
      ProjectsController(endpoint: Uri.parse(MyApp.apiEndpoint));
  late final Future<ListProjectsResponse> _apiResponse;

  @override
  void initState() {
    super.initState();
    _apiResponse = _projectsController.listProjects(ListProjectsRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showAppBar(context),
      body: Center(
        child: FutureBuilder<ListProjectsResponse>(
          future: _apiResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _showProjects(context, snapshot.data!.projects);
            } else if (snapshot.hasError) {
              return _showError(context, error: snapshot.error!);
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _showProjects(BuildContext context, List<Project> projects) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: _navigateToProjectDetailPage(projects[index]),
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

  Widget _showError(BuildContext context, {required Object error}) {
    return Text(error.toString());
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
          },
        ),
      ],
    );
  }

  _navigateToProjectDetailPage(Project project) {
    // Put nav stuff here
  }
}
