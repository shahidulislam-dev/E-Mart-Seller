import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController{
  late QueryDocumentSnapshot snapshotData;

  var profileImagePath = ''.obs;
  var profileImageLink = '';
  var isLoading = false.obs;

  var nameController = TextEditingController();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();

  changeImage(context) async{
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 20);
      if(img == null) return;
      profileImagePath.value = img.path;
    } on PlatformException catch(e){
      VxToast.show(context, msg: e.toString(), bgColor: red,position: VxToastPosition.center);
    }
  }

  uploadProfileImage() async{
    var filename = basename(profileImagePath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }
  
  updateProfile({name, password, imgurl}) async{
    var store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    await store.set({'vendor_name': name, 'vendor_password':password, 'image_url':imgurl}, SetOptions(merge: true));
    isLoading(false);
  }
  
  changeAuthPassword({email, password, newPassword}) async{
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value){
      currentUser!.updatePassword(newPassword);
    }).catchError((error){});
  }
}