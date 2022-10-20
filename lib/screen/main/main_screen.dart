import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/main/main_screen_controller.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screen/main/main_screen_model.dart';
import 'package:untitled/service/date_format.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/bounce_button.dart';
import 'package:untitled/widgets/input.dart';
import 'package:untitled/widgets/pop-up/password-reset.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainScreen extends StatelessWidget {
  MainScreenController mainScreenController = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: getHeight(500),
            color: Color(0xFF07BAAD),
          ),
          Container(
            // margin: EdgeInsets.only(left: getWidth(25), right: getWidth(25)),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: getWidth(16),
                  ),
                  child: Text(
                    "Hi ${globalController.user.value.username}, have a good day",
                    style: TextStyle(
                      fontSize: getWidth(18),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getWidth(16),
                  ),
                  child: Text(
                    TimeService.currentTimeDayOfWeek(DateTime.now()),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(12),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: getWidth(16),
                    ),
                    Obx(() {
                      return Container(
                        height: getHeight(40),
                        width: mainScreenController.hasSearched.value
                            ? getWidth(250)
                            : getWidth(343),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color(0xFFC4C4C4),
                            width: getWidth(1),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 68,
                              child: inputSearch(
                                context,
                                hintText: "Search by service",
                                textEditingController:
                                mainScreenController.searchText,
                                onSearch: () async {
                                  var res = await mainScreenController
                                      .getBusinesses();
                                  if (res) {
                                    mainScreenController.hasSearched.value =
                                    true;
                                  } else {
                                    print("not found");
                                  }
                                },
                                options: List.generate(
                                    mainScreenController.categories.length,
                                        (index) => mainScreenController
                                        .categories[index].name),
                                prefixIcon: "assets/icons/search.svg",
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SvgPicture.asset(
                                "assets/icons/line.svg",
                              ),
                            ),
                            Expanded(
                              flex: 30,
                              child: inputSearch(
                                context,
                                hintText: "Zipcode",
                                textEditingController:
                                mainScreenController.searchZipcode,
                                onSearch: () async {
                                  var res = await mainScreenController
                                      .getBusinesses();
                                  if (res) {
                                    mainScreenController.hasSearched.value =
                                    true;
                                  } else {
                                    print("not found");
                                  }
                                },
                                options: [],
                                prefixIcon: "assets/icons/location.svg",
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    Obx(() {
                      return mainScreenController.hasSearched.value
                          ? Container(
                        margin: EdgeInsets.only(left: getWidth(2)),
                        width: getWidth(70),
                        height: getHeight(32),
                        child: Bouncing(
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.black12,
                            child: Text(
                              "Send request",
                              style: TextStyle(
                                fontSize: getWidth(10),
                              ),
                            ),
                          ),
                          onPress: () async {
                            var res =
                            await mainScreenController.sendRequest();
                            if (res) {
                              showPopUp(
                                message:
                                "Request has been sent successfully",
                              );
                            }
                          },
                        ),
                      )
                          : SizedBox();
                    })
                  ],
                ),
                SizedBox(
                  height: getHeight(24),
                ),
                Obx(() {
                  return mainScreenController.hasSearched.value
                      ? searchResults()
                      : mainScreenDisplay();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container mainScreenDisplay() {
    return Container(
      padding: EdgeInsets.only(
        left: getWidth(16),
        right: getWidth(16),
        top: getHeight(20),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
              Text(
                "Best Services",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: getWidth(18),
                ),
              ),
            ],
          ),
          SizedBox(
            height: getHeight(12),
          ),
          CarouselSlider(
            options: CarouselOptions(
                height: getHeight(250),
                viewportFraction: 1,
                onPageChanged: (index, reason) =>
                {mainScreenController.currentIndex.value = index}),
            items: [1, 2, 3, 4, 5]
                .map(
                  (i) => Container(
                // color: Colors.grey,
                child: carouselItem(),
              ),
            )
                .toList(),
          ),
          SizedBox(
            height: getHeight(12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                Obx(() {
                  return Container(
                      margin: EdgeInsets.only(
                        left: getWidth(3),
                        right: getWidth(3),
                      ),
                      height: 6,
                      width:
                      i == mainScreenController.currentIndex.value ? 16 : 6,
                      decoration: BoxDecoration(
                          color: i == mainScreenController.currentIndex.value
                              ? Color(0xFFFF511A)
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5)));
                })
            ],
          ),
          SizedBox(
            height: getHeight(24),
          ),
          Text(
            "Most interest",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: getWidth(18),
            ),
          ),
          SizedBox(
            height: getHeight(12),
          ),
          Container(
            // height: getHeight(600),
            child: FutureBuilder(
              future: mainScreenController.getMostInterest,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.count(
                    shrinkWrap: true,
                    childAspectRatio: (167 / 105),
                    crossAxisCount: 2,
                    children: List.generate(
                      mainScreenController.mostInterested.length,
                          (index) {
                        return serviceItem(
                          image: mainScreenController
                              .mostInterested[index].bussiness["logoUrl"] ??
                              "",
                          service: mainScreenController
                              .mostInterested[index].bussiness["name"] ??
                              "",
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
          SizedBox(
            height: getHeight(73),
          ),
          Text(
            "Professional Near You",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: getWidth(18),
            ),
          ),
          SizedBox(
            height: getHeight(12),
          ),
          Container(
            child: FutureBuilder(
                future: mainScreenController.getProNear,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: List.generate(
                        mainScreenController.businessNearList.length,
                            (index) {
                          return handymanItem(
                            image: mainScreenController.businessNearList[index]
                                .bussiness["bannerUrl"] ??
                                "",
                            logo: mainScreenController.businessNearList[index]
                                .bussiness["logoUrl"] ??
                                "",
                            title: mainScreenController.businessNearList[index]
                                .bussiness["name"] ??
                                "",
                            stars: (mainScreenController.businessNearList[index]
                                .rating["rate"] ?? 0.0 ) * 1.0,
                            reviews: mainScreenController
                                .businessNearList[index].rating["review"]
                                ?.toInt() ??
                                0,
                            id: mainScreenController
                                .businessNearList[index].bussiness["id"],
                          );
                        },
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),
          ),
        ],
      ),
    );
  }

  Container searchResults() {
    return Container(
      color: Colors.white,
      child: Column(
        children:
        List.generate(mainScreenController.businesses.length, (index) {
          return handymanItem(
            image:
            mainScreenController.businesses[index].bussiness["bannerUrl"] ??
                "",
            logo: mainScreenController.businesses[index].bussiness["logoUrl"] ??
                "",
            title:
            mainScreenController.businesses[index].bussiness["name"] ?? "",
            stars: mainScreenController.businesses[index].rating["rate"] ?? 0,
            reviews: mainScreenController.businesses[index].rating["review"]
                ?.toInt() ??
                0,
            isSearchResult: true,
            about: mainScreenController
                .businesses[index].bussiness["descriptions"] ??
                "",
            id: mainScreenController.businesses[index].bussiness["id"] ?? "",
          );
        }),
      ),
    );
  }
}