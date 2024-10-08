import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/orders_controller.dart';
import 'package:e_mart_seller/services/store_services.dart';
import 'package:e_mart_seller/views/orders_screen/order_details.dart';
import 'package:e_mart_seller/views/widget_common/appbar_widget.dart';
import 'package:e_mart_seller/views/widget_common/loading_indecator.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());
    return Scaffold(
        appBar: appBarWidget(orders),
        body: StreamBuilder(
            stream: StoreServices.getOrders(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator(color: purpleColor);
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ListView(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(data.length, (index) {
                              var time = data[index]['order_date'].toDate();
                              return ListTile(
                                onTap: () {
                                  Get.to(() =>  OrderDetails(data: data[index]));
                                },
                                tileColor: purpleColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                title: boldText(
                                    text: "${data[index]['order_code']}",
                                    color: white),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          color: white,
                                        ),
                                        10.widthBox,
                                        boldText(
                                            text: intl.DateFormat()
                                                .add_yMd()
                                                .format(time),
                                            color: white)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.payment,
                                          color: white,
                                        ),
                                        10.widthBox,
                                        boldText(text: unpaid, color: red)
                                      ],
                                    )
                                  ],
                                ),
                                trailing: boldText(
                                    text: "${data[index]['total_amount']}", color: white, size: 16.0),
                              )
                                  .box
                                  .margin(const EdgeInsets.only(bottom: 4))
                                  .make();
                            }))
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
