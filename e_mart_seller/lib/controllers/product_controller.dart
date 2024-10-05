import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/home_controller.dart';
import 'package:e_mart_seller/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductController extends GetxController{
  var isLoading = false.obs;
  var productNameController = TextEditingController();
  var productDescController = TextEditingController();
  var productPriceController = TextEditingController();
  var productQuantityController = TextEditingController();

  var categoryList =<String> [].obs;
  var subCategoryList =<String> [].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subCategoryValue = ''.obs;
  var selectedColor = 0.obs;
  
  getCategories() async{
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cate = categoryModelFromJson(data);
    category = cate.categories;
  }

  populateCategoryList(){
    categoryList.clear();
    for(var item in category){
      categoryList.add(item.name);
    }
  }
  
  populateSubCategory(cate){
    subCategoryList.clear();
    var data = category.where((element)=> element.name == cate).toList();
    for(var i = 0; i < data.first.subcategory.length; i++){
      subCategoryList.add(data.first.subcategory[i]);
    }
  }

  picImage(index, context) async{
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
      if(img == null){
        return;
      }else{
        pImagesList[index] = File(img.path);
      }
    }catch(e){
      VxToast.show(context, msg: e.toString(), bgColor: Colors.red, position: VxToastPosition.center);
    }
  }


  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        if (item is File) {
          var filename = basename(item.path);
          var destination = 'images/vendors/${currentUser!.uid}/$filename';
          Reference ref = FirebaseStorage.instance.ref().child(destination);
          await ref.putFile(item);
          var downloadUrl = await ref.getDownloadURL();
          pImagesLinks.add(downloadUrl);
        } else if (item is String) {
          pImagesLinks.add(item);
        }
      }
    }
  }

  // uploadImages() async{
  //   pImagesLinks.clear();
  //   for(var item in pImagesList){
  //     if(item != null){
  //       var filename = basename(item.path);
  //       var destination = 'images/vendors/${currentUser!.uid}/$filename';
  //       Reference ref = FirebaseStorage.instance.ref().child(destination);
  //       await ref.putFile(item);
  //       var n = await ref.getDownloadURL();
  //       pImagesLinks.add(n);
  //     }
  //   }
  // }

  uploadProducts(context) async {
    var store = firestore.collection(productsCollection).doc();  // Create a new document reference with a unique ID
    var productId = store.id;  // Get the generated document ID

    await store.set({
      'id': productId,  // Add the ID to the document data
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subCategoryValue.value,
      'p_colors': FieldValue.arrayUnion([Colors.red.value, Colors.black.value, Colors.brown.value, Colors.pink.value]),
      'p_images': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_description': productDescController.text,
      'p_name': productNameController.text,
      'p_price': productPriceController.text,
      'p_quantity': productQuantityController.text,
      'p_seller': Get.find<HomeController>().username,
      'p_ratting': '5.0',
      'vendor_id': currentUser!.uid,
      'featured_id': '',
    });

    isLoading(false);
    VxToast.show(context, msg: "Product Added", bgColor: green);
  }


  addFeatured(docId) async{
   await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured': true
    }, SetOptions(merge: true));
  }

  removeFeatured(docId) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': '',
      'is_featured': false
    }, SetOptions(merge: true));
  }

  removeProduct(docId) async{
    await firestore.collection(productsCollection).doc(docId).delete();
  }

  void resetFields() {
    productNameController.clear();
    productDescController.clear();
    productPriceController.clear();
    productQuantityController.clear();
    pImagesList.value = [null, null, null]; // Reset images
    selectedColor.value = 0;
    categoryValue.value = '';
    subCategoryValue.value = '';
  }
  updateProduct(context,String productId) async {
    var store = firestore.collection(productsCollection).doc(productId);
    await store.update({
      'p_name': productNameController.text,
      'p_description': productDescController.text,
      'p_price': productPriceController.text,
      'p_quantity': productQuantityController.text,
      'p_category': categoryValue.value,
      'p_subcategory': subCategoryValue.value,
      'p_images': FieldValue.arrayUnion(pImagesLinks),
      'p_colors': [selectedColor.value]
    });
    isLoading(false);
    VxToast.show(context, msg: "Product Updated", bgColor: green);
  }
}