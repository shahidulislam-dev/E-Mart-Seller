import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/home_controller.dart';
import 'package:e_mart_seller/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var productNameController = TextEditingController();
  var productDescController = TextEditingController();
  var productPriceController = TextEditingController();
  var productQuantityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subCategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = []; // List for image URLs
  var pImagesList = RxList<dynamic>.generate(3, (index) => null); // List for picked images

  var categoryValue = ''.obs;
  var subCategoryValue = ''.obs;
  var selectedColor = 0.obs;

  // Load categories from JSON file
  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cate = categoryModelFromJson(data);
    category = cate.categories;
  }

  // Populate the category list
  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  // Populate the subcategory list based on the selected category
  populateSubCategory(cate) {
    subCategoryList.clear();
    var data = category.where((element) => element.name == cate).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subCategoryList.add(data.first.subcategory[i]);
    }
  }

  // Pick image for a specific index
  picImage(index, context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) return;
      pImagesList[index] = File(img.path); // Assign picked image to the specific index
    } catch (e) {
      VxToast.show(context, msg: e.toString(), bgColor: Colors.red, position: VxToastPosition.center);
    }
  }

  // Upload a single image for a specific index to Firebase Storage
  uploadImageAtIndex(int index) async {
    var item = pImagesList[index];
    if (item != null && item is File) {
      var filename = basename(item.path);
      var destination = 'images/vendors/${currentUser!.uid}/$filename';
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(item);
      var downloadUrl = await ref.getDownloadURL();
      if (pImagesLinks.length > index) {
        pImagesLinks[index] = downloadUrl; // Replace the existing image URL
      } else {
        pImagesLinks.add(downloadUrl);
      }
    } else if (item != null && item is String) {
      if (pImagesLinks.length > index) {
        pImagesLinks[index] = item;
      } else {
        pImagesLinks.add(item);
      }
    }
  }

  // Upload all images (if there are updates)
  uploadImages() async {
    for (int i = 0; i < pImagesList.length; i++) {
      if (pImagesList[i] != null) {
        await uploadImageAtIndex(i); // Upload each image at a specific index
      }
    }
  }

  // Add a new product to Firestore
  uploadProducts() async {
    isLoading(true);
    await uploadImages(); // Upload images first

    var store = firestore.collection(productsCollection).doc();  // Create a new document reference with a unique ID
    var productId = store.id;  // Get the generated document ID

    await store.set({
      'id': productId,  // Add the ID to the document data
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subCategoryValue.value,
      'p_colors': FieldValue.arrayUnion([selectedColor.value]), // Store selected color
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
    Fluttertoast.showToast(msg: "Product Added", backgroundColor: green);
  }

  // Update an existing product in Firestore
  updateProduct(String productId) async {
    isLoading(true);
    await uploadImages(); // Upload all images

    var store = firestore.collection(productsCollection).doc(productId);
    await store.update({
      'p_name': productNameController.text,
      'p_description': productDescController.text,
      'p_price': productPriceController.text,
      'p_quantity': productQuantityController.text,
      'p_category': categoryValue.value,
      'p_subcategory': subCategoryValue.value,
      'p_images': pImagesLinks,
      'p_colors': [selectedColor.value]
    });
    isLoading(false);
    Fluttertoast.showToast(msg: "Product Updated", backgroundColor: green);
  }

  // Add a product to the featured list in Firestore
  addFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured': true
    }, SetOptions(merge: true));
  }

  // Remove a product from the featured list in Firestore
  removeFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': '',
      'is_featured': false
    }, SetOptions(merge: true));
  }

  // Remove a product from Firestore
  removeProduct(docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }

  // Reset fields in the add product form
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
}
