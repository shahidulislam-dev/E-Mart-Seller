import 'package:e_mart_seller/const/const.dart';

Widget buttons(onPress, color, textColor, String title){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: color,
          padding: const EdgeInsets.all(12)
      ),
      onPressed: onPress,
      child: title.text.color(textColor).bold.make()
  );
}