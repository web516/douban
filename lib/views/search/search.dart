/*
 * @Author: web516
 * @Date: 2020-06-15 10:09:24
 * @LastEditTime: 2020-06-23 16:51:34
 * @FilePath: \AndroidStudioProjects\douban\lib\views\search\search.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
const searchList = [
  "jiejie-大长腿",
  "jiejie-水蛇腰",
  "gege1-帅气欧巴",
  "gege2-小鲜肉"
];

const recentSuggest = [
  "推荐-1",
  "推荐-2"
];

const imageList = [
  "assets/images/0.jpg",
  "assets/images/1.jpg",
  "assets/images/2.jpg",
  "assets/images/3.jpg",
  "assets/images/4.webp",
];
class SearchPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchBarDemo()
    );
  }
}

class SearchBarDemo extends StatefulWidget {
  @override
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  _launchURL() async {
    const url = 'http://qss.516ku.cn';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              //print("开始搜索");
              showSearch(context: context,delegate: SearchBarDelegate());
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height:12),
          Container(
            height: 180,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageList[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
              itemCount: imageList.length,
              viewportFraction: 0.8,
              scale: 0.9,
              pagination: SwiperPagination(),
              autoplay:true,
              autoplayDelay:5000
              //control: SwiperControl(),
            ),
          ),
          SizedBox(height:20),
          Center(
            child: InkWell(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    "assets/images/quan.png",
                    width: 48,
                  ),
                ),
              ),
              onTap: (){
                _launchURL();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBarDelegate extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context){
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color:Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context){
    final suggestionList = query.isEmpty
        ? recentSuggest
        : searchList.where((input)=>input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder:(context,index)=>ListTile(
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0,query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children:[
              TextSpan(
                text:suggestionList[index].substring(query.length),
                style:TextStyle(
                  color:Colors.grey
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}