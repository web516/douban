/*
 * @Author: web516
 * @Date: 2020-06-18 12:32:29
 * @LastEditTime: 2020-06-18 12:40:16
 * @FilePath: \AndroidStudioProjects\douban\lib\components\custom_router.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';

class CustomeRoute extends PageRouteBuilder{
  final Widget widget;
  CustomeRoute(this.widget)
    :super(
      transitionDuration:const Duration(milliseconds:400),
      pageBuilder:(
        BuildContext context,
        Animation<double> animation1,
        Animation<double> animation2
      ){return widget;},
      transitionsBuilder:(
        BuildContext context,
        Animation<double> animation1,
        Animation<double> animation2,
        Widget child
      ){
        //渐隐渐现过度效果
        // return FadeTransition(
        //   opacity: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
        //     parent: animation1,
        //     curve: Curves.fastOutSlowIn
        //   )),
        //   child: child,
        // );

        //缩放动画
        // return ScaleTransition(
        //   scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
        //     parent:animation1,
        //     curve:Curves.fastOutSlowIn
        //   )),
        //   child: child,
        // );

        //缩放+旋转动画
        // return RotationTransition(
        //   turns: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
        //     parent: animation1,
        //     curve: Curves.fastOutSlowIn
        //   )),
        //   child: ScaleTransition(
        //     scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
        //       parent: animation1,
        //       curve: Curves.fastOutSlowIn
        //     )),
        //     child: child,
        //   ),
        // );

        //左右路由滑动动画
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1.0,0.0),
            end: Offset(0.0,0.0)
          ).animate(CurvedAnimation(
            parent: animation1,
            curve: Curves.easeInOut
          )),
          child: child,
        );
      }
    );
}