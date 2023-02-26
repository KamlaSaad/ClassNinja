import 'dart:async';
import 'package:E3yoon/controllers/call_Contrls/share_chat.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../../widgets/chat_boxs.dart';
import '../../widgets/shared.dart';
import 'package:get/get.dart';
class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var queryMessages,
      dataLoaded = false.obs;
  bool updateMsgs = false,
      loading = false;
  String msgTxt = "";
  var scrollContrl = ScrollController(),
      msgContrl = TextEditingController(),
      editContrl = TextEditingController();

  void onChange() {
    this.scroll();
  }

  @override void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 1), () {
      onChange();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (updateMsgs) {
      print("reloading chats");
      chatContrl.getChats();
    }
    super.dispose();
  }

  scroll() {
    if (dataLoaded.isTrue) {
      scrollContrl.jumpTo(scrollContrl.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    queryMessages = chatContrl.messagesRef.orderByChild("chatId").equalTo(chatContrl.chatId.value);
    return Directionality(textDirection: TextDirection.rtl, child:
      Scaffold(appBar: AppBar(elevation: 2, backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black,),
          title: Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // CircleAvatar(backgroundColor: mainColor,
              //     backgroundImage: chatContrl.chat['img'].isEmpty ? null :
              //     NetworkImage(chatContrl.chat['img']),
              //     radius: 20),
              defaultImg(chatContrl.chat['img'],18),
              SizedBox(width: 5,),
              Txt(chatContrl.chat['name'], mainColor, 22, FontWeight.bold),
            ],
          ),
        ), resizeToAvoidBottomInset: true,
        body:Stack(
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: height * 0.8,
                    padding: EdgeInsets.only(top: 10),
                    child: Obx(() => chatContrl.loading.isTrue ? Center(child: CircularProgressIndicator(color: mainColor,)) :
                    FirebaseAnimatedList(shrinkWrap: true,
                        key: chatContrl.chatKey.value,
                        query: queryMessages,controller: scrollContrl,
                        itemBuilder: (context, snapshot,
                            Animation<double> animation, int i) {
                          Map snap = snapshot.value as Map;
                          var msg = {
                            "id": "${snapshot.key}",
                            "text": "${snap["text"]}",
                            "date": chatContrl.convertDate("${snap["date"]}"),
                            // "time": chatContrl.convertDate("${snap["date"]}"),
                            "sender": snap["sender"],
                            "showTime": false,
                            "isSender": snap["sender"] ==
                                chatContrl.currentUser.value
                          };
                          dataLoaded.value = true;
                          // scrollContrl.jumpTo(scrollContrl.position.maxScrollExtent);
                          // print(snap["date"]);
                          Timer.periodic(Duration(minutes: 1),
                                  (Timer t) {
                                msg['date'] =
                                    chatContrl.convertDate("${snap["date"]}");
                              });
                          return MessageBox(msg);
                        }),
                    )),
                  // AddMsgBox()
                ],),
            Positioned(left:5,bottom: 5,child: AddMsgBox())
          ],
        ),


            ));
  }

  Widget AddMsgBox() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          width: width * 0.78,
          height: 55,
          decoration: BoxDecoration(
              color: inputColor, borderRadius: BorderRadius.circular(20)),
          child: TextField(style: TxtStyle(Colors.black, 18, FontWeight.w500),
            controller: msgContrl, textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(hintText: "اكتب رسالة ...",
              // hintStyle: TxtStyle(Colors.black, 18, FontWeight.w500),
              border: InputBorder.none,
              fillColor: inputColor,
            ),),
        ),
        GestureDetector(onTap: () async {
          print(chatContrl.chat['receiver']);
          print(chatContrl.currentUser);
          print(chatContrl.chatId.value);
          print(chatContrl.chatKey.firstRebuild);
          if (msgContrl.text.isNotEmpty) {
            // setState(() => loading = true);
            await chatContrl.initChat(
                msgContrl.text, chatContrl.chat['receiver']);
            scroll();
            setState(() {
              updateMsgs = true;
              updateMsgs = true;
              msgContrl.clear();
            });
          }
        },
            child: CircleAvatar(backgroundColor: mainColor,
                child: Icon(Icons.send),
                radius: 25))
      ],
    );
  }
  Options(String id,String text){
    Get.defaultDialog(backgroundColor: inputColor,
      title: "",titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
      content: Directionality(textDirection: TextDirection.rtl,
        child: Column( children: [
          OptionItem(false, (){
            //edit msg
            Get.back();
            setState(() {
              editContrl.text=text;
            });
            editBox(editContrl, (){
              Get.back();
              if( editContrl.text!=text &&editContrl.text.isNotEmpty){
                chatContrl.editMsg(id,editContrl.text);
                setState(() => updateMsgs = true);
              }
            });
          }),
          OptionItem(true, (){
            //delete msg
            Get.back();
            confirmBox("حذف ", " هل تريد حذف هذه الرسالة ؟", (){
              Get.back();
              chatContrl.removerMsg(id);
              setState(() => updateMsgs = true);
            });
          }),
        ],),
      ),
    );
  }
  Widget MessageBox(Map msg){
    var showTime=false.obs;
    return Row(mainAxisAlignment: msg["isSender"]?MainAxisAlignment.start:MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: (){
            showTime.value=!showTime.value;
            print(showTime.value);
            print(msg['date']);
          },
          onLongPress: (){
            if(msg['isSender']){
              Options(msg['id'],msg['text']);
            }
          },
          child: Column(crossAxisAlignment: msg['isSender']?CrossAxisAlignment.start:CrossAxisAlignment.end,
            children: [
              Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),margin:EdgeInsets.all(6) ,
                // alignment: sender?Alignment.centerRight:Alignment.centerLeft,
                constraints: BoxConstraints(maxWidth:width*0.7 ),
                decoration: BoxDecoration(color: msg['isSender']?mainColor:inputColor,borderRadius: BorderRadius.circular(20)),
                child: Txt( msg['text'], msg['isSender']?Colors.white:Colors.black, 20, FontWeight.w500),
              ),
              Obx(() => showTime.isTrue?Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Txt(msg['date'], Color(0xff222222), 17, FontWeight.w500),
              ):SizedBox(height: 0,))
            ],
          ),
        ),
      ],
    );
  }


  Widget OptionItem(bool del,action){
    return Row(children: [
      Icon(del?Icons.delete:Icons.edit,color: del?Colors.red:Colors.black,size: 25,),
      SizedBox(width: 5,),
      TxtBtn(del?"حذف الرسالة":" تعديل الرسالة", del?Colors.red:Colors.black, 18, action),

    ],);
  }
  editBox(TextEditingController contrl,action){
    Get.defaultDialog(backgroundColor: inputColor,
        title: " تعديل الرسالة",titleStyle: TxtStyle(mainColor, 20, FontWeight.w500),
        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),
        content: Directionality(textDirection: TextDirection.rtl,
            child: Column(children: [
              SizedBox(width:width*0.8,
                  child: TextField(controller: contrl,style: TxtStyle(Colors.black, 17, FontWeight.w500),
                    decoration: InputDecoration(border:InputBorder.none,focusedBorder: InputBorder.none,
                    ),
                  )),
              // Input(TextInputType.text, "", contrl, width*0.8, 40, null, (val){}, (val){}),
              SizedBox(height: 36,
                  child: Btn(Txt("تعديل", Colors.white, 18, FontWeight.w500),
                      mainColor,  mainColor,  mainColor, 100, action))
            ],)
        ));
  }


}
