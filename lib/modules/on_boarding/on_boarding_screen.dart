import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body
  });
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'
    ),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'
    ),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'
    ),
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }


// bool onBoarding = false;
//
// void submit({bool fromShared})
// {
//   if (fromShared != null)
//   {
//     onBoarding = false;
//   } else
//   {
//     onBoarding = !onBoarding;
//     CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
//       if(value){
//         navigateAndFinish(context, LoginScreen());
//       }
//     });
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       actions: [
         defaultTextButton(
             function: submit,
             text: 'skip'
         )
       ],
     ),

      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (index){
                  if (index == boarding.length-1)
                    {
                      setState(() {
                        isLast = true;
                      });
                    }
                  else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast)
                      {
                        submit();
                      }
                    else {
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_sharp,
                  ),
                )
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
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}
