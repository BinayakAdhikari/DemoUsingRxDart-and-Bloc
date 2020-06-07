import 'package:flutter/material.dart';
import 'package:themechanger/blocs/movieCounterBloc.dart';
import 'package:themechanger/blocs/themeBloc.dart';
import 'package:themechanger/models/movieModel.dart';
import 'package:themechanger/screens/eachMovieDetails.dart';
import 'package:themechanger/utils/constants.dart';
import 'package:themechanger/utils/theme_utils.dart';

class CustomDrawer extends StatelessWidget {
  final ThemeBloc themeBloc;

  CustomDrawer({this.themeBloc});

  final List<Color> colors = [
    Colors.cyanAccent,
    Colors.deepOrange,
    Color(0xff032038)
  ];
  final List<Color> borders = [
    Colors.amberAccent,
    Colors.limeAccent,
    Colors.yellow
  ];
  final List<String> themes = ['Light', 'Default', 'Dark'];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeData>(
      initialData: defaultTheme.themeData,
      stream: themeBloc.themeDataStream,
      builder: (context, AsyncSnapshot<ThemeData> snapshot) {
        return Theme(
          data: snapshot.data,
          child: Container(
            alignment: Alignment.bottomCenter,
            color: snapshot.data.primaryColor,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Choose App Theme',
                  ),
                ],
              ),
              subtitle: SizedBox(
                height: 100,
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2, color: borders[index]),
                                      color: colors[index]),
                                ),
                              ),
                              Text(
                                themes[index],
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        themeBloc.selectedTheme.add(lightTheme);
                                        break;
                                      case 1:
                                        themeBloc.selectedTheme
                                            .add(defaultTheme);
                                        break;
                                      case 2:
                                        themeBloc.selectedTheme.add(darkTheme);
                                        break;
                                    }
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: snapshot.data.primaryColor ==
                                            colors[index]
                                        ? Icon(Icons.done,
                                            color: snapshot.data.accentColor)
                                        : Container(),
                                  ),
                                ),
                              ),
                              Text(
                                themes[index],
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.white,
            child: Text('Retry', style: TextStyle(color: Colors.black)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }
}

class ScrollingMoviesList extends StatelessWidget {
  final List<Movie> movieList;
  final String title;
  final ThemeBloc themeBloc;
  final MovieCounterBloc movieCounterBloc;

  ScrollingMoviesList(
      {Key key,
      this.movieList,
      this.title,
      this.themeBloc,
      this.movieCounterBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeData>(
      initialData: defaultTheme.themeData,
      stream: themeBloc.themeDataStream,
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: movieList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EachMovieDetails(
                                    themeBloc: themeBloc,
                                    movie: movieList[index],
                                    heroId: '${movieList[index].id}$title')));
                      },
                      child: Hero(
                        tag: '${movieList[index].id}$title',
                        child: SizedBox(
                          width: 150,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Stack(
                                      children: <Widget>[
                                        FadeInImage(
                                          image: NetworkImage(
                                              TMDB_BASE_IMAGE_URL +
                                                  'w500/' +
                                                  movieList[index].posterPath),
                                          fit: BoxFit.cover,
                                          placeholder: AssetImage(
                                              'assets/images/loading.gif'),
                                          height: 300,
                                        ),
                                        Positioned(
                                          bottom: 1,
                                          right: 1,
                                          child: GestureDetector(
                                            onTap: () => movieCounterBloc
                                                .counterEventSink
                                                .add(AddMovie()),
                                            child: Icon(
                                              Icons.favorite,
                                              size: 30,
                                              color: snapshot.data.accentColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  movieList[index].title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
