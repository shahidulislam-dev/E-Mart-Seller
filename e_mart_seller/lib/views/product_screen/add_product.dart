import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/product_controller.dart';
import 'package:e_mart_seller/views/product_screen/components/product_dropdown.dart';
import 'package:e_mart_seller/views/product_screen/components/product_iamge.dart';
import 'package:e_mart_seller/views/widget_common/custom_textfield.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        foregroundColor: white,
        title: boldText(text: "Add Product", color: white, size: 16.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField("Product Name",white, "eg. BMW", controller.productNameController, false, false),
              10.heightBox,
              customTextField("Description",white, "eg. Nice product", controller.productDescController, false, true),
              10.heightBox,
              customTextField("Product Price",white, "eg. 1290.0", controller.productPriceController, false, false),
              10.heightBox,
              customTextField("Product Quantity",white, "eg. 20", controller.productQuantityController, false, false),
              10.heightBox,
              boldText(text: "Product Category", color: white, size: 16.0),
              5.heightBox,
              productDropdown(),
              10.heightBox,
              boldText(text: "Product Sub-Category", color: white, size: 16.0),
              5.heightBox,
              productDropdown(),
              10.heightBox,
              boldText(text: "Choose Product Images", color: white, size: 16.0),
              normalText(text: "First image will be your display image", color: white),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    3,
                    (index) => productImages(label: "${index + 1}"),
                )
              ),
              10.heightBox,
              boldText(text: "Choose Product Color", color: white, size: 16.0),
              5.heightBox,
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(
                    16,
                    (index)=> Stack(
                      alignment: Alignment.center,
                      children: [
                        VxBox().color(Vx.randomPrimaryColor).roundedFull.size(40, 40).make(),
                        const Icon(Icons.done_outline_sharp, color: white,size: 15,)
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
