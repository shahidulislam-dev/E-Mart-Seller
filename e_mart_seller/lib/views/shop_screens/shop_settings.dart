import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/widget_common/custom_textfield.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        foregroundColor: white,
        title: boldText(text:shopSettings, size: 16.0),
        actions: [TextButton(onPressed: (){}, child: normalText(text: save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  customTextField(shopName,purpleColor, shopNameHint, shopName, false,false),
                  10.heightBox,
                  customTextField(address,purpleColor, shopAddressHint, address, false,false),
                  10.heightBox,
                  customTextField(mobile,purpleColor, shopMobileHint, mobile, false,false),
                  10.heightBox,
                  customTextField(website,purpleColor, shopWebsiteHint, website, false,false),
                  10.heightBox,
                  customTextField(description,purpleColor,shopDescHint, description, false,true),
                ],
              ).box.white.roundedSM.padding(const EdgeInsets.all(8.0)).make(),
          
            ],
          ),
        )
      ),
    );
  }
}
