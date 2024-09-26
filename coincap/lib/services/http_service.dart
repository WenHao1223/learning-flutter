import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../models/app_config.dart';

class HttpService {
  final Dio dio = Dio();

  AppConfig? _appConfig;
  String? _base_url;

  HttpService() {
    _appConfig = GetIt.instance.get<AppConfig>();
    _base_url = _appConfig!.COIN_API_BASE_URL;
  }

  Future<Response?> get(String _path) async { // `?` because of catch block
    try {
      String _url = "$_base_url$_path";
      // `dio.get` properties
      // queryParameters: {"" : ""}
      // options: Options(headers: {"": ""})
      Response _response = await dio.get(_url);
      return _response;
    } catch (e) {
      print("HTTPService: Unable to perform a get requrest.");
      print(e);
    }
  }
}