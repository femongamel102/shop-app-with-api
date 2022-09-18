import 'package:flutter/material.dart';
import 'package:shop_app_with_api/modules/login/shop_login_screen.dart';
import 'package:shop_app_with_api/shared/components/components.dart';
import 'package:shop_app_with_api/shared/network/local/chache_helper.dart';
import 'package:shop_app_with_api/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController page = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding_0.jpg',
        title: 'On Board 1 Title',
        body: "On Board 1 body"),
    BoardingModel(
        image: 'assets/images/onboarding_1.jpg',
        title: 'On Board 2 Title',
        body: "On Board 2 body"),
    BoardingModel(
        image: 'assets/images/onboarding_2.jpg',
        title: 'On Board 3 Title',
        body: "On Board 3 body"),
  ];

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(
            context,
            ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function:submit,
              text: 'SKIP'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: page,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  itemCount: boarding.length,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index])),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: page,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5),
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      page.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.easeInOut);
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage(model.image),
          )),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.body,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
}
