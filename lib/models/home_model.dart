/*
 * @Author: web516
 * @Date: 2020-06-15 17:38:29
 * @LastEditTime: 2020-06-19 11:14:35
 * @FilePath: \AndroidStudioProjects\douban\lib\models\home_model.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
class Person{
  String name;
  //String avatarURL;
  Person.fromMap(Map<String,dynamic>json){
    this.name = json["name"];
    //this.avatarURL = json["avatars"]["medium"];
  }
}
class Actor extends Person{
  Actor.fromMap(Map<String,dynamic>json):super.fromMap(json);
}

class Director extends Person{
  Director.fromMap(Map<String,dynamic>json):super.fromMap(json);
}

int counter = 1;
class MovieItem{
  double rating;
  List<String> genres;
  String title;
  List<Actor> casts;
  String originalTitle;
  Director director;
  String imageURL;
  String playDate;
  int rank;
  String id;
  MovieItem.fromMap(Map<String, dynamic> json) {
    this.rank = counter++;
    this.imageURL = json["images"]["medium"];
    this.title = json["title"];
    this.playDate = json["year"];
    this.rating = json["rating"]["average"];
    this.genres = json["genres"].cast<String>();
    this.casts = (json["casts"] as List<dynamic>).map((item) {
      return Actor.fromMap(item);
    }).toList();
    this.director = Director.fromMap(json["directors"][0]);
    this.originalTitle = json["original_title"];
    this.id = json["id"];
  }
}