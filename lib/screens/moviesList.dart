import 'package:flutter/material.dart';
import 'package:themechanger/blocs/movieBloc.dart';
import 'package:themechanger/blocs/movieCounterBloc.dart';
import 'package:themechanger/blocs/themeBloc.dart';
import 'package:themechanger/endpoints/apiEndpoints.dart';
import 'package:themechanger/models/movieModel.dart';
import 'package:themechanger/networking/response.dart';
import 'package:themechanger/utils/widgets.dart';

class MoviesList extends StatefulWidget {
  final ThemeBloc themeBloc;

  MoviesList({Key key, this.themeBloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MoviesListState();
  }
}

class MoviesListState extends State<MoviesList> {
  MovieBloc _upcomingMoviesBloc, _nowPlayingMovieBloc, _popularMovieBloc;

  final _movieCounterBloc = MovieCounterBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _upcomingMoviesBloc = MovieBloc(ApiEndpoints.upcomingMoviesUrl(1));
    _nowPlayingMovieBloc = MovieBloc(ApiEndpoints.nowPlayingUrl(1));
    _popularMovieBloc = MovieBloc(ApiEndpoints.popularMoviesUrl(1));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _upcomingMoviesBloc.dispose();
    _nowPlayingMovieBloc.dispose();
    _popularMovieBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            buildMoviesList(_upcomingMoviesBloc, 'Upcoming Movies'),
            buildMoviesList(_nowPlayingMovieBloc, 'NowPlaying Movies'),
            buildMoviesList(_popularMovieBloc, 'Popular Movies')
          ],
        ),
      ),
      drawer: Drawer(
        child: CustomDrawer(
          themeBloc: widget.themeBloc,
        ),
      ),
      floatingActionButton: StreamBuilder(
          initialData: 0,
          stream: _movieCounterBloc.counter,
          builder: (context, snapshot) {
            return FloatingActionButton(
              onPressed: () {},
              child: Text('${snapshot.data.toString()}'),
            );
          }),
    );
  }

  Widget buildMoviesList(MovieBloc bloc, String title) {
    return StreamBuilder<Response<List<Movie>>>(
      stream: bloc.movieDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
              return Loading(loadingMessage: snapshot.data.message);
              break;
            case Status.COMPLETED:
              return ScrollingMoviesList(
                themeBloc: widget.themeBloc,
                title: title,
                movieList: snapshot.data.data,
                movieCounterBloc: _movieCounterBloc,
              );
              break;
            case Status.ERROR:
              return Error(
                errorMessage: snapshot.data.message,
                onRetryPressed: bloc.fetchMovie(ApiEndpoints.nowPlayingUrl(1)),
              );
              break;
          }
        }
        return Container();
      },
    );
  }
}
