import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/orders_screen/components/order_place.dart';
import 'package:e_mart_seller/views/widget_common/buttons.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: orderDetails, color: fontGrey, size: 16.0),
      ),
      bottomNavigationBar: SizedBox(
        height: 40,
        width: context.screenWidth,
        child: buttons(() {}, purpleColor, white, "Confirm Order"),
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
                      value: true,
                      onChanged: (value) {},
                      title: boldText(text: "Confirmed", color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: green,
                      value: false,
                      onChanged: (value) {},
                      title: boldText(text: "On Delivery", color: fontGrey),
                    ),
                    SwitchListTile(
                      activeColor: green,
                      value: false,
                      onChanged: (value) {},
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
                      d1: "data['order_code']",
                      d2: "data['shipping_method']",
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  orderPlaceDetails(
                      d1: "data['order_code']",
                      d2: "data['shipping_method']",
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  orderPlaceDetails(
                      d1: "data['order_code']",
                      d2: "data['shipping_method']",
                      title1: "Order Code",
                      title2: "Shipping Method"),
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
                            normalText(text: "Order by name"),
                            normalText(text: "Order by email"),
                            normalText(text: "Order by address"),
                            normalText(text: "Order by city"),
                            normalText(text: "Order by state"),
                            normalText(text: "Order by phone"),
                            normalText(text: "Order by postal code")
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
                              boldText(text: "300.0", color: red, size: 16.0)
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
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(3, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      5.heightBox,
                      Center(child: boldText(text: "Ordered Products", color: fontGrey, size: 16.0)),
                      10.heightBox,
                      orderPlaceDetails(
                          title1: "data[orders][index][title]",
                          title2: "data[orders][index][tprice]",
                          d1: "{data[orders][index][qty]}x",
                          d2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: purpleColor,
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white.roundedSM
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
