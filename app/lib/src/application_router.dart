import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todart_common/api.dart';
import 'package:todart_web/src/error_page.dart';
import 'package:todart_web/src/projects/projects_controller.dart';
import 'package:todart_web/src/projects/projects_detail_view.dart';
import 'package:todart_web/src/projects/projects_list_view.dart';

class ApplicationRouter {
  static final _projectController = ProjectsController();

  static final List<GoRoute> _routes = [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: FutureBuilder<ListProjectsResponse>(
          future: _projectController.listProjects(ListProjectsRequest()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorPage(snapshot.error as Exception?);
            }
            if (snapshot.hasData) {
              return ProjectsListView(apiResponse: snapshot.data!);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    ),
    GoRoute(
      path: '/project/:projectId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: FutureBuilder<Project>(
          future: _projectController
              .getProjects(GetProjectRequest(name: state.params['projectId']!)),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorPage(snapshot.error as Exception?);
            }
            if (snapshot.hasData) {
              return ProjectDetailView(project: snapshot.data!);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    ),
  ];

  static GoRouter getRouter() {
    return GoRouter(routes: _routes, errorPageBuilder: _errorPageBuilder);
  }

  static Page _errorPageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ErrorPage(state.error),
    );
  }
}

class NoTransitionPage<T> extends CustomTransitionPage<T> {
  const NoTransitionPage({required Widget child, LocalKey? key})
      : super(transitionsBuilder: _transitionsBuilder, child: child, key: key);

  static Widget _transitionsBuilder(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
      child;
}
