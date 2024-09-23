import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/messages_screen/chat_screen.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
                20,
                (index) => ListTile(
                  onTap: (){
                    Get.to(()=> const ChatScreen());
                  },
                  leading: const CircleAvatar(
                    backgroundColor: purpleColor,
                    child: Icon(Icons.person, color: white,),
                  ),
                  title: boldText(text: userName, color: purpleColor),
                  subtitle: normalText(text: "last message....", color: darkGrey),
                  trailing: normalText(text: "10.45", color: darkGrey),
                )
            )
          ),
        ),
      ),
    );
  }
}
