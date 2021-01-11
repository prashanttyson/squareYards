import 'package:dio/dio.dart';
import 'package:prashantmishrasquareyards/Model/EnquiryDetails.dart';




class ApiProvider {
  static final ApiProvider _api = ApiProvider._internal();
  static final String baseUrl =
      "https://5fcb733151f70e00161f196c.mockapi.io/api/v1/contactDetails";

  final Dio dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: baseUrl,
      headers: <String, dynamic>{
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      responseType: ResponseType.json));


  factory ApiProvider() {
    return _api;
  }

  ApiProvider._internal() {
    injectInterceptor();
  }

  injectInterceptor() {
    dio.interceptors
        .add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          return options;
        },
        onResponse: (Response response) async {

          return response;
        },
        onError: (DioError e) async {
          print("hello brother: ${e.response.statusCode}");

          return  e;
        }
    ));
  }

  Future<EnquiryDetails> enquiryService(Map<String, dynamic> map) async {
    Response response = await dio.post(baseUrl, data: map);
    if (response != null) {
      return EnquiryDetails.fromJson(response.data);
    }
    return null;
  }

}





