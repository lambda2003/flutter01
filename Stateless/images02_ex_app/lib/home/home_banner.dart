import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Scrollbar(
        thumbVisibility: false, // Make the thumb visible by default
        thickness: 5.0,
        // Optional: Customize the radius
        radius: const Radius.circular(5.0),
        // interactive: true, // Allow interaction with the scrollbar
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: Image.asset('assets/images/flower_01.png', width: 100),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: Image.asset('assets/images/flower_02.png', width: 100),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: Image.asset('assets/images/flower_03.png', width: 100),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: Image.asset('assets/images/flower_04.png', width: 100),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: Image.asset('assets/images/flower_05.png', width: 100),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(9.0),
                child: Image.asset('assets/images/flower_06.png', width: 100),
              ),
              // Image.asset('assets/images/flower_02.png', width: 100),
              // Image.asset('assets/images/flower_03.png', width: 100),
              // Image.asset('assets/images/flower_04.png', width: 100),
              // Image.asset('assets/images/flower_05.png', width: 100),
              // Image.asset('assets/images/flower_06.png', width: 100),
            ],
          ),
        ),
      ),
    );
  }
}
