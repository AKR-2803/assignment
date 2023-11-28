import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:quadb_tech/constants/constants.dart';
import 'package:quadb_tech/models/movie_model.dart';
import 'package:quadb_tech/screens/search_screen.dart';
import 'package:http/http.dart' as http;
import 'package:quadb_tech/screens/show_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //get api method
  Future<List<MovieModel>> getMoviesApi() async {
    List<MovieModel> movieList = [];
    final response =
        await http.get(Uri.parse("https://api.tvmaze.com/search/shows?q=all"));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> item in data) {
        // print(item['name']);
        movieList.add(MovieModel.fromJson(item));
      }
      return movieList;
    } else {
      return movieList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Constants.getText(text: "NETFLIX", color: Colors.red, size: 25),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(Constants.createRoute(SearchScreen()));
            },
            icon: const Icon(Icons.search_sharp),
            color: Colors.white,
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: FutureBuilder(
            future: getMoviesApi(),
            builder: ((context, AsyncSnapshot<List<MovieModel>> snapshot) {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.isNotEmpty) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 5,
                            childAspectRatio: 0.6,
                            crossAxisCount: 2),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      MovieModel movieModel = snapshot.data![index];
                      MovieImage? movieImage;
                      String? movieName = "Show name unavailable";
                      List<String>? movieGenreList = [];
                      String? movieSummary = "Show summary unavailable";

                      if (movieModel.show != null) {
                        movieImage = movieModel.show!.image;
                        movieName = movieModel.show!.name;
                        movieGenreList = movieModel.show!.genres;
                        movieSummary = movieModel.show!.summary;
                      }
                      //Rendering cards of respective shows
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ShowDetailsScreen(movieModel: movieModel)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white30, width: 0.5),
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.black,
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              //thumbnail/image
                              AspectRatio(
                                aspectRatio: 25 / 26,
                                child: movieImage != null
                                    ? Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            alignment:
                                                FractionalOffset.topCenter,
                                            image: NetworkImage(movieModel
                                                .show!.image!.original!),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: Colors.white24,
                                        ),
                                        child: Text(
                                          movieModel.show!.name!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30),
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 5),
                              //name/title
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                alignment: Alignment.centerLeft,
                                child: Constants.getText(
                                    text: movieName!.toUpperCase(),
                                    color: Colors.white,
                                    size: 18),
                              ),
                              //genre
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                alignment: Alignment.centerLeft,
                                child: Constants.getText(
                                    text: movieGenreList!.join(" | "),
                                    color: Colors.red[400],
                                    size: 14),
                              ),
                              const SizedBox(height: 2),
                              //summary
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "$movieSummary",
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.fade,
                                  maxLines: 5,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                // print("\nsnapshot has error: ${snapshot.error}");
                return Center(
                    child: Text("Snapshot error : ${snapshot.error}"));
              } else {
                // print("\nsnapshot is Loading");
                return const Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                );
              }
            })),
      ),
    );
  }
}
