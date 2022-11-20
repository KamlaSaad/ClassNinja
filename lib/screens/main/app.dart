import 'package:class_ninja/screens/main/ads.dart';
import 'package:class_ninja/screens/main/details.dart';
import 'package:class_ninja/screens/main/favourite.dart';
import 'package:class_ninja/screens/main/home.dart';
import 'package:class_ninja/widgets/shared.dart';
import 'package:flutter/material.dart';
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int selected=0;
  static List<Widget> _pages = <Widget>[
    Home(),
    Ads(),
    Favourite(),
    Details(),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _pages.elementAt(selected),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selected,
          onTap: (i){
            setState(() =>selected=i);
          },
          // fixedColor: mainColor.withOpacity(0.4),
          unselectedItemColor: mainColor.withOpacity(0.4),
          selectedItemColor: mainColor,
          selectedLabelStyle: TextStyle(color: mainColor,fontSize: 18),
          unselectedLabelStyle: TextStyle(color: Colors.white,fontSize: 0),
          items: <BottomNavigationBarItem>[
            // Item(Icons.home,'الرئيسية'),
            // Item(Icons.home,'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'اعلانات'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'المفضلة'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف'),
          ],
        ),
      ),
    );
  }
  BottomNavigationBarItem Item(IconData icon,String label){
    return BottomNavigationBarItem(icon: Icon(icon,color:mainColor.withOpacity(0.4)),label: label);
  }
}
