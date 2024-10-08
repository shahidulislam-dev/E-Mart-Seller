import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/product_controller.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';
import 'package:get/get.dart';

Widget productDropdown(hint, List<String> list, RxString dropValue, ProductController controller) {
  // Create a unique list to avoid duplicates
  List<String> uniqueList = list.toSet().toList();

  return Obx(
        () => DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: normalText(text: "$hint", color: lightGrey),
        ),
        isDense: true,
        value: uniqueList.contains(dropValue.value) ? dropValue.value : null,
        isExpanded: true,
        items: uniqueList.map((e) {
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
        }).toList(),
        onChanged: (newValue) {
          if (hint == "Select a category") {
            controller.subCategoryValue.value = '';
            controller.populateSubCategory(newValue.toString());
          }
          dropValue.value = newValue.toString();
        },
      ).box.color(white).padding(const EdgeInsets.only(left: 12)).height(33).make(),
    ),
  );
}

