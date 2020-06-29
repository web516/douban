/*
 * @Author: web516
 * @Date: 2020-06-19 12:32:48
 * @LastEditTime: 2020-06-22 18:22:02
 * @FilePath: \AndroidStudioProjects\douban\lib\models\home_detail_model.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
//评分

class Rating{
  double max;
  double average;
  double value;
  Rating.fromMap(Map<String,dynamic>json){
    this.max = json["max"].toDouble();
    this.value = json["value"];
    this.average = json["average"];
  }
}
//片源
class VideosItem{
  Map<String,dynamic> source;
  String sampleLink;
  String videoId;
  VideosItem.fromMap(Map<String,dynamic>json){
    this.source = json["source"];
    this.sampleLink = json["sample_link"];
    this.videoId = json["video_id"];
  }
}
//评论
class CommentItem{
  Rating rating;
  int usefulCount;
  Author author;
  String subjectId;
  String content;
  String createdAt;
  String id;
  CommentItem.fromMap(Map<String,dynamic>json){
    this.rating = Rating.fromMap(json["rating"]);
    this.usefulCount = json["useful_count"];
    this.author = Author.fromMap(json["author"]);
    this.subjectId = json["subject_id"];
    this.content = json["content"];
    this.createdAt = json["created_at"];
    this.id = json["id"];
  }
}
class Person{
  Map<String,dynamic> avatars;
  String name;
  String alt;
  String id;
  Person.fromMap(Map<String,dynamic>json){
    this.avatars = json["avatars"];
    this.name = json["name"];
    this.alt = json["ail"];
    this.id = json["id"];
  }
}
//评论者
class Author{
  String avatar;
  String name;
  String alt;
  String id;
  Author.fromMap(Map<String,dynamic>json){
    this.avatar = json["avatar"];
    this.name = json["name"];
    this.alt = json["ail"];
    this.id = json["id"];
  }
}
//作者
class Writer extends Person{
  Writer.fromMap(Map<String,dynamic>json):super.fromMap(json);
}
// 演员
class Actor extends Person{
  Actor.fromMap(Map<String,dynamic>json):super.fromMap(json);
}
//导演
class Director extends Person{
  Director.fromMap(Map<String,dynamic>json):super.fromMap(json);
}
//剧照
class PhotoItem{
  String thumb;
  String image;
  String cover;
  String alt;
  String id;
  String icon;
  PhotoItem.fromMap(Map<String,dynamic>json){
    this.thumb = json["thumb"];
    this.image = json["image"];
    this.cover = json["cover"];
    this.alt = json["alt"];
    this.icon = json["icon"];
    this.id = json["id"];
  }
}

class MovieItemDetail {
  Rating rating;//电影评分
  int reviewsCount;
  List<VideosItem> videos;
  int wishCount;//想看人数
  String originalTitle;//原始名字
  String images;//海报
  String year;//上映年份
  List<CommentItem> popularComments;//热门评论
  String alt;//电影主页
  String id;//电影id
  String mobileUrl;//手机地址
  String title;//名字
  bool hasVideo;//是否有片源
  List<dynamic> languages;//语言
  List<Writer> writers;//作者
  List<dynamic> tags;//标签
  List<dynamic> durations;//时长
  List<dynamic> genres;//类别
  List<dynamic> trailerUrls;//预告片
  List<Actor> casts;//演员
  List<dynamic> countries;//国家
  List<PhotoItem> photos;//剧照
  List<dynamic> photoList;//剧照列表
  String summary;//简介
  List<Director> directors;//导演
  int commentsCount;//评论人数
  int ratingsCount;//评分人数
  List<dynamic> aka;//别名
  MovieItemDetail.fromMap(Map<String,dynamic>json){
    this.rating = Rating.fromMap(json["rating"]);
    this.reviewsCount = json["reviews_count"];
    this.videos = (json["videos"] as List<dynamic>).map((item) {
      return VideosItem.fromMap(item);
    }).toList();
    // for(Map<String,dynamic> videoitem in json["videos"]){
    //   this.videos.add(VideosItem.fromMap(videoitem));
    // }
    this.wishCount = json["wish_count"];
    this.originalTitle = json["original_title"];
    this.images = json["images"]["medium"];
    this.year = json["year"];
    this.popularComments = (json["popular_comments"] as List<dynamic>).map((item) {
      return CommentItem.fromMap(item);
    }).toList();
    // for(Map<String,dynamic>comment in json["popular_comments"]){
    //   this.popularComments.add(CommentItem.fromMap(comment));
    // }
    this.alt = json["alt"];
    this.id = json["id"];
    this.mobileUrl = json["mobile_url"];
    this.title = json["title"];
    this.hasVideo = json["has_video"];
    this.languages = json["languages"];
    this.writers = (json["writers"] as List<dynamic>).map((item) {
      return Writer.fromMap(item);
    }).toList();
    // for(Map<String,dynamic>writer in json["writers"]){
    //   this.writers.add(Writer.fromMap(writer));
    // }
    this.tags = json["tags"];
    this.durations = json["durations"];
    this.genres = json["genres"];
    this.trailerUrls = json["trailer_urls"];
    this.casts = (json["casts"] as List<dynamic>).map((item) {
      return Actor.fromMap(item);
    }).toList();
    this.countries = json["countries"];
    this.photos = (json["photos"] as List<dynamic>).map((item) {
      return PhotoItem.fromMap(item);
    }).toList();
    this.photoList = (json["photos"] as List).map((item) {
      return item["thumb"];
    }).toList();
    // for(Map<String,dynamic>photo in json["photos"]){
    //   this.photoList.add(photo["thumb"]);
    // }
    this.summary = json["summary"];
    this.directors = (json["directors"] as List<dynamic>).map((item) {
      return Director.fromMap(item);
    }).toList();
    // for(Map<String,dynamic>director in json["directors"]){
    //   this.directors.add(Director.fromMap(director));
    // }
    this.commentsCount = json["comments_count"];
    this.ratingsCount = json["ratings_count"];
    this.aka = json["aka"];
  }
}