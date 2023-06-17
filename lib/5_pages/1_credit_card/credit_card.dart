import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/show_snackbar.dart';
import 'package:tour_a_vlog/5_pages/1_success/success.dart';

class CreditCard extends StatefulWidget {
  static const routeName = '/credit_card';

  const CreditCard({super.key});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            getTranslate(context, 'credit_card.credit_card'),
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
          children: [
            creditCard(size),
            Column(
              children: [
                creditcardfrom(),
                heightBox(30),
                makePaymentButton(size),
                heightSpace,
                heightSpace,
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget creditCard(Size size) {
    return CreditCardWidget(
      height: size.height * 0.28,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      showBackView: isCvvFocused,
      obscureCardNumber: true,
      obscureCardCvv: true,
      isHolderNameVisible: true,
      cardType: CardType.visa,
      backgroundImage: "assets/creditcard/Group 1034.png",
      customCardTypeIcons: <CustomCardTypeIcon>[
        CustomCardTypeIcon(
          cardType: CardType.visa,
          cardImage: Image.asset(
            'assets/creditcard/visa-pay-logo.png',
            height: 48,
            width: 48,
          ),
        ),
      ],
      onCreditCardWidgetChange: (CreditCardBrand? creditCardBrand) {},
    );
  }

  Widget creditcardfrom() {
    return CreditCardForm(
      obscureCvv: true,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      cursorColor: primaryColor,
      cardHolderDecoration: InputDecoration(
        hintText: getTranslate(context, 'credit_card.enter_holder_name'),
        hintStyle: semibold16black.copyWith(color: greyb7Color),
        labelText: getTranslate(context, 'credit_card.card_holder_name'),
        labelStyle: semibold18black.copyWith(color: greyb7Color),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      cardNumberDecoration: InputDecoration(
        hintText: "xxxx xxxx xxxx xxxx",
        hintStyle: semibold18black.copyWith(color: greyb7Color),
        labelText: getTranslate(context, 'credit_card.card_number'),
        labelStyle: semibold16black.copyWith(color: greyb7Color),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor)),
      ),
      expiryDateDecoration: InputDecoration(
        hintText: "MM/YY",
        hintStyle: semibold16black.copyWith(color: greyb7Color),
        labelText: "MM/YY",
        labelStyle: semibold18black.copyWith(color: greyb7Color),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor)),
      ),
      cvvCodeDecoration: InputDecoration(
        hintText: getTranslate(context, 'credit_card.cvv_code'),
        hintStyle: semibold16black.copyWith(color: greyb7Color),
        labelText: getTranslate(context, 'credit_card.enter_cvv'),
        labelStyle: semibold18black.copyWith(color: greyb7Color),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor)),
      ),
      onCreditCardModelChange: (CreditCardModel? creditCardModel) {
        setState(() {
          cardNumber = creditCardModel!.cardNumber;
          expiryDate = creditCardModel.expiryDate;
          cardHolderName = creditCardModel.cardHolderName;
          cvvCode = creditCardModel.cvvCode;
          isCvvFocused = creditCardModel.isCvvFocused;
        });
      },
      themeColor: primaryColor,
      formKey: formKey,
    );
  }

  bool validate(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (cardNumber != '' &&
        expiryDate != '' &&
        cardHolderName != '' &&
        cvvCode != '') {
      return true;
    }
    showSnackBar(context, Icons.cancel_outlined, Colors.red,
        "There is empty field!", Colors.red);
    return false;
  }

  makePaymentButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (validate(context)) {
          Navigator.pushNamed(context, SuccessScreen.routeName);
        }
      },
      child: Container(
        height: size.height * 0.07,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
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
          getTranslate(context, 'credit_card.make_payment'),
          style: semibold18white,
        ),
      ),
    );
  }
}
