import 'dart:io';

import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/profile_controller.dart';
import 'package:e_mart_seller/views/widget_common/buttons.dart';
import 'package:e_mart_seller/views/widget_common/custom_textfield.dart';
import 'package:e_mart_seller/views/widget_common/loading_indecator.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.put(ProfileController());
  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          foregroundColor: white,
          title: boldText(text: setting, size: 16.0),
          actions: [
            controller.isLoading.value ? loadingIndicator(color: white, size: 35) : TextButton(
                onPressed: () async {
                  controller.isLoading(true);
                  //if image is not selected
                  if (controller.profileImagePath.value.isNotEmpty) {
                    await controller.uploadProfileImage();
                  } else {
                    controller.profileImageLink =
                        controller.snapshotData['image_url'];
                  }

                  //if old password matches database
                  if (controller.snapshotData['vendor_password'] ==
                      controller.oldPassController.text) {
                    await controller.changeAuthPassword(
                        email: controller.snapshotData['vendor_email'],
                        password: controller.oldPassController.text,
                        newPassword: controller.newPassController.text);

                    await controller.updateProfile(
                        imgurl: controller.profileImageLink,
                        name: controller.nameController.text,
                        password: controller.newPassController.text);
                    VxToast.show(context, msg: "Profile Updated", bgColor: green);
                  } else if (controller.oldPassController.text.isEmptyOrNull &&
                      controller.newPassController.text.isEmptyOrNull) {
                    await controller.updateProfile(
                        imgurl: controller.profileImageLink,
                        name: controller.nameController.text,
                        password: controller.snapshotData['vendor_password']);
                  } else {
                    VxToast.show(context,
                        msg: "Wrong Old Password", bgColor: red);
                    controller.isLoading(false);
                  }
                },
                child: normalText(text: "Update")).marginOnly(right: 10)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [
                controller.snapshotData['image_url'] == '' &&
                        controller.profileImagePath.isEmpty
                    ? Image.asset(
                        icProduct,
                        width: 150,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : controller.snapshotData['image_url'] != '' &&
                            controller.profileImagePath.isEmpty
                        ? Image.network(
                            controller.snapshotData['image_url'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImagePath.value),
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                // Image.asset(icProduct, width: 150,).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                buttons(() {
                  controller.changeImage(context);
                }, white, darkGrey, "Change Image")
                    .box
                    .height(40)
                    .make(),
                10.heightBox,
                const Divider(),
                5.heightBox,
                Column(
                  children: [
                    customTextField(userName, purpleColor, userNameHint,
                        controller.nameController, false, false),
                    10.heightBox,
                    customTextField(password, purpleColor, passwordHint,
                        controller.oldPassController, true, false),
                    10.heightBox,
                    customTextField(confirmPassword, purpleColor, passwordHint,
                        controller.newPassController, true, false),
                    // buttons((){
                    //   Get.to(const Home());
                    // }, purpleColor, white, login).box.width(context.screenWidth-30).make()
                  ],
                )
                    .box
                    .rounded
                    .color(white)
                    .padding(const EdgeInsets.all(12))
                    .shadowSm
                    .make(),
              ],
            ),
          ),
      ),
    );
  }
}
