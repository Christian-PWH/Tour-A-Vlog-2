import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/currency_formatter.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/order_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/order_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/profile_booking_vm.dart';
import 'package:tour_a_vlog/5_pages/5_holiday_history/holiday_history.dart';
import 'package:tour_a_vlog/5_pages/5_holiday_ongoing/holiday_ongoing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileBookingScreen extends ConsumerStatefulWidget {
  static const routeName = '/profile_booking';

  const ProfileBookingScreen({super.key});

  @override
  ConsumerState<ProfileBookingScreen> createState() =>
      _ProfileBookingScreenState();
}

class _ProfileBookingScreenState extends ConsumerState<ProfileBookingScreen> {
  int selectedIndex = 0;

  final tabList = [
    {"title": "Holiday package", "name": "Holiday package"},
  ];

  String appbarName = '';

  @override
  void initState() {
    appbarName = tabList[0]['title'].toString();
    super.initState();
  }

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
          appbarName.toString(),
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
      body: Column(
        children: [
          tabs(size),
          if (selectedIndex == 0) holidayTabView(size),
        ],
      ),
    );
  }

  holidayTabView(Size size) {
    final orders = ref.watch(getBookingHistoryProvider);
    final holidaySelected = ref.watch(profileBookingHolidaySelectedProvider);
    return Expanded(
      child: Column(
        children: [
          holidayTabContainer(size),
          Expanded(
              child: orders.when(
            data: (data) {
              if (data.isEmpty) return emptyBooking(size);
              // for (int i = 0; i < data.length; i++)
              //   debugPrint(data[i].toString());
              if (holidaySelected == 0) {
                final newOrders = data.where((e) => e.status == 'new').toList();
                return holidayNewList(size, newOrders);
              }
              if (holidaySelected == 1) {
                final ongoingOrders =
                    data.where((e) => e.status == 'ongoing').toList();
                return holidayOngoingList(size, ongoingOrders);
              }
              if (holidaySelected == 2) {
                final completedOrders =
                    data.where((e) => e.status == 'completed').toList();
                return holidayHistoryList(size, completedOrders);
              }
              return emptyBooking(size);
            },
            error: (error, stackTrace) {
              return const Center(child: Text('Error'));
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          ))
        ],
      ),
    );
  }

  Widget holidayNewList(Size size, List<OrderModel> newOrders) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      itemCount: newOrders.length,
      itemBuilder: (context, index) {
        return holidayListContent(
          size,
          newOrders[index],
          () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => HolidayOngoing(
            //       index: index,
            //     ),
            //   ),
            // );
          },
        );
      },
    );
  }

  Widget holidayOngoingList(Size size, List<OrderModel> ongoingOrders) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      itemCount: ongoingOrders.length,
      itemBuilder: (context, index) {
        return holidayListContent(
          size,
          ongoingOrders[index],
          () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => HolidayOngoing(index: index),
            //   ),
            // );
          },
        );
      },
    );
  }

  Widget holidayHistoryList(Size size, List<OrderModel> completedOrders) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      itemCount: completedOrders.length,
      itemBuilder: (context, index) {
        return holidayListContent(
          size,
          completedOrders[index],
          () {
            // Navigator.pushNamed(context, HolidayHistory.routeName);
          },
        );
      },
    );
  }

  Widget holidayListContent(
    Size size,
    OrderModel orderItem,
    Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(fixPadding),
        margin: const EdgeInsets.symmetric(vertical: fixPadding),
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                orderItem.tour.image[0],
                height: size.height * 0.17,
                width: double.infinity,
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
            height5Space,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderItem.tour.title,
                        style:
                            medium16black.copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      heightBox(2.0),
                      Visibility(
                        visible:
                            orderItem.tour.status2 == "deal" ? true : false,
                        child: Text(
                          CurrencyFormat.convertToIdr(
                              double.parse(orderItem.tour.price), 2),
                          // "Rp. ${tour.price}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: grey94Color,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ),
                      heightBox(2.0),
                      orderItem.tour.status2 == "deal"
                          ? RichText(
                              text: TextSpan(
                                text: CurrencyFormat.convertToIdr(
                                    double.parse(
                                        orderItem.tour.newprice ?? "0"),
                                    2),
                                style: semibold16primary,
                                children: [
                                  TextSpan(
                                    text: getTranslate(
                                        context, 'booking.per_person'),
                                    style: medium14black.copyWith(
                                      color: const Color(0xff585656),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                                text: CurrencyFormat.convertToIdr(
                                    double.parse(orderItem.tour.price), 2),
                                style: semibold16primary,
                                children: [
                                  TextSpan(
                                    text: getTranslate(
                                        context, 'booking.per_person'),
                                    style: medium14black.copyWith(
                                      color: const Color(0xff585656),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCancelDialog(context);
                  },
                  child: Container(
                    width: 100.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.25),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      getTranslate(context, 'booking.cancel'),
                      style: semibold18white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> showCancelDialog(context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.warning,
          size: 75.0,
          color: starColor,
        ),
        title: Text(
          getTranslate(context, 'booking.cancel_dialog_title'),
        ),
        content: SizedBox(
          height: 100.0,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              getTranslate(context, 'booking.cancel_dialog_desc'),
              style: const TextStyle(fontSize: 14.0),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 100.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.25),
                    blurRadius: 5,
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                getTranslate(context, 'booking.cancel'),
                style: semibold18white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 100.0,
              height: 40.0,
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
                getTranslate(context, 'booking.confirm'),
                style: semibold18white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget emptyBooking(Size size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/bottomavigation/fluent_ticket-diagonal-16-filled.png",
            color: greyColor,
            height: size.height * 0.05,
            width: size.height * 0.05,
            fit: BoxFit.cover,
          ),
          height5Space,
          Text(
            "No booking yet",
            style: medium18black.copyWith(color: grey94Color),
          ),
        ],
      ),
    );
  }

  Widget holidayTabContainer(Size size) {
    return Padding(
      padding: const EdgeInsets.only(
          top: fixPadding,
          left: fixPadding * 2,
          right: fixPadding * 2,
          bottom: fixPadding),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref
                    .read(profileBookingHolidaySelectedProvider.notifier)
                    .update((state) => 0);
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ref.watch(profileBookingHolidaySelectedProvider) == 0
                      ? primaryColor
                      : whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(getTranslate(context, 'booking.new'),
                    style: ref.watch(profileBookingHolidaySelectedProvider) == 0
                        ? semibold16white
                        : semibold16grey),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref
                    .read(profileBookingHolidaySelectedProvider.notifier)
                    .update((state) => 1);
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ref.watch(profileBookingHolidaySelectedProvider) == 1
                      ? primaryColor
                      : whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(getTranslate(context, 'booking.ongoing'),
                    style: ref.watch(profileBookingHolidaySelectedProvider) == 1
                        ? semibold16white
                        : semibold16grey),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref
                    .read(profileBookingHolidaySelectedProvider.notifier)
                    .update((state) => 2);
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ref.watch(profileBookingHolidaySelectedProvider) == 2
                      ? primaryColor
                      : whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  getTranslate(context, 'booking.history'),
                  style: ref.watch(profileBookingHolidaySelectedProvider) == 2
                      ? semibold16white
                      : semibold16grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget tabs(Size size) {
    return SizedBox(
      height: size.height * 0.075,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: fixPadding),
        scrollDirection: Axis.horizontal,
        itemCount: tabList.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(fixPadding),
            child: GestureDetector(
              onTap: () {
                //   selectedIndex = index;
                //   appbarName = tabList[index]['title'].toString();
              },
              child: Column(
                children: [
                  Flexible(
                    child: Text(
                      tabList[index]['name'].toString(),
                      style: medium16grey,
                    ),
                  ),
                  height5Space,
                  selectedIndex == index
                      ? Container(
                          height: 2,
                          width: selectedIndex == (tabList.length - 1)
                              ? size.width * 0.2
                              : size.width * 0.09,
                          color: primaryColor)
                      : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
