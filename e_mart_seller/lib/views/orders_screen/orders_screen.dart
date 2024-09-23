import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/orders_screen/order_details.dart';
import 'package:e_mart_seller/views/widget_common/appbar_widget.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(orders),
      body: Padding(
        padding:  const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                      20,
                          (index) => ListTile(
                        onTap: (){
                          Get.to(()=> const OrderDetails());
                        },
                            tileColor: purpleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                        title: boldText(text: "9010875445485458",color: white),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_month, color: white,),
                                10.widthBox,
                                boldText(text: intl.DateFormat().add_yMd().format(DateTime.now()), color: white)
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.payment, color: white,),
                                10.widthBox,
                                boldText(text: unpaid, color: red)
                              ],
                            )
                          ],
                        ),
                            trailing: boldText(text: "40", color: white, size: 16.0),
                      ).box.margin(const EdgeInsets.only(bottom: 4)).make()
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}