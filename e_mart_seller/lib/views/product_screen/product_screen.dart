import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/product_screen/add_product.dart';
import 'package:e_mart_seller/views/product_screen/product_details.dart';
import 'package:e_mart_seller/views/widget_common/appbar_widget.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';


class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        foregroundColor: white,
        onPressed: () {
          Get.to(const AddProduct());
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      appBar: appBarWidget(products),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                      20,
                      (index) => Card(
                            child: ListTile(
                              onTap: () {
                                Get.to(()=> const ProductDetails());
                              },
                              leading: Image.asset(icProduct,
                                  width: 100, height: 100, fit: BoxFit.cover),
                              title: boldText(
                                  text: "Product Title", color: fontGrey),
                              subtitle:
                                  normalText(text: "40.0", color: darkGrey),
                              trailing: VxPopupMenu(
                                arrowSize: 0.0,
                                menuBuilder: ()=> Column(
                                  children: List.generate(
                                      popupMenuTitles.length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(popupMenuIcons[index]),
                                            10.widthBox,
                                            normalText(text: popupMenuTitles[index], color: darkGrey)
                                          ],
                                        ).onTap((){}),
                                      )
                                    ),
                                ).box.white.width(150).rounded.make(),
                                clickType: VxClickType.singleClick,
                                child: const Icon(Icons.more_vert_rounded),
                              ),
                            ),
                          )))
            ],
          ),
        ),
      ),
    );
  }
}
