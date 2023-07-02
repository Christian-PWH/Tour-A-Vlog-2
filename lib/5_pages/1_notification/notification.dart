import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/notification_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/column_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/notification_controller.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  static const routeName = '/notification';

  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
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
      body: notificationList(size),
    );
  }

  Widget notificationList(Size size) {
    final notifications = ref.watch(notificationControllerProvider);
    return notifications.when(
      data: (data) {
        // return ListView.builder(
        //   itemCount: data.length,
        //   itemBuilder: (context, index) {
        //     return ListTile(title: Text(data[index].title));
        //   },
        // );
        if (data.isEmpty) return emptyNotification();
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            todayNotificationList(size, data),
            // olderNotification.isEmpty ? Container() : olderNotificationList(size)
          ],
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error'));
      },
    );
  }

  Widget emptyNotification() {
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

  Widget todayNotificationList(
    Size size,
    List<NotificationModel> notifications,
  ) {
    return ColumnBuilder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            ref
                .read(notificationControllerProvider.notifier)
                .remove(notifications[index]);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    getTranslate(context, 'notification.remove_notification')),
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
                // Container(
                //   height: size.height * 0.065,
                //   width: size.height * 0.065,
                //   decoration: const BoxDecoration(
                //     shape: BoxShape.circle,
                //     gradient: LinearGradient(
                //         colors: gradient,
                //         begin: Alignment.topLeft,
                //         end: Alignment.bottomRight),
                //   ),
                //   alignment: Alignment.center,
                //   child: Image.asset(
                //     todayNotification[index]['icon'].toString(),
                //     height: size.height * 0.03,
                //     width: size.height * 0.03,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                // widthSpace,
                // widthSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notifications[index].title,
                        style: semibold16black,
                      ),
                      heightBox(3),
                      RichText(
                        text: TextSpan(
                          text: notifications[index].description,
                          style: semibold14black.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      heightBox(3),
                      Text(
                        notifications[index].date.toString(),
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
    );
  }
}
