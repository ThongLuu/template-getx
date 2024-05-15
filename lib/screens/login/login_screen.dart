import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/radio_controller.dart';
import 'package:flutter_template/controllers/signup_controller.dart';
import 'package:flutter_template/services/auth_api_service.dart';
import 'package:flutter_template/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter_template/widgets/common_widgets/custom_textfield.dart';
import 'package:get/get.dart';

import '../../config/config_api.dart';
import '../../controllers/login/login_controller.dart';
import '../../routes/app_pages.dart';
import '../../widgets/common_widgets/loading_overlay.dart';
import '../../utils/constants/constants.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  void checkHeaderMessages(duration) {
    if (Get.arguments != null &&
        Get.arguments.containsKey('message') &&
        Get.arguments['message'].containsKey('status_text') &&
        Get.arguments['message']['status_text'] == 'session_expired') {
      var message = Get.arguments['message']['body'];
      Get.snackbar(
        "Warning",
        message.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
        shouldIconPulse: true,
        barBlur: 20,
      );
      Get.arguments.remove('message');
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(checkHeaderMessages);

    var controller1 = Get.put(RadioController());
    var controllerSignUp =
        Get.put(SignupController(Get.find<AuthApiService>()));

    return Obx(() => Scaffold(
        backgroundColor: Constants.greyBackgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 40,
                            width: 50,
                          ),
                          const SizedBox.square(
                            dimension: 12,
                          ),
                          const Text(
                            'Welcome',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox.square(
                            dimension: 12,
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, right: 8, left: 8),
                              decoration: BoxDecoration(
                                color: controller1.radioGroupValue.value ==
                                        "signup"
                                    ? Constants.backgroundColor
                                    : Constants.greyBackgroundColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(children: [
                                ListTile(
                                  minLeadingWidth: 2,
                                  leading: SizedBox.square(
                                    dimension: 12,
                                    child: Radio(
                                        value: "signup",
                                        groupValue:
                                            controller1.radioGroupValue.value,
                                        onChanged: (value) {
                                          controller1.radioGroupValue.value =
                                              "signup";
                                        }),
                                  ),
                                  title: RichText(
                                    text: const TextSpan(children: [
                                      TextSpan(
                                        text: 'Create account. ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                    ]),
                                  ),
                                  onTap: () {
                                    controller1.radioGroupValue.value =
                                        "signup";
                                  },
                                ),
                                controller1.radioGroupValue.value == "signup"
                                    ? Form(
                                        key: controllerSignUp.signupFormKey,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (ConfigAPI.signupWithPassword)
                                              Column(children: [
                                                CustomTextfield(
                                                  controller: controllerSignUp
                                                      .emailController,
                                                  hintText: 'Email',
                                                ),
                                                CustomTextfield(
                                                  controller: controllerSignUp
                                                      .passwordController,
                                                  hintText: 'Set password',
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                CustomElevatedButton(
                                                  buttonText: 'Signup',
                                                  onPressed: () async {
                                                    if (controllerSignUp
                                                        .signupFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      LoadingOverlay.show(
                                                          message:
                                                              'Registering...');
                                                      try {
                                                        await controllerSignUp
                                                            .signup();

                                                        controllerSignUp
                                                            .signupFormKey
                                                            .currentState!
                                                            .save();

                                                        Get.offAllNamed(
                                                            Routes.HOMESCREEN);
                                                      } catch (err, _) {
                                                        printError(
                                                            info:
                                                                err.toString());
                                                        LoadingOverlay.hide();
                                                        Get.snackbar(
                                                          "Error",
                                                          err.toString(),
                                                          snackPosition:
                                                              SnackPosition.TOP,
                                                          backgroundColor:
                                                              Colors.red
                                                                  .withOpacity(
                                                                      .75),
                                                          colorText:
                                                              Colors.white,
                                                          icon: const Icon(
                                                              Icons.error,
                                                              color:
                                                                  Colors.white),
                                                          shouldIconPulse: true,
                                                          barBlur: 20,
                                                        );
                                                      } finally {}
                                                    }
                                                  },
                                                )
                                              ]),
                                            GestureDetector(
                                              onTap: () {
                                                Get.offAllNamed(
                                                    Routes.HOMESCREEN);
                                              },
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      'Don\'t have an account?'),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    'Sign Up',
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ])),
                          Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, right: 8, left: 8),
                              decoration: BoxDecoration(
                                  color: controller1.radioGroupValue.value ==
                                          "signin"
                                      ? Constants.backgroundColor
                                      : Constants.greyBackgroundColor,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Column(
                                children: [
                                  ListTile(
                                    minLeadingWidth: 2,
                                    leading: SizedBox.square(
                                      dimension: 12,
                                      child: Radio(
                                          value: "signin",
                                          groupValue:
                                              controller1.radioGroupValue.value,
                                          onChanged: (value) {
                                            controller1.radioGroupValue.value =
                                                "signin";
                                          }),
                                    ),
                                    title: RichText(
                                      text: const TextSpan(children: [
                                        TextSpan(
                                          text: 'Sign in. ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: 'Already a customer?',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black87),
                                        ),
                                      ]),
                                    ),
                                    onTap: () {
                                      controller1.radioGroupValue.value =
                                          "signin";
                                    },
                                  ),
                                  controller1.radioGroupValue.value == "signin"
                                      ? Form(
                                          key: controller.loginFormKey,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (ConfigAPI.loginWithPassword)
                                                Column(children: [
                                                  CustomTextfield(
                                                    controller: controller
                                                        .emailController,
                                                    hintText: 'Email',
                                                  ),
                                                  CustomTextfield(
                                                    controller: controller
                                                        .passwordController,
                                                    hintText: 'Set password',
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  CustomElevatedButton(
                                                    buttonText: 'Continue',
                                                    onPressed: () async {
                                                      if (controller
                                                          .loginFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        LoadingOverlay.show(
                                                            message:
                                                                'Login...');
                                                        try {
                                                          await controller
                                                              .login();
                                                          Get.offAllNamed(Routes
                                                              .HOMESCREEN);
                                                        } catch (err, _) {
                                                          printError(
                                                              info: err
                                                                  .toString());
                                                          LoadingOverlay.hide();
                                                          Get.snackbar(
                                                            "Error",
                                                            err.toString(),
                                                            snackPosition:
                                                                SnackPosition
                                                                    .TOP,
                                                            backgroundColor:
                                                                Colors.red
                                                                    .withOpacity(
                                                                        .75),
                                                            colorText:
                                                                Colors.white,
                                                            icon: const Icon(
                                                                Icons.error,
                                                                color: Colors
                                                                    .white),
                                                            shouldIconPulse:
                                                                true,
                                                            barBlur: 20,
                                                          );
                                                        } finally {}

                                                        controller.loginFormKey
                                                            .currentState!
                                                            .save();
                                                      }
                                                    },
                                                  )
                                                ]),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     Get.offAllNamed(Routes.SIGNUP);
                                              //   },
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.center,
                                              //     children: [
                                              //       const Text(
                                              //           'Don\'t have an account?'),
                                              //       SizedBox(
                                              //         width: 3,
                                              //       ),
                                              //       Text(
                                              //         'Sign Up',
                                              //         style: TextStyle(
                                              //             color: Colors.blue),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ],
                              )),
                        ]))))));
  }
}
