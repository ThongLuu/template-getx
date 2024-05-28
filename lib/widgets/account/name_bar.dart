import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/user_controller.dart';
import 'package:get/get.dart';
import '../../../../utils/utils.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class NameBar extends StatelessWidget {
  const NameBar({super.key});

  @override
  Widget build(BuildContext context) {
    var controllerUser = Get.put(UserController());
    controllerUser.getUserData();
    return Obx(() => Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff92DDE6),
                Color(0xffA6E6CE),
              ]),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello, ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
            ),
            controllerUser.user.value.name != ''
                ? Text(
                    controllerUser.user.value.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  )
                : const SizedBox(),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                      minimumSize: MaterialStatePropertyAll(Size(40, 30)),
                      maximumSize: MaterialStatePropertyAll(Size(40, 30)),
                      fixedSize: MaterialStatePropertyAll(Size(40, 30)),
                    ),
                    onPressed: () async {
                      // var res = await Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const SimpleBarcodeScannerPage(),
                      //     ));
                    },
                    child: const Icon(Icons.qr_code),
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
