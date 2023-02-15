
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/shared.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool online=false,read=true,save=false;

  double lat=0.0,
      long=0.0;
  var action;
  @override
  void initState() {
    setState((){
      read=Get.arguments[0];
      lat=Get.arguments[1];
      long=Get.arguments[2];
       action=Get.arguments[3];
    }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    if(long<1){
      //cairo 30.033333, 31.233334.
      lat=24.774265;
      long=46.738586;
    }
    final LatLng _kMapCenter =
    LatLng(lat, long);
    final CameraPosition _kInitialPosition =
    CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

    return Scaffold(
      appBar: null,
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: _kInitialPosition,onMapCreated: (h){
            print("===============================================");
            print("MapCreated $h");
        },
          onTap: (LatLng postion){
            if(!read) {
                setState(() {
                  save=true;
                  lat = postion.latitude;
                  long = postion.longitude;
                });
                print("lat $lat , long $long");
              }
            },
        ),
        Positioned(left: 10,bottom: 30,
            child: read?SizedBox(height: 0,width: 0):
            SizedBox(height: 38,child:Btn(btnTxt("حفظ"), Colors.white, save?mainColor:mainColor.withOpacity(0.4), mainColor, 75, (){
             if(save){
               mapLat.value=lat;
               mapLong.value=long;
               action();
               Get.back();
             }
            })))
      ],),
    );
  }
}
