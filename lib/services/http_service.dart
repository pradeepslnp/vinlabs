import 'package:demo_app/services/http_interceptor.dart';
import 'package:http_interceptor/http/intercepted_http.dart';

class HttpService{
  static var http = InterceptedHttp.build(interceptors: [
    HttpInterceptor(),
  ]);
    static Future httpPhpGet(String url) async {
         
      return http.get(Uri.parse(url),);
   
  }
}