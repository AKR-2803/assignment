import 'package:flutter/material.dart';
import 'package:quadb_tech/screens/search_results.dart';

class Constants {
  //text widget for common use
  static Text getText(
      {required String text,
      Color? color = Colors.black,
      double? size = 14.0}) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size),
    );
  }

  //animating the screen transition
  static Route createRoute(Widget className) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => className,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeIn;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static Widget getTextFormField(
      TextEditingController searchController, BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.left,
      textAlignVertical: TextAlignVertical.center,
      controller: searchController,
      onChanged: (val) {
        // user is typing something
      },
      // when the search field is submitted
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (val) {
        // pass the searched term to the search results screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SearchResults(
              searchedString: val,
            ),
          ),
        );
      },
      autofocus: true,
      // enabled: true,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade500,
        // contentPadding: EdgeInsets.only(top: 2),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black38, width: 1)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: Colors.black38, width: 0.4)),
        // border: null,
        hintText: "Search",
        hintStyle: const TextStyle(fontWeight: FontWeight.w400),
        isCollapsed: true,
        prefixIcon: const Icon(Icons.search, color: Colors.black87),
      ),
    );
  }

  static Widget getContainner(
      {required String text, required double fontSize}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      child: Constants.getText(text: text, color: Colors.white, size: fontSize),
    );
  }
}
