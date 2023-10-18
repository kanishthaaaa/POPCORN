import 'dart:convert';
import 'package:tmdb_api/tmdb_api.dart';

class Movie {
  final String title;
  final String backDropPath;
  final String originalTitle;
  final String overView;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;

  Movie({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overView,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json["title"] ?? "Some Title", //default title
      backDropPath: json["backdrop_path"],
      originalTitle: json["original_title"],
      overView: json["overview"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      voteAverage: json["vote_average"],
    );
  }
}
