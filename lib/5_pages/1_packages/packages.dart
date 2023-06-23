import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/currency_formatter.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/tour_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';

class Packages extends StatefulWidget {
  static const routeName = '/packages';

  final List<TourModel> packageMap;

  const Packages({super.key, required this.packageMap});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  bool? isFavorite;

  List<TourModel> get packages => widget.packageMap;

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
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          getTranslate(context, 'packages.package'),
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
      body: ListView.builder(
        itemCount: packages.length,
        padding: const EdgeInsets.all(fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          TourModel detailItem = packages[index];
          List<String> detailItemImage = detailItem.image;
          if (packages.isEmpty) {
            return const Center(
              child: Text("Data is Empty!"),
            );
          }
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                PackageDetail.routeName,
                arguments: detailItem,
              );
            },
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
                      detailItemImage[0].toString(),
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
                              detailItem.title.toString(),
                              style: medium16black.copyWith(
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                            heightBox(2.0),
                            Visibility(
                              visible:
                                  detailItem.status2 == "deal" ? true : false,
                              child: Text(
                                CurrencyFormat.convertToIdr(
                                    double.parse(detailItem.price), 2),
                                // "Rp. ${tour.price}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: grey94Color,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                            heightBox(2.0),
                            detailItem.status2 == "deal"
                                ? RichText(
                                    text: TextSpan(
                                      text: CurrencyFormat.convertToIdr(
                                          double.parse(
                                              detailItem.newprice ?? "0"),
                                          2),
                                      style: semibold16primary,
                                      children: [
                                        TextSpan(
                                          text: getTranslate(
                                              context, 'detail.per_person'),
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
                                          double.parse(detailItem.price), 2),
                                      style: semibold16primary,
                                      children: [
                                        TextSpan(
                                          text: getTranslate(
                                              context, 'detail.per_person'),
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
                      Visibility(
                        visible: detailItem.status2 == "deal" ? true : false,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: fixPadding / 2, horizontal: fixPadding),
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.2),
                                blurRadius: 5,
                              )
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${detailItem.percent}%",
                            style: medium14primary,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
