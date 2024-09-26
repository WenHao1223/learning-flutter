import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/app_config.dart';

class HttpService {
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? baseUrl;

  HttpService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    baseUrl = _appConfig!.COIN_API_BASE_URL;
  }

  Future<Response?> get(String path) async { // `?` because of catch block
    try {
      String url = "$baseUrl$path";
      // `dio.get` properties
      // queryParameters: {"" : ""}
      // options: Options(headers: {"": ""})
      Response response = await dio.get(url);
      return response;
    } catch (e) {
      print("HTTPService: Unable to perform a get requrest.");
      print(e);
    }
  }
}