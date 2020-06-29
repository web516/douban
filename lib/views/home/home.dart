/*
 * @Author: web516
 * @Date: 2020-06-15 10:08:58
 * @LastEditTime: 2020-06-28 11:29:29
 * @FilePath: \AndroidStudioProjects\douban\lib\views\home\home.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:loading_indicator_view/loading_indicator_view.dart';
import '../../models/home_model.dart';
import '../../network/home_request.dart';
import 'movie_item.dart';
import '../../components/loading.dart';


const COUNT = 20;

class HomePage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("首页"),
        centerTitle: true,
      ),
      body:BodyContent()
    );
  }
}
class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class BodyContent extends StatefulWidget {
  @override
  _BodyContentState createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  //初始化首页的网络请求对象
  HomeRequest homeRequest = HomeRequest();
  int page = 0;
  int _start = 0;
  bool isLoading=false;
  List<MovieItem> movieItems=[];

  ScrollController _controller;
  bool _isShowTop = false;

  @override
  void initState() {
    _controller = ScrollController();

    //获取电影列表
    getMovieTopList(_start,COUNT);

    _controller.addListener(() {
      //监听滚动距离，判断是否显示回到顶部按钮
      var tempSsShowTop = _controller.offset >= 1000;
      if (tempSsShowTop != _isShowTop) {
        setState(() {
          _isShowTop = tempSsShowTop;
        });
      }
      //监听触底加载
      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        print(_start);
      
        getMovieTopList(_start,COUNT);
        print("开始加载。。。");
      }
    });
    super.initState();

    // HttpRequest.request("https://api.douban.com/v2/movie/top250?start=0&count=20")
    //   .then((res){
    //     final subjects = res.data["subjects"];
    //     // print(subjects);
    //     // print(subjects.runtimeType);
    //     List<MovieItem> movies = [];
    //     for(var sub in subjects){
    //       movies.add(MovieItem.fromMap(sub));
    //     }
    //     setState(() {
    //       movieItems = movies;
    //     });
    //   });
  }
  void getMovieTopList(int start,int count){
    setState(() {
      isLoading = true;
    });
    homeRequest.getTopList(start,count).then((res){
      setState(() {
        movieItems.addAll(res);
        isLoading = false;
        page++;
        _start = page*COUNT;
      });
    });
  }

  Future _onRefresh() async {
    setState(() {
      counter = 1;
      page = 0;
      _start = 0;
      movieItems=[];
    });
    getMovieTopList(_start,COUNT);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        RefreshIndicator(//下拉刷新
          onRefresh:_onRefresh,
          child: ListView.builder(
            controller: _controller,
            itemCount: movieItems.length,
            itemBuilder: (BuildContext context, int index){
              return MovieListItem(movieItems[index]);
            }
          ),
        ),
        isLoading?Loading():SizedBox(height: 0,width: 0,),
        Align(
          alignment: Alignment(0.9,0.96),
          child: _isShowTop ? Container(
            width: 36,
            child: FloatingActionButton(
              onPressed: () {
                _controller.animateTo(0, duration: Duration(milliseconds: 1000), curve: Curves.ease);
              },
              child: Icon(Icons.arrow_upward),
            ),
          ) : null,
        )
      ],
    );
  }
}