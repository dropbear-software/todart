import 'package:todart_common/api.dart';

/// Provides a series of helper methods for working with [ProjectService]
class ProjectServiceHelper {
  /// Takes a [ListProjectsRequest] from the outside world and prepares it for
  /// use in the rest of our codebase.
  ///
  /// Example usage:
  /// ```dart
  /// final sanitizedRequest =
  ///   ProjectServiceHelper.sanitizeListProjectsRequest(externalRequestObject);
  /// ```
  static ListProjectsRequest sanitizeListProjectsRequest(
      ListProjectsRequest request) {
    // Specify some limitations around how many records can be requested
    const int minimumProjectsRequested = 1;
    const int maximumProjectsRequested = 1000;
    const int defaultProjectsRequested = 50;

    // If the request doesn't specify valid defaults for the maximum number
    // of records it wants returned we should specify them explicitly
    if (!request.hasPageSize() || request.pageSize < minimumProjectsRequested) {
      request.pageSize = defaultProjectsRequested;
    }

    if (request.pageSize > maximumProjectsRequested) {
      request.pageSize = maximumProjectsRequested;
    }

    return request;
  }
}
