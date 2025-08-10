import 'package:flutter/material.dart';
import '../../../core/constants.dart';
class CustomHeader extends StatelessWidget {
  final String heading,subHeading;
  const CustomHeader({super.key, required this.heading, required this.subHeading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Curved Background
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryRed, primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(250),
            ),
          ),
        ),

        Positioned(
          right: 20,
          top: 60,
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              'assets/images/logo.png',
              height: 120,
              width: 120,
              color: Colors.white,
            ),
          ),
        ),

        // Profile Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image(image: AssetImage('assets/images/logo.png'),height: 60,width: 60,color: white,),
                  // SizedBox(width: 5,),
                  Image(image: AssetImage("assets/images/text_logo.png"),height: 140,width: 140,)

                  // Text(
                  //   'L',
                  //   style: TextStyle(
                  //     fontSize: 60,
                  //     fontWeight: FontWeight.w500,
                  //     color: mediumPink,
                  //   ),
                  // ),
                  //
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       'Language',
                  //       style: TextStyle(
                  //         fontSize: 22,
                  //         fontWeight: FontWeight.w700,
                  //         color: white,
                  //       ),
                  //     ),
                  //     Text(
                  //       'earner',
                  //       style: TextStyle(
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.w700,
                  //         color: mediumPink,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              Text(
                heading,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                subHeading,
                style: TextStyle(

                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    );;
  }
}
