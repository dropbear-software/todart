import 'package:flutter/material.dart';
import 'package:todart_common/api.dart';
import '../app.dart';
import 'projects_controller.dart';
import 'projects_list_view.dart';
import 'package:grpc/grpc_web.dart';

class ProjectDetailView extends StatefulWidget {
  const ProjectDetailView({Key? key, required this.projectId})
      : super(key: key);

  static const routeName = '/project/1';
  static const screenName = 'Project Details';

  final int projectId;

  @override
  _ProjectDetailViewState createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends State<ProjectDetailView> {
  late final ProjectsController _projectsController =
      ProjectsController(endpoint: Uri.parse(ToDart.apiEndpoint));
  late final Future<Project> _apiResponse;

  @override
  void initState() {
    super.initState();
    _apiResponse = _projectsController.getProjects(GetProjectRequest(name: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectsListView.screenName),
      ),
      body: Center(
        child: FutureBuilder<Project>(
          future: _apiResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _showProject(context, snapshot.data!);
            } else if (snapshot.hasError) {
              return _showError(context, error: snapshot.error! as GrpcError);
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _showProject(BuildContext context, Project data) {
    return Text(data.name);
  }

  Widget _showError(BuildContext context, {required GrpcError error}) {
    if (error.codeName == GrpcError.notFound().codeName) {
      return const Text('File not found');
    } else {
      return const Text('Generic error');
    }
  }
}
