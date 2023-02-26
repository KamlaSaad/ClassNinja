import 'package:E3yoon/controllers/get_token.dart';
import 'package:E3yoon/widgets/bottom_bar.dart';
import 'package:E3yoon/widgets/shared.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../controllers/call_Contrls/share_chat.dart';
import '../../controllers/call_Contrls/share_orders.dart';
class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    if(ordersController.myOrders.isEmpty){
      ordersController.getOrders();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(appBar: MainBar("الطلبات", 25, true, false),
        body: Obx(()=>
            ordersController.myOrders.isNotEmpty ?
            ListView.builder(itemCount: ordersController.myOrders.length,
              itemBuilder: (BuildContext context,int i){
              var item=ordersController.myOrders[i]['ad'];
              // print(userType.value);
              // print(item);
                return Box(item['image'],item['title'],item['price'],
                    userType.value=="client"?item['provider']:ordersController.myOrders[i]['user'],userType.value=="client");
              },
            )
            : ordersController.online.isTrue ?
            (ordersController.loading.isTrue?
            Center(child: CircularProgressIndicator(color: mainColor))
                : Center(child: Txt(
                "لايوجد طلبات بعد", Colors.black, 15, FontWeight.w600)))
                : Center(child: Txt(
                "لايوجد اتصال بالانترنت", Colors.black, 15,
                FontWeight.w600),))

      ),
    );
  }

  Widget Box(String img,String title,var price,Map provider,bool client){
    return Container(margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: inputColor,borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
       Row(
         children: [
           Container(width: width*0.4,height: 70,
             margin: EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: NetworkImage(img),fit: BoxFit.fill)
            ),
           ),
           SizedBox(width: 10),
           Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(width: width*0.45,child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                   child: Txt(title, Colors.black, 18, FontWeight.w600),),
               ),
               SizedBox(height: 8),
               Txt("SR $price",mainColor, 17, FontWeight.w600)
             ],
           )
         ],
       ),
       Divider(color: mainColor,thickness: 1,),
         ListTile(
         leading: defaultImg(provider['image'],21),
         title:   SizedBox(width: width*0.65,child: SingleChildScrollView(scrollDirection: Axis.horizontal,
          child: Txt(provider['name'], Colors.black, 17, FontWeight.w600))),
         contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
         subtitle: Padding(
           padding: const EdgeInsets.only(top: 8),
           child: Txt(provider['phone'], Colors.black, 16, FontWeight.w600),
         ),
         trailing: Container(width: 80,
           padding: const EdgeInsets.only(bottom:20),
           child: Row(mainAxisAlignment: MainAxisAlignment.end,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Transform.translate(
                offset: Offset(0,-7),
                 child: IconButton(onPressed: (){
                   String user=client?"provider${provider['id']}":"client${provider['id']}";
                   print(user);
                   Map chat=chatContrl.getChatByUsers(user);
                   if(chat.isEmpty){
                     chatContrl.chatId.value="";
                     chatContrl.chat.value={"id":"","name":provider['name'],
                       "img":provider['image']??"","receiver":user };
                   }else{
                     chatContrl.chatId.value=chat['id'];
                     chatContrl.chat.value=chat;
                   }
                   print(chatContrl.chat.value);
                   Get.toNamed("/chat");
                 }, icon: Icon(Icons.message,size: 30)),
               )
               ,CircleAvatar(backgroundColor: Colors.blue,radius: 15,
                 child: IconButton(icon: Icon(Icons.call,color: Colors.white,size: 15,),onPressed: (){
                   launch("tel://${provider['phone']}");
                 }),
               ),
             ],
           ),
         ),
       )
      ],
      ),
    );
  }


}
