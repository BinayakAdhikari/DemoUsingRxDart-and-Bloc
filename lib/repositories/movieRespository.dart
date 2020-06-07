import 'package:themechanger/models/movieModel.dart';
import 'package:themechanger/networking/apiProvider.dart';

class MovieRepository {
  APIProvider _apiProvider = APIProvider();

  Future<List<Movie>> fetchPopularMovies(String url) async {
    MovieList movieList;
    final response = await _apiProvider.get(url);
    movieList = MovieList.fromJson(response);
    return movieList.movies;
  }
}
