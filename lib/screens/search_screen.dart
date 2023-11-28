import 'package:flutter/material.dart';
import 'package:quadb_tech/constants/constants.dart';
import 'package:quadb_tech/main.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // leading: SizedBox.shrink(),
        backgroundColor: Colors.black,
        title: SizedBox(
          height: mq.height * .055,
          child: Constants.getTextFormField(searchController, context),
        ),
      ),
      body: Center(
        child: Constants.getText(text: "Search Here", color: Colors.white24),
      ),
    );
  }
}
