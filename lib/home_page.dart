import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie DB"),
      ),
      body: Container(
        child: FutureBuilder(
          builder: (context, snapshot) {
            var listUpcomingMovies = json.decode(snapshot.data.toString());
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text("Error display data"));
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                            child: Text("Popular Movies",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          listViewPopularMovies(),
                          Container(
                            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                            child: Text("Upcoming Movies",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          UpComingMoviesCell(
                            posterPath: listUpcomingMovies[index]["poster_path"],
                            title: listUpcomingMovies[index]["title"],
                            overview: listUpcomingMovies[index]["overview"],
                          )
                        ],
                      );
                    } else {
                      return UpComingMoviesCell(
                        posterPath: listUpcomingMovies[index]["poster_path"],
                        title: listUpcomingMovies[index]["title"],
                        overview: listUpcomingMovies[index]["overview"],
                      );
                    }
                  },
                  itemCount: listUpcomingMovies.length,
                );
              } else return Center(child: Text("Cannot display data"));
            }
          },
          future: DefaultAssetBundle.of(context).loadString("assets/upcoming_movies.json"),
        )
      ),
    );
  }

  Widget listViewPopularMovies() {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      child: FutureBuilder(
        builder: (context, snapshot) {
          var listPopularMovies = json.decode(snapshot.data.toString());
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text("Error display data"));
            } else if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return PopularMoviesCell(
                    posterPath: listPopularMovies[index]["poster_path"],
                    title: listPopularMovies[index]["title"],
                  );
                },
                itemCount: listPopularMovies.length,
              );
            } else return Center(child: Text("Cannot display data"));
          }
        },
        future: DefaultAssetBundle.of(context).loadString("assets/popular_movies.json"),
      ),
    );
  }
}

class PopularMoviesCell extends StatelessWidget {
  PopularMoviesCell({Key key, this.posterPath, this.title}) : super(key: key);
  final String posterPath, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/3,
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: MediaQuery.of(context).size.height/3.5,
              width: MediaQuery.of(context).size.width/3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage("https://image.tmdb.org/t/p/w500"+posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width/3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                      this.title,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class UpComingMoviesCell extends StatelessWidget {
  UpComingMoviesCell({Key key, this.posterPath, this.title, this.overview}) : super(key: key);
  final String posterPath, title, overview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      height: 150,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage("https://image.tmdb.org/t/p/w500"+posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )
                      ),
                      SizedBox(height: 5),
                      Text(
                        this.overview,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}

