import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/user_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/error_screen.dart';
import 'package:tour_a_vlog/1_common/widgets/show_alert_dialog.dart';
import 'package:tour_a_vlog/1_common/widgets/show_loading_dialog.dart';
import 'package:tour_a_vlog/1_common/widgets/show_snackbar.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/controller/edit_profile_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/languages.dart';
import 'package:tour_a_vlog/4_home_navigation/bottom_navigation.dart';

class EditProfile extends ConsumerStatefulWidget {
  static const routeName = '/edit_profile';

  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late UserModel userModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool userImageUpdated = false;
  bool userImageDeleted = false;
  String defaultUserImagePath = "assets/profile/User Image.png";
  String userImageFromUrl = '-';
  String? userImageFilePath;

  Position? position;

  @override
  void initState() {
    super.initState();
    _getDateLocation(context);
  }

  Future<void> _getDateLocation(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await showAlertDialog(
        context: context,
        icon: Icons.error_outline,
        title: "Location Unavailable",
        content: "Location services are disabled,\nplease enable it!",
        defaultActionText: "CLOSE",
        onButtonPressed: () {
          Navigator.pop(context);
        },
      );
      Navigator.pop(context);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await showAlertDialog(
          context: context,
          icon: Icons.error_outline,
          title: "Location Unavailable",
          content: "Location permissions are denied\nplease approve it",
          defaultActionText: "CLOSE",
          onButtonPressed: () {
            Navigator.pop(context);
          },
        );
        Navigator.pop(context);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await showAlertDialog(
        context: context,
        icon: Icons.error_outline,
        title: "Location Unavailable",
        content:
            "Location permissions are denied permanently\nplease approve it",
        defaultActionText: "CLOSE",
        onButtonPressed: () {
          Navigator.pop(context);
        },
      );
      Navigator.pop(context);
    }

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    Placemark place = placeMarks[0];

    ref.read(editProfileLocationProvider.notifier).state =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    userImageUpdated = ref.watch(editProfileImageUpdatedProvider);
    userImageDeleted = ref.watch(editProfileImageDeletedProvider);
    userImageFilePath = ref.watch(editProfileImageFilePathProvider);
    locationController.text = ref.watch(editProfileLocationProvider);
    final currentUser = ref.watch(userControllerProvider);
    debugPrint('edit profile - build scaffold');
    return currentUser.when(
      data: (userModel) {
        userImageFromUrl = userModel?.profilePicture ?? '-';
        nameController.text = userModel?.fullName ?? 'user';
        emailController.text = userModel?.email ?? 'email';
        phoneController.text = userModel?.phoneNumber ?? 'phone';
        return Scaffold(
          backgroundColor: whiteColor,
          body: editProfileBody(size, context, userModel),
        );
      },
      error: (error, stackTrace) {
        return const ErrorScreen(text: 'Navigator Screen - Call Developer');
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  updateButton(Size size) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return passwordConfirmation(context, size);
          },
        );
      },
      child: Container(
        height: size.height * 0.07,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: gradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.25),
              blurRadius: 5,
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'edit_profile.update'),
          style: semibold18white,
        ),
      ),
    );
  }

  Widget editProfileBody(Size size, context, UserModel? userModel) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: whiteColor,
            ),
          ),
          titleSpacing: 0,
          title: Text(
            getTranslate(context, 'edit_profile.edit_profile'),
            style: semibold18white,
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(fixPadding * 2),
          children: [
            userProfile(size, context),
            heightSpace,
            height5Space,
            nameField(context),
            heightSpace,
            emailField(context),
            heightSpace,
            phoneField(context),
            heightSpace,
            locationField(context),
            heightBox(40.0),
            updateButton(size),
          ],
        ),
      ),
    );
  }

  Widget passwordConfirmation(context, Size size) {
    bool isLoading = ref.watch(editProfileLoadingProvider);
    return SizedBox(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        backgroundColor: Colors.white,
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                child: Text(
                  getTranslate(context, 'edit_profile.password_verification'),
                  style: semibold16black,
                ),
              ),
              heightBox(10.0),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: getTranslate(
                      context, 'edit_profile.password_verification'),
                  hintStyle: regular14grey,
                  suffixIcon: const Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: primaryColor,
                  ),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Field Can\'t Be Empty';
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
              heightBox(40.0),
              GestureDetector(
                onTap: () async {
                  showLoadingDialog(context);
                  updatingProfile(context);
                },
                child: Container(
                  height: size.height * 0.07,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: gradient,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.25),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          getTranslate(context, 'edit_profile.update'),
                          style: semibold18white,
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updatingProfile(context) async {
    final res = await ref.read(userControllerProvider.notifier).updateUser(
          profilePictureUpdated: userImageUpdated,
          profilePicture: userImageFilePath!,
          fullName: nameController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          longitude: position!.longitude.toString(),
          latitude: position!.latitude.toString(),
        );
    if (res['success']) {
      ref.read(editProfileLoadingProvider.notifier).state = false;
      Navigator.pop(context);
      Navigator.pushNamed(context, BottomNavigationScreen.routeName);
      showSnackBar(context, Icons.done, Colors.greenAccent, "Profile Updated.",
          Colors.greenAccent);
    } else {
      ref.read(editProfileLoadingProvider.notifier).state = false;
      Navigator.pop(context);
      showSnackBar(context, Icons.cancel_outlined, Colors.red,
          res["message"].toString(), Colors.red);
    }
  }

  locationField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'edit_profile.location'),
          style: semibold16black,
        ),
        height5Space,
        Container(
          padding: languageValue == "عربي"
              ? const EdgeInsets.only(right: fixPadding * 2)
              : const EdgeInsets.only(
                  left: fixPadding * 2,
                ),
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
              colorScheme: const ColorScheme.light(primary: primaryColor),
            ),
            child: TextField(
              controller: locationController,
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: getTranslate(context, 'edit_profile.choose_location'),
                hintStyle: regular14grey,
                suffixIcon: const Icon(
                  Icons.location_on_outlined,
                  size: 20,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  emailField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'edit_profile.email_id'),
          style: semibold16black,
        ),
        height5Space,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
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
              colorScheme: const ColorScheme.light(primary: primaryColor),
            ),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: getTranslate(context, 'edit_profile.enter_email'),
                hintStyle: regular14grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  phoneField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'edit_profile.phone_number'),
          style: semibold16black,
        ),
        height5Space,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
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
              colorScheme: const ColorScheme.light(primary: primaryColor),
            ),
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: getTranslate(context, 'edit_profile.enter_number'),
                hintStyle: regular14grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  nameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'edit_profile.name'),
          style: semibold16black,
        ),
        height5Space,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
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
              colorScheme: const ColorScheme.light(primary: primaryColor),
            ),
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: getTranslate(context, 'edit_profile.enter_name'),
                hintStyle: regular14grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  userProfile(Size size, BuildContext context) {
    return Center(
      child: SizedBox(
        height: size.height * 0.155,
        width: size.height * 0.15,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.15,
              width: size.height * 0.15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: userImageUpdated
                  ? userImageDeleted
                      ? ClipOval(
                          child: Image.asset(
                            defaultUserImagePath,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: Image.file(
                            File(userImageFilePath!),
                            fit: BoxFit.cover,
                          ),
                        )
                  : userImageFromUrl == '-'
                      ? ClipOval(
                          child: Image.asset(
                            defaultUserImagePath,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: Image.network(
                            userImageFromUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, event) {
                              if (event == null) return child;
                              return Center(
                                child: SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    value: event.cumulativeBytesLoaded /
                                        (event.expectedTotalBytes ?? 1),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, object, stacktrace) {
                              return const Center(
                                child: SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: Icon(Icons.image_not_supported),
                                ),
                              );
                            },
                          ),
                        ),
            ),
            GestureDetector(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: size.height * 0.035,
                  width: size.height * 0.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        colors: gradient,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        color: whiteColor,
                        size: 16,
                      ),
                      width5Space,
                      Text(
                        getTranslate(context, 'edit_profile.change'),
                        style: medium12black.copyWith(color: whiteColor),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  barrierColor: blackColor.withOpacity(0.2),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10))),
                  elevation: 4,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: size.height * 0.26,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: fixPadding * 2, horizontal: fixPadding * 2),
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            getTranslate(
                                context, 'edit_profile.change_profile'),
                            style: semibold18black,
                          ),
                          heightSpace,
                          heightSpace,
                          height5Space,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              bottomSheetGetMedia(
                                size,
                                Icons.camera_alt_rounded,
                                const Color(0xff1E4799),
                                getTranslate(context, 'edit_profile.camera'),
                                context,
                                () async {
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.camera);
                                  ref
                                      .read(editProfileImageUpdatedProvider
                                          .notifier)
                                      .state = true;
                                  ref
                                      .read(editProfileImageDeletedProvider
                                          .notifier)
                                      .state = false;
                                  ref
                                      .read(editProfileImageFilePathProvider
                                          .notifier)
                                      .state = image!.path;
                                },
                              ),
                              bottomSheetGetMedia(
                                size,
                                Icons.photo,
                                const Color(0xff1E996D),
                                getTranslate(context, 'edit_profile.gallery'),
                                context,
                                () async {
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  ref
                                      .read(editProfileImageUpdatedProvider
                                          .notifier)
                                      .state = true;
                                  ref
                                      .read(editProfileImageDeletedProvider
                                          .notifier)
                                      .state = false;
                                  ref
                                      .read(editProfileImageFilePathProvider
                                          .notifier)
                                      .state = image!.path;
                                },
                              ),
                              bottomSheetGetMedia(
                                size,
                                Icons.delete_outline_outlined,
                                const Color(0xffEF1717),
                                getTranslate(
                                    context, 'edit_profile.remove_image'),
                                context,
                                () async {
                                  ref
                                      .read(editProfileImageUpdatedProvider
                                          .notifier)
                                      .state = true;
                                  ref
                                      .read(editProfileImageDeletedProvider
                                          .notifier)
                                      .state = true;
                                  ref
                                      .read(editProfileImageFilePathProvider
                                          .notifier)
                                      .state = '-';
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  bottomSheetGetMedia(Size size, IconData icon, Color color, String text,
      context, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: size.height * 0.07,
            width: size.height * 0.07,
            decoration: BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: grey94Color.withOpacity(0.3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          height5Space,
          Text(text.toString(),
              style: regular16black.copyWith(fontSize: 15),
              textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
