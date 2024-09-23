import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/views/widget_common/text_style.dart';

Widget productDropdown() {
  return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: normalText(text: "Select Category", color: lightGrey),
        ),
        isDense: true,
        value: null,
        isExpanded: true,
        items: const [],
        onChanged: (value) {},
  )
  ).box.color(white).make();
}
