
import 'package:E3yoon/controllers/call_Contrls/share_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/get_token.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/shared.dart';

// import '../../controllers/auth_controller.dart';
// import '../../controllers/user_controller.dart';

class Profile extends StatelessWidget {
  UserController userController=Get.put(UserController());
 AuthController authController=Get.put(AuthController());
  Profile({Key? key}) : super(key: key);
  double w=width*0.95;
  // bool condition=userController.token.value.isEmpty&&token.isEmpty;
  // String token=getToken();
  @override
  Widget build(BuildContext context) {
    // userController.update();
    print(userController.phone.value);
    return Directionality(textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar:MainBar("الملف الشخصي",24, false,false),
      body: Stack(
          children: [
       Container(width: width,height: height,
        child: userToken.isEmpty?NoProfile():Column(
        children: [
          SizedBox(height: 10),
          Container(width: w,padding: EdgeInsets.all( 10),
            decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
               Obx(() =>  userController.img.value.isNotEmpty?
               CircleAvatar(radius: 26,backgroundColor: mainColor,backgroundImage:NetworkImage(userController.img.value))
                   :CircleAvatar(radius: 25,backgroundColor: inputColor,backgroundImage:AssetImage("imgs/man.png"))),
                SizedBox(width: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Txt(userController.name.value, Colors.black, 20, FontWeight.w600)),
                    Obx(() => Txt(userController.phone.value, Colors.black, 19, FontWeight.w600)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          Box("تعديل البيانات", ()=>Get.toNamed("/edit")),
          Box("الطلبات", ()=>Get.toNamed("/orders")),
          Box("الرسائل", ()async{
            // Map msg={ "receiver": {"id": 1," type":" client"},"sender": {"id": 1," type":" client"}};
            // print(msg['sender']['id']);

            // if(chatContrl.chatId.isEmpty){
            //   await chatContrl.addChat();
            // }
            // chatContrl.chatId.value="sHgNjjHYXIC9KvmNHyzJ";
            // var msg=await chatContrl.getLastMsg("sHgNjjHYXIC9KvmNHyzJ");
            // print(msg);
            // chatContrl.getMessages();
            // var chat=await chatContrl.addMsg("Hello",{"id":1,"type":"client"});
            // var chats=await chatContrl.getChats();
            // print(chats);
            // chatContrl.getUser("client1");
           print(chatContrl.currentUser);
            Get.toNamed("/chats");
          }),
          Box("حذف الحساب", (){
            print(userController.img.value);
            confirmBox("حذف الحساب", "هل انت متاكد من حذف الحساب؟", ()async{
              print("remove account");
              Get.back();
              await  authController.leave(false);

            });
          }),
          Box("تسجيل الخروج", ()async{
            confirmBox("تسجيل الخروج", " هل انت متاكد من تسجيل الخروج؟", ()async{
              print("logout");
              Get.back();
              await  authController.leave(true);
            });}),
           ],
          ) ),
            Positioned(left: 0,bottom: 0,
                child: BottomBar(width, [false,false,false,false,true]))
          ],
      ),
    ));
  }
  Widget Box(String title,action){
    return GestureDetector(onTap: action,
      child: Container(width: w,height: 60,alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all( 10),
        decoration: BoxDecoration(color: inputColor,
        borderRadius: BorderRadius.circular(12)),
        child: Txt(title, Colors.black, 18, FontWeight.w600),
      ),
    );
  }
  Widget NoProfile(){
    return Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: height*0.3),
        CircleAvatar(radius: 65,
            backgroundColor: inputColor,backgroundImage:  AssetImage("imgs/man.png")),
        SizedBox(height: 6),
        Txt("هل انت مستخدم جديد؟", Colors.black, 15, FontWeight.w600),
        TxtBtn("قم بانشاء حساب الان", mainColor, 17, ()=>Get.offAllNamed("/signup"))
      ],
    );
  }
}
