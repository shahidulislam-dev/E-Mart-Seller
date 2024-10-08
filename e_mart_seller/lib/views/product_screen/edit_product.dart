import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/product_controller.dart';
import 'package:e_mart_seller/views/product_screen/components/product_dropdown.dart';
import 'package:e_mart_seller/views/product_screen/components/product_iamge.dart';
import 'package:e_mart_seller/views/widget_common/custom_textfield.dart';
import 'package:e_mart_seller/views/widget_common/loading_indecator.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';

class EditProduct extends StatelessWidget {
  final Map<String, dynamic> productData; // Accept product data

  const EditProduct({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    // Populate the fields with existing product data
    controller.productNameController.text = productData['p_name'];
    controller.productDescController.text = productData['p_description'];
    controller.productPriceController.text = productData['p_price'].toString();
    controller.productQuantityController.text = productData['p_quantity'].toString();
    controller.categoryValue.value = productData['p_category'];
    controller.subCategoryValue.value = productData['p_subcategory'];

    // Handle product images and colors if available
    controller.pImagesList.value = productData['p_images'];
    controller.selectedColor.value = productData['p_colors'][0] ?? 0;

    controller.getCategories().then((_) {
      controller.populateCategoryList();
      controller.populateSubCategory(controller.categoryValue.value);
    });

    return Obx(() => Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        foregroundColor: white,
        title: boldText(text: "Edit Product", color: white, size: 16.0),
        actions: [
          controller.isLoading.value
              ? loadingIndicator(color: white, size: 35)
              : TextButton(
              onPressed: () async {
                controller.isLoading(true);
                await controller.uploadImages();
                await controller.updateProduct(productData['id']); // Call the update function
                Get.back();
              },
              child: normalText(text: "Update"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField("Product Name", white, "eg. BMW",
                  controller.productNameController, false, false),
              10.heightBox,
              customTextField("Description", white, "eg. Nice product",
                  controller.productDescController, false, true),
              10.heightBox,
              customTextField("Product Price", white, "eg. 1290.0",
                  controller.productPriceController, false, false),
              10.heightBox,
              customTextField("Product Quantity", white, "eg. 20",
                  controller.productQuantityController, false, false),
              10.heightBox,
              boldText(text: "Product Category", color: white, size: 16.0),
              5.heightBox,
              productDropdown("Select a category", controller.categoryList,
                  controller.categoryValue, controller),
              10.heightBox,
              boldText(text: "Product Sub-Category", color: white, size: 16.0),
              5.heightBox,
              productDropdown(
                  "Select a sub-category",
                  controller.subCategoryList,
                  controller.subCategoryValue,
                  controller),
              10.heightBox,
              boldText(text: "Choose Product Images", color: white, size: 16.0),
              normalText(
                  text: "First image will be your display image", color: white),
              5.heightBox,
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  var image = controller.pImagesList[index];
                  return image != null
                      ? image is String
                      ? Image.network(image,  // If it's a URL (String)
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ).onTap(() {
                    controller.picImage(index, context);
                  })
                      : Image.file(image,  // If it's a File
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ).onTap(() {
                    controller.picImage(index, context);
                  })
                      : productImages(label: "${index + 1}").onTap(() {
                    controller.picImage(index, context);
                  });
                }),
              )),
              10.heightBox,
              boldText(text: "Choose Product Color", color: white, size: 16.0),
              5.heightBox,
              Obx(() => Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(
                    16,
                        (index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        VxBox()
                            .color(Vx.randomPrimaryColor)
                            .roundedFull
                            .size(40, 40)
                            .make()
                            .onTap(() {
                          controller.selectedColor.value = index;
                        }),
                        controller.selectedColor.value == index
                            ? const Icon(
                          Icons.done_outline_sharp,
                          color: white,
                          size: 15,
                        )
                            : const SizedBox()
                      ],
                    )),
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
