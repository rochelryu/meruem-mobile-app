import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meruem/app_styles.dart';
import 'package:meruem/main.dart';
import 'package:meruem/model/onboard_data.dart';
import 'package:meruem/size_configs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages.dart';
import '../widgets/widgets.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;

  PageController _pageController = PageController(initialPage: 0);
  final difference = DateTime.now().difference(DateTime(2022,06,17)).inDays * 89 + new Random().nextInt(10);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kSecondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Future setSeenonboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    seenOnboard = await prefs.setBool('seenOnboard', true);
  }

  @override
  void initState() {
    super.initState();
    setSeenonboard();
  }

  @override
  Widget build(BuildContext context) {
    // initialize size config
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 9,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: onboardingContents.length,
              itemBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  Text(
                    onboardingContents[index].title,
                    style: kTitle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  Container(
                    height: sizeV * 45,
                    child: Image.asset(
                      onboardingContents[index].image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                  description(index),
                  SizedBox(
                    height: sizeV * 5,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  currentPage == onboardingContents.length - 1
                      ? Expanded(
                          child: MyTextButton(
                            buttonName: 'COMMENCER',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(),
                                  ));
                            },
                            bgColor: kPrimaryColor,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OnBoardNavBtn(
                              name: currentPage > 0 ? 'Retour': 'Passer',
                              onPressed: () {
                                if(currentPage > 0) {
                                  _pageController.previousPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeOut,
                                  );
                                } else {
                                  _pageController.animateToPage(onboardingContents.length - 1, duration: Duration(milliseconds: 400),
                                    curve: Curves.easeOut);
                                }
                              },
                            ),
                            Row(
                              children: List.generate(
                                onboardingContents.length,
                                (index) => dotIndicator(index),
                              ),
                            ),
                            OnBoardNavBtn(
                              name: 'Suivant',
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              },
                            )
                          ],
                        ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget description(int index) {
    if(index == 0) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: kBodyText1,
            children: [
              TextSpan(text: "Transférez de l'argent de vos comptes "),
              TextSpan(
                  text: 'mobiles moneys ',
                  style: TextStyle(
                    color: kPrimaryColor,
                  )),
              TextSpan(text: 'vers un autre compte '),
              TextSpan(
                text: 'mobile money ',
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
              TextSpan(text: 'ou un '),
              TextSpan(
                text: 'portefeuille crypto ',
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    } else if(index == 1) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: kBodyText1,
            children: [
              TextSpan(text: "Récharger votre compte en "),
              TextSpan(
                  text: 'cryptomonnaie ',
                  style: TextStyle(
                    color: kPrimaryColor,
                  )),
              TextSpan(text: 'pour le transformer en '),
              TextSpan(
                text: 'argent liquide ',
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    } else if(index == 2) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: kBodyText1,
            children: [
              TextSpan(
                  text: 'Économisez ',
                  style: TextStyle(
                    color: kPrimaryColor,
                  )),
              TextSpan(text: "à votre rythme sur un "),
              TextSpan(
                  text: 'compte bloqué ',
                  style: TextStyle(
                    color: kPrimaryColor,
                  )),
              TextSpan(text: 'puis touchez un '),
              TextSpan(
                text: 'bonus pourcentage ',
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
              TextSpan(text: 'en fonction du '),
              TextSpan(
                text: 'temps et montant épargné',
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: kBodyText1,
            children: [
              TextSpan(text: "Disponible "),
              TextSpan(
                  text: '24h/24 ',
                  style: TextStyle(
                    color: kPrimaryColor,
                  )),
              TextSpan(text: 'avec plus de '),
              TextSpan(
                text: '${difference.toString()} utilisateurs actifs',
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
