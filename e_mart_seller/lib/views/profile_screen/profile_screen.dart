import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/messages_screen/messages_screen.dart';
import 'package:e_mart_seller/views/profile_screen/edit_profile_screen.dart';
import 'package:e_mart_seller/views/shop_screens/shop_settings.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: setting, size: 16.0),
        actions: [
          IconButton(onPressed: (){Get.to(const EditProfileScreen());}, icon: const Icon(Icons.edit, color: white,)),
          TextButton(onPressed: (){}, child: normalText(text: logout))
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: Image.asset(icProduct).box.roundedFull.clip(Clip.antiAlias).make(),
            title: boldText(text: "Vendor Name"),
            subtitle: normalText(text: "vendoremail@emart.com"),
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
      )
    );
  }
}