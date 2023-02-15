import 'dart:async';

import 'package:E3yoon/controllers/call_Contrls/share_orders.dart';
import 'package:E3yoon/controllers/get_token.dart';
import 'package:E3yoon/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/fav_controller.dart';
// FavController favController=Get.put(FavController());
Widget MainBox(double w,String img,iconBtn,bool addIcon,int id,String price,String title,String sub,String address){
  return Container(
      width: w,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(8),
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
      // child:  new LayoutBuilder(
      // builder: (BuildContext context, BoxConstraints constraints) {
      //   double w=constraints.maxWidth >350?width*0.4:width*0.34;
      child:Column(mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(height: 110,
              width: w,
              // padding: EdgeInsets.all(5),
              // alignment: Alignment.topRight,
              decoration: BoxDecoration(color: Colors.white,
                  image: img.isNotEmpty? DecorationImage(image:NetworkImage(img),fit: BoxFit.fill):null,
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  // img.isNotEmpty?Center(child: Image(image:NetworkImage(img),width: w,height: 90,))
                  //     :SizedBox(height: 0,),
                  iconBtn!=null?Positioned(top: 6,right: 6,
                      child: CircleAvatar(radius: 14,
                          backgroundColor: inputColor.withOpacity(0.8),
                          child: Center( child: iconBtn)))
                      :SizedBox(width: 0,height: 0)
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              price.isNotEmpty?SingleChildScrollView(scrollDirection: Axis.horizontal,
                child:Row(
                    children: [
                      Txt(" $price ", mainColor, 16, FontWeight.w700),
                      Txt(sub, Colors.grey, 13, FontWeight.normal),
                    ]),
              ):SizedBox(height: 0),
              title.isNotEmpty?SingleChildScrollView(scrollDirection: Axis.horizontal,
                  child: Txt(title, Colors.black, 15, FontWeight.w600)):SizedBox(height: 0),
            ],),
            sub.isEmpty && addIcon&&userType.value=="client"?addOrder(title,id):SizedBox(width: 0,)
          ],),
          SizedBox(height: 4),
          address.isNotEmpty?Directionality(textDirection: TextDirection.ltr,
              child:SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Txt(address, Color(0xffaaaaaa), 13, FontWeight.w600))):SizedBox(height: 0),
        ],
      )
  );

}
Widget addOrder(String title,int id){
  return Column(
    children: [
      CircleAvatar(radius: 18,backgroundColor: mainColor,child:
      IconButton(icon: Icon(Icons.add,color: Colors.white,size: 18,),onPressed: ()async{

        print("ad is $id");
        bool exist=ordersController.orderExist(id);
        print(exist);
        confirmBox(title, exist?"هل انت متاكد من طلب هذا المنتج مرة اخري؟":"هل انت متاكد من طلب هذا المنتج؟", ()async{
          Timer(Duration(milliseconds: 100), () {
            Get.back();
          });
          await ordersController.addOrder(id);
        });
      }),),
      SizedBox(height: 5,),
      Txt("اطلب", mainColor, 13, FontWeight.w600),
      // SizedBox(height: 2),

    ],
  );
}
