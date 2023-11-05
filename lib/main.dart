
import 'package:insta/responsive/webScreenLayout.dart';
import 'package:insta/responsive/mobileScreenLayout.dart';
import 'package:insta/responsive/responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta/Util/colors.dart';
import 'package:insta/screen/login_screen.dart';
// import 'package:insta/screen/signup_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Instagram',
    theme: ThemeData.dark(useMaterial3: true,).copyWith(
      scaffoldBackgroundColor: mobileBackgroundColor,
    ),
    // theme: ThemeData.dark(useMaterial3: true).copyWith(
    //   scaffoldBackgroundColor: mobileBackgroundColor,
    // ),
    // home: const ResponsiveLayout(mobileScreen: Mobile() ,webScreen: Web(),),
    home: StreamBuilder(
      stream:FirebaseAuth.instance.authStateChanges() ,
      builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.active){
          if(snapshot.hasData){
            return  const ResponsiveLayout(mobileScreen: Mobile() ,webScreen: Web(),);
          }
          else if(snapshot.hasError){
            return Center(child:Text('${snapshot.error}',));
          }
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(color: primaryColor,),);
        }
        return const LoginScreen();
      },
    ),
  ));
}

