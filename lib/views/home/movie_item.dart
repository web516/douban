/*
 * @Author: web516
 * @Date: 2020-06-16 11:20:22
 * @LastEditTime: 2020-06-18 12:37:21
 * @FilePath: \AndroidStudioProjects\douban\lib\views\home\movie_item.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';
import '../../models/home_model.dart';

import '../../components/dash_line.dart';
import '../../components/star_rating.dart';
import '../../components/custom_router.dart';

import 'movie_detail.dart';

class MovieListItem extends StatelessWidget{
  final MovieItem movieItem;
  MovieListItem(this.movieItem);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context, 
          CustomeRoute(
            MovieDetailPage(movieItem: movieItem,)
          )
        );
      },
      child: getMovieItem()
    );
  }
  Widget getMovieItem(){
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffe2e2e2),
            width: 10,
            style: BorderStyle.solid
          )
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 1.电影排名
          getMovieRankWidget(),
          SizedBox(height: 12),
          // 2.具体内容
          getMovieContentWidget(),
          SizedBox(height: 12),
          // 3.电影简介
          getMovieIntroduceWidget(),
          SizedBox(height: 12,)
        ],
      ),
    );
  }

  //1.排名组件
  Widget getMovieRankWidget (){
    return Container(
      padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(255, 238, 205, 144)
      ),
      child: Text(
        "NO.${movieItem.rank}",
        style: TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 131, 95, 36)
        ),
      ),
    );
  }

  //2.具体内容
  Widget getMovieContentWidget(){
    return Container(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getContentImage(),
          getContentDesc(),
          getDashLine(),
          getContentWish()
        ],
      ),
    );
  }
  //2.1左侧图片组件
  Widget getContentImage(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(movieItem.imageURL),
    );
  }
  //2.2中间描述
  Widget getContentDesc(){
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTitleWidget(),
            SizedBox(height: 3,),
            getRatingWidget(),
            SizedBox(height: 3,),
            getInfoWidget()
          ],
        ),
      )
    );
  }
  //2.2.1描述标题组件
  Widget getTitleWidget(){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top:0),
          child: Icon(Icons.play_circle_outline,color: Colors.redAccent,size: 22,)
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "     "+movieItem.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )
              ),
              TextSpan(
                text: "(${movieItem.playDate})",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54
                )
              )
            ]
          )
        )
      ],
    );
  }
  //2.2.2描述评分组件
  Widget getRatingWidget(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        HLStarRating(rating: movieItem.rating, size: 18,selectedColor: Color(0xffFEC11A),),
        SizedBox(width: 5),
        Text("${movieItem.rating}")
      ],
    );
  }
  //2.2.3描述内容组件
  Widget getInfoWidget(){
    //获取各类字符串
    final genres = movieItem.genres.join(" ");
    final director = movieItem.director.name;
    String castString = "";
    for(Actor cast in movieItem.casts){
      castString += cast.name + " ";
    }
    //创建Widget
    return Text(
      "$genres / $director / $castString",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16
      ),
    );
  }
  //2.3虚线组件
  Widget getDashLine(){
    return Container(
      width: 1,
      height: 100,
      child: HLDashedLine(
        axis: Axis.vertical,
        dashedHeight: 6,
        dashedWidth: .5,
        count: 12,
        color: Colors.grey,
      ),
    );
  }
  //2.4喜欢组件
  Widget getContentWish(){
    return Container(
      width: 60,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/wish.png",
            width: 30,
          ),
          Text(
            "想看",
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 235, 170, 60)),
          )
        ],
      ),
    );
  }

  //3.电影简介
  Widget getMovieIntroduceWidget(){
    return Container(
      padding: EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(10, 0, 0, 0),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text(
        movieItem.originalTitle,
        style: TextStyle(fontSize: 18, color: Colors.black54),
      ),
    );
  }
}

