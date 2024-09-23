
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/home_screen/home.dart';
import 'package:e_mart_seller/views/widget_common/buttons.dart';
import 'package:e_mart_seller/views/widget_common/custom_textfield.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: Padding(
        padding:const EdgeInsets.all(12.0),
        child: Column(
          children: [
            80.heightBox,
            Image.asset(icLogo, width: 80, height: 80,).box.rounded.padding(const EdgeInsets.all(8)).alignCenter.make(),
            Row(
              children: [
                normalText(text: welcome, size: 18.0),
                10.widthBox,
                normalText(text: appname, size: 18.0)
              ],
            ).box.margin(const EdgeInsets.only(left: 40)).make(),
            30.heightBox,
            normalText(text: loginTo, color: lightGrey, size: 20.0),
            5.heightBox,
            Column(
              children: [
                customTextField(email,purpleColor, emailHint, emailController, false,false ),
                10.heightBox,
                customTextField(password,purpleColor, passwordHint, passwordController, true,false ),
                Align(alignment: Alignment.centerRight, child: TextButton(onPressed: (){}, child: normalText(text: forgotPassword,color: purpleColor))),
                10.heightBox,
                buttons((){
                  Get.to(const Home());
                }, purpleColor, white, login).box.width(context.screenWidth-30).make()
              ],
            ).box.rounded.color(white).padding(const EdgeInsets.all(12)).shadowSm.make(),
            10.heightBox,
            Center(
              child: normalText(text: anyProblem),
            )

          ],
        ),
      ),
    );
  }
}
