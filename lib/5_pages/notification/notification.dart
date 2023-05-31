import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/column_builder.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification';

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final todayNotification = [
    {
      "icon": "assets/notification/Group.png",
      "title": "Flight booking",
      "text1": "Congretulation! your flight",
      "text2": "Air india's",
      "text3": "ticket is book successfully.",
    },
    {
      "icon": "assets/notification/ri_hotel-line.png",
      "title": "Hotel booking",
      "text1": "Congretulation! your",
      "text2": "Hilton hotel",
      "text3": "ticket is book successfully",
    },
  ];

  final olderNotification = [
    {
      "icon": "assets/notification/icon-park-outline_beach-umbrella.png",
      "title": "Holiday package",
      "text1": "Congretulation! your",
      "text2": "Honymoon in bali",
      "text3": "package is book successfully.",
      "time": "Yesterday",
    },
    {
      "icon": "assets/notification/Group.png",
      "title": "Flight booking",
      "text1": "Congretulation! your flight",
      "text2": "Air india's",
      "text3": "ticket is book successfully.",
      "time": "12 march 2022",
    },
  ];

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
          getTranslate(context, 'notification.notification'),
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
      body: (todayNotification.isEmpty && olderNotification.isEmpty)
          ? emptyNotification()
          : notificationList(size),
    );
  }

  notificationList(Size size) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        todayNotification.isEmpty ? Container() : todayNotificationList(size),
        olderNotification.isEmpty ? Container() : olderNotificationList(size)
      ],
    );
  }

  emptyNotification() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.notifications_off_sharp,
            size: 48,
            color: greyb7Color,
          ),
          heightSpace,
          Text(
            getTranslate(context, 'notification.no_notification'),
            style: medium16grey,
          ),
        ],
      ),
    );
  }

  olderNotificationList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: fixPadding * 2,
            right: fixPadding * 2,
            top: fixPadding * 2,
          ),
          child: Text(
            getTranslate(context, 'notification.older_notification'),
            style: semibold16black,
          ),
        ),
        ColumnBuilder(
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  olderNotification.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(getTranslate(
                        context, 'notification.remove_notification')),
                    backgroundColor: blackColor,
                    duration: const Duration(milliseconds: 1500),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              background: Container(
                color: Colors.red,
                margin: const EdgeInsets.symmetric(vertical: fixPadding),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 2, vertical: fixPadding),
                padding: const EdgeInsets.all(fixPadding),
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
                    Container(
                      height: size.height * 0.065,
                      width: size.height * 0.065,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        olderNotification[index]['icon'].toString(),
                        height: size.height * 0.03,
                        width: size.height * 0.03,
                        fit: BoxFit.cover,
                      ),
                    ),
                    widthSpace,
                    widthSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            olderNotification[index]['title'].toString(),
                            style: semibold16black,
                          ),
                          heightBox(3),
                          RichText(
                            text: TextSpan(
                              text: olderNotification[index]['text1'],
                              style: semibold14black.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                const TextSpan(text: " "),
                                TextSpan(
                                  text: olderNotification[index]['text2'],
                                  style: semibold14black.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor),
                                ),
                                const TextSpan(text: " "),
                                TextSpan(
                                  text: olderNotification[index]['text3'],
                                ),
                              ],
                            ),
                          ),
                          heightBox(3),
                          Text(
                            olderNotification[index]['time'].toString(),
                            style: regular12grey,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: olderNotification.length,
        ),
      ],
    );
  }

  todayNotificationList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: fixPadding * 2,
            right: fixPadding * 2,
            top: fixPadding * 2,
          ),
          child: Text(
            getTranslate(context, 'notification.new_notification'),
            style: semibold16black,
          ),
        ),
        ColumnBuilder(
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  todayNotification.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(getTranslate(
                        context, 'notification.remove_notification')),
                    backgroundColor: blackColor,
                    duration: const Duration(milliseconds: 1500),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              background: Container(
                color: Colors.red,
                margin: const EdgeInsets.symmetric(vertical: fixPadding),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 2, vertical: fixPadding),
                padding: const EdgeInsets.all(fixPadding),
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
                    Container(
                      height: size.height * 0.065,
                      width: size.height * 0.065,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: gradient,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        todayNotification[index]['icon'].toString(),
                        height: size.height * 0.03,
                        width: size.height * 0.03,
                        fit: BoxFit.cover,
                      ),
                    ),
                    widthSpace,
                    widthSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todayNotification[index]['title'].toString(),
                            style: semibold16black,
                          ),
                          heightBox(3),
                          RichText(
                            text: TextSpan(
                              text: todayNotification[index]['text1'],
                              style: semibold14black.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                const TextSpan(text: " "),
                                TextSpan(
                                  text: todayNotification[index]['text2'],
                                  style: semibold14black.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor),
                                ),
                                const TextSpan(text: " "),
                                TextSpan(
                                  text: todayNotification[index]['text3'],
                                ),
                              ],
                            ),
                          ),
                          heightBox(3),
                          const Text(
                            "2 min ago",
                            style: regular12grey,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: todayNotification.length,
        ),
      ],
    );
  }
}
