import 'package:flutter/material.dart';
import 'package:themechanger/blocs/themeBloc.dart';
import 'package:themechanger/models/movieModel.dart';
import 'package:themechanger/utils/constants.dart';
import 'package:themechanger/utils/theme_utils.dart';

class EachMovieDetails extends StatelessWidget {
  final Movie movie;
  final String heroId;
  final ThemeBloc themeBloc;

  EachMovieDetails({this.movie, this.heroId, this.themeBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<ThemeData>(
      stream: themeBloc.themeDataStream,
      initialData: defaultTheme.themeData,
      builder: (context, snapshot) {
        return Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      movie.backdropPath == null
                          ? Image.asset(
                              'assets/images/na.jpg',
                              fit: BoxFit.cover,
                            )
                          : FadeInImage(
                              width: double.infinity,
                              height: double.infinity,
                              image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                  'original/' +
                                  movie.backdropPath),
                              fit: BoxFit.cover,
                              placeholder:
                                  AssetImage('assets/images/loading.gif'),
                            ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.bottomCenter,
                                end: FractionalOffset.topCenter,
                                colors: [
                                  snapshot.data.accentColor,
                                  snapshot.data.accentColor.withOpacity(0.3),
                                  snapshot.data.accentColor.withOpacity(0.2),
                                  snapshot.data.accentColor.withOpacity(0.1),
                                ],
                                stops: [
                                  0.0,
                                  0.25,
                                  0.5,
                                  0.75
                                ])),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: snapshot.data.accentColor,
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: snapshot.data.accentColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 230, 16, 16),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: snapshot.data.primaryColor,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 120.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            movie.title,
                                            style: snapshot
                                                .data.textTheme.headline5,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  movie.voteAverage,
                                                  style: snapshot
                                                      .data.textTheme.bodyText1,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.green,
                                                ),
                                                SizedBox(
                                                  width: 80,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  'Overview',
                                                  style: snapshot
                                                      .data.textTheme.bodyText1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              movie.overview,
                                              style: snapshot
                                                  .data.textTheme.caption,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, bottom: 4.0),
                                                child: Text(
                                                  'Release date : ${movie.releaseDate}',
                                                  style: snapshot
                                                      .data.textTheme.bodyText1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 150,
                          left: 30,
                          child: Hero(
                            tag: heroId,
                            child: SizedBox(
                              width: 110,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: movie.posterPath == null
                                    ? Image.asset(
                                        'assets/images/na.jpg',
                                        fit: BoxFit.cover,
                                      )
                                    : FadeInImage(
                                        image: NetworkImage(
                                            TMDB_BASE_IMAGE_URL +
                                                'w500/' +
                                                movie.posterPath),
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage(
                                            'assets/images/loading.gif'),
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    ));
  }
}
