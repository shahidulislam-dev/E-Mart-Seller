import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/widget_common/appbar_widget.dart';
import 'package:e_mart_seller/views/widget_common/dashboard_buttons.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(dashboard),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButtons(context, title: products,count: "75", icon: icProducts),
                dashboardButtons(context, title: orders,count: "15", icon: icOrders),
              ],
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
                  10,
                    (index) => ListTile(
                      onTap: (){},
                      leading: Image.asset(icProduct, width: 100, height: 100, fit: BoxFit.cover),
                      title: boldText(text: "Product Title",color: fontGrey),
                      subtitle: normalText(text: "40.0", color: darkGrey),
                    )
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
