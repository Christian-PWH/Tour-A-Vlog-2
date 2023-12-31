import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/tour_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/favorite_controller.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  static const routeName = '/favorites';

  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  // final favorites = [
  //   {
  //     "image": "assets/favorite/Rectangle 115 (1).png",
  //     "type": "place",
  //     "name": "Visit diving in Tulamben",
  //     "desc": "Amazing sunset point"
  //   },
  //   {
  //     "image": "assets/favorite/Rectangle 115 (2).png",
  //     "type": "place",
  //     "name": "Visit Climbing Mount Batur",
  //     "desc": "Amazing sunset point"
  //   },
  //   {
  //     "image": "assets/favorite/Rectangle 115 (3).png",
  //     "type": "restaurant",
  //     "name": "Jakarta",
  //     "star": 3,
  //   },
  //   {
  //     "image": "assets/favorite/Rectangle 115 (4).png",
  //     "type": "restaurant",
  //     "name": "Indonesia food",
  //     "star": 2,
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final favorites = ref.watch(favoriteControllerProvider);

    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          topImageContainer(size, context),
          favorites.when(
            data: (data) {
              return Expanded(
                child: data.isEmpty
                    ? emptyListText(context)
                    : favoritesListView(size, data),
              );
            },
            error: (error, stackTrace) {
              return const Center(child: Text('Error'));
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  favoritesListView(Size size, List<TourModel> favorites) {
    return GridView.builder(
      itemCount: favorites.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: size.width / (size.height / 1.7),
        mainAxisSpacing: fixPadding * 2,
        crossAxisSpacing: fixPadding * 2,
      ),
      padding: const EdgeInsets.all(fixPadding * 2),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return favoritesContent(context, size, favorites[index]);
      },
    );
  }

  Widget favoritesContent(context, Size size, TourModel tour) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PackageDetail.routeName,
          arguments: tour,
        );
      },
      child: Container(
        width: size.width * 0.4,
        margin: const EdgeInsets.symmetric(
            horizontal: fixPadding, vertical: fixPadding / 2),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  tour.image[0],
                  width: size.width * 0.4,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: fixPadding / 2, horizontal: fixPadding),
              child: Text(
                tour.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: medium14black33,
              ),
            )
          ],
        ),
      ),
    );
  }

  emptyListText(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite,
            color: greyb7Color,
            size: 35,
          ),
          height5Space,
          Text(
            getTranslate(context, 'favorite.empty_list'),
            style: medium18black.copyWith(color: grey94Color),
          ),
          height5Space,
          Text(
            getTranslate(context, 'favorite.empty_content'),
            style: regular14grey,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  topImageContainer(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.21,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding * 2),
      decoration: BoxDecoration(
        color: primaryColor,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: const AssetImage("assets/auth/signin.png"),
          colorFilter:
              ColorFilter.mode(primaryColor.withOpacity(0.4), BlendMode.dstIn),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(getTranslate(context, 'favorite.favourite'),
                style: semibold20white),
            Text(
              getTranslate(context, 'favorite.favorite_content'),
              style: semibold16white,
            )
          ],
        ),
      ),
    );
  }
}

//  return GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, PlaceDetail.routeName);
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: whiteColor,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: grey94Color.withOpacity(0.5),
//                   blurRadius: 5,
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(10)),
//                         child: Image.asset(
//                           // favorites[index]['image'].toString(),
//                           favorites[index].image[0],
//                           width: double.maxFinite,
//                           height: double.maxFinite,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               favorites.removeAt(index);
//                             });
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 backgroundColor: blackColor,
//                                 content: Text(getTranslate(context,
//                                     'favorite_add_remove.removed_favorites')),
//                                 duration: const Duration(milliseconds: 1500),
//                                 behavior: SnackBarBehavior.floating,
//                               ),
//                             );
//                           },
//                           child: const Padding(
//                             padding: EdgeInsets.all(fixPadding),
//                             child: Icon(
//                               Icons.close,
//                               color: whiteColor,
//                               size: 20,
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 if (favorites[index]['type'] == "place")
//                   Padding(
//                     padding: const EdgeInsets.all(fixPadding),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           favorites[index]['name'].toString(),
//                           style: medium14primary.copyWith(fontSize: 13),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Text(
//                           favorites[index]['desc'].toString(),
//                           overflow: TextOverflow.ellipsis,
//                           style: medium12grey94,
//                         )
//                       ],
//                     ),
//                   ),
//                 if (favorites[index]['type'] == 'restaurant')
//                   Padding(
//                     padding: const EdgeInsets.all(fixPadding),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           favorites[index]['name'].toString(),
//                           style: semibold14black,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             for (int i = 0; i < 5; i++)
//                               Icon(
//                                 Icons.star,
//                                 size: 17,
//                                 color: (i < (favorites[index]['star'] as int))
//                                     ? const Color(0xffEEA02C)
//                                     : grey94Color,
//                               ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 if (favorites[index]['type'] == 'hotel')
//                   Padding(
//                     padding: const EdgeInsets.all(fixPadding),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           favorites[index]['name'].toString(),
//                           style: semibold14black,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.center,
//                         ),
//                         Text(
//                           favorites[index]['desc'].toString(),
//                           style: regular12grey,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.center,
//                         )
//                       ],
//                     ),
//                   )
//               ],
//             ),
//           ),
//         );