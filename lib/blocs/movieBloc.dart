import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:themechanger/models/movieModel.dart';
import 'package:themechanger/networking/response.dart';
import 'package:themechanger/repositories/movieRespository.dart';

class MovieBloc {
  MovieRepository _movieRepository;
  BehaviorSubject<Response<List<Movie>>> _movieDataController;

  StreamSink<Response<List<Movie>>> get movieDataSink =>
      _movieDataController.sink;

  Stream<Response<List<Movie>>> get movieDataStream =>
      _movieDataController.stream;

  MovieBloc(String url) {
    _movieDataController = BehaviorSubject<Response<List<Movie>>>();
    _movieRepository = MovieRepository();
    fetchMovie(url);
  }

  fetchMovie(String url) async {
    movieDataSink.add(Response.loading('Movies are loading'));
    try {
      List<Movie> movies = await _movieRepository.fetchPopularMovies(url);
      movieDataSink.add(Response.completed(movies));
    } catch (e) {
      movieDataSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieDataController.close();
  }
}
