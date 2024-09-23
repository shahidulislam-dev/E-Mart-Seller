import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/product_screen/components/product_dropdown.dart';
import 'package:e_mart_seller/views/product_screen/components/product_iamge.dart';
import 'package:e_mart_seller/views/widget_common/custom_textfield.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
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
              customTextField("Product Name",white, "eg. BMW", "productNameController", false, false),
              10.heightBox,
              customTextField("Description",white, "eg. Nice product", "descriptionController", false, true),
              10.heightBox,
              customTextField("Product Price",white, "eg. 1290.0", "priceController", false, false),
              10.heightBox,
              customTextField("Product Quantity",white, "eg. 20", "quantityController", false, false),
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

            ],
          ),
        ),
      ),
    );
  }
}
