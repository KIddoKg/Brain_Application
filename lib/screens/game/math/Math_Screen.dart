import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:brain_application/general/app_route.dart';
import 'package:brain_application/provider/auth.dart';
import 'package:brain_application/screens/home/stack_custom.dart';
import 'package:brain_application/widgets/components/button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MathScreen extends ConsumerWidget {
  const MathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: 900,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.white,
                Color(0xE6FFCD4D),
              ])),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xE6FFCD4D),
                      ),
                      child: Row(
                        children: [
                          // CircleAvatar(
                          //   radius: 21,
                          //   backgroundColor: const Color(0xff37EBBC),
                          //   child: CircleAvatar(
                          //     radius: 18,
                          //     backgroundImage: NetworkImage(
                          //       auth.user.profilePicture,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(width: 5),
                          Text(
                            'Name',
                            style: const TextStyle(
                              color: Color(0xff001663),
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('AppRoute.settings');
                      },
                      icon: const Icon(Icons.settings),
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'CH???N TR?? CH??I',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontSize: 25, letterSpacing: 1),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: Animator<double>(
                  duration: const Duration(milliseconds: 500),
                  cycles: 0,
                  curve: Curves.easeInOut,
                  tween: Tween<double>(begin: 15.0, end: 20.0),
                  builder: (context, animatorState, child) => Icon(
                    Icons.keyboard_arrow_down,
                    size: animatorState.value * 3.5,
                    color: Colors.black,
                  ),
                ),
              ),
              CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    height: 500,
                    enlargeCenterPage: true,
                    padEnds: true,
                    viewportFraction: .7,
                  ),
                  items: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.gameMath1);
                        },
                        child: const CustomStack(
                          image: 'assets/LogoGame/shoping-math-game.jpg',
                          icon: 'assets/LogoGame/shoping-math-game-icon.jpg',
                          text1: 'Tr?? Ch??i Mua S???m',
                          text2: 'Ch???n s???n ph???m c?? gi?? ??t h??n',
                          padding_left: 5,
                          padding_top: 45,
                          padding: 0,
                          color: Color(0xff2D2D2D),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RouteGenerator.gameMath2);
                      },
                      child: const CustomStack(
                        image: 'assets/LogoGame/plus-math-game-background.png',
                        icon: 'assets/LogoGame/plus-math-game-icon.png',
                        text1: 'Tr?? Ch??i T??m T???ng',
                        text2: 'T??m t???ng 2 s??? theo y??u c???u',
                        padding_left: 7,
                        padding_top: 80,
                        padding: 28,
                        color: Color(0xff444444),
                      ),
                    ),
                  ]),
              // Button(
              //     onPressed: () {
              //       Navigator.of(context).pushNamed(RouteGenerator.homepage);
              //     },
              //     text: 'Trang ch???')
            ],
          ),
        ),
      ),
    );
  }
}
