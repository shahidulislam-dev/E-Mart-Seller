import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/product_controller.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';

Widget productDropdown(hint, List<String> list, dropValue, ProductController controller) {
  return Obx(()=> DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      hint: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: normalText(text: "$hint", color: lightGrey),
      ),
      isDense: true,
      value: dropValue.value == '' ? null : dropValue.value,
      isExpanded: true,
      items: list.map((e) {
        return DropdownMenuItem(
          value: e,
          child: e.toString().text.make(),
        );
      }).toList(),
      onChanged: (newValue) {
        if(hint == "Select a category"){
          controller.subCategoryValue.value = '';
          controller.populateSubCategory(newValue.toString());
        }
        dropValue.value = newValue.toString();
      },
    )).box.color(white).padding(const EdgeInsets.only(left: 12)).height(33).make(),
  );
}
