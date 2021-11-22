import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todart_web/src/error_page.dart';
import 'package:todart_web/src/projects/projects_controller.dart';
import 'package:todart_web/src/projects/projects_repository.dart';

class ApplicationRouter {
  static final _projectsController = ProjectsController(ProjectsRepository());

  static final List<GoRoute> _routes = [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          _projectsController.index(context, state),
    ),
    GoRoute(
      path: '/project/:projectId',
      pageBuilder: (context, state) => _projectsController.show(context, state),
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
