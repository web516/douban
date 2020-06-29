/*
 * @Author: web516
 * @Date: 2020-06-20 10:33:44
 * @LastEditTime: 2020-06-20 11:53:47
 * @FilePath: \AndroidStudioProjects\douban\lib\components\loading.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/loading.gif",
            width: 30,
          ),
          SizedBox(height: 2,),
          Text(
            "加载中",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}