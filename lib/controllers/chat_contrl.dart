import 'dart:convert';
import 'package:E3yoon/screens/auth/share_contrl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'conn.dart';
class ChatContrl extends GetxController{
  var loading=false.obs,online=false.obs,noChats=false.obs,newChat=false.obs,
      chat={}.obs,chatId="".obs,allChats=[].obs,userChats=[].obs,chatUsers=[].obs,
      currentUser="".obs,queryMessages,chatKey = Key("list").obs;
  CollectionReference chats = FirebaseFirestore.instance.collection("chats");
  final DatabaseReference messagesRef =FirebaseDatabase.instance.reference().child('messages'),
      chatsRef =FirebaseDatabase.instance.reference().child('chats');

  @override
  void onInit() async{
    online.value = await connection();
   currentUser.value=userController.type.value+userController.id.value;
   print("=====currentUser ${currentUser.value}================");
    // TODO: implement onInit
    super.onInit();
  }

  sortByDate(List list, bool desc) {
    var newList = [];
    list.sort((a, b) {
      DateTime date1 = DateTime.now(), date2 = DateTime.now();
      if (a["date"] != null && b["date"] != null) {
        date1 = DateTime.parse(a["date"]);
        date2 = DateTime.parse(b["date"]);
      }
      return desc ? date2.compareTo(date1) : date1.compareTo(date2);
    });
    return list;
  }

  getUser(String userId)async{
    String type="",id="";
    id= userId.replaceAll(RegExp(r'[^0-9]'),'');
    type=userId.contains("lient")?"client":"provider";
    print(type);
    print(id);
    Map user={};
    print("loading .......");
    String url="https://glass.teraninjadev.com/api/$type/data/$id";
    var response=await http.get(Uri.parse(url),
        headers:{"Accept": "application/json","Accept-Language": "en"});
    var result=jsonDecode(response.body);
    // print(result);
    if(result['status']==1 &&result['code']==200){
      user={"id":result['data']['id'],"name":result['data']['name'],
        "img":result['data']['image'],"phone":result['data']['phone']};
    }
    return user;
  }
  user(String id){
    Map user={};
    for(int i=0;i<chatUsers.length;i++){
      if("${chatUsers[i]['id']}".trim()==id.trim()){
        user=chatUsers[i];
      }
    }
    return user;
  }
  getUserData(String id)async{
    Map localUser=user(id),userData={};
    // print(localUser);
    if(localUser.isEmpty) {
      userData = await getUser(id);
      chatUsers.add(userData);
    }else{
      userData  = localUser;
    }
    return userData;
  }
  getChats() async {
    var myChats = [];
    if(currentUser.isEmpty){
      currentUser.value=userController.type.value+userController.id.value;
    }
    online.value=await connection();
    if (online.isTrue && loading.isFalse) {
      loading.value=true;
      await chats.where("users", arrayContains: currentUser.value).get().then((
          data) async {
        for (var i = 0; i < data.docs.length; i++) {
          var msgSenderData,
              lastMsg = await getLastMsg(data.docs[i].id) ,
              item = data.docs[i].data() as Map,users = [];
          if (item.isNotEmpty) {
            users = item['users'];
          }
          print(lastMsg);
          String msgTxt = "", msgDate = "",dt = "", msgSenderName = "";
          if (lastMsg != null) {
            String sender=lastMsg['sender'];
            print(sender);
            msgSenderData=await getUser(sender);
            msgDate = lastMsg['date'];
            dt = convertDate(lastMsg['date']);
            // msgSenderData = getUser(lastMsg['senderId']);
            msgSenderName =
            lastMsg['sender'] == currentUser.value ? "انت" : msgSenderData['name'];
            msgTxt = "${lastMsg['text']}".length > 16
                ? "${lastMsg['text']}".substring(0, 16) + " ..."
                : "${lastMsg['text']}";
          }
          String receiver = users[0] == currentUser.value ? users[1] : users[0];
          var   receiverData = await getUser(receiver),
              name = receiverData['name'];
          item['id'] = data.docs[i].id;
          item['name'] = name.toString();
          item['receiver'] = receiver;
          item['img'] = receiverData['img'] ?? "";
          item['date'] = msgDate;
          item['lastMsg'] = msgTxt;
          item['lastMsgDate'] = dt;
          item['lastMsgSender'] = msgSenderName;
          myChats.add(item);
        }
      });
      noChats.value=myChats.isEmpty;
      allChats.value = myChats;
    }
    List finalChats=getChatsHaveMsgs();
    userChats.value=sortByDate(finalChats, true);
    loading.value=false;
    return finalChats;
  }
  getChatsHaveMsgs(){
    List chats=[];
    for(int i=0;i<allChats.length;i++){
      if(allChats[i]['lastMsg'].toString().isNotEmpty){
        chats.add(allChats[i]);
      }
    }
    return chats;
  }
  //search in local user chats
  getChatByUsers(String userId){
    var chat = {};
    List users = [currentUser.value, userId], usersR = [userId, currentUser.value];
    print(users);
    for (int i = 0; i < allChats.length; i++) {
      List item = allChats[i]['users'];
      if (listEquals(item, users) || listEquals(item, usersR)) {
        chat = allChats[i];
      }
    }
    return chat;
  }

  initChat(String text,String receiverId)async{
    Map chat={};String id="";
    if(chatId.isEmpty ){
      if(userChats.isEmpty &&noChats.isFalse){
        print("get chats...");
        userChats.value = await getChats();
        chat = getChatByUsers(receiverId);
      }
      if(chat.isEmpty){
        print("create new chat...");
        id=await createChat(receiverId);
        chatId.value=id;
        newChat.value=true;
        getChats();
      }else{
        id=chat['id'];
      }
      addMsg(id, text, receiverId);
    }else{
      addMsg(chatId.value, text, receiverId);
    }
  }
  getLastMsg(String chatId) async {
    var msg ;
    await messagesRef.orderByChild("chatId")
        .equalTo(chatId).limitToLast(1)
        .once().then((data) {
      if (data!= null) {
        var val=data.snapshot.value;
       if(val!=null){
         data.snapshot.children.forEach((element) {
           // print(element.key);
           msg=element.value;
           msg['id']=element.key;
         });
       }
      }
    });
    return msg;
  }
  createChat(String userId) async {
    if(currentUser.isEmpty){
      currentUser.value=userController.type.value+userController.id.value;
    }
    DocumentReference chat1 = await chats.add({"users": [currentUser.value,userId] });
    if (chat1.id.isNotEmpty) {
      chatId.value=chat1.id;
      chatKey.value=Key("12345 ${chat1.id}");
      // queryMessages.value=messagesRef.orderByChild("chatId").equalTo(chatId.value);
      userChats.value = await getChats();
      // mainController.changeHomeKey();
    }
    return chat1.id;
  }

  String msgDate(String mDate) {
    var now = DateTime.now();
    String result = "", today = DateFormat.yMd().format(now);
    DateTime msgDate = DateFormat.yMd().parse(mDate),
        currentDate =DateFormat.yMd().parse(today);
    var compare = currentDate.difference(msgDate).inDays;
    return compare == 0 ?"" : (compare == 1 ? "امس" : mDate);
  }
  convertDate(String d) {
    String dateTime = "";
    var  date = '';
    if (d.isNotEmpty) {
      DateTime dt = DateTime.parse(d), now = DateTime.now();
      String currentHour = DateFormat.Hm().format(now),
          t = DateFormat.Hm().format(dt);
      // time = currentHour == t ? "now" : t;
      date = DateFormat.yMd().format(dt);
      dateTime = dt.day == now.day ? t : "$date $t";
     // print("dt $dt");
     // print("now $now");
     // print("days ${now.difference(dt).inDays}");
    }
    return dateTime;
  }
  addMsg(String id,String text,String receiverId) {
   if(id.isNotEmpty){
     var now = DateTime.now().toString(),
         msg = {
           "text": text,
           "sender": currentUser.value,
           "receiver": receiverId,
           "chatId":id,
           "date": now,
         };
     messagesRef.push().set(msg).asStream();
   }
  }
  removerMsg(String id) async{
    messagesRef.child(id).remove();
    // userChats.value = await getChats();
  }

  editMsg(String id, String txt)async{
    messagesRef.child(id).update({"text": txt});
    // userChats.value = await getChats();
  }
}
