import 'package:E3yoon/controllers/call_Contrls/share_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/shared.dart';
class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);
  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  var searchList=[],searchChat=TextEditingController();
  @override
  void initState() {
    // chatContrl.getChats();
      if(chatContrl.userChats.isEmpty){
        chatContrl.getChats();
      }

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
      appBar:  AppBar(elevation: 0,backgroundColor: Colors.white,
      leading: BackButton(color: Colors.black,),centerTitle: true,
      title: Txt("الرسائل", mainColor, 24, FontWeight.bold),
    ),resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Input(TextInputType.text, "بحث ....", searchChat, width*0.95, 45,
                    IconButton(onPressed: ()=>search(), icon: Icon(Icons.search,color: mainColor,))
                 , (val){}, (val){
                     print(chatContrl.allChats.value);
                     print(chatContrl.chatUsers.value);
                      // search();
                    }),
                // IconButton(onPressed: (){}, icon: icon)
              ],
            ),
            Container(height: height*0.75,child: Obx(() => chatContrl.userChats.isNotEmpty?chats():
            (chatContrl.loading.isTrue?Center(child: CircularProgressIndicator(color: mainColor))
                : Center(child: Txt(chatContrl.online.isTrue?
            "لاتوجد رسائل بعد":"لايوجد اتصال بالانترنت", Colors.black, 15, FontWeight.w600))))),
          ],
        ),
      )
      ));
  }
  Widget chats(){
    // data=searchList.isEmpty?chatContrl.userChats:searchList;
    return ListView.builder(
          itemCount: searchChat.text.isEmpty?chatContrl.userChats.length:searchList.length,
          itemBuilder: (context,i){
            var item= searchChat.text.isEmpty?chatContrl.userChats[i]:searchList[i];
            String msg=item["lastMsg"]??"";
            return msg.isNotEmpty?Container(margin: EdgeInsets.symmetric(vertical: 5),
              child: ListTile(onTap: (){
                chatContrl.chatId.value=item["id"];
                chatContrl.chat.value=item;
                print(item["id"]);
                Get.toNamed("/chat");
              },
                // leading: CircleAvatar(radius:25,backgroundColor: mainColor,backgroundImage: NetworkImage(item['img'])),
                leading: defaultImg(item['img'],25),
                title: SingleChildScrollView(scrollDirection: Axis.horizontal,
                  child: Txt(item["name"], mainColor, 22, FontWeight.w600)),
                subtitle: Txt(item["lastMsg"], Color(0xff111111), 17, FontWeight.w600),
                trailing: SizedBox(width: width*0.26,child: SingleChildScrollView(scrollDirection: Axis.horizontal,reverse: true,
                      child: Txt(item["lastMsgDate"], Colors.black, 17, FontWeight.w500)),
                ),
              ),
            ):SizedBox(height: 0);
          }
    );
  }
  search(){
    // searchChat.text="provider";
    setState(() =>searchList.clear());
    if(searchChat.text.isNotEmpty){
      for(int i=0;i<chatContrl.userChats.length;i++) {
        String name = chatContrl.userChats[i]['name'];
        if (name.toLowerCase().contains(searchChat.text.toLowerCase())) {
            if( !searchList.contains( chatContrl.userChats[i])) {
              setState(() =>searchList.add(chatContrl.userChats[i]));
            }
        }
      }
    }
  }
}
