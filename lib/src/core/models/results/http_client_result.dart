abstract class HttpClientResult<T> {}

class SuccessfulRequest<T> extends HttpClientResult<T> {
  final T? retrievedData;

  SuccessfulRequest([this.retrievedData]);
}

class FailedRequest<T> extends HttpClientResult {
  /// id used to translate the error message.
  final String errorId;

  FailedRequest(this.errorId);
}
