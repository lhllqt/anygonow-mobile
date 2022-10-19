import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/brand_detail/brand_detail_controller.dart';
import 'package:untitled/utils/config.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled/widgets/bottom_navigator.dart';
import 'package:readmore/readmore.dart';
import 'package:untitled/widgets/image.dart';

class BrandDetailScreen extends StatelessWidget {
  BrandDetailController brandDetailController = Get.put(BrandDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBrandDetail(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: getHeight(205),
                  color: brandDetailController.business.bussiness["bannerImage"] == null ? Colors.grey : Colors.transparent,
                  child: getImage(brandDetailController.business.bussiness["bannerImage"]),
                ),
                Container(
                    margin: EdgeInsets.only(top: getHeight(160)),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(56),
                        child: Container(
                            width: getHeight(60),
                            height: getHeight(60),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: brandDetailController.business.bussiness["logoImage"] == null ? Colors.blueGrey : Colors.transparent),
                            child: getImage(brandDetailController.business.bussiness["logoImage"], width: getWidth(60), height: getHeight(60))),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    brandDetailController.business.bussiness["name"] ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: getWidth(10),
                  ),
                  SvgPicture.asset("assets/icons/share.svg"),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(10),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBarIndicator(
                    rating: 2.75,
                    itemSize: getHeight(20),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                  ),
                  SizedBox(
                    width: getWidth(10),
                  ),
                  Text(
                    "4 reviews",
                    style: TextStyle(fontSize: getWidth(12), color: const Color(0xFF999999)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(22),
            ),
            Container(
              margin: EdgeInsets.only(
                left: getWidth(18),
                right: getWidth(24),
              ),
              child: Column(
                children: [
                  aboutUs(),
                  SizedBox(
                    height: getHeight(17),
                  ),
                  SvgPicture.asset(
                    "assets/icons/section-line.svg",
                    height: getHeight(3),
                  ),
                  SizedBox(
                    height: getHeight(12),
                  ),
                  services(),
                  SizedBox(
                    height: getHeight(17),
                  ),
                  SvgPicture.asset(
                    "assets/icons/section-line.svg",
                    height: getHeight(3),
                  ),
                  SizedBox(
                    height: getHeight(12),
                  ),
                  reviews(),
                  SizedBox(
                    height: getHeight(12),
                  ),
                  comments(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container aboutUs() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About us",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getWidth(18),
            ),
          ),
          SizedBox(
            height: getHeight(9),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: ReadMoreText(
              brandDetailController.business.bussiness["descriptions"] ?? "",
              style: TextStyle(fontSize: getWidth(12)),
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Read more',
              trimExpandedText: 'Show less',
              trimLines: 3,
            ),
          )
        ],
      ),
    );
  }

  Container services() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service provided",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getWidth(18),
            ),
          ),
          SizedBox(
            height: getHeight(9),
          ),
          SizedBox(
            height: getHeight(145),
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: List.generate(brandDetailController.services.length, (index) => brandService(name: brandDetailController.services[index].name)),
            ),
          )
        ],
      ),
    );
  }

  Container brandService({String name = ""}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFFE6E6E6),
        ),
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        right: getHeight(17),
      ),
      width: getWidth(290),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: getWidth(16),
              ),
              SvgPicture.asset(
                "assets/icons/mail_sending.svg",
                width: getWidth(62),
                height: getHeight(62),
              ),
              SizedBox(
                width: getWidth(16),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("500 times request"),
                  Text("Best house cleaning"),
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: getHeight(6)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
              border: Border.all(
                color: Color(0xFFE6E6E6),
              ),
              color: Color(0xFFFFF511A),
            ),
            width: double.infinity,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Container reviews() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reviews",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getWidth(18),
            ),
          ),
          SizedBox(
            height: getHeight(9),
          ),
          Container(
            height: getHeight(74),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(56),
                          child: Container(
                            width: getHeight(80),
                            height: getHeight(80),
                            color: Color(0xFFFFF5F2),
                            alignment: Alignment.center,
                            child: Text(
                              "3.0",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xFFC02D02)),
                            ),
                          ),
                        ),
                      )),
                ),
                Expanded(
                  flex: 30,
                  child: Stack(
                    children: [
                      RatingBarIndicator(
                        rating: 2.75,
                        itemSize: getHeight(20),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: getHeight(28)),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/user.svg",
                              width: getWidth(18),
                            ),
                            SizedBox(
                              width: getWidth(8),
                            ),
                            Text(
                              "Total 4",
                              style: TextStyle(
                                fontSize: getWidth(14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container comments(context) {
    return Container(
      height: getHeight(400),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Comments",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: getWidth(18),
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(context: context, child: ListView(
              children: [
                ...brandDetailController.comments.map((e) {
                  return commentItem();
                }).toList(),
              ],
            ),),
          ),
        ],
      ),
    );
  }

  Container commentItem() {
    return Container(
        margin: EdgeInsets.only(bottom: getHeight(40)),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(56),
                        child: Container(
                          width: getHeight(32),
                          height: getHeight(32),
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey),
                        ),
                      ),
                    )),
                SizedBox(
                  width: getWidth(8),
                ),
                Stack(children: [
                  Container(
                    child: Text(
                      "Trinh Van Thuan",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: getHeight(14),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: getHeight(20)),
                    child: Text(
                      "Customer service: Moves and Truck",
                      style: TextStyle(
                        fontSize: getHeight(12),
                        color: Color(0xFF333333),
                      ),
                    ),
                  )
                ]),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: getHeight(40), left: getWidth(32)),
              child: RatingBarIndicator(
                rating: 2.75,
                itemSize: getHeight(20),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: getHeight(70), left: getWidth(32)),
              padding: EdgeInsets.symmetric(vertical: getHeight(8), horizontal: getWidth(8)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFFE6E6E6),
                ),
              ),
              child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's....."),
            )
          ],
        ));
  }
}