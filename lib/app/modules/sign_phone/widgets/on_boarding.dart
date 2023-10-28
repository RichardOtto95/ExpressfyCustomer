import 'package:delivery_customer/app/shared/color_theme.dart';
import 'package:delivery_customer/app/shared/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();
  bool firstPage = true;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getOverlayStyleFromColor(white),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: hXD(523, context),
              child: PageView(
                onPageChanged: (val) {
                  // print('val: $val');
                  if (val == 1) {
                    setState(() {
                      firstPage = false;
                    });
                  } else {
                    setState(() {
                      firstPage = true;
                    });
                  }
                },
                controller: pageController,
                children: [
                  WellCome(),
                  Delivery(),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: wXD(102, context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                          setState(() {
                            firstPage = true;
                          });
                        },
                        child: Container(
                          height: wXD(8, context),
                          width: wXD(47, context),
                          decoration: BoxDecoration(
                            color: darkBlue.withOpacity(.32),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          print('pageController: ${pageController.page}');
                          pageController.animateToPage(1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                          setState(() {
                            firstPage = false;
                          });
                        },
                        child: Container(
                          height: wXD(8, context),
                          width: wXD(47, context),
                          decoration: BoxDecoration(
                            color: darkBlue.withOpacity(.32),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  left: firstPage ? 0 : wXD(55, context),
                  duration: Duration(milliseconds: 300),
                  child: Container(
                    height: wXD(8, context),
                    width: wXD(47, context),
                    decoration: BoxDecoration(
                      color: darkBlue,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () async {
                  // print('pageController: ${pageController.page}');
                  if (pageController.page == 0) {
                    pageController.animateToPage(1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
                  } else {
                    await Modular.to.pushNamed('/sign-phone');
                    pageController.jumpToPage(0);
                  }
                },
                child: Container(
                  width: wXD(92, context),
                  height: wXD(52, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(50),
                    ),
                    border: Border.all(
                      color: totalBlack,
                    ),
                    color: darkBlue,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 3),
                        color: Color(0x30000000),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_forward,
                    size: wXD(25, context),
                    color: primary,
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class WellCome extends StatelessWidget {
  const WellCome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          'Bem vindo!',
          style: GoogleFonts.montserrat(
            color: textTotalBlack.withOpacity(.8),
            fontStyle: FontStyle.italic,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: wXD(10, context)),
        Text(
          'A Scorefy vem revolucionando\no mercado eletrônico\nbrasiliense.',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: textTotalBlack,
            fontStyle: FontStyle.italic,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        Spacer(),
        Image.asset(
          "./assets/images/mercado_expresso.png",
          height: wXD(240, context),
          fit: BoxFit.fill,
        ),
        Spacer(),
      ],
    );
  }
}

class Delivery extends StatelessWidget {
  const Delivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          'Delivery',
          style: GoogleFonts.montserrat(
            color: textTotalBlack.withOpacity(.8),
            fontStyle: FontStyle.italic,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: wXD(10, context)),
        Text(
          'Usando a tática de delivery\npara smartphones, impulsione\nseu negócio com a Scorefy.',
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: textTotalBlack,
            fontStyle: FontStyle.italic,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        Spacer(),
        Image.asset(
          "./assets/images/mercado_expresso.png",
          height: wXD(240, context),
          fit: BoxFit.fill,
        ),
        Spacer(),
      ],
    );
  }
}
