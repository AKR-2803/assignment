import 'package:flutter/material.dart';
import 'package:quadb_tech/main.dart';
import 'package:quadb_tech/models/movie_model.dart';
import 'package:quadb_tech/constants/constants.dart';

class ShowDetailsScreen extends StatelessWidget {
  final MovieModel movieModel;
  const ShowDetailsScreen({required this.movieModel, super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    // MovieModel movieModel = widget.movieModel;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Constants.getText(text: "NETFLIX", color: Colors.red, size: 25),
        centerTitle: true,
        backgroundColor: Colors.black,
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                //thumbnail available
                movieModel.show!.image != null
                    ? Container(
                        height: mq.height * 0.6,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white10, width: 1.0),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                alignment: FractionalOffset.topCenter,
                                image: NetworkImage(
                                    movieModel.show!.image!.original!))))
                    :
                    //thumbnail unavailable
                    Container(
                        height: mq.height * 0.6,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Constants.getText(
                            text: movieModel.show!.name!,
                            color: Colors.white,
                            size: 25)),
                //play button
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Constants.getText(text: "Play"),
                  icon: const Icon(Icons.play_arrow_rounded, color: Colors.red),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),

            //title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.add, color: Colors.white),
                Container(
                  child: Constants.getText(
                      text: movieModel.show!.name!.toUpperCase(),
                      color: Colors.white,
                      size: 22),
                ),
                const Icon(Icons.share, color: Colors.white),
              ],
            ),
            SizedBox(height: mq.height * 0.01),

            //genre
            Constants.getText(
                text: movieModel.show!.genres != [] ||
                        movieModel.show!.genres == null
                    ? movieModel.show!.genres!.join(" | ")
                    : "Genre : Unavailable",
                color: Colors.white60,
                size: 16),
            SizedBox(height: mq.height * 0.01),

            //rating
            Constants.getText(
                text:
                    "Rating : ${movieModel.show!.rating!.average! == 0.0 ? "Unavailable" : "${movieModel.show!.rating!.average!}/10 ⭐"}",
                color: Colors.white60,
                size: 15),
            SizedBox(height: mq.height * 0.015),
            Divider(
                color: Colors.white60,
                indent: mq.width * 0.2,
                endIndent: mq.width * 0.2),
            SizedBox(height: mq.height * 0.01),

            //summary
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: mq.width * 0.1),
              child: movieModel.show!.summary != null
                  ? Text(
                      overflow: TextOverflow.fade,
                      maxLines: 10,
                      movieModel.show!.summary!,
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                      textAlign: TextAlign.center,
                    )
                  : const Text("Summary unavailable"),
            ),
            SizedBox(height: mq.height * 0.01),
            Divider(
                color: Colors.white60,
                indent: mq.width * 0.2,
                endIndent: mq.width * 0.2),
          ],
        ),
      ),
    );
  }
}
