/*
 * @Author: web516
 * @Date: 2020-06-19 12:31:12
 * @LastEditTime: 2020-06-20 09:19:33
 * @FilePath: \AndroidStudioProjects\douban\lib\network\home_detail_request.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 

import 'http_request.dart';
import '../models/home_detail_model.dart';

class HomeDetailRequest {
  Future<MovieItemDetail> getMovieDetail(String id)async{
    //1.拼接url
    final url = 'http://api.douban.com/v2/movie/subject/$id';

    //2.发送请求
    final result = await HttpRequest.request(url);
    //3.转成模型对象
    final movieData = result.data;
    MovieItemDetail movieDetail = MovieItemDetail.fromMap(movieData);
    
    return movieDetail;
  }
}