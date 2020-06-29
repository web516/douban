/*
 * @Author: web516
 * @Date: 2020-06-22 16:20:20
 * @LastEditTime: 2020-06-22 17:10:26
 * @FilePath: \AndroidStudioProjects\douban\lib\components\picture_review.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
class PreviewImagesWidget extends StatefulWidget {
  ///图片Lst
  final List<dynamic> imageList;

  ///初始展示页数。默认0
  int initialPage;

  ///选中的页的点的颜色
  Color checkedColor;

  ///未选中的页的点的颜色
  Color uncheckedColor;

  PreviewImagesWidget(this.imageList,
      {this.initialPage = 0,
      this.checkedColor = Colors.white,
      this.uncheckedColor = Colors.grey});

  @override
  _PreviewImagesWidgetState createState() =>
      _PreviewImagesWidgetState(initialPage: initialPage);
}

class _PreviewImagesWidgetState extends State<PreviewImagesWidget> {
  PageController pageController;
  int nowPosition;
  int initialPage;
  List<Widget> dotWidgets;

  _PreviewImagesWidgetState({this.initialPage = 0});

  @override
  void initState() {
    super.initState();
    nowPosition = initialPage;
    pageController = PageController(initialPage: initialPage);
    _initData();
  }

  void _initData() {
    dotWidgets = [];
    if (widget.imageList.length > 1) {
      for (int i = 0; i < widget.imageList.length; i++) {
        dotWidgets.add(_buildDots(i));
      }
    }
  }

  Widget _buildDots(int index) => Container(
        margin: EdgeInsets.all(5),
        child: ClipOval(
          child: Container(
            color: index == nowPosition
                ? widget.checkedColor
                : widget.uncheckedColor,
            width: 5.0,
            height: 5.0,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PhotoViewGallery.builder(
            onPageChanged: (index) {
              setState(() {
                nowPosition = index;
                _initData();
              });
            },
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(widget.imageList[index]),
              );
            },
            itemCount: widget.imageList.length,
            pageController: pageController,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Wrap(
              children: dotWidgets,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
}
