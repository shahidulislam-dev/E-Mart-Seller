import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                autoPlay: true,
                height: 350,
                viewportFraction: 1.0,
                itemCount: data['p_images'].length,
                aspectRatio: 16/9,
                itemBuilder: (context, index){
                  return Image.network(
                    data['p_images'][index],
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
                  boldText(text: "${data['p_name']}",color: fontGrey,size: 16.0),
                  //title!.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(text: "${data['p_category']}", color: fontGrey, size: 14.0),
                      10.widthBox,
                      normalText(text: "${data['p_subcategory']}", color: fontGrey, size: 14.0)
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_ratting']),
                    onRatingUpdate: (value){},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  "${data['p_price']}".text.color(red).bold.size(18).make(),
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
                                data['p_colors'].length,
                                    (index) => VxBox().size(40, 40).roundedFull.color(Color(data['p_colors'][index])).margin(const EdgeInsets.symmetric(horizontal: 4)).make()
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
                          boldText(text: "${data['p_quantity']}", color: fontGrey)
                        ],
                      ),
                    ],
                  ).box.white.padding(const EdgeInsets.all(8.0)).make(),
                  const Divider(),
                  boldText(text: "Description", color: fontGrey),
                  10.heightBox,
                  normalText(text: "${data['p_description']}",color: fontGrey)
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
