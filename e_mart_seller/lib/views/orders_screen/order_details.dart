import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/orders_controller.dart';
import 'package:e_mart_seller/views/orders_screen/components/order_place.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  var controller = Get.find<OrdersController>();
  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.oneDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
        appBar: AppBar(
          title: boldText(text: orderDetails, color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 40,
            width: context.screenWidth,
            child: ElevatedButton(
                onPressed: (){
                  controller.confirmed(true);
                  controller.changeStatus(title: "order_confirmed", status: true, docId: widget.data.id);
                },
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  ),
                  backgroundColor: purpleColor
                ),
                child: boldText(text: "Confirm Order",color: white)
            )

          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  child: Column(
                    children: [
                      boldText(text: "Order Status", color: fontGrey, size: 16.0),
                      SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Order Placed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.oneDelivery.value,
                        onChanged: (value) {
                          controller.oneDelivery.value = value;
                          controller.changeStatus(title: "order_on_delivery", status: value, docId: widget.data.id);
                        },
                        title: boldText(text: "On Delivery", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;
                          controller.changeStatus(title: "order_delivered", status: value, docId: widget.data.id);
                        },
                        title: boldText(text: "Delivered", color: fontGrey),
                      )
                    ],
                  )
                      .box
                      .outerShadowMd
                      .white
                      .border(color: lightGrey)
                      .roundedSM
                      .make(),
                ),
                10.heightBox,

                //order details section
                Column(
                  children: [
                    orderPlaceDetails(
                        d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}",
                        title1: "Order Code",
                        title2: "Shipping Method"),
                    orderPlaceDetails(
                        d1: intl.DateFormat().add_yMd().format((widget.data['order_date'].toDate())),
                        d2: "${widget.data['payment_method']}",
                        title1: "Order Date",
                        title2: "Payment Method"),
                    orderPlaceDetails(
                        d1: "Unpaid",
                        d2: "Order Placed",
                        title1: "Payment Status",
                        title2: "Delivery Status"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Shipping Address", color: purpleColor),
                              normalText(text: "${widget.data['order_by_name']}", color: fontGrey),
                              normalText(text: "${widget.data['order_by_email']}", color: fontGrey),
                              normalText(text: "${widget.data['order_by_address']}", color: fontGrey),
                              normalText(text: "${widget.data['order_by_city']}", color: fontGrey),
                              normalText(text: "${widget.data['order_by_district']}", color: fontGrey),
                              normalText(text: "${widget.data['order_by_phone']}", color: fontGrey),
                              normalText(text: "${widget.data['order_by_postalcode']}", color: fontGrey)
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Total Amount", color: purpleColor),
                                boldText(text: "${widget.data['total_amount']}", color: red, size: 16.0)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),

                20.heightBox,
                Column(
                  children: [
                    Center(child: boldText(text: "Ordered Products", color: fontGrey, size: 16.0)),
                    10.heightBox,
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(controller.orders.length, (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            orderPlaceDetails(
                                title1: "${controller.orders[index]['title']}",
                                title2: "${controller.orders[index]['total_price']}",
                                d1: "${controller.orders[index]['quantity']}x",
                                d2: "Refundable"),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                width: 30,
                                height: 20,
                                color: Color(controller.orders[index]['color']),
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      }).toList(),
                    )
                  ],
                ).box
                    .outerShadowMd
                    .white.roundedSM
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
                20.heightBox
              ],
            ),
          ),
        ),
      ),
    );
  }
}
