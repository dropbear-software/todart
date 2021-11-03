import 'package:todart_common/api.dart';
import 'package:test/test.dart';
import 'package:todart_server/src/projects/helpers/project_service_helper.dart';

void main() {
  group('ProjectServiceHelper', () {
    group('sanitizeListProjectsRequest method', () {
      const defaultPageSize = 50;
      const maximumPageSize = 1000;
      test('rewrites negative pageSize arguments to the default value', () {
        final invalidRequest = ListProjectsRequest(pageSize: -1);
        final response =
            ProjectServiceHelper.sanitizeListProjectsRequest(invalidRequest);

        expect(response.pageSize, equals(defaultPageSize));
      });

      test(
          'rewrites the pageSize argument to the default value when 0 is specified',
          () {
        final invalidRequest = ListProjectsRequest(pageSize: 0);
        final response =
            ProjectServiceHelper.sanitizeListProjectsRequest(invalidRequest);

        expect(response.pageSize, equals(defaultPageSize));
      });

      test('rewrites pageSize arguments that are too big', () {
        final invalidPageSize =
            ListProjectsRequest(pageSize: maximumPageSize + 1);
        final response =
            ProjectServiceHelper.sanitizeListProjectsRequest(invalidPageSize);

        expect(response.pageSize, equals(maximumPageSize));
      });

      test('accepts the maximum pageSize argument', () {
        final validRequest = ListProjectsRequest(pageSize: maximumPageSize);
        final response =
            ProjectServiceHelper.sanitizeListProjectsRequest(validRequest);

        expect(response.pageSize, equals(maximumPageSize));
      });

      test('does not modify valid pageSize arguments', () {
        final validRequest = ListProjectsRequest(pageSize: 10);
        final response =
            ProjectServiceHelper.sanitizeListProjectsRequest(validRequest);

        expect(response.pageSize, equals(10));
      });

      test('enforces a default pageSize value when none is specified', () {
        final validRequest = ListProjectsRequest(pageSize: 10);
        final response =
            ProjectServiceHelper.sanitizeListProjectsRequest(validRequest);

        expect(response.pageSize, equals(10));
      });
    });
  });
}
