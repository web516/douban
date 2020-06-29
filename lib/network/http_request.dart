/*
 * @Author: web516
 * @Date: 2020-06-15 14:55:45
 * @LastEditTime: 2020-06-16 15:55:39
 * @FilePath: \AndroidStudioProjects\douban\lib\network\http_request.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:dio/dio.dart';
import 'http_config.dart';

class HttpRequest {
  static BaseOptions baseOptions = BaseOptions(//创建实例的相关设置
    baseUrl:baseUrl,
    connectTimeout:timeout,
    queryParameters:{
      "apikey":"0df993c66c0c636e29ecbb5344252a4a"
    }
  );
  //1.创建dio实例
  static final dio = Dio(baseOptions);

  static Future request(String url,{method="get",Map<String,dynamic>params}) async{
    
    //2.发送网络请求
    Options options = Options(//发送网络请求的设置
      method: method
    );
    try{
      Response response =await dio.request(url,queryParameters:params,options:options);
      return response;
    } on DioError catch(err){
      throw err;
    }
  }
}