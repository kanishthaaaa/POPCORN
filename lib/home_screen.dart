import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popcorn/api/api.dart';
import 'package:popcorn/components/trending_slider.dart';
import 'package:popcorn/search_screen.dart';
import 'model/movie.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List trendingMovies = [];
  List topRatedMovies = [];
  List upcomingMovies = [];

  final String apikey = '3bcbc58bfa32599f427aa5b18286e541';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYmNiYzU4YmZhMzI1OTlmNDI3YWE1YjE4Mjg2ZTU0MSIsInN1YiI6IjY1Mjk0YmJjODEzODMxMDBjNDhhZDE3YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X6Pdum5oUa5-y-TdPpT8tI-MGUeXFzVZfpbF0dVzI4k';

  @override
  void initState() {
    getTrendingMovies();
    super.initState();
  }
  //function to load trending movie

  getTrendingMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, readAccessToken),
        logConfig: ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    //map we get from api
    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResults = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map upcomingResult = await tmdbWithCustomLogs.v3.movies.getUpcoming();

    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResults['results'];
      upcomingMovies = upcomingResult['results'];
    });
    print(trendingMovies);
    print(topRatedResults);
    print(upcomingResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/popcornn.png',
              height: 35,
              width: 45,
              fit: BoxFit.cover,
            ),
            Text(
              'P O P C O R N',
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending Movies',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.search,
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              // SizedBox(
              //   child: FutureBuilder(
              //     future: trendingMovies,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasError) {
              //         return Center(
              //           child: Text(
              //             snapshot.error.toString(),
              //           ),
              //         );
              //       } else if (snapshot.hasData) {
              //         return TrendingSlider(snapshot: snapshot);
              //       } else {
              //         return Center(child: CircularProgressIndicator());
              //       }
              //     },
              //   ),
              // )
              TrendingSlider(trending: trendingMovies),
              SizedBox(
                height: 30,
              ),
              Text(
                'Top Rated Movies',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: 5,
                  options: CarouselOptions(
                    height: 150,
                    viewportFraction: 0.30,
                    padEnds: true,
                  ),
                  itemBuilder: (context, itemIndex, pageViewIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 300,
                        width: 200,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'http://image.tmdb.org/t/p/w500' +
                                      topRatedMovies[itemIndex]['poster_path']),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
