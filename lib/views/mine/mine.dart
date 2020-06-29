/*
 * @Author: web516
 * @Date: 2020-06-15 10:11:09
 * @LastEditTime: 2020-06-29 16:35:44
 * @FilePath: \douban\lib\views\mine\mine.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'web_view.dart';

class MinePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title:Text("我的"),
      //   centerTitle: true,
      // ),
      body: Mybody(),
    );
  }
}
class Mybody extends StatelessWidget {
  _launchURL() async {
    const url = 'http://www.516919.net';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //     color: Colors.red,
            //     offset: Offset(0,-55),
            //     blurRadius: 5.0, //阴影模糊程度
            //     spreadRadius: 0.0 //阴影扩散程度
            //   ),
            // ]
          ),
          child: Column(
            children: <Widget>[
              ListTileWidget(
                icon: Image.asset(
                  "assets/images/github.png",
                  width: 24,
                ),
                title: "项目地址",
                clickFn: (){
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (BuildContext context){
                      return WebViewPage();
                    })
                  );
                },
              ),
              ListTileWidget(
                icon: Image.asset(
                  "assets/images/qq.png",
                  width: 24,
                ),
                title: "我的QQ号",
                clickFn: (){
                  Clipboard.setData(ClipboardData(text: '516919611'));
                  Fluttertoast.showToast(
                    msg: "QQ号复制成功",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(160, 0, 0, 0),
                    textColor: Colors.white,
                    fontSize: 16.0
                  );
                },
              ),
              ListTileWidget(
                icon: Image.asset(
                  "assets/images/watch.png",
                  width: 24,
                ),
                title: "我的微信号",
                clickFn: (){
                  Clipboard.setData(ClipboardData(text: 'web516919'));
                  Fluttertoast.showToast(
                    msg: "微信号复制成功",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color.fromARGB(160, 0, 0, 0),
                    textColor: Colors.white,
                    fontSize: 16.0
                  );
                },
              ),
              ListTileWidget(
                icon: Image.asset("assets/images/blog.png",width: 24,),
                title: "我的博客",
                clickFn: _launchURL,
              )
            ],
          ),
        )
      ],
    );
  }
}

class Header extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius:BorderRadius.circular(30),
            child: Image.asset(
              "assets/images/logo.jpeg",
              width: 60,
            ),
          ),
          SizedBox(height:10),
          Text(
            "WEB516",
            style: TextStyle(
              color:Colors.white,
              fontSize:18,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final icon;
  final String title;
  final clickFn;
  ListTileWidget({
    this.icon,
    this.title,
    this.clickFn
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      decoration: BoxDecoration(
        border: Border(
          bottom:BorderSide(color: Colors.black12,width: 1)
        )
      ),
      child: ListTile(
        leading: this.icon,
        title: Text(
          this.title,
          style: TextStyle(
            color:Colors.black87,
            fontSize: 18,
          ),
        ),
        trailing: Icon(Icons.chevron_right,color: Colors.black54,size: 30,),
        onTap: clickFn,
      ),
    );
  }
}