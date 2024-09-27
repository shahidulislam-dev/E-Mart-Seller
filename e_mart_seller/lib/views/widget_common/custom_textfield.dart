import 'package:e_mart_seller/const/const.dart';

Widget customTextField(String? title,color, String? hint,controller,isPass, isDescription){
  return Column(
    children: [
      Align(
          alignment: Alignment.centerLeft,
          child: title!.text.color(color).semiBold.size(16).make()
      ),
      5.heightBox,
      TextField(
        controller: controller,
        maxLines: isDescription ? 4 : 1,
        obscureText: isPass,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
              color: textfieldGrey,
            ),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled:true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: white
                )
            )
        ),
      )
    ],
  );
}