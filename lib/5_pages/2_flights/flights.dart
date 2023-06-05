import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/2_select_flights/select_flights.dart';

class Flights extends StatefulWidget {
  static const routeName = '/flights';

  const Flights({super.key});

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {
  int selectedIndex = 0;

  var onewaydate = DateTime.now();

  var roundTripdate = DateTime.now();
  var roundTripdate2 = DateTime.now();

  var onewayadultNo = 0;
  var roundTripadultNo = 0;
  var onewaykidsNo = 0;
  var roundTripkidsNo = 0;
  var onewaySelectedClass = 0;
  var roundtripSelectClass = 0;

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
          icon: const Icon(Icons.arrow_back_ios, size: 22, color: whiteColor),
        ),
        titleSpacing: 0,
        title: Text(
          getTranslate(context, 'flights.flights'),
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
      body: Padding(
        padding: const EdgeInsets.only(top: fixPadding * 2),
        child: Column(
          children: [
            tabContainer(size),
            heightSpace,
            if (selectedIndex == 0) firstTabview(size),
            if (selectedIndex == 1) secondTabView(size),
          ],
        ),
      ),
    );
  }

  firstTabview(Size size) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            top: fixPadding,
            bottom: fixPadding * 2,
            left: fixPadding * 2,
            right: fixPadding * 2),
        children: [
          fromContainer(size),
          heightSpace,
          heightSpace,
          toContainer(size),
          heightSpace,
          heightSpace,
          oneWayDateContainer(size),
          heightSpace,
          heightSpace,
          adultContainer(size, () {
            setState(() {
              if (onewayadultNo > 0) {
                onewayadultNo--;
              }
            });
          }, () {
            setState(() {
              onewayadultNo++;
            });
          }, onewayadultNo.toString()),
          heightSpace,
          heightSpace,
          kidsContainer(size, () {
            setState(() {
              if (onewaykidsNo > 0) {
                onewaykidsNo--;
              }
            });
          }, () {
            setState(() {
              onewaykidsNo++;
            });
          }, onewaykidsNo.toString()),
          heightSpace,
          onewaySelectClass(size),
          heightSpace,
          heightSpace,
          heightSpace,
          searchFlightsButton(size),
        ],
      ),
    );
  }

  secondTabView(Size size) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            top: fixPadding,
            bottom: fixPadding * 2,
            left: fixPadding * 2,
            right: fixPadding * 2),
        children: [
          fromContainer(size),
          heightSpace,
          heightSpace,
          toContainer(size),
          heightSpace,
          heightSpace,
          roundTripDepartContainer(size),
          heightSpace,
          heightSpace,
          roundTripreturnContainer(size),
          heightSpace,
          heightSpace,
          adultContainer(size, () {
            setState(() {
              if (roundTripadultNo > 0) {
                roundTripadultNo--;
              }
            });
          }, () {
            setState(() {
              roundTripadultNo++;
            });
          }, roundTripadultNo.toString()),
          heightSpace,
          heightSpace,
          kidsContainer(size, () {
            setState(() {
              if (roundTripkidsNo > 0) {
                roundTripkidsNo--;
              }
            });
          }, () {
            setState(() {
              roundTripkidsNo++;
            });
          }, roundTripkidsNo.toString()),
          heightSpace,
          roundTripSelectClass(size),
          heightSpace,
          heightSpace,
          heightSpace,
          searchFlightsButton(size),
        ],
      ),
    );
  }

  roundTripDepartContainer(Size size) {
    return GestureDetector(
      onTap: () async {
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
                child: child!,
              );
            });
        if (pickedDate != null) {
          setState(() {
            roundTripdate = pickedDate;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2, vertical: fixPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: grey94Color.withOpacity(0.5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            iconContainer(size, Icons.date_range_outlined),
            widthSpace,
            width5Space,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getTranslate(context, 'flights.depart'),
                      style: medium14grey94),
                  Text(
                      DateFormat("dd MMMM, yyyy",
                              Localizations.localeOf(context).toString())
                          .format(roundTripdate),
                      style: medium14black)
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: grey94Color,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  roundTripreturnContainer(Size size) {
    return GestureDetector(
      onTap: () async {
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
                child: child!,
              );
            });
        if (pickedDate != null) {
          setState(() {
            roundTripdate2 = pickedDate;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2, vertical: fixPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: grey94Color.withOpacity(0.5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            iconContainer(size, Icons.date_range_outlined),
            widthSpace,
            width5Space,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getTranslate(context, 'flights.return'),
                      style: medium14grey94),
                  Text(
                      DateFormat("dd MMMM, yyyy",
                              Localizations.localeOf(context).toString())
                          .format(roundTripdate2),
                      style: medium14black)
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: grey94Color,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  searchFlightsButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SelectFlights.routeName);
      },
      child: Container(
        height: size.height * 0.07,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: gradient,
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.25),
                blurRadius: 5,
              )
            ]),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'flights.search_flights'),
          style: semibold18white,
        ),
      ),
    );
  }

  onewaySelectClass(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                onewaySelectedClass = 0;
              });
            },
            child: Row(
              children: [
                Container(
                  height: size.height * 0.028,
                  width: size.height * 0.028,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    border: onewaySelectedClass == 0
                        ? Border.all(width: 6, color: primaryColor)
                        : Border.all(
                            color: const Color(0xffb4b4b4),
                          ),
                  ),
                ),
                widthSpace,
                Text(
                  getTranslate(context, 'flights.business_class'),
                  style: semibold14black.copyWith(fontSize: 13),
                )
              ],
            ),
          ),
        ),
        widthSpace,
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                onewaySelectedClass = 1;
              });
            },
            child: Row(
              children: [
                Container(
                  height: size.height * 0.028,
                  width: size.height * 0.028,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    border: onewaySelectedClass == 1
                        ? Border.all(width: 6, color: primaryColor)
                        : Border.all(
                            color: const Color(0xffb4b4b4),
                          ),
                  ),
                ),
                widthSpace,
                Text(
                  getTranslate(
                      context, getTranslate(context, 'flights.economy_class')),
                  style: semibold14black.copyWith(fontSize: 13),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  roundTripSelectClass(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                roundtripSelectClass = 0;
              });
            },
            child: Row(
              children: [
                Container(
                  height: size.height * 0.028,
                  width: size.height * 0.028,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    border: roundtripSelectClass == 0
                        ? Border.all(width: 6, color: primaryColor)
                        : Border.all(
                            color: const Color(0xffb4b4b4),
                          ),
                  ),
                ),
                widthSpace,
                Text(
                  getTranslate(context, 'flights.business_class'),
                  style: semibold14black.copyWith(fontSize: 13),
                )
              ],
            ),
          ),
        ),
        widthSpace,
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                roundtripSelectClass = 1;
              });
            },
            child: Row(
              children: [
                Container(
                  height: size.height * 0.028,
                  width: size.height * 0.028,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    shape: BoxShape.circle,
                    border: roundtripSelectClass == 1
                        ? Border.all(width: 6, color: primaryColor)
                        : Border.all(
                            color: const Color(0xffb4b4b4),
                          ),
                  ),
                ),
                widthSpace,
                Text(
                  getTranslate(context, 'flights.economy_class'),
                  style: semibold14black.copyWith(fontSize: 13),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  kidsContainer(
      Size size, Function() substract, Function() add, String passanger) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: grey94Color.withOpacity(0.5),
            blurRadius: 5,
          )
        ],
      ),
      child: Row(
        children: [
          iconContainer(size, Icons.accessibility_new_rounded),
          widthSpace,
          width5Space,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslate(context, 'flights.kids'),
                style: medium14grey94,
              ),
              height5Space,
              Row(
                children: [
                  InkWell(
                    onTap: substract,
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
                        size: 13,
                      ),
                    ),
                  ),
                  widthSpace,
                  Text(
                    passanger,
                    style: semibold14black,
                  ),
                  widthSpace,
                  GestureDetector(
                    onTap: add,
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
                        size: 13,
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

  adultContainer(
      Size size, Function() substract, Function() add, String passanger) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: grey94Color.withOpacity(0.5),
            blurRadius: 5,
          )
        ],
      ),
      child: Row(
        children: [
          iconContainer(size, Icons.person),
          widthSpace,
          width5Space,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslate(context, 'flights.adult'),
                style: medium14grey94,
              ),
              height5Space,
              Row(
                children: [
                  InkWell(
                    onTap: substract,
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
                        size: 13,
                      ),
                    ),
                  ),
                  widthSpace,
                  Text(
                    passanger,
                    style: semibold14black,
                  ),
                  widthSpace,
                  GestureDetector(
                    onTap: add,
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
                        size: 13,
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

  oneWayDateContainer(Size size) {
    return GestureDetector(
      onTap: () async {
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
                child: child!,
              );
            });
        if (pickedDate != null) {
          setState(() {
            onewaydate = pickedDate;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2, vertical: fixPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: grey94Color.withOpacity(0.5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            iconContainer(size, Icons.date_range_outlined),
            widthSpace,
            width5Space,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getTranslate(context, 'flights.date'),
                      style: medium14grey94),
                  Text(
                      DateFormat("dd MMMM, yyyy",
                              Localizations.localeOf(context).toString())
                          .format(onewaydate),
                      style: medium14black)
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: grey94Color,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  fromContainer(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: grey94Color.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          iconContainer(size, Icons.flight_takeoff),
          widthSpace,
          width5Space,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslate(context, 'flights.from'),
                  style: medium14grey94),
              const Text("Jakarta ,Indonesia", style: medium14black)
            ],
          )
        ],
      ),
    );
  }

  toContainer(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: grey94Color.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          iconContainer(size, Icons.flight_land),
          widthSpace,
          width5Space,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslate(context, 'flights.to'), style: medium14grey94),
              const Text("Surabaya ,Indonesia", style: medium14black)
            ],
          )
        ],
      ),
    );
  }

  iconContainer(Size size, IconData icon) {
    return Container(
      height: size.height * 0.045,
      width: size.height * 0.045,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: whiteColor,
        size: 20,
      ),
    );
  }

  tabContainer(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                  gradient: selectedIndex == 0
                      ? const LinearGradient(
                          colors: gradient,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(getTranslate(context, 'flights.one_way'),
                    style:
                        selectedIndex == 0 ? semibold16white : semibold16black),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                  gradient: selectedIndex == 1
                      ? const LinearGradient(
                          colors: gradient,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  getTranslate(context, 'flights.round_trip'),
                  style: selectedIndex == 1 ? semibold16white : semibold16black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
