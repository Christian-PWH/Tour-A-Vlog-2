import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/tour_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/show_snackbar.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/order_controller.dart';
import 'package:tour_a_vlog/5_pages/1_success/success.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TravelDetail extends ConsumerStatefulWidget {
  static const routeName = '/travel_detail';

  final TourModel tour;

  const TravelDetail({super.key, required this.tour});

  @override
  ConsumerState<TravelDetail> createState() => _TravelDetailState();
}

class _TravelDetailState extends ConsumerState<TravelDetail> {
  TourModel get tour => widget.tour;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final noOfTravellersController = TextEditingController();
  final dateController = TextEditingController();
  DateTime? bookingDate;

  bool value = false;

  int personNo = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
            getTranslate(context, 'travel_detail.travellers_detail'),
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
            textField(
              context,
              nameController,
              () {},
              TextInputType.name,
              Icons.person_outline,
              getTranslate(context, 'travel_detail.full_name'),
              false,
              true,
              getTranslate(context, 'travel_detail.name_suggestion_text'),
            ),
            heightSpace,
            heightSpace,
            textField(
              context,
              phoneController,
              () {},
              TextInputType.phone,
              Icons.phone_android_rounded,
              getTranslate(context, 'travel_detail.mobile_number'),
              false,
              true,
              getTranslate(context, 'travel_detail.mobile_suggestion_text'),
            ),
            heightSpace,
            heightSpace,
            textField(
              context,
              emailController,
              () {},
              TextInputType.emailAddress,
              Icons.mail_outline,
              getTranslate(context, 'travel_detail.email_address'),
              false,
              false,
              '',
            ),
            heightSpace,
            heightSpace,
            textField(
              context,
              noOfTravellersController,
              () {
                noOfTravelModalSheet(context, size);
              },
              TextInputType.number,
              Icons.person_outline,
              getTranslate(context, 'travel_detail.no_travellers'),
              true,
              false,
              '',
            ),
            heightSpace,
            heightSpace,
            textField(
              context,
              dateController,
              () async {
                bookingPickedDate(context);
              },
              TextInputType.text,
              Icons.calendar_month_outlined,
              getTranslate(context, 'travel_detail.booking_date'),
              true,
              false,
              '',
            ),
            heightSpace,
            agreeBox(),
            heightSpace,
            heightSpace,
            continueButton(context, size),
          ],
        ),
      ),
    );
  }

  Future<dynamic> noOfTravelModalSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: blackColor.withOpacity(0.3),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2, vertical: fixPadding),
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: grey94Color,
                      ),
                    )
                  ],
                ),
                heightSpace,
                personContainer(size, state),
                heightSpace,
              ],
            ),
          );
        });
      },
    );
  }

  void bookingPickedDate(context) async {
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: primaryColor),
            ),
            child: child!);
      },
    );
    if (pickedDate == null) return;
    bookingDate = pickedDate;
    String formattedDate = DateFormat(
            'dd MMMM yyyy',
            // ignore: use_build_context_synchronously
            Localizations.localeOf(context).toString())
        .format(pickedDate);
    dateController.text = formattedDate;
  }

  Widget textField(
    context,
    TextEditingController textEditingController,
    void Function()? onTap,
    TextInputType textInputType,
    IconData icon,
    String hintText,
    bool readOnly,
    bool fieldAlert,
    String fieldAlertText,
  ) {
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
              onTap: onTap,
              controller: textEditingController,
              keyboardType: textInputType,
              readOnly: readOnly,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: regular14grey,
                prefixIcon: Icon(
                  icon,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: fieldAlert,
          child: Column(
            children: [
              heightBox(3.0),
              Text(
                fieldAlertText,
                style: regular12black.copyWith(
                  color: const Color(0xffFF4747),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  bool validate(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (nameController.text.trim() != '' &&
        phoneController.text.trim() != '' &&
        emailController.text.trim() != '' &&
        noOfTravellersController.text.trim() != '' &&
        dateController.text.trim() != '' &&
        bookingDate != null) {
      return true;
    }
    showSnackBar(context, Icons.cancel_outlined, Colors.red,
        "There is empty field!", Colors.red);
    return false;
  }

  Widget continueButton(context, Size size) {
    return GestureDetector(
      onTap: () async {
        if (!validate(context)) return;
        final orderController = ref.watch(orderControllerProvider);
        final user =
            await ref.read(userControllerProvider.notifier).getCurrentUser();
        if (user == null) return;
        orderController.save(
          // tourId: tour.id,
          tour: tour,
          userId: user.uid!,
          status: 'new',
          fullName: nameController.text.trim(),
          numberPhone: phoneController.text.trim(),
          email: emailController.text.trim(),
          quantity: int.parse(noOfTravellersController.text),
          price: double.parse(tour.price),
          totalPrice: double.parse(tour.price) *
              int.parse(noOfTravellersController.text),
          bookingDate: bookingDate!,
        );
        // Navigator.pushNamed(context, CreditCard.routeName);
        Navigator.pushNamed(context, SuccessScreen.routeName);
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
        child: const Text(
          // getTranslate(context, 'travel_detail.continue'),
          'Make a Payment',
          style: semibold18white,
        ),
      ),
    );
  }

  Widget agreeBox() {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (newValue) {
            setState(() {
              value = newValue!;
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
          getTranslate(context, 'travel_detail.agree_text'),
          style: regular12grey.copyWith(fontSize: 13),
        ),
      ],
    );
  }

  Widget personContainer(Size size, StateSetter state) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffF9F9F9),
        boxShadow: [
          BoxShadow(
            color: grey94Color.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: size.height * 0.05,
            width: size.height * 0.05,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.person, color: whiteColor),
          ),
          widthSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslate(context, 'travel_detail.person'),
                style: medium14grey94,
              ),
              height5Space,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        state(() {
                          if (personNo > 0) {
                            personNo--;
                          }
                        });
                      });
                      noOfTravellersController.text = "$personNo";
                    },
                    child: Container(
                      padding: const EdgeInsets.all(fixPadding / 3),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        color: blackColor,
                        size: 12,
                      ),
                    ),
                  ),
                  widthSpace,
                  Text(
                    personNo.toString(),
                    style: semibold14black,
                  ),
                  widthSpace,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        state(() {
                          personNo++;
                        });
                      });
                      noOfTravellersController.text = "$personNo";
                    },
                    child: Container(
                      padding: const EdgeInsets.all(fixPadding / 3),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        color: blackColor,
                        size: 12,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
