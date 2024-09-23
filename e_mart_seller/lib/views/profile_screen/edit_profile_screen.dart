import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/widget_common/buttons.dart';
import 'package:e_mart_seller/views/widget_common/custom_textfield.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        foregroundColor: white,
        title: boldText(text:setting, size: 16.0),
        actions: [TextButton(onPressed: (){}, child: normalText(text: save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(icProduct, width: 150,).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            buttons((){}, white, darkGrey, "Change Image").box.height(40).make(),
            10.heightBox,
            const Divider(),
            5.heightBox,
            Column(
              children: [
                customTextField(userName,purpleColor, userNameHint, userName, false, false),
                10.heightBox,
                customTextField(password,purpleColor, passwordHint, password, true,false),
                10.heightBox,
                customTextField(confirmPassword,purpleColor, passwordHint, password, true,false),
                // buttons((){
                //   Get.to(const Home());
                // }, purpleColor, white, login).box.width(context.screenWidth-30).make()
              ],
            ).box.rounded.color(white).padding(const EdgeInsets.all(12)).shadowSm.make(),
          ],
        ),
      ),
    );
  }
}
