import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/product_controller.dart';
import 'package:e_mart_seller/services/store_services.dart';
import 'package:e_mart_seller/views/product_screen/add_product.dart';
import 'package:e_mart_seller/views/product_screen/product_details.dart';
import 'package:e_mart_seller/views/widget_common/appbar_widget.dart';
import 'package:e_mart_seller/views/widget_common/loading_indecator.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';


class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        foregroundColor: white,
        onPressed: () async{
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(const AddProduct());
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      appBar: appBarWidget(products),
      body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return loadingIndicator(color: purpleColor);
            }else{
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
                          children: List.generate(
                              data.length,
                                  (index) => Card(
                                child: ListTile(
                                  onTap: () {
                                    Get.to(()=>  ProductDetails(data: data[index]));
                                  },
                                  leading: Image.network(data[index]['p_images'][0],
                                      width: 100, height: 100, fit: BoxFit.cover),
                                  title: boldText(
                                      text: "${data[index]['p_name']}", color: fontGrey),
                                  subtitle:
                                  Row(
                                    children: [
                                      normalText(text: "${data[index]['p_price']}", color: darkGrey),
                                      20.widthBox,
                                      boldText(text: data[index]['is_featured'] == true ? "Featured" : '', color: green)
                                    ],
                                  ),
                                  trailing: VxPopupMenu(
                                    arrowSize: 0.0,
                                    menuBuilder: ()=> Column(
                                      children: List.generate(
                                          popupMenuTitles.length,
                                              (i) => Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Icon(popupMenuIcons[i], color: data[index]['featured_id'] == currentUser!.uid && i == 0 ? green : darkGrey,),
                                                10.widthBox,
                                                normalText(text: data[index]['featured_id'] == currentUser!.uid && i == 0 ? "Remove Feature" : popupMenuTitles[i], color: darkGrey)
                                              ],
                                            ).onTap((){
                                              switch(i) {
                                                case 0:
                                                  if(data[index]['is_featured'] == true){
                                                    controller.removeFeatured(data[index].id);
                                                    VxToast.show(context, msg: "Featured Removed", bgColor: green);
                                                  }else{
                                                    controller.addFeatured(data[index].id);
                                                    VxToast.show(context, msg: "Featured Added", bgColor: green);
                                                  }
                                                  break;
                                                case 1:
                                                  break;
                                                case 2:
                                                  controller.removeProduct(data[index].id);
                                                  VxToast.show(context, msg: "Product Removed", bgColor: green);
                                                  break;
                                                default:
                                              }
                                            }),
                                          )
                                      ),
                                    ).box.white.width(200).rounded.make(),
                                    clickType: VxClickType.singleClick,
                                    child: const Icon(Icons.more_vert_rounded),
                                  ),
                                ),
                              )))
                    ],
                  ),
                ),
              );
            }
          }
      )
    );
  }
}
