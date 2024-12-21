// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:vallabh/UI/screens/onboarding/login_page.dart';

class OnBoarding {
  final String ellipsePath;
  final String avPath;
  final String title;
  final String subTitle;
  final String description;
  final double offset;

  const OnBoarding(
      {required this.ellipsePath,
      required this.avPath,
      required this.title,
      required this.subTitle,
      required this.description,
      this.offset = -288});
}

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final onboarding = [
    OnBoarding(
        ellipsePath: 'images/Ellipse-two.png',
        avPath: 'images/av-two.png',
        title: 'Choices.',
        subTitle: 'an indefinite war in the mind to choose taste vs health',
        description:
            'Health is wealth. In an era of overwhelming array of conflicting nutritional advice Individuals often struggle to maintain balanced diet that aligns with their health goals and unmet health objectives.'),
    OnBoarding(
      ellipsePath: 'images/Ellipse-three.png',
      avPath: 'images/av-three.png',
      title: 'Vallabh to the rescue',
      subTitle: 'your schedule shouldn’t be a bottleneck',
      description:
          'The app creates tailored AI based weekly meal plans based on the comprehensive user report that we gather, considering nutritional needs, dietary restrictions, cooking skills, and your budget.',
      offset: -330,
    ),
    OnBoarding(
        ellipsePath: 'images/Ellipse-two.png',
        avPath: 'images/av-four.png',
        title: 'Essence',
        subTitle: 'enjoy the essence of the flavoured nourishment food!',
        description:
            'Savor a healthier lifestyle without losing the flavors you love! Get fresh ingredients delivered, plus a cheat meal after your first week. Stay on track, indulge, and enjoy the results!'),
  ];

  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: PageView.builder(
            controller: pageViewController,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          SvgPicture.asset('images/logo.svg',
                              width: 25.7, height: 25.7),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vallabh',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff65558F)),
                                ),
                                Text('the ananta initiative',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Color(0xff65558F),
                                            fontWeight: FontWeight.w200))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            alignment: Alignment.topCenter,
                            onboarding[index].ellipsePath,
                            fit: BoxFit.fitWidth,
                            height: 400,
                          ),
                        ),
                        Positioned(
                          top: onboarding[index].offset,
                          child: Image.asset(onboarding[index].avPath,
                              width: 424, height: 288),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 40, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                onboarding[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: 280,
                                child: Text(onboarding[index].subTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Color(0xffD0C0F9))),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                onboarding[index].description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 16,
                                    child: ListView.builder(
                                      itemCount: 3,
                                      itemBuilder: (context, dotIndex) {
                                        return Container(
                                          width: 8,
                                          height: 8,
                                          margin: EdgeInsets.only(right: 8),
                                          decoration: BoxDecoration(
                                              color: dotIndex == index
                                                  ? Colors.white
                                                  : Colors.white
                                                      .withOpacity(0.5),
                                              shape: BoxShape.circle),
                                        );
                                      },
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      // if (index == 2) {
                                      //   Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             LoginPage()),
                                      //   );
                                      // } else {
                                      pageViewController.animateToPage(
                                          index + 1,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInOut);
                                      // }
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_right_alt,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text('Next',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: Colors.white)),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
