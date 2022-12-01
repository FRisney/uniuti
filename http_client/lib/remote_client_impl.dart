part of '../http_client.dart';

class RemoteClientImpl implements RemoteClient {
  final String host;
  final List<InterceptorContract> interceptors = [];
  late RetryPolicy? retryPolicy;

  RemoteClientImpl({
    required this.host,
    this.retryPolicy,
  });

  @override
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    if (!endpoint.startsWith('/')) {
      endpoint = '/$endpoint';
    }
    late http.Response response;
    late Map<String, dynamic> body;
    try {
      response = await InterceptedHttp.build(
        interceptors: interceptors,
        retryPolicy: retryPolicy,
      ).get(
        Uri.parse('https://$host$endpoint'),
        params: params,
      );
      // TODO: Testar statusCode e retornar mensagem corretoa
      body = json.decode(response.body);
    } on SocketException catch (e) {
      throw RemoteClientConnectionException(e.toString());
    } catch (e) {
      throw RemoteClientException(e.toString());
    }
    return Response.fromHttpResponse(response: response, body: body);
  }

  @override
  Future<Response> post(String endpoint,
      {Map<String, dynamic>? params, Object? body}) async {
    if (!endpoint.startsWith('/')) {
      endpoint = '/$endpoint';
    }
    late http.Response response;
    late Map<String, dynamic> responseBody;
    try {
      response = await InterceptedHttp.build(
        interceptors: interceptors,
        retryPolicy: retryPolicy,
      ).post(
        Uri.parse('https://$host$endpoint'),
        params: params,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 404) {
        responseBody = {
          'errors': ['Resource Not Found.']
        };
      } else if (response.body.isNotEmpty) {
        responseBody = json.decode(response.body);
      } else {
        responseBody = {};
      }
    } on SocketException catch (e) {
      throw RemoteClientConnectionException(e.toString());
    } catch (e) {
      throw RemoteClientException(e.toString());
    }
    return Response.fromHttpResponse(response: response, body: responseBody);
  }

  @override
  Future<Response> put(String endpoint,
      {Map<String, dynamic>? params, Object? body}) async {
    if (!endpoint.startsWith('/')) {
      endpoint = '/$endpoint';
    }
    late http.Response response;
    late Map<String, dynamic> responseBody;
    try {
      response = await InterceptedHttp.build(
        interceptors: interceptors,
        retryPolicy: retryPolicy,
      ).put(
        Uri.parse('https://$host$endpoint'),
        params: params,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 404) {
        responseBody = {
          'errors': ['Resource Not Found.']
        };
      } else if (response.body.isNotEmpty) {
        responseBody = json.decode(response.body);
      } else {
        responseBody = {};
      }
    } on SocketException catch (e) {
      throw RemoteClientConnectionException(e.toString());
    } catch (e) {
      throw RemoteClientException(e.toString());
    }
    return Response.fromHttpResponse(response: response, body: responseBody);
  }

  addInteceptor(InterceptorContract interceptor) {
    interceptors.add(interceptor);
  }

  setRetryPolicy(RetryPolicy retryPolicy) {
    this.retryPolicy = retryPolicy;
  }
}
