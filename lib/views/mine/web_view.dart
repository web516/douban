/*
 * @Author: web516
 * @Date: 2020-06-29 14:14:27
 * @LastEditTime: 2020-06-29 16:46:08
 * @FilePath: \douban\lib\views\mine\web_view.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';//分享插件
import '../../components/loading.dart';


class WebViewPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage>{
  String _title = "WebView";
  WebViewController _controller;
  bool isLoaded = false;
 
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(_title),
        centerTitle: true,
        actions:[
          FlatButton(
            child: Icon(Icons.share,color: Colors.white,),
            onPressed: (){
              final RenderBox box = context.findRenderObject();
              Share.share(//分享功能
                "Flutter学习项目地址:https://github.com/web516/douban",//分享具体内容
                subject: "这是分享",
                sharePositionOrigin:box.localToGlobal(Offset.zero) & box.size
              );
            },
          ),
        ]
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://github.com/web516/douban',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              //_controller.complete(webViewController);
            },
            onPageFinished: (url) {
                _controller.evaluateJavascript("document.title").then((result){
                  setState(() {
                    _title = result;
                    isLoaded = true;
                  });
                }
              );
            },
          ),
          isLoaded ? SizedBox(width:0,height:0) : Loading()
        ],
      ),
    );
  }
}

