import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:popcorn/constants.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TrendingSlider extends StatelessWidget {
  final List trending;
  const TrendingSlider({super.key, required this.trending});

  //final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 5,
        options: CarouselOptions(
            height: 300,
            autoPlay: true,
            viewportFraction: 0.55,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 1)),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 300,
              width: 200,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('http://image.tmdb.org/t/p/w500' +
                        trending[itemIndex]['poster_path']),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
