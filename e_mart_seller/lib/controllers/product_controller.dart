import 'dart:io';

import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController{
  var productNameController = TextEditingController();
  var productDescController = TextEditingController();
  var productPriceController = TextEditingController();
  var productQuantityController = TextEditingController();

  var categoryList =<String> [].obs;
  var subCategoryList =<String> [].obs;
  List<Category> category = [];
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
}