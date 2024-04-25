// import 'package:flutter/material.dart';
// import 'package:flutter_amazon_clone_bloc/src/config/router/app_route_constants.dart';
// import 'p../../../../widgets/account/account_button.dart';
// import '../../../../utils/utils.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class TopButtons extends StatelessWidget {
//   const TopButtons({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             AccountButton(
//                 buttonName: 'Your Orders',
//                 onPressed: () {
//                   context
//                       .pushNamed(AppRouteConstants.yourOrdersScreenRoute.name);
//                 }
//                 // Navigator.pushNamed(context, YourOrders.routeName)
//                 ),
//             const SizedBox(
//               width: 10,
//             ),
//             AccountButton(buttonName: 'Buy Again', onPressed: () {}),
//           ],
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             AccountButton(
//                 buttonName: 'Log Out',
//                 onPressed: () async {
//                   try {
//                     await Hive.box('user').clear();

//                     if (context.mounted) {
//                       context.goNamed(AppRouteConstants.authRoute.name);
//                     }
//                   } catch (e) {
//                     if (context.mounted) {
//                       showSnackBar(context, e.toString());
//                     }
//                   }
//                 }),
//             const SizedBox(
//               width: 10,
//             ),
//             AccountButton(
//                 buttonName: 'Wish List',
//                 onPressed: () {
//                   context.pushNamed(
//                       AppRouteConstants.yourWishListScreenRoute.name);
//                 }),
//           ],
//         ),
//       ],
//     );
//   }
// }
