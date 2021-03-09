import 'package:flutter/material.dart';
import 'package:moviedb_flutter/model/popular_movies_model.dart';

class PopularMoviesDetailPage extends StatelessWidget {
  final ResultsPopularMovies resultsPopularMovies;
  PopularMoviesDetailPage({this.resultsPopularMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies Detail"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                resultsPopularMovies.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      height: MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://image.tmdb.org/t/p/w500"+resultsPopularMovies.posterPath),
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
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orangeAccent,
                                    size: 25.0,
                                  ),
                                  Text(
                                    resultsPopularMovies.voteAverage.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Release Date",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                resultsPopularMovies.releaseDate,
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Language",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                resultsPopularMovies.originalLanguage,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Overview",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                resultsPopularMovies.overview,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
