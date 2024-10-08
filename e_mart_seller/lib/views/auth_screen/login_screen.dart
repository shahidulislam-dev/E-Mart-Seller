
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/auth_controlller.dart';
import 'package:e_mart_seller/views/home_screen/home.dart';
import 'package:e_mart_seller/views/widget_common/buttons.dart';
import 'package:e_mart_seller/views/widget_common/custom_textfield.dart';
import 'package:e_mart_seller/views/widget_common/loading_indecator.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
   var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding:const EdgeInsets.all(12.0),
          child: Column(
            children: [
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
              Obx(()=> Column(
                  children: [
                    customTextField(email,purpleColor, emailHint, controller.emailController, false,false ),
                    10.heightBox,
                    customTextField(password,purpleColor, passwordHint, controller.passwordController, true,false ),
                    Align(alignment: Alignment.centerRight, child: TextButton(onPressed: (){}, child: normalText(text: forgotPassword,color: purpleColor))),
                    10.heightBox,
                    controller.isLoading.value ? loadingIndicator(color: purpleColor, size: 35) : buttons(() async{
                      controller.isLoading(true);
                      await controller.loginMethod(context).then((value){
                        if(value != null){
                          controller.isLoading(false);
                          Fluttertoast.showToast(msg: "Logged In", backgroundColor: green, textColor: white);
                          Get.offAll(() =>const Home());
                        }else{
                          controller.isLoading(false);
                          Fluttertoast.showToast(msg: "Error to logged in", backgroundColor: red,textColor: white);
                        }
                      });
        
                    }, purpleColor, white, login).box.width(context.screenWidth-30).make()
                  ],
                ).box.rounded.color(white).padding(const EdgeInsets.all(12)).shadowSm.make(),
              ),
              10.heightBox,
              Center(
                child: normalText(text: anyProblem),
              )
        
            ],
          ),
        ),
      ),
    );
  }
}
