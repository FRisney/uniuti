part of '../http_client.dart';

typedef GetApiToken = Future<String> Function();
typedef RefreshApiToken = Future<String?> Function();

String parseErrorsList(List body, String ret) {
  for (var element in body) {
    ret += '$element\n';
  }
  return ret;
}

String parseErrorsMap(Map body, String ret) {
  for (var element in body.entries) {
    ret += '${element.key}: ';
    for (int i = 0; i < element.value.length; i++) {
      ret += element.value[i];
      if (i + 1 == element.value.length) {
        ret += '\n';
      } else if (i > 0) {
        ret += ',\n';
      }
    }
  }
  return ret;
}

class AuthInterceptor implements InterceptorContract {
  final GetApiToken getToken;
  AuthInterceptor({
    required this.getToken,
  });

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer ${await getToken()}',
    });
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}

class RetryPolicyImpl extends RetryPolicy {
  final RefreshApiToken performRefreshToken;

  RetryPolicyImpl(this.performRefreshToken);
  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    var should = false;
    if (response.statusCode == 401) {
      await performRefreshToken();
      should = !should;
    }
    return should;
  }
}
