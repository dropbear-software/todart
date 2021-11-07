import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todart_web/src/error_page.dart';
import 'package:todart_web/src/projects/projects_detail_view.dart';
import 'package:todart_web/src/projects/projects_list_view.dart';

class ApplicationRouter {
  static final List<GoRoute> _routes = [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const ProjectsListView(),
      ),
    ),
    GoRoute(
      path: '/projects/:projectId',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: ProjectDetailView(
          projectId: state.params['projectId'],
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
