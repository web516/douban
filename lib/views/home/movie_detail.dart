/*
 * @Author: web516
 * @Date: 2020-06-18 11:23:54
 * @LastEditTime: 2020-06-23 12:05:20
 * @FilePath: \AndroidStudioProjects\douban\lib\views\home\movie_detail.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';
import '../../components/star_rating.dart';
import '../../network/home_detail_request.dart';
import '../../models/home_detail_model.dart';
import '../../components/loading.dart';
import '../../components/picture_review.dart';

class MovieDetailPage extends StatefulWidget{
  final movieItem;
  MovieDetailPage({
    this.movieItem
  });

  @override
  State<StatefulWidget> createState() {
    return MovieDetailPageState();
  }
}

class MovieDetailPageState extends State <MovieDetailPage>{
  //初始化详情页网络请求
  HomeDetailRequest homeDetailRequest = HomeDetailRequest();
  MovieItemDetail movieItemDetail;
  bool isLoading = false;
  bool isOpen = false;
  int maxLines = 4;
  @override
  void initState() {
    isLoading = true;
    homeDetailRequest.getMovieDetail(widget.movieItem.id)
      .then((res) {
        setState(() {
          movieItemDetail = res;
          //print(movieItemDetail.popularComments);
          isLoading = false;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("电影详情"),
        centerTitle: true,
      ),
      body: isLoading?Loading():getMovieItem(),
    );
  }
  Widget getMovieItem(){
    return Container(
      padding: EdgeInsets.all(10),
      child: getMovieContentWidget(),
    );
  }

  
  //2.具体内容
  Widget getMovieContentWidget(){
    return Container(
      //height: 150,
      child: Container(
        child: ListView(
          children:<Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getContentImage(),
                getContentDesc(),
              ],
            ),
            //标签
            getLabelWidget(),
            //简介
            getSummaryWidget(),
            //演员
            getActorWidget(),
            //剧照
            getPhotosWidget(movieItemDetail.photoList),
            //热门评论
            getHotCommentWidget()
          ]
        ),
      ),
    );
  }
  //2.1左侧图片组件
  Widget getContentImage(){
    return Container(
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(movieItemDetail.images),
      ),
    );
  }
  //2.2中间描述
  Widget getContentDesc(){
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
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
                text: "     "+movieItemDetail.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )
              ),
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
        HLStarRating(rating: movieItemDetail.rating.average, size: 18,selectedColor: Color(0xffFEC11A),),
        SizedBox(width: 5),
        Text("${movieItemDetail.rating.average}")
      ],
    );
  }
  //2.2.3描述内容组件
  Widget getInfoWidget(){
    //获取各类字符串
    final genres = movieItemDetail.genres.join(" ");
    final director = movieItemDetail.directors[0].name;
    String castString = "";
    for(Actor cast in movieItemDetail.casts){
      castString += cast.name + " ";
    }
    //创建Widget
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "上映时间: ${movieItemDetail.year}",
          style: TextStyle(
            fontSize: 14
          ),
        ),
        Text(
          "分类: $genres",
          style: TextStyle(
            fontSize: 14
          ),
        ),
        Text(
          "导演: $director",
          style: TextStyle(
            fontSize: 14
          ),
        ),
        Text(
          "演员: $castString",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14
          ),
        )
      ],
    );
  }
  //3.标签组件
  Widget getLabelWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10,),
        getTitle("标签"),
        SizedBox(height: 5,),
        Container(
          height: 32,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieItemDetail.tags.length,
            itemBuilder: (context,index){
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right:8),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                //width:60,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child:Text(
                  movieItemDetail.tags[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              );
            }
          ),
        )
      ],
    );
  }
  //
  Widget getTitle(title){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right:6),
          height: 25,
          width: 6,
          color: Colors.green,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
  //4.简介组件
  Widget getSummaryWidget(){
    return Container(
      margin: EdgeInsets.only(top:10),
      child:Column(
        children: <Widget>[
          getTitle("简介"),
          SizedBox(height: 6,),
          Text(
            movieItemDetail.summary,
            maxLines: maxLines,
          ),
          isOpen?getRetractWidget("收起",Icons.expand_less,):getRetractWidget("显示全部",Icons.expand_more,)
        ],
      )
    );
  }
  //4.1收起展开组件
  Widget getRetractWidget(String text,IconData icon){
    return InkWell(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(text),
          Icon(icon,size: 26,),
        ],
      ),
      onTap: (){
        if(isOpen){
          setState(() {
            maxLines = 4;
            isOpen = false;
          });
        }else{
          setState(() {
            maxLines = 100;
            isOpen = true;
          });
        }
      },
    );
  }
  //5.演员组件
  Widget getActorWidget(){
    return Column(
      children: <Widget>[
        getTitle("演员"),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieItemDetail.casts.length,
            itemBuilder: (context,index){
              return getSingleActorWidget(movieItemDetail.casts[index]);
            }
          ),
        )
      ],
    );
  }
  //5.1单个演员组件
  Widget getSingleActorWidget(Actor item){
    return Container(
      margin: EdgeInsets.only(top:8,right:12),
      width: 80,
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              item.avatars["medium"],
            ),
          ),
          SizedBox(height: 8,),
          Text(
            item.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
  //6.剧照
  Widget getPhotosWidget(List list){
    return Container(
      margin: EdgeInsets.only(top:10),
      child: Column(
        children: <Widget>[
          getTitle("剧照"),
          Container(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context,index){
                return getSingleImageWidget(list,list[index],index);
              }
            ),
          )
        ],
      ),
    );
  }
  //6.1单个图片组件
  Widget getSingleImageWidget(list,src,index){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(right:10,top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 100,
            width: 150,
            child: Image.network(
              src,
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (c, a, s){
              return PreviewImagesWidget(list,initialPage: index,);
            }
          )
        );
        print(666);
      },
    );
  }
  //7.热门评论组件
  Widget getHotCommentWidget(){
    return Container(
      margin: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        //height: 600,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: ListView(
          shrinkWrap: true, //解决无限高度问题
          physics: NeverScrollableScrollPhysics(), //禁用滑动事件
          children: <Widget>[
            Text(
              "热门评论",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height:10),
            Container(
              //height: 1000,
              child: ListView.builder(
                shrinkWrap: true, //解决无限高度问题
                physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                itemCount: movieItemDetail.popularComments.length,
                itemBuilder: (context,index){
                  return getSingleCommentWidget(movieItemDetail.popularComments[index]);
                }
              ),
            )
          ],
        ),
      ),
    );
  }
  //7.1单个评论
  Widget getSingleCommentWidget(CommentItem item){
    return Container(
      margin: EdgeInsets.only(top:12),
      padding: EdgeInsets.only(bottom:10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white70,
            width: 1,
            style: BorderStyle.solid
          )
        ),
      ),
      //height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  item.author.avatar,
                  scale: 1
                ),
              ),
              SizedBox(width:8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(" "+item.author.name,style: TextStyle(color:Colors.white),),
                  Row(
                    children: <Widget>[
                      StarRating(
                        starRating: item.rating.value,
                        maxStarRting:item.rating.max,
                        size: 18,
                        selectedColor: Colors.orange,
                      ),
                      Text(
                        item.createdAt,
                        style: TextStyle(color:Colors.white)
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(height:10),
          Text(
            item.content,
            style: TextStyle(color:Colors.white)
          )
        ],
      ),
    );
  }
}