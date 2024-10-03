import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/services/store_services.dart';
import 'package:e_mart_seller/views/product_screen/product_details.dart';
import 'package:e_mart_seller/views/widget_common/appbar_widget.dart';
import 'package:e_mart_seller/views/widget_common/dashboard_buttons.dart';
import 'package:e_mart_seller/views/widget_common/loading_indecator.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(dashboard),
      body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return loadingIndicator(color: purpleColor);
            }else{
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b)=> b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FutureBuilder<int>(
                      future: StoreServices.getOrdersCount(currentUser!.uid),
                      builder: (context, AsyncSnapshot<int> orderSnapshot) {
                        if (!orderSnapshot.hasData) {
                          return loadingIndicator(color: purpleColor);
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              dashboardButtons(context, title: products, count: "${data.length}", icon: icProducts),
                              dashboardButtons(context, title: orders, count: "${orderSnapshot.data}", icon: icOrders), // Show total orders
                            ],
                          );
                        }
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButtons(context, title: ratings,count: "60", icon: icStar),
                        dashboardButtons(context, title: totalSales,count: "15",icon: icSales),
                      ],
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(text: popularProducts, color: darkGrey, size: 16.0),
                    20.heightBox,
                    Expanded(
                      child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              data.length,
                                  (index) => data[index]['p_wishlist'].length == 0 ? const SizedBox() : ListTile(
                                onTap: (){
                                  Get.to(()=> ProductDetails(data: data[index]));
                                },
                                leading: Image.network(data[index]['p_images'][0], width: 100, height: 100, fit: BoxFit.cover),
                                title: boldText(text: "${data[index]['p_name']}",color: fontGrey),
                                subtitle: normalText(text: "${data[index]['p_price']}", color: darkGrey),
                              )
                          )
                      ),
                    )
                  ],
                ),
              );
            }
          }
      )
    );
  }
}
