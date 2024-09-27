import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/auth_controlller.dart';
import 'package:e_mart_seller/controllers/profile_controller.dart';
import 'package:e_mart_seller/services/store_services.dart';
import 'package:e_mart_seller/views/auth_screen/login_screen.dart';
import 'package:e_mart_seller/views/messages_screen/messages_screen.dart';
import 'package:e_mart_seller/views/profile_screen/edit_profile_screen.dart';
import 'package:e_mart_seller/views/shop_screens/shop_settings.dart';
import 'package:e_mart_seller/views/widget_common/loading_indecator.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: setting, size: 16.0),
        actions: [
          IconButton(onPressed: (){Get.to( EditProfileScreen(
            username: controller.snapshotData['vendor_name'],
          ));}, icon: const Icon(Icons.edit, color: white,)),
          TextButton(onPressed: () async{
            await Get.find<AuthController>().signOutMethod(context);
            Get.offAll(()=> const LoginScreen());
          }, child: normalText(text: logout))
        ],
      ),
      body: FutureBuilder (
          future: StoreServices.getProfile(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return loadingIndicator(color: white);
            }
            else{
              controller.snapshotData = snapshot.data!.docs[0];
              return Column(
                children: [
                  ListTile(
                    leading: Image.asset(icProduct).box.roundedFull.clip(Clip.antiAlias).make(),
                    title: boldText(text: "${controller.snapshotData['vendor_name']}"),
                    subtitle: normalText(text: "${controller.snapshotData['vendor_email']}"),
                  ),
                  const Divider(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(
                          profileButtonTitles.length,
                              (index) => ListTile(
                            onTap: (){
                              switch(index){
                                case 0:
                                  Get.to(const ShopSettings());
                                  break;
                                case 1:
                                  Get.to(const MessagesScreen());
                                  break;
                                default:
                              }
                            },
                            leading: Icon(profileButtonIcons[index], color: white,),
                            title: normalText(text: profileButtonTitles[index]),
                          )

                      ),
                    ),
                  )
                ],
              );
            }
          }
      ),
    );
  }
}