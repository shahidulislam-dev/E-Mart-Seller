import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controllers/home_controller.dart';
import 'package:e_mart_seller/views/home_screen/home_screen.dart';
import 'package:e_mart_seller/views/orders_screen/orders_screen.dart';
import 'package:e_mart_seller/views/product_screen/product_screen.dart';
import 'package:e_mart_seller/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      const HomeScreen(),
      const ProductScreen(),
      const OrdersScreen(),
      const ProfileScreen()
    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            width: 24,
            color: darkGrey,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            width: 24,
            color: darkGrey,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSettings,
            width: 24,
            color: darkGrey,
          ),
          label: setting),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            items: bottomNavbar),
      ),
      body: Obx(
        () => Column(
          children: [
            40.heightBox,
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
