import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/services/store_services.dart';
import 'package:e_mart_seller/views/messages_screen/chat_screen.dart';
import 'package:e_mart_seller/views/widget_common/loading_indecator.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: boldText(text: messages, size: 16.0, color: fontGrey),
        ),
        body: StreamBuilder(
            stream: StoreServices.getMessages(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator(
                  color: white,
                );
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        children: List.generate(data.length, (index) {
                          var t = data[index]['created_on'] == null ? DateTime.now() : data[index]['created_on'].toDate();
                          var time = intl.DateFormat("h:mma").format(t);
                          return ListTile(
                            onTap: (){
                              Get.to(()=> const ChatScreen());
                            },
                            leading: const CircleAvatar(
                              backgroundColor: purpleColor,
                              child: Icon(Icons.person, color: white,),
                            ),
                            title: boldText(text: "${data[index]['sender_name']}", color: fontGrey),
                            subtitle: normalText(text: "${data[index]['last_message']}", color: darkGrey),
                            trailing: normalText(text: time, color: darkGrey),
                          );
                        })),
                  ),
                );
              }
            }));
  }
}

// Padding(
// padding: const EdgeInsets.all(8.0),
// child: SingleChildScrollView(
// physics: const BouncingScrollPhysics(),
// child: Column(
// children: List.generate(
// 20,
// (index) => ListTile(
// onTap: (){
// Get.to(()=> const ChatScreen());
// },
// leading: const CircleAvatar(
// backgroundColor: purpleColor,
// child: Icon(Icons.person, color: white,),
// ),
// title: boldText(text: userName, color: purpleColor),
// subtitle: normalText(text: "last message....", color: darkGrey),
// trailing: normalText(text: "10.45", color: darkGrey),
// )
// )
// ),
// ),
// ),
