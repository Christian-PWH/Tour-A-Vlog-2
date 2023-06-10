import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/column_builder.dart';
import 'package:tour_a_vlog/5_pages/1_detail/detail.dart';
import 'package:tour_a_vlog/5_pages/1_discover_by_categories/discover_by_categories.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';
import 'package:tour_a_vlog/5_pages/1_recommendation/recommendation.dart';
import 'package:tour_a_vlog/5_pages/1_notification/notification.dart';
import 'package:tour_a_vlog/5_pages/1_search/search.dart';
import 'package:tour_a_vlog/5_pages/1_top_indonesia_destination/top_indonesia_destination.dart';

final cityList = [
  {"name": "Medan", "id": 0},
  {"name": "Jakarta", "id": 1},
  {"name": "Bandung", "id": 3},
  {"name": "Semarang", "id": 4},
  {"name": "Surabaya", "id": 5},
  {"name": "Yogyakarta", "id": 6},
  {"name": "Bali", "id": 7},
  {"name": "Pontianak", "id": 8},
  {"name": "Samarinda", "id": 9},
  {"name": "Manado", "id": 10},
  {"name": "Makassar", "id": 11},
  {"name": "Ambon", "id": 12},
  {"name": "NTB", "id": 13},
  {"name": "NTT", "id": 14},
];

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCityName = cityList[1]['name'].toString();

  Map<String, dynamic> recommendationMap = {
    "-NV4pZeNKa_1da9VK8xz": {
      "category": "Beach",
      "city": "Bengkulu",
      "code": "BKL1",
      "customizationForDays": ["default 01", "default 02"],
      "details": "3d2n",
      "image": [
        "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/ToursImages%2F1683725111132-bengkulu.jpg?alt=media&token=2a497c86-23cb-496f-bbc7-17b30d2f39a1"
      ],
      "newprice": "213",
      "percent": 100,
      "price": "1000000",
      "status1": "recomen",
      "status2": "deal",
      "title": "Bengkulu trip",
      "type": "Open Trip"
    },
    "-NVUjdjo-mZNz3qMRe_B": {
      "category": "Mountain",
      "city": "Sumatra Barat",
      "code": "a4",
      "customizationForDays": ["default"],
      "details": "asdasd",
      "image": [
        "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/ToursImages%2F1684159772872-mountain.jpg?alt=media&token=067813de-ba97-494d-a6e7-99431aa947a4",
        "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/ToursImages%2F1684159772870-beach.webp?alt=media&token=577317e1-0d06-4dbc-ad18-c99026dd1e69",
        "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/ToursImages%2F1684159772871-budaya.jpg?alt=media&token=51927a15-40ed-4906-bb07-fa15ed4e1aba"
      ],
      "newprice": "213",
      "percent": 100,
      "price": "12313",
      "status1": "recomen",
      "status2": "deal",
      "title": "sadsad",
      "type": "Open Trip"
    },
    "-NW2U4zx094I5N4D3Vdc": {
      "category": "Mountain",
      "city": "Jawa Timur",
      "code": "2d",
      "customizationForDays": ["default"],
      "details": "sad",
      "image": [
        "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/ToursImages%2F1684759403334-budaya.jpg?alt=media&token=d81ea24a-6f26-4656-a2e9-14afe21127c1"
      ],
      "newprice": "53243",
      "percent": -22949,
      "price": "231",
      "status1": "",
      "status2": "deal",
      "title": "sadad",
      "type": "Private Tour"
    }
  };

  Map<String, dynamic> indonesianDestination = {
    "-NV4iHKqhd5dZA2LuKl2": {
      "code": "ID-AC",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723201379-aceh2.jpg?alt=media&token=097b5b18-8640-4fce-996c-a9671987b595",
      "title": "Aceh"
    },
    "-NV4iVrVr1CrSr-NtZ82": {
      "code": "ID-SU",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723261079-medan.jpg?alt=media&token=034621c2-ab5e-474a-95c2-74cd2cd4a978",
      "title": "Sumatra Utara"
    },
    "-NV4icFRvqmRT6--gTgj": {
      "code": "ID-SB",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723291122-padang.jpg?alt=media&token=d5d592f0-b6ed-4de7-833b-5ac48482b57c",
      "title": "Sumatra Barat"
    },
    "-NV4ijQcwAMvI1X3dXHM": {
      "code": "ID-RI",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723320805-riau.jpg?alt=media&token=bfe3335d-d1cc-4dc1-b9b7-7368d8864f75",
      "title": "Riau"
    },
    "-NV4iwzREnl0b7Zo75j8": {
      "code": "ID-KR",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723376119-kepulauanriau.jpg?alt=media&token=bbadc4b2-28fa-40b7-a1b4-5915cf2ed11a",
      "title": "Kepulauan Riau"
    },
    "-NV4j1NZ0Riomg--brnI": {
      "code": "ID-JA",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723398219-jambi.jpg?alt=media&token=ca4830f6-814a-412f-8143-5edf4fd588ff",
      "title": "Jambi"
    },
    "-NV4je9O4IrxbhjB6dw-": {
      "code": "ID-SS",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723561040-palembang.jpg?alt=media&token=bc07398f-0670-4801-a0ae-404af23cc56b",
      "title": "Palembang"
    },
    "-NV4jjx1ShQukGGBPolw": {
      "code": "ID-BE",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723584789-bengkulu.jpg?alt=media&token=9bebf5eb-89d6-402b-8dcd-a0f4d24132bf",
      "title": "Bengkulu"
    },
    "-NV4jpInb28p8xIfA5Qz": {
      "code": "ID-LA",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723606773-lampung.jpg?alt=media&token=c4445ae3-5e7e-4309-bd85-dd2f21b64a30",
      "title": "Lampung"
    },
    "-NV4ju0wllfwEE5CsmHa": {
      "code": "ID-BB",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723626209-bangkabelitung.jpg?alt=media&token=a66f7b84-5476-4d71-a999-267b643db768",
      "title": "Bangka Belitung"
    },
    "-NV4jyXCfOBYx5clo4t8": {
      "code": "ID-JK",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723644473-jakarta.jpg?alt=media&token=22e0aec4-3ea3-4a3b-ba4a-c9f1715fd4dd",
      "title": "DKI Jakarta"
    },
    "-NV4k33ZTXI16dMHesYy": {
      "code": "ID-JB",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723667455-bandung.jpg?alt=media&token=39a8e47d-c8e2-4a62-ae8a-03bf703b39ec",
      "title": "Jawa Barat"
    },
    "-NV4k6pmX2plcAXQevmp": {
      "code": "ID-BT",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723682655-banten.jpg?alt=media&token=6d39fe10-8092-4477-8331-e3dc20c55dc5",
      "title": "Banten"
    },
    "-NV4kDh4ImpjnRbN3IOP": {
      "code": "ID-JT",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723710922-semarang.jpg?alt=media&token=c7ace9d9-0dce-43ed-b901-17294de16b30",
      "title": "Jawa Tengah"
    },
    "-NV4kL8aAtk3IidlIJT1": {
      "code": "ID-YO",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723741279-jogja.jpg?alt=media&token=ff352460-0bee-4b19-8d4f-d1f0ab3c42d8",
      "title": "Daerah Istimewa Yogyakarta (DIY)"
    },
    "-NV4kS0Bim6D6iJrCFb7": {
      "code": "ID-JI",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723769426-surabaya.jpg?alt=media&token=d5633afa-8e7a-471a-b484-e8891f0b651b",
      "title": "Jawa Timur"
    },
    "-NV4lGk10ZwwiGLfh29s": {
      "code": "ID-BA",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683723985412-bali.jpg?alt=media&token=12d2045b-6d2c-4489-95e7-80e5dd8b7d57",
      "title": "Bali"
    },
    "-NV4lVCDy9skcec30_1F": {
      "code": "ID-NT",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724044802-ntt.jpg?alt=media&token=8f06914b-b31f-456a-b46e-0d71718dd9ab",
      "title": "Nusa Tenggara Timur"
    },
    "-NV4lsUqgIxa7luoeZoj": {
      "code": "ID-NB",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724132874-ntb.jpg?alt=media&token=cd603e5f-39b4-4d59-90fe-71c90630202a",
      "title": "Nusa Tenggara Barat"
    },
    "-NV4m-v1bhDS4SDIJJQA": {
      "code": "ID-KB",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724178555-pontianak.jpg?alt=media&token=66c01d2b-06f0-41a9-a3fe-55d7e012eb42",
      "title": "Kalimantan Barat"
    },
    "-NV4mgNIsCNfSv3U_-xi": {
      "code": "ID-KT",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724353836-palangkaraya.jpg?alt=media&token=1909e82b-6972-49a9-b320-1f37012e0480",
      "title": "Kalimantan Tengah"
    },
    "-NV4mnrGcZuzmGOZGyDD": {
      "code": "ID-KS",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724386215-banjarbaru.jpg?alt=media&token=3453be7e-3cdc-4634-875d-91db134f9393",
      "title": "Kalimantan Selatan"
    },
    "-NV4n-4zW0QoYB3gp4xY": {
      "code": "ID-KI",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724437560-samarinda.jpg?alt=media&token=d33ed066-bd61-4508-ac74-bf4387c9b20d",
      "title": "Kalimantan Timur"
    },
    "-NV4n3s_k6RtHXjMaMGx": {
      "code": "ID-KU",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724457051-tanjungselor.jpg?alt=media&token=cf324221-7787-4e5c-b35c-6fecbb97e240",
      "title": "Kalimantan Utara"
    },
    "-NV4nPrxt9MQN15MEn3Q": {
      "code": "ID-SA",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724546716-manado.jpg?alt=media&token=1628b035-3d86-4e1f-a2b4-f0eb914e5089",
      "title": "Sulawesi Utara"
    },
    "-NV4nWim68Vnf3G9abvP": {
      "code": "ID-GO",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724574997-gorontalo.jpg?alt=media&token=422710cf-f964-45d0-b0c6-b4495c931cc3",
      "title": "Gorontalo"
    },
    "-NV4nb14e19lYkqC52dw": {
      "code": "ID-ST",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724597123-palu.jpeg?alt=media&token=340a7973-2478-42c5-ab65-b1aacc5905ca",
      "title": "Sulawesi Tengah"
    },
    "-NV4oRwEz5n_jyuuA0Hp": {
      "code": "ID-SN",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724817771-makassar.jpg?alt=media&token=f7cf379e-972f-4a48-afb4-65e9ae868f51",
      "title": "Sulawesi Selatan"
    },
    "-NV4oaWo_2E7cxJEhAQs": {
      "code": "ID-SR",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724856989-mamuju.jpg?alt=media&token=685702a8-a444-4840-8f8b-088ece249816",
      "title": "Sulawesi Barat"
    },
    "-NV4olNFEq-Wo0gHUUND": {
      "code": "ID-SG",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724900543-kendari.jpg?alt=media&token=8950e90b-2871-43ae-8c35-cc70779336af",
      "title": "Sulawesi Tenggara"
    },
    "-NV4oxa5z3YNJB07KH-9": {
      "code": "ID-MA",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724951473-ambon.jpg?alt=media&token=80adbfb3-922b-455d-8f3d-d5ea7cc2c025",
      "title": "Maluku"
    },
    "-NV4p2OZSSrZWx-65XEK": {
      "code": "ID-MU",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724975419-sofifi.jpg?alt=media&token=046bd558-4ec7-4b94-a052-15cc00cbb782",
      "title": "Maluku utara"
    },
    "-NV4p8E4to-Ic66ZaV0J": {
      "code": "ID-PA",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683724999174-jayapura.jpg?alt=media&token=3a3facaa-593c-4373-bccd-3a93f3956406",
      "title": "Papua"
    },
    "-NV4pFygoOP66DLk9_P9": {
      "code": "ID-PB",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CityImages%2F1683725030722-manokwari.jpg?alt=media&token=cba3fecb-0d97-45da-b7fe-3a01e5f22a19",
      "title": "Papua Barat"
    },
  };

  Map<String, dynamic> discoverByCategories = {
    "-NV4hP8HXTSoX-Y5X-yO": {
      "code": "BCH",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CategoriesImages%2F1683722971025-beach.webp?alt=media&token=a7d30a30-ead1-496a-979f-aba48dbbef2d",
      "title": "Beach"
    },
    "-NV4hRhVLOTRIp4dYgRm": {
      "code": "MT",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CategoriesImages%2F1683722981937-mountain.jpg?alt=media&token=b921bc22-397b-4298-963a-f62d0cc58403",
      "title": "Mountain"
    },
    "-NV8GurpLGhxSz71nMpe": {
      "code": "CULT",
      "image":
          "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/CategoriesImages%2F1683782874075-budaya.jpg?alt=media&token=02bc5c05-662c-4b74-b657-d1d982fbb115",
      "title": "Culture"
    }
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          topImageContainer(size, context),
          bottomView(size),
        ],
      ),
    );
  }

  bottomView(Size size) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(
            left: 0.0, right: 0.0, top: 0.0, bottom: fixPadding),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          discoverByCategoriesList(size),
          recommendationListView(size),
          indonesiaDestinationList(size),
        ],
      ),
    );
  }

  discoverByCategoriesList(Size size) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2, vertical: fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                getTranslate(context, 'home.discover_categories'),
                style: semibold16white.copyWith(
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.15,
          width: double.maxFinite,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            itemCount: discoverByCategories.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              Map<String, dynamic> categoryItem = discoverByCategories[
                  discoverByCategories.keys.elementAt(index)];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                child: GestureDetector(
                  onTap: () {
                    Map<String, dynamic> newMapBasedOnCategory = {};
                    recommendationMap.forEach(
                      (key, value) {
                        Map<String, dynamic> rawMap = recommendationMap[key];
                        if (rawMap["category"]
                            .toString()
                            .contains(categoryItem["title"])) {
                          newMapBasedOnCategory
                              .addEntries({key: value}.entries);
                        }
                      },
                    );
                    Navigator.pushNamed(context, DiscoverByCategories.routeName,
                        arguments: newMapBasedOnCategory);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.1,
                        width: size.height * 0.1,
                        child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            categoryItem['image'].toString(),
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
                      height5Space,
                      Text(
                        categoryItem['title'].toString(),
                        style: regular16black,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  recommendationListView(Size size) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2, vertical: fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  getTranslate(context, 'home.recommendation'),
                  style: semibold16white.copyWith(
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Recommendation.routeName,
                      arguments: recommendationMap);
                },
                child: Text(
                  getTranslate(context, 'home.see_all'),
                  style: medium14primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.width * 0.55,
          width: double.maxFinite,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            itemCount: recommendationMap.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              Map<String, dynamic> tourItem =
                  recommendationMap[recommendationMap.keys.elementAt(index)];
              List<String> tourImage = tourItem["image"];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PackageDetail.routeName,
                    arguments: tourItem,
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
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                          child: Image.network(
                            tourImage[0],
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
                          tourItem["title"].toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: medium14black33,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  indonesiaDestinationList(Size size) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2, vertical: fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  getTranslate(context, 'home.indonesia_destination'),
                  style: semibold16white.copyWith(
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TopIndonesiaDestination.routeName,
                    arguments: indonesianDestination,
                  );
                },
                child: Text(
                  getTranslate(context, 'home.see_all'),
                  style: medium14primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.23,
          width: double.maxFinite,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            itemCount: indonesianDestination.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              Map<String, dynamic> indonesiaItem = indonesianDestination[
                  indonesianDestination.keys.elementAt(index)];
              return GestureDetector(
                onTap: () {
                  Map<String, dynamic> newMapBasedOnCity = {};
                  recommendationMap.forEach(
                    (key, value) {
                      Map<String, dynamic> rawMap = recommendationMap[key];
                      if (rawMap["city"]
                          .toString()
                          .contains(indonesiaItem["title"])) {
                        newMapBasedOnCity.addEntries({key: value}.entries);
                      }
                    },
                  );
                  Navigator.pushNamed(
                    context,
                    DetailScreen.routeName,
                    arguments: {
                      "arg_1": newMapBasedOnCity,
                      "arg_2": indonesiaItem,
                    },
                  );
                },
                child: Container(
                  width: size.width * 0.4,
                  margin: const EdgeInsets.symmetric(
                      horizontal: fixPadding, vertical: fixPadding / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        indonesiaItem['image'].toString(),
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: grey94Color.withOpacity(0.5),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: fixPadding / 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          blackColor.withOpacity(0),
                          blackColor.withOpacity(0.02),
                          blackColor.withOpacity(0.07),
                          blackColor.withOpacity(0.1),
                          blackColor.withOpacity(0.2),
                          blackColor.withOpacity(0.5),
                          blackColor.withOpacity(0.6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      indonesiaItem['title'].toString(),
                      style: semibold18white,
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  topImageContainer(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.21,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          getTranslate(context, 'home.travel_text'),
                          style: semibold18white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.room_rounded,
                            size: 18,
                            color: whiteColor,
                          ),
                          width5Space,
                          GestureDetector(
                            onTap: () {
                              selectCityDialog(context, size);
                            },
                            child: Row(
                              children: [
                                Text(
                                  selectedCityName,
                                  style: semibold14white,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: whiteColor,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  width: size.height * 0.04,
                  child: Stack(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, NotificationScreen.routeName);
                        },
                        icon: const Icon(
                          Icons.notifications_sharp,
                          color: whiteColor,
                          size: 24,
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: Container(
                          height: 6,
                          width: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xffEC2727),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            heightSpace,
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: blackColor.withOpacity(0.25),
                    blurRadius: 6,
                  )
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: primaryColor),
                ),
                child: TextField(
                  onTap: () {
                    Navigator.pushNamed(context, SearchScreen.routeName);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 22,
                    ),
                    hintText: getTranslate(context, 'home.search_destination'),
                    hintStyle: semibold14grey.copyWith(height: 1.6),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  selectCityDialog(BuildContext context, Size size) {
    return showDialog(
      barrierColor: blackColor.withOpacity(0.3),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, set) {
          return AlertDialog(
            scrollable: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            titlePadding: const EdgeInsets.only(top: fixPadding * 2),
            title: Center(
              child: Text(
                getTranslate(context, 'home.select_city'),
                style: medium18black,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: fixPadding),
              child: ColumnBuilder(
                itemCount: cityList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        set(() {
                          selectedCityName = cityList[index]['name'].toString();
                        });
                      });
                      Navigator.pop(context);
                    },
                    leading: Container(
                      height: size.height * 0.035,
                      width: size.height * 0.035,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
                        border: selectedCityName == cityList[index]['name']
                            ? Border.all(
                                color: primaryColor,
                                width: 8,
                              )
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                    ),
                    minLeadingWidth: 10,
                    title: Text(
                      cityList[index]['name'].toString(),
                      style: medium16black,
                    ),
                  );
                },
              ),
            ),
          );
        });
      },
    );
  }
}
