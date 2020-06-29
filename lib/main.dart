/*
 * @Author: web516
 * @Date: 2020-06-15 10:06:52
 * @LastEditTime: 2020-06-23 15:48:22
 * @FilePath: \AndroidStudioProjects\douban\lib\main.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'views/home/home.dart';
import 'views/mine/mine.dart';
import 'views/search/search.dart';
// import 'components/toast.dart';

void main(List<String> args) {
  runApp(MyApp());
  // if (Platform.isAndroid) {
  //   // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
  //   SystemUiOverlayStyle systemUiOverlayStyle =
  //       SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // }
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Project practice of Flutter",
      theme: ThemeData(
        primarySwatch: Colors.green,
        splashColor:Colors.transparent,//将splashColor和highlightColor都设置为透明点击就没有水波纹了
        highlightColor:Colors.transparent
      ),
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}


//闪屏动画组件
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState(){
    _statusBar();
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds:3000));
    _animation = Tween(begin:0.0,end: 1.0).animate(_controller);

    /*动画事件监听器
    它可以监听到动画的执行状态，
    我们这里只监听动画是否结束，
    如果结束则执行页面跳转动作。
   */
    _animation.addStatusListener((status){
      if (status==AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder:(context)=>MyStackPage()),
          (route)=>route==null
        );
      }
    });
    // 播放动画
    _controller.forward();
  }
  
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.network(
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589878855414&di=d5779b0d5b3d292efa28cf2413c58a73&imgtype=0&src=http%3A%2F%2Fd.paper.i4.cn%2Fmax%2F2016%2F05%2F20%2F11%2F1463715731728_778225.jpg',
        scale: 2.0,
        fit: BoxFit.cover,
      ),
    );
  }
}


//底部导航路由组件
class MyStackPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyStackPageState();
  }
}

class MyStackPageState extends State<MyStackPage>{
  DateTime lastPopTime;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(//监听返回按钮
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type:BottomNavigationBarType.fixed,
          unselectedFontSize:14,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("首页")
            ),
            createItem("search","搜索"),
            createItem("mine","我的"),
          ],
          currentIndex: _index,
          onTap: (index){
            setState(() {
              _index = index;
            });
          },
        ),
        body: IndexedStack(
          index: _index,
          children: <Widget>[
            HomePage(),
            SearchPage(),
            MinePage()
          ],
        )
      ),
      onWillPop:() async{
        // 点击返回键的操作
        if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
          lastPopTime = DateTime.now();
          print('再按一次退出');
          Fluttertoast.showToast(
            msg: "再按一次退出应用",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(160, 0, 0, 0),
            textColor: Colors.white,
            fontSize: 16.0
          );
          return false;
        }else{
          lastPopTime = DateTime.now();
          // 退出app
          return await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
    );
  }
}

BottomNavigationBarItem createItem(String iconName,String title){
  return BottomNavigationBarItem(
    title: Text(title),
    icon: Image.asset("assets/images/$iconName.png",width: 24,),
    activeIcon: Image.asset("assets/images/${iconName}_active.png",width: 24,)
  );
}


/// 状态栏样式 沉浸式状态栏
_statusBar([String color]) {
  // 白色沉浸式状态栏颜色  白色文字
  SystemUiOverlayStyle light = SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: null,
    /// 注意安卓要想实现沉浸式的状态栏 需要底部设置透明色
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  // 黑色沉浸式状态栏颜色 黑色文字
  SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: null,
    /// 注意安卓要想实现沉浸式的状态栏 需要底部设置透明色
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
  // 这个地方你可以去掉三目运算符 直接调用你想要的 效果即可
  "while" == color?.trim()
      ? SystemChrome.setSystemUIOverlayStyle(light)
      : SystemChrome.setSystemUIOverlayStyle(dark);
}