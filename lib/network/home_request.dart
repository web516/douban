/*
 * @Author: web516
 * @Date: 2020-06-16 10:14:55
 * @LastEditTime: 2020-06-16 16:04:32
 * @FilePath: \AndroidStudioProjects\douban\lib\network\home_request.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'http_request.dart';
import '../models/home_model.dart';

class HomeRequest {
  Future<List<MovieItem>> getTopList(int start,int count)async{
    //1.拼接url
    final url = "https://api.douban.com/v2/movie/top250?start=$start&count=$count";

    //2.发送请求
    final result = await HttpRequest.request(url);
    //3.转成模型对象
    final subjects = result.data["subjects"];
    List<MovieItem> movies = [];
    for(var sub in subjects){
      movies.add(MovieItem.fromMap(sub));
    }
    
    return movies;
  }
}