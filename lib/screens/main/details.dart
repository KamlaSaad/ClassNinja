import 'package:flutter/material.dart';
import '../../widgets/shared.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double w=width*0.9;
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(elevation: 0,
          leading: BackButton(color: Colors.black),
          title: null,backgroundColor: Colors.white,
        ),
        body: Center(
          child: SingleChildScrollView(child:
          Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(height: 150,width: w,
            decoration: BoxDecoration(color: Colors.white,
                image: DecorationImage(image: AssetImage("imgs/images1.png"),fit:BoxFit.fill),
                borderRadius: BorderRadius.circular(10))),
            SizedBox(height: 20),
            Container(width: w,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(color: inputColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Txt("د/احمد عبد المجيد العربي", Colors.black, 18, FontWeight.bold),
                ),
                SizedBox(height: 5),
                Container(height: 1,width: w,color: mainColor),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    contact("01037454764",  Colors.blue, Icons.call),
                    Container(height: 60,width: 1,color: mainColor),
                    contact("08364743467",  Colors.green, Icons.call)
                  ],
                ),
                Container(height: 1,width: w,color: mainColor),
                ListTile(
                  leading: Image.asset("imgs/map.png",width: 40,height: 40,),
                  title: Txt("الرياض شارع ابن سينا حي المروج", Colors.black, 17, FontWeight.w700),
                )
              ]),
            ),
            SizedBox(height: 20),
            Container(height: 200,width: w,
                decoration: BoxDecoration(color: Colors.white,
                    image: DecorationImage(image: AssetImage("imgs/images1.png"),fit:BoxFit.fill),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft:Radius.circular(10) ))),
          SizedBox(height: 20),
            Container(height: 150,width: w,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: inputColor,
                    borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                Txt("يمكنك متابعتنا علي مواقع التواصل الاجتماعي", Colors.black, 17, FontWeight.bold),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Social("www"),
                    Social("twitter"),
                    Social("snapchat"),
                    Social("insta"),
                    Social("face"),

                  ],
                )
              ]),
            ),
          ],),),
        ),
      ),
    );
  }
  Widget contact(String phone,Color color,IconData icon){
    return SizedBox(width: w*0.45,height: 60,
      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
          child:Row(
            children: [
              CircleAvatar(radius: 16,backgroundColor: color,child: Icon(icon,color: Colors.white)),
              SizedBox(width: 5),
              Txt(phone, Colors.black, 18, FontWeight.w500),
            ],
          )),
    );
  }
  Widget Social(String img){
    return CircleAvatar(radius: 22,backgroundImage: AssetImage("imgs/$img.png"),);
  }
}
