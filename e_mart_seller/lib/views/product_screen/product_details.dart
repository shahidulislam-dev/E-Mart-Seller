import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "Product Details", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 350,
                viewportFraction: 1.0,
                itemCount: 3, aspectRatio: 16/9,
                itemBuilder: (context, index){
                  return Image.asset(
                    icProduct,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }
            ),
            10.heightBox,
            //title and details section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: "Product Title",color: fontGrey,size: 16.0),
                  //title!.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "Category", color: fontGrey, size: 16.0),
                      10.widthBox,
                      normalText(text: "Subcategory", color: fontGrey, size: 16.0)
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: true,
                    value: 3.0,
                    onRatingUpdate: (value){},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    size: 25,
                    stepInt: true,
                  ),
                  10.heightBox,
                  "\$30,000".text.color(red).bold.size(18).make(),
                  20.heightBox,
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Color:", color: fontGrey),
                          ),
                          Row(
                            children: List.generate(
                                3,
                                    (index) => VxBox().size(40, 40).roundedFull.color(Vx.randomPrimaryColor).margin(EdgeInsets.symmetric(horizontal: 4)).make()
                            ),
                          )
                        ],
                      ),
                      10.heightBox,

                      //Quantity section
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Quantity:", color: fontGrey)
                          ),
                          boldText(text: "20 items", color: fontGrey)
                        ],
                      ),
                    ],
                  ).box.white.padding(const EdgeInsets.all(8.0)).make(),
                  const Divider(),
                  boldText(text: "Description", color: fontGrey),
                  10.heightBox,
                  normalText(text: "Description of this item.",color: fontGrey)
                ],
              ),
            ),
            10.heightBox,

          ],
        ),
      ),
    );
  }
}
