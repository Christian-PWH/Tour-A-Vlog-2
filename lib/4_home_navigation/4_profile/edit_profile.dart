import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/show_snackbar.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/languages.dart';
import 'package:tour_a_vlog/5_pages/4_pick_location/pick_location.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit_profile';

  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool userImageUpdated = false;
  String userImagePath =
      "https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500";
  File? userImageFile;
  @override
  void initState() {
    nameController.text = "Teresaki";
    emailController.text = "example@gmail.com";
    phoneController.text = "+62(1234567890)";
    locationController.text = "6391 Elgin St. Celina, Delaware 10299";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
    );
  }

  updateButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
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
              onTap: () {
                pickLocation(context);
              },
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
                  ? ClipOval(
                      child: Image.file(
                        userImageFile!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(
                      child: Image.network(
                        userImagePath,
                        fit: BoxFit.cover,
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
                                  context),
                              bottomSheetGetMedia(
                                  size,
                                  Icons.photo,
                                  const Color(0xff1E996D),
                                  getTranslate(context, 'edit_profile.gallery'),
                                  context),
                              bottomSheetGetMedia(
                                  size,
                                  Icons.delete_outline_outlined,
                                  const Color(0xffEF1717),
                                  getTranslate(
                                      context, 'edit_profile.remove_image'),
                                  context),
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

  bottomSheetGetMedia(
      Size size, IconData icon, Color color, String text, context) {
    return GestureDetector(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.camera);
        debugPrint(image.toString());
        setState(() {
          if (image == null) return;
          userImageUpdated = true;
          userImageFile = File(image.path);
        });
      },
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

  void pickLocation(BuildContext context) async {
    final result = await Navigator.pushNamed(context, PickLocation.routeName);
    setState(() {
      locationController.text = result.toString();
    });
  }
}
