import 'package:http_interceptor/http_interceptor.dart';

class HttpInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData? data}) async {
    return data!;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData? data}) async {
    return data!;
  }
}
