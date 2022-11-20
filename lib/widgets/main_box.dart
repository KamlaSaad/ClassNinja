import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
Widget MainBox(double w,String img,bool fav,String price,String title,String sub,String address){
  var radius=Radius.circular(10);
  return Container(
    width: w,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(7),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: inputColor.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 3,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
     gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [inputColor,inputColor.withOpacity(0.4)],
        )
    ),
    child: Column(mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Container(height: 120,width: width*0.4,
            padding: EdgeInsets.all(5),
            alignment: Alignment.topRight,
          decoration: BoxDecoration(color: Colors.white,
              image: DecorationImage(image: AssetImage("imgs/glass2.png"),fit:BoxFit.fill),
          borderRadius: BorderRadius.circular(10)),
          child: CircleAvatar(radius: 16,
              backgroundColor: inputColor.withOpacity(0.8),
            child: Center(
              child: IconButton(icon: Icon(Icons.favorite,size: 16,
                color: fav?Colors.red:Colors.grey,),onPressed: (){}),
            )),
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Txt(" $price ", mainColor, 16, FontWeight.bold),
            Txt(sub, Colors.grey, 13, FontWeight.normal),
          ],
        ),
        SizedBox(height: 6),
        Txt(title, Colors.black, 17, FontWeight.bold),
        SizedBox(height: 4),
        Txt(address, Color(0xffaaaaaa), 14, FontWeight.w500),

      ],
    ),
  );
}