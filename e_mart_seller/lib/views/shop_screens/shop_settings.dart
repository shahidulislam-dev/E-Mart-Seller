import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/profile_controller.dart';
import 'package:e_mart_seller/views/widget_common/custom_textfield.dart';
import 'package:e_mart_seller/views/widget_common/loading_indecator.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          foregroundColor: white,
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(color: white, size: 35)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopName: controller.shopNameController.text,
                        shopAddress: controller.shopAddressController.text,
                        shopMobile: controller.shopMobileController.text,
                        shopWebsite: controller.shopWebsiteController.text,
                        shopDesc: controller.shopDescController.text,
                      );
                      Fluttertoast.showToast(msg: "Shop Details Updated",
                          backgroundColor: green,
                          textColor: white);
                    },
                    child: normalText(text: save))
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  20.heightBox,
                  boldText(
                      text: "Enter Your Shop Details",
                      color: lightGrey,
                      size: 20.0),
                  10.heightBox,
                  Column(
                    children: [
                      customTextField(shopName, purpleColor, shopNameHint,
                          controller.shopNameController, false, false),
                      10.heightBox,
                      customTextField(address, purpleColor, shopAddressHint,
                          controller.shopAddressController, false, false),
                      10.heightBox,
                      customTextField(mobile, purpleColor, shopMobileHint,
                          controller.shopMobileController, false, false),
                      10.heightBox,
                      customTextField(website, purpleColor, shopWebsiteHint,
                          controller.shopWebsiteController, false, false),
                      10.heightBox,
                      customTextField(description, purpleColor, shopDescHint,
                          controller.shopDescController, false, true),
                    ],
                  )
                      .box
                      .white
                      .roundedSM
                      .padding(const EdgeInsets.all(8.0))
                      .make(),
                ],
              ),
            )),
      ),
    );
  }
}
