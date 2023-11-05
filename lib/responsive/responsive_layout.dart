import 'package:flutter/material.dart';
import 'package:insta/Util/dimensions.dart';
class ResponsiveLayout extends StatelessWidget {
  final Widget webScreen;
  final Widget mobileScreen;
  const ResponsiveLayout({super.key,required this.mobileScreen,required this.webScreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder:(context,constraints){
          if(constraints.maxWidth > webScreenSize){
              return webScreen;
          }
            return mobileScreen;

        },
    );
  }
}
