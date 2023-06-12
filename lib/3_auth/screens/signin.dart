// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/show_snackbar.dart';
import 'package:tour_a_vlog/3_auth/controller/auth_screen_controller.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/3_auth/screens/signup.dart';
import 'package:tour_a_vlog/4_home_navigation/bottom_navigation.dart';

class SignInScreen extends ConsumerWidget {
  static const routeName = '/sign_in';
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  DateTime? backPressTime;

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isLoading = ref.watch(signInLoadingProvider);
    return WillPopScope(
      onWillPop: () async {
        bool backStatus = onWillPop(context);
        if (backStatus) {
          exit(0);
        } else {
          return false;
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: whiteColor,
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  imageContainer(size),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: fixPadding * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heightBox(size.height * 0.1),
                        welcomeText(context),
                        heightSpace,
                        heightSpace,
                        heightSpace,
                        signInFields(size, context),
                        heightSpace,
                        heightSpace,
                        height5Space,
                        bottomContainer(size, isLoading, context, ref),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  welcomeText(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'signin.welcome'),
          style: bold20white,
        ),
        Text(
          getTranslate(context, 'signin.sign_continue'),
          style: semibold18white,
        ),
      ],
    );
  }

  bottomContainer(Size size, bool isLoading, context, ref) {
    return Column(
      children: [
        arrowButton(size, isLoading, context, ref),
        heightSpace,
        heightSpace,
        continueText(context)
      ],
    );
  }

  continueText(context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, SignUpScreen.routeName);
        },
        child: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(text: "Don't have account? "),
              TextSpan(
                  text: "SignUp",
                  style: TextStyle(
                      color: Colors.lightBlue, fontWeight: FontWeight.bold)),
              TextSpan(text: " now!"),
            ],
          ),
        ),
      ),
    );
  }

  bool validate(context, ref) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (emailController.text.trim() != '' &&
        passwordController.text.trim() != '') {
      return true;
    }
    ref.read(signInLoadingProvider.notifier).state = false;
    showSnackBar(context, Icons.cancel_outlined, Colors.red,
        "There is empty field!", Colors.red);
    return false;
  }

  void firebaseSignIn(context, WidgetRef ref) async {
    ref.read(signInLoadingProvider.notifier).state = true;
    if (validate(context, ref)) {
      final res = await ref.read(userControllerProvider.notifier).loginUser(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      if (res['success']) {
        ref.read(signInLoadingProvider.notifier).state = false;
        Navigator.popAndPushNamed(context, BottomNavigationScreen.routeName);
        showSnackBar(context, Icons.done, Colors.greenAccent,
            "Sign In Success.", Colors.greenAccent);
      } else {
        ref.read(signInLoadingProvider.notifier).state = false;
        showSnackBar(context, Icons.cancel_outlined, Colors.red,
            res["message"].toString(), Colors.red);
      }
    }
  }

  arrowButton(Size size, bool isLoading, context, ref) {
    return Center(
      child: GestureDetector(
        onTap: () {
          firebaseSignIn(context, ref);
        },
        child: Container(
          height: size.height * 0.1,
          width: size.height * 0.1,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : const Icon(
                  Icons.arrow_forward_rounded,
                  size: 40,
                  color: whiteColor,
                ),
        ),
      ),
    );
  }

  imageContainer(Size size) {
    return Container(
      height: size.height * 0.35,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: primaryColor,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: const AssetImage("assets/auth/sign.jpg"),
          colorFilter:
              ColorFilter.mode(primaryColor.withOpacity(0.4), BlendMode.dstIn),
        ),
      ),
    );
  }

  signInFields(Size size, context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(fixPadding * 2),
      margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.6),
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            getTranslate(context, 'signin.login'),
            style: semibold22text,
          ),
          heightSpace,
          heightSpace,
          textField(
            context,
            emailController,
            TextInputType.emailAddress,
            false,
            Icons.email_outlined,
            'signin.email_address',
          ),
          heightSpace,
          heightSpace,
          textField(
            context,
            passwordController,
            TextInputType.visiblePassword,
            true,
            Icons.password_outlined,
            'signin.password',
          ),
        ],
      ),
    );
  }

  textField(
    context,
    TextEditingController textEditingController,
    TextInputType textInputType,
    bool obscureText,
    IconData icon,
    String text,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.5),
            blurRadius: 5,
          )
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xff6879DC),
          ),
        ),
        child: TextField(
          controller: textEditingController,
          keyboardType: textInputType,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              icon,
              size: 18,
            ),
            hintText: getTranslate(context, text),
            hintStyle: regular14grey,
          ),
        ),
      ),
    );
  }

  onWillPop(context) {
    DateTime now = DateTime.now();

    if (backPressTime == null ||
        now.difference(backPressTime!) > const Duration(seconds: 2)) {
      backPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: blackColor,
            content: Text(
              getTranslate(context, 'app_exit.exit_text'),
              style: const TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            duration: const Duration(milliseconds: 1500),
            behavior: SnackBarBehavior.floating),
      );
      return false;
    } else {
      return true;
    }
  }
}
