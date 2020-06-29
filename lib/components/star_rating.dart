/*
 * @Author: web516
 * @Date: 2020-06-16 11:23:00
 * @LastEditTime: 2020-06-23 11:51:09
 * @FilePath: \AndroidStudioProjects\douban\lib\components\star_rating.dart
 * @web516版权所有，若引用请联系作者QQ:516919611
 */ 
import 'package:flutter/material.dart';

//codewhy 
class HLStarRating extends StatefulWidget {
  final double rating;
  final double maxRating;
  final Widget unselectedImage;
  final Widget selectedImage;
  final int count;
  final double size;
  final Color unselectedColor;
  final Color selectedColor;

  HLStarRating({
    @required this.rating,
    this.maxRating = 10,
    this.size = 30,
    this.unselectedColor = const Color(0xffbbbbbb),
    this.selectedColor = const Color(0xffe0aa46),
    Widget unselectedImage,
    Widget selectedImage,
    this.count = 5,
  }): unselectedImage = unselectedImage ?? Icon(Icons.star, size: size, color: unselectedColor,),
        selectedImage = selectedImage ?? Icon(Icons.star, size: size, color: selectedColor);

  @override
  _HLStarRatingState createState() => _HLStarRatingState();
}

class _HLStarRatingState extends State<HLStarRating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Row(children: getUnSelectImage(), mainAxisSize: MainAxisSize.min),
          Row(children: getSelectImage(), mainAxisSize: MainAxisSize.min),
        ],
      ),
    );
  }

  // 获取评星
  List<Widget> getUnSelectImage() {
    return List.generate(widget.count, (index) => widget.unselectedImage);
  }

  List<Widget> getSelectImage() {
    // 1.计算Star个数和剩余比例等
    double oneValue = widget.maxRating / widget.count;
    int entireCount = (widget.rating / oneValue).floor();
    double leftValue = widget.rating - entireCount * oneValue;
    double leftRatio = leftValue / oneValue;

    // 2.获取start
    List<Widget> selectedImages = [];
    for (int i = 0; i < entireCount; i++) {
      selectedImages.add(widget.selectedImage);
    }

    // 3.计算
    Widget leftStar = ClipRect(
      clipper: MyRectClipper(width: leftRatio * widget.size),
      child: widget.selectedImage,
    );
    selectedImages.add(leftStar);

    return selectedImages;
  }
}


class MyRectClipper extends CustomClipper<Rect>{
  final double width;

  MyRectClipper({
    this.width
  });

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }

  @override
  bool shouldReclip(MyRectClipper oldClipper) {
    return width != oldClipper.width;
  }
}

//自写组件
class StarRating extends StatefulWidget {
  final double starRating;
  final double numbers;
  final double size;
  final double maxStarRting;
  final Color unSelectedColor;
  final Color selectedColor;
  final Widget unSelectedImage;
  final Widget selectedImage;
  StarRating({
    @required this.starRating,
    this.numbers = 5,
    this.maxStarRting = 10,
    this.size = 24,
    Widget unSelectedImage,
    Widget selectedImage,
    this.unSelectedColor = Colors.grey,
    this.selectedColor = Colors.orange
  }):this.unSelectedImage = (unSelectedImage!=null?unSelectedImage:Icon(Icons.star,color: unSelectedColor,size: size,)),
    this.selectedImage = (selectedImage!=null?selectedImage:Icon(Icons.star,color: selectedColor,size: size,));
  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        unSelectedImage(),
        selectedImage(),
      ],
    );
  }
  Widget unSelectedImage(){
    List<Widget> unSelectedImageList = [];
    for(int i=0;i<widget.numbers;i++){
      unSelectedImageList.add(
        widget.unSelectedImage
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: unSelectedImageList,
    );
  }

  Widget selectedImage(){
    double oneValue = widget.maxStarRting/widget.numbers;//一个星星代表的分值
    int wholeNum = (widget.starRating/oneValue).floor();//完整的星星个数
    double halfWidth = (widget.starRating - oneValue*wholeNum)/oneValue*widget.size;//不完整星星的宽度

    List<Widget> selectedImageList = [];
    for(int i=0;i<wholeNum;i++){
      selectedImageList.add(
        widget.selectedImage
      );
    }

    Widget halfStar(){//裁切星星
      return ClipRect(
        clipper: MyClipper(halfWidth),
        child: widget.selectedImage,
      );
    }

    selectedImageList.add(halfStar());
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: selectedImageList,
    );
  }
}

class MyClipper extends CustomClipper<Rect>{
  final double width;
  MyClipper(this.width);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width,size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}