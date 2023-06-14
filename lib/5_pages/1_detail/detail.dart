import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/city_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/tour_controller.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';
import 'package:tour_a_vlog/5_pages/1_packages/packages.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScreen extends ConsumerStatefulWidget {
  static const routeName = '/detail';

  final CityModel city;

  const DetailScreen({super.key, required this.city});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen>
    with SingleTickerProviderStateMixin {
  CityModel get city => widget.city;
  bool isFavorite = false;

  TabController? tabController;

  int selectedTab = 0;

  bool? packageFavorite;

  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            backgroundColor: primaryColor,
            expandedHeight: size.height * 0.27,
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
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: blackColor,
                      content: isFavorite == true
                          ? Text(getTranslate(
                              context, 'favorite_add_remove.added_favorites'))
                          : Text(getTranslate(context,
                              'favorite_add_remove.removed_favorites')),
                      duration: const Duration(milliseconds: 1500),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 22,
                  color: whiteColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: whiteColor,
                  size: 22,
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/auth/signin.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [tabs(size), if (selectedTab == 0) firstTabView(size)],
            ),
          )
        ],
      ),
    );
  }

  firstTabView(Size size) {
    // final List<TourModel> data = [];
    // int index = 0;
    final tours = ref.watch(getTourByCityProvider(cityTitle: city.title));

    return tours.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(fixPadding * 2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "${city.title} ${getTranslate(context, 'packages.package')} (${data.length})",
                      style: semibold16black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Packages.routeName,
                        arguments: data,
                      );
                    },
                    child: Text(
                      getTranslate(context, 'detail.see_all'),
                      style:
                          medium14black.copyWith(fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: fixPadding),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text("Data is Empty!"),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PackageDetail.routeName,
                        arguments: data[index],
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
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  data[index].image[0],
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
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    isFavorite == true
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 20,
                                    color: whiteColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          height5Space,
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].title,
                                      style: medium16black.copyWith(
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    heightBox(2.0),
                                    Text(
                                      getTranslate(
                                          context, 'detail.detail_text'),
                                      style: medium14grey94,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    heightBox(2.0),
                                    RichText(
                                      text: TextSpan(
                                        text: "Rp ${data[index].price}",
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
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: fixPadding,
                                    vertical: fixPadding / 2),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.3),
                                      blurRadius: 5,
                                    )
                                  ],
                                  border: Border.all(color: primaryColor),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  data[index].details,
                                  style: medium14primary,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  tabs(Size size) {
    return Stack(
      children: [
        Container(
          height: size.height * 0.07,
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xfff0f0f0),
                width: 2,
              ),
            ),
          ),
        ),
        TabBar(
          onTap: (index) {
            setState(() {
              selectedTab = index;
            });
          },
          controller: tabController,
          labelStyle: semibold16white.copyWith(fontWeight: FontWeight.bold),
          labelColor: primaryColor,
          unselectedLabelColor: grey94Color,
          unselectedLabelStyle:
              semibold16white.copyWith(fontWeight: FontWeight.bold),
          indicatorColor: primaryColor,
          tabs: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Tab(
                    text:
                        "${city.title} ${getTranslate(context, 'packages.package')}",
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
