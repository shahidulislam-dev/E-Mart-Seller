
import 'dart:async';

import 'package:e_mart_seller/views/auth_screen/login_screen.dart';
import 'package:e_mart_seller/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../controllers/session_controller.dart';



class SplashService{


  void isLogin(BuildContext context){
    FirebaseAuth auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    if(user != null){
      SessionController().userId = user.uid.toString();
      Timer(const Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home())));

    }
    else{
      Timer(const Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen())));

    }

  }
}