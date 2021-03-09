import 'package:flutter/material.dart';
import 'package:moviedb_flutter/model/upcoming_movies_model.dart';

class UpcomingMoviesDetailPage extends StatelessWidget {
  final ResultsUpcomingMovies resultsUpcomingMovies;
  UpcomingMoviesDetailPage({this.resultsUpcomingMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Upcoming Movies Detail"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height/1.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://image.tmdb.org/t/p/w500"+resultsUpcomingMovies.posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      resultsUpcomingMovies.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                        size: 25.0,
                      ),
                      Text(
                        resultsUpcomingMovies.voteAverage.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                      "Release Date",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  Text(
                      resultsUpcomingMovies.releaseDate,
                      style: TextStyle(fontSize: 15)
                  ),
                  SizedBox(height: 10),
                  Text(
                      "Overview",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  Text(
                      resultsUpcomingMovies.overview,
                      style: TextStyle(fontSize: 15)
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
