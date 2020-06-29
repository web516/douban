/*
 * @Author: web516
 * @Date: 2020-06-16 11:22:46
 * @LastEditTime: 2020-06-17 13:05:44
 * @FilePath: \douban\lib\components\dash_line.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';

class HLDashedLine extends StatelessWidget {
  final Axis axis;
  final double dashedWidth;
  final double dashedHeight;
  final int count;
  final Color color;

  HLDashedLine({
    @required this.axis,
    this.dashedWidth = 1,
    this.dashedHeight = 1,
    @required this.count,
    this.color = const Color(0xffff0000)
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 根据宽度计算个数
        return Flex(
          direction: this.axis,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(this.count, (int index) {
            return SizedBox(
              width: dashedWidth,
              height: dashedHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class DashedLine extends StatelessWidget{
  final Axis axis;
  final double lengthOfLine;
  final double sWidth;
  final double sHeight;
  final double density;
  final Color color;
  DashedLine({
    @required this.axis, //虚线的方向
    @required this.lengthOfLine, //虚线的长度
    this.sWidth = 6, //小线的宽度
    this.sHeight = 2, //小线的高度
    double density, //虚线的密集度
    this.color = Colors.red //线的颜色
  }):this.density=(axis==Axis.horizontal?lengthOfLine/sWidth*3/5:lengthOfLine/sHeight*3/5);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: axis==Axis.horizontal ? lengthOfLine:sWidth,
      height: axis==Axis.horizontal ? sHeight:lengthOfLine,
      child: Flex(
        direction: axis,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: createWidgetList(),
      ),
    );
  }

  Widget createLine(){
    return Container(
      width: sWidth,
      height: sHeight,
      color: color,
    );
  }
  List<Widget> createWidgetList(){
    List<Widget> lists = [];
    for(int i=0;i<density;i++){
      lists.add(createLine());
    }
    return lists;
  }
}