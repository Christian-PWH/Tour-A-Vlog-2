// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/3_auth/screens/signin.dart';

import '../controller/auth_screen_controller.dart';

class SignUpScreen extends ConsumerWidget {
  static const routeName = '/sign_up';

  SignUpScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          Stack(
            children: [
              imageContainer(size, context),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backButton(context),
                    welcomeText(context),
                    heightSpace,
                    registerFields(size, context),
                    heightSpace,
                    heightSpace,
                    height5Space,
                    bottomContainer(size, context, ref),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  backButton(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 22,
        color: whiteColor,
      ),
    );
  }

  welcomeText(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'signup.welcome'),
            style: bold20white,
          ),
          Text(
            getTranslate(context, 'signup.Signup_continue'),
            style: semibold18white,
          )
        ],
      ),
    );
  }

  imageContainer(Size size, context) {
    return Container(
      height: size.height * 0.35,
      width: double.infinity,
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

  registerFields(Size size, context) {
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
            getTranslate(context, 'signup.register'),
            style: semibold22text,
          ),
          heightSpace,
          heightSpace,
          nameField(context),
          heightSpace,
          heightSpace,
          emailField(context),
          heightSpace,
          heightSpace,
          phoneField(context),
          heightSpace,
          heightSpace,
          passwordField(context),
          heightSpace,
        ],
      ),
    );
  }

  bottomContainer(Size size, BuildContext context, ref) {
    return Column(
      children: [
        arrowButton(size, context, ref),
        // heightSpace,
        // heightSpace,
        // orText(context),
        // heightSpace,
        // heightSpace,
        // socialButtons(size),
      ],
    );
  }

  socialButtons(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Row(
        children: [
          Expanded(
            child: socialIcon(size, const Color(0xff4A75EB),
                "assets/auth/la_facebook-f.png", "Facebook"),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: socialIcon(size, const Color(0xffFB3434),
                "assets/auth/carbon_logo-google.png", "Google"),
          ),
        ],
      ),
    );
  }

  socialIcon(Size size, Color color, String icon, String name) {
    return Container(
      height: size.height * 0.07,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.5),
            blurRadius: 5,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: size.height * 0.03,
            width: size.height * 0.03,
            fit: BoxFit.cover,
          ),
          widthSpace,
          Text(name, style: semibold16white)
        ],
      ),
    );
  }

  orText(context) {
    return Text(
      getTranslate(context, 'signup.or_text'),
      style: medium14grey94,
    );
  }

  bool validate(context, ref) {
    if (nameController.text.trim() != '' &&
        emailController.text.trim() != '' &&
        phoneController.text.trim() != '' &&
        passwordController.text.trim() != '') {
      return true;
    }
    ref.read(signInLoadingProvider.notifier).state = false;
    showSnackBar(context, Icons.cancel_outlined, Colors.red,
        "There is empty field!", Colors.red);
    return false;
  }

  void firebaseSignUp(context, ref) async {
    ref.read(signUpLoadingProvider.notifier).state = true;
    if (validate(context, ref)) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        DatabaseReference dbRef =
            FirebaseDatabase.instance.ref("Users/${credential.user?.uid}");
        await dbRef.set({
          "email": emailController.text.trim(),
          "fullName": nameController.text.trim(),
          "phoneNumber": phoneController.text.trim(),
          "password": passwordController.text.trim(),
        });
        ref.read(signInLoadingProvider.notifier).state = false;
        showSnackBar(context, Icons.done, Colors.greenAccent, "Sign up success",
            Colors.greenAccent);
        Navigator.pushNamed(context, SignInScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ref.read(signInLoadingProvider.notifier).state = false;
          showSnackBar(context, Icons.cancel_outlined, Colors.red,
              "The password provided is too weak.", Colors.red);
        } else if (e.code == 'email-already-in-use') {
          ref.read(signInLoadingProvider.notifier).state = false;
          showSnackBar(context, Icons.cancel_outlined, Colors.red,
              "The account already exists for that email.", Colors.red);
        }
      }
    }
  }

  arrowButton(Size size, context, ref) {
    final isLoading = ref.watch(signInLoadingProvider);
    return Center(
      child: GestureDetector(
        onTap: () {
          firebaseSignUp(context, ref);
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

  void showSnackBar(BuildContext context, IconData? icon, Color? iconColor,
      String? message, Color? messageColor) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Text(
                  message!,
                  style: TextStyle(
                    color: messageColor!,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      );
  }

  phoneField(context) {
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
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.phone_android_outlined,
              size: 18,
            ),
            hintText: getTranslate(context, 'signup.mobile_number'),
            hintStyle: regular14grey,
          ),
        ),
      ),
    );
  }

  emailField(context) {
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
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.email_outlined,
              size: 18,
            ),
            hintText: getTranslate(context, 'signup.email_address'),
            hintStyle: regular14grey,
          ),
        ),
      ),
    );
  }

  nameField(context) {
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
          controller: nameController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.person_outline_sharp,
              size: 20,
            ),
            hintText: getTranslate(context, 'signup.name'),
            hintStyle: regular14grey,
          ),
        ),
      ),
    );
  }

  passwordField(context) {
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
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.password_outlined,
              size: 18,
            ),
            hintText: getTranslate(context, "password"),
            hintStyle: regular14grey,
          ),
        ),
      ),
    );
  }
}
