import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todart_common/api.dart';
import '../views/projects_detail_view.dart';
import '../views/projects_list_view.dart';
import '../repositories/projects_repository.dart';
import '../../error_page.dart';

/// A [ProjectsRouteController] is responsible for taking an incoming route
/// for a project based resource via a [GoRouterState] along with a
/// [BuildContext] and build the correct view after providing it whatever
/// data it needs to build the view.
class ProjectsRouteController {
  final ProjectsRepository _repository;

  const ProjectsRouteController(this._repository);

  Page<dynamic> index(BuildContext context, GoRouterState state) {
    final request = ListProjectsRequest();
    final method = _repository.listProjects;

    return MaterialPage<void>(
      key: state.pageKey,
      child: FutureBuilder<ListProjectsResponse>(
        future: method(request),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _handleError(snapshot.error as Exception?);
          }
          if (snapshot.hasData) {
            return ProjectsListView(apiResponse: snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Page<dynamic> show(BuildContext context, GoRouterState state) {
    final projectId = state.params['projectId']!;
    final request = GetProjectRequest(name: projectId);
    final method = _repository.getProjects;

    return MaterialPage<void>(
      key: state.pageKey,
      child: FutureBuilder<Project>(
        future: method(request),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _handleError(snapshot.error as Exception?);
          }
          if (snapshot.hasData) {
            return ProjectDetailView(project: snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ErrorPage _handleError(Exception? exception) {
    return ErrorPage(exception);
  }
}
