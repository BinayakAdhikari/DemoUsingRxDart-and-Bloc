import 'package:themechanger/utils/constants.dart';

class ApiEndpoints {
  static String popularMoviesUrl(int page) {
    return 'movie/popular?api_key=$TMDB_API_KEY&include_adult=true&page=$page';
  }

  static String topRatedMoviesUrl(int page) {
    return 'movie/top_rated?api_key=$TMDB_API_KEY&include_adult=true&page=$page';
  }

  static String nowPlayingUrl(int page) {
    return 'movie/now_playing?api_key=$TMDB_API_KEY&include_adult=true&page=$page';
  }

  static String upcomingMoviesUrl(int page) {
    return 'movie/upcoming?api_key=$TMDB_API_KEY&include_adult=true&page=$page';
  }
}
