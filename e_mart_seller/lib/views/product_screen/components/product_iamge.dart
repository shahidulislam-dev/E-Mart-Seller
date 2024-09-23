import 'package:e_mart_seller/const/const.dart';

Widget productImages({required label, onPress}){
  return "$label".text.bold.color(fontGrey).size(16.0).makeCentered().box.color(lightGrey).size(100, 100).roundedSM.make();
}