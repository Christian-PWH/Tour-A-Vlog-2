import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_credit_card/credit_card.dart';

class FlightTravelDetails extends StatefulWidget {
  static const routeName = '/flight_travel_detail';

  const FlightTravelDetails({super.key});

  @override
  State<FlightTravelDetails> createState() => _FlightTravelDetailsState();
}

class _FlightTravelDetailsState extends State<FlightTravelDetails> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  bool value = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
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
          getTranslate(context, 'flight_traveller_detail.travellers_detail'),
          style: semibold18white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        children: [
          nameField(context),
          heightSpace,
          heightSpace,
          phoneField(context),
          heightSpace,
          heightSpace,
          emailField(context),
          heightSpace,
          agreebox(),
          heightBox(40),
          continueButton(size),
        ],
      ),
    );
  }

  continueButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CreditCard.routeName);
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
          getTranslate(context, 'flight_traveller_detail.continue'),
          style: semibold18white,
        ),
      ),
    );
  }

  nameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: grey94Color.withOpacity(0.5),
                blurRadius: 5,
              ),
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
                hintText:
                    getTranslate(context, 'flight_traveller_detail.full_name'),
                hintStyle: regular14grey,
                prefixIcon: const Icon(
                  Icons.person_outline,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        heightBox(3.0),
        Text(
          getTranslate(context, 'flight_traveller_detail.name_suggestion_text'),
          style: regular12black.copyWith(
            color: const Color(0xffFF4747),
          ),
        )
      ],
    );
  }

  phoneField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: grey94Color.withOpacity(0.5),
                blurRadius: 5,
              ),
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
                hintText: getTranslate(
                    context, 'flight_traveller_detail.mobile_number'),
                hintStyle: regular14grey,
                prefixIcon: const Icon(
                  Icons.phone_android_rounded,
                  size: 19,
                ),
              ),
            ),
          ),
        ),
        heightBox(3.0),
        Text(
          getTranslate(
              context, 'flight_traveller_detail.mobile_suggestion_text'),
          style: regular12black.copyWith(
            color: const Color(0xffFF4747),
          ),
        )
      ],
    );
  }

  emailField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: grey94Color.withOpacity(0.5),
            blurRadius: 5,
          ),
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
            hintText:
                getTranslate(context, 'flight_traveller_detail.email_address'),
            hintStyle: regular14grey,
            prefixIcon: const Icon(
              Icons.mail_outline,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  agreebox() {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (newvalue) {
            setState(() {
              value = newvalue!;
            });
          },
          activeColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          side: const BorderSide(color: grey94Color),
          visualDensity: VisualDensity.compact,
        ),
        width5Space,
        Text(
          getTranslate(context, 'flight_traveller_detail.agree_text'),
          style: regular12grey.copyWith(fontSize: 13),
        ),
      ],
    );
  }
}
