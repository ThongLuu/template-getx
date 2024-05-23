import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/bottom_bar_controller.dart';
import 'package:flutter_template/controllers/cart/cart_controller.dart';
import 'package:flutter_template/controllers/user_controller.dart';
import 'package:flutter_template/screens/cart/cart_screen.dart';
import 'package:get/get.dart';
import '../../screens/account/account_screen.dart';
import '../../screens/another_screen.dart';
import '../home/home_screen.dart';
import '../../screens/menu/menu_screen.dart';
import '../../widgets/bottom_bar/custom_bottom_nav_bar.dart';
import '../../widgets/bottom_bar/custom_bottom_sheet.dart';
import '../../utils/constants/constants.dart';

// ignore: must_be_immutable
class BottomBar extends GetView<BottomBarController> {
  BottomBar({super.key});

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const AnotherScreen(appBarTitle: 'More Screen'),
    const CartScreen(),
    const MenuScreen(),
  ];

  bool isOpen = false;
  int lastIndex = 0;

  @override
  Widget build(BuildContext context) {
    var controllerBottomBar = Get.put(BottomBarController());
    var controllerUser = Get.put(UserController());
    var controllerCart = Get.put(CartController());
    controllerUser.getUserData();
    controllerCart.onGetCartHandler();

    return Obx(() => controllerBottomBar.bottomBarMoreClickedIndex.value !=
                null &&
            controllerBottomBar.isOpen.value != null
        ? Scaffold(
            body: Scaffold(
              body: GestureDetector(
                onTap: () {
                  controllerBottomBar.onBotttomBarMoreClickedEvent(
                      controllerBottomBar.bottomBarMoreClickedIndex.value,
                      false);
                  controllerBottomBar.onBottomBarClickedHandler(lastIndex);
                },
                child: Stack(
                  children: [
                    pages[lastIndex],
                    Container(
                      color: controllerBottomBar.isOpen.value==true? Colors.black87.withOpacity(0.5):Colors.black87.withOpacity(0),
                    )
                  ],
                ),
              ),
            ),
            bottomSheet: controllerBottomBar.isOpen.value == true
                ? BottomSheet(
                    backgroundColor: const Color(0xffffffff),
                    shadowColor: Colors.white,
                    dragHandleColor: const Color(0xffDDDDDD),
                    dragHandleSize: const Size(50, 4),
                    enableDrag: false,
                    showDragHandle: true,
                    constraints:
                        const BoxConstraints(minHeight: 400, maxHeight: 400),
                    onClosing: () {},
                    builder: (context) {
                      return const CustomBottomSheet();
                    })
                : null,
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex:
                  controllerBottomBar.bottomBarMoreClickedIndex.value!,
              bottomNavBarList: items(
                  index: controllerBottomBar.bottomBarMoreClickedIndex.value!,
                  isOpen: controllerBottomBar.isOpen.value!),
              onTap: (page) {
                if (page == 2) {
                  if (controllerBottomBar.isOpen.value == true) {
                    controllerBottomBar.onBotttomBarMoreClickedEvent(
                        page, false);
                    controllerBottomBar.onBottomBarClickedHandler(lastIndex);
                  } else {
                    controllerBottomBar.onBotttomBarMoreClickedEvent(
                        page, true);
                  }
                } else {
                  lastIndex = page;
                  controllerBottomBar.onBotttomBarMoreClickedEvent(page, false);
                  controllerBottomBar.onBottomBarClickedHandler(page);
                }
              },
            ))
        : controllerBottomBar.bottomBarIndex.value != null
            ? Scaffold(
                body: pages[controllerBottomBar.bottomBarIndex.value!],
                bottomNavigationBar: CustomBottomNavBar(
                  currentIndex: controllerBottomBar.bottomBarIndex.value!,
                  bottomNavBarList:
                      items(index: controllerBottomBar.bottomBarIndex.value!),
                  onTap: (page) {
                    if (page == 2) {
                      if (isOpen) {
                        controllerBottomBar.onBotttomBarMoreClickedEvent(
                            page, false);
                        controllerBottomBar
                            .onBottomBarClickedHandler(lastIndex);
                      } else {
                        controllerBottomBar.onBotttomBarMoreClickedEvent(
                            page, true);
                      }
                    } else {
                      lastIndex = page;
                      controllerBottomBar
                            .onBottomBarClickedHandler(page);
                    }
                  },
                ))
            : const SizedBox());
  }

  List<BottomNavigationBarItem> items(
      {required int index, bool isOpen = false}) {
    return [
      bottomNavBarItem(
        index: index,
        iconName: 'home',
        isOpen: isOpen,
        page: 0,
        label: 'Home',
      ),
      bottomNavBarItem(
        index: index,
        iconName: 'you',
        isOpen: isOpen,
        page: 1,
        label: 'You',
      ),
      bottomNavBarItem(
        index: index,
        iconName: 'more',
        isOpen: isOpen,
        page: 2,
        label: 'More',
      ),
      bottomNavBarItem(
        index: index,
        iconName: 'cart',
        isOpen: isOpen,
        page: 3,
        label: 'Cart',
      ),
      bottomNavBarItem(
        index: index,
        iconName: 'menu',
        isOpen: isOpen,
        page: 4,
        label: 'Menu',
      ),
    ];
  }

  BottomNavigationBarItem bottomNavBarItem(
      {required String iconName,
      required int page,
      isOpen = false,
      required int index,
      required String label,
      double height = 20,
      double width = 20}) {
    var controllerCart = Get.put(CartController());
    return BottomNavigationBarItem(
        icon: Column(
          children: [
            Container(
              width: 42,
              height: 5.5,
              decoration: BoxDecoration(
                color: index == page && index != 2
                    ? Constants.selectedNavBarColor
                    : Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            page == 3
                ? Stack(
                    children: [
                      Image.asset('assets/images/bottom_nav_bar/$iconName.png',
                          height: 25,
                          width: 30,
                          color: index == page
                              ? Constants.selectedNavBarColor
                              : Constants.unselectedNavBarColor),
                      Positioned(
                        top: 0,
                        left: 13,
                        child: Builder(builder: (context) {
                          if (controllerCart.total.value != null &&
                              controllerCart.cartProducts.value != null &&
                              controllerCart.productsQuantity.value != null &&
                              controllerCart.averageRatingList.value != null &&
                              controllerCart.saveForLaterProducts.value !=
                                  null) {
                            int cartLength =
                                controllerCart.cartProducts.value!.length;

                            return Text(
                              cartLength.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: index == page
                                      ? Constants.selectedNavBarColor
                                      : Constants.unselectedNavBarColor),
                            );
                          }
                          return Text(
                            '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: index == page
                                    ? Constants.selectedNavBarColor
                                    : Constants.unselectedNavBarColor),
                          );
                        }),
                      ),
                    ],
                  )
                : Image.asset('assets/images/bottom_nav_bar/$iconName.png',
                    height: height,
                    width: width,
                    color: index == page
                        ? Constants.selectedNavBarColor
                        : Constants.unselectedNavBarColor),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        label: label);
  }
}
