import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/handyman/manage_advertise/manage_advertise.dart';
import 'package:untitled/controller/handyman/my_request/my_request_controller.dart';
import 'package:untitled/screen/handyman/advertise_manage/buy_advertise.dart';
import 'package:untitled/utils/config.dart';
import 'package:untitled/widgets/bounce_button.dart';

class ListAdvertiseScreen extends StatefulWidget {
  static const listServices = [''];

  @override
  State<ListAdvertiseScreen> createState() => _ListAdvertiseScreenState();
}

class _ListAdvertiseScreenState extends State<ListAdvertiseScreen> {
  MyRequestController myRequestController = Get.put(MyRequestController());
  ManageAdvertiseController manageAdvertiseController = Get.put(ManageAdvertiseController());

  
  // bool isCheck = true;
  @override
  void initState() {
      // manageAdvertiseController.pageController = PageController(viewportFraction: 0.6);
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    manageAdvertiseController.getListAdvertise();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Advertise",
          style: TextStyle(
            color: Colors.black,
            fontSize: getWidth(24),
            fontWeight: FontWeight.w700,
          ),
        ),
        shadowColor: Color(0xFFE5E5E5),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(16),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: getHeight(16),
              left: getWidth(16),
              right: getWidth(16),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: getWidth(20),
            right: getWidth(20),
          ),
          child: Column(children: [
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: getHeight(19),
                  ),
                  Text(
                    "We help get more customers for your business with comprehensive ads",
                    style: TextStyle(
                      color: Color.fromARGB(255, 56, 100, 255),
                      fontSize: getWidth(14),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'TTNorm',
                    ),
                  ),
                  SizedBox(
                    height: getHeight(16),
                  ),
                  Obx(() => 
                    Container(
                      // width: getWidth(265),
                      height: !manageAdvertiseController.isBuy.value ? getHeight(168) : getHeight(230),
                      child: !manageAdvertiseController.isBuy.value ? getAdvertises() : itemAdvertiseBuy(),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(24),
                  ),
                  Obx(()=> 
                    manageAdvertiseController.listAdvertise.isNotEmpty ?
                    Container(
                      width: getWidth(375),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'With ' + (manageAdvertiseController.listAdvertise[manageAdvertiseController.indexCurrentAd.value]["name"]) + ' you will get',
                              style: TextStyle(
                                fontSize: getWidth(18),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'TTNorm',
                              ),
                            ),
                            SizedBox(height: getHeight(24)),
                            Text(
                              'Services',
                              style: TextStyle(
                                fontSize: getWidth(18),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'TTNorm',
                              ),
                            ),
                            SizedBox(height: getHeight(16)),
                            Container(
                              child: Column(
                                children: List.generate(
                                  !manageAdvertiseController.isBuy.value ? 
                                   (manageAdvertiseController.listAdvertise[manageAdvertiseController.indexCurrentAd.value]["serviceInfo"].length)
                                  : (manageAdvertiseController.currentAdvertise["serviceInfo"].length),
                                  (index) => Column(
                                    children: [
                                      SizedBox(height: getHeight(12)),
                                      Container(
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/star.svg',
                                            ),
                                            SizedBox(width: getWidth(7)),
                                            Text(
                                              !manageAdvertiseController.isBuy.value 
                                              ? (manageAdvertiseController.listAdvertise[manageAdvertiseController.indexCurrentAd.value]["serviceInfo"][index]["serviceName"])
                                              : manageAdvertiseController.currentAdvertise["serviceInfo"][index]["serviceName"],
                                              style: TextStyle(
                                                fontSize: getWidth(16),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'TTNorm',
                                                color: Color.fromARGB(
                                                    255, 80,80,80),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                    ]
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: getHeight(24)),
                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: getWidth(18),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'TTNorm',
                              ),
                            ),
                            SizedBox(height: getHeight(12)),
                            Text(
                              !manageAdvertiseController.isBuy.value 
                              ? (manageAdvertiseController.listAdvertise[manageAdvertiseController.indexCurrentAd.value]["description"])
                              : manageAdvertiseController.currentAdvertise["description"],
                              style: TextStyle(
                                fontSize: getWidth(14),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'TTNorm',
                              ),
                            ),
                            SizedBox(height: getHeight(24)),
                          ]),
                    ) : 
                    Container(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(height: getHeight(50)),
                            Text(
                              'No ad packs yet',
                              style: TextStyle(
                                fontFamily: 'TTNorm',
                                fontSize: getWidth(20),
                                fontWeight: FontWeight.w600,
                              )
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Stack getAdvertises() {
    return Stack(
      children: [
        PageView.builder(
          padEnds: false,
          scrollDirection: Axis.horizontal,
          controller: manageAdvertiseController.pageController,
          onPageChanged: (value) {
            manageAdvertiseController.onChangeIndexCurrentAd(value);
          },
          itemCount: manageAdvertiseController.listAdvertise.isNotEmpty ? manageAdvertiseController.listAdvertise.length : 0,
          itemBuilder: (BuildContext context, index) =>
              itemAdvertise(
                name: manageAdvertiseController.listAdvertise[index]["name"], 
                price: manageAdvertiseController.listAdvertise[index]["price"],
              ),
        ),
      ],
    );
  }

  Container itemAdvertise({
    String name = "",
    dynamic price = 0.0,
    List<String> services = ListAdvertiseScreen.listServices,
    String description = '',
  }) {
    return Container(
      
      child: Column(mainAxisAlignment: MainAxisAlignment.start, 
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(20)),
          margin: EdgeInsets.only(
            right: getWidth(5),
          ),
          height: getHeight(168),
          width: getWidth(259),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Color(0xFFE6E6E6),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: getHeight(20),
              ),
              Text(name,
                  style: TextStyle(
                    fontSize: getWidth(16),
                  )),
              SizedBox(
                height: getHeight(16),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "\$" + '$price',
                        style: TextStyle(
                            fontSize: getWidth(24),
                            color: Color.fromARGB(255, 255, 81, 26),
                            fontFamily: 'TTNorm',
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: '/day',
                        style: TextStyle(
                            fontSize: getWidth(24),
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'TTNorm',
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              SizedBox(
                height: getHeight(12),
              ),
              Bouncing(
                onPress: () async {
                  await manageAdvertiseController.getItemAdvertise(manageAdvertiseController.listAdvertise[manageAdvertiseController.indexCurrentAd.value]["id"]);
                  await manageAdvertiseController.getPaymentMethods();
                  Get.to(() => BuyAdvertiseScreen()); 
                },
                child: Container(
                  width: getWidth(235),
                  height: getHeight(40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color.fromARGB(255, 255, 81, 26),
                        width: 1,
                      )),
                  child: Center(
                    child: Text('Get now',
                        style: TextStyle(
                            fontSize: getWidth(16),
                            color: Color.fromARGB(255, 255, 81, 26),
                            fontFamily: 'TTNorm',
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Container itemAdvertiseBuy() {
    return Container(
      padding: EdgeInsets.all(12),
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: Color.fromARGB(255, 230,230,230),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Color.fromARGB(255, 79,191,103),
              ),
              SizedBox(width: getWidth(10)),
              Text(
                manageAdvertiseController.currentAdvertise["name"],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: getWidth(18),
                  fontFamily: 'TTNorm',
                  fontWeight: FontWeight.w600
                )
              )
            ],
          ),
          SizedBox(height: getHeight(16)),
          itemShowInfoDate(title: "Registration date", date: manageAdvertiseController.registrationDate.text),
          SizedBox(height: getHeight(16)),
          itemShowInfoDate(title: "Expiry date", date: manageAdvertiseController.expiryDate.text),
          SizedBox(height: getHeight(16)),
          itemShowInfoDate(title: "Price", date: "\$" + manageAdvertiseController.currentAdvertise["price"].toString() + "/Day"),

          SizedBox(height: getHeight(24)),
          Bouncing(
                onPress: () {
                  manageAdvertiseController.clearState();
                },
                child: Container(
                  width: getWidth(319),
                  height: getHeight(40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color.fromARGB(255, 255, 81, 26),
                        width: 1,
                      )),
                  child: GestureDetector(
                    onTap: () {
                      manageAdvertiseController.NoChangeBuy();
                    },
                    child: Center(
                      child: Text('Buy more',
                          style: TextStyle(
                              fontSize: getWidth(16),
                              color: Color.fromARGB(255, 255, 81, 26),
                              fontFamily: 'TTNorm',
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              )

        ],
      ),
    );
  }

  Row itemShowInfoDate({String title = "", String date = ""}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: getWidth(14), 
            fontWeight: FontWeight.w400,
            fontFamily: 'TTNorm',
          )
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: getWidth(14), 
            fontWeight: FontWeight.w600,
            fontFamily: 'TTNorm',
          )
        ),
      ]
    );
  }
}
