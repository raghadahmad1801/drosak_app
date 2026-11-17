import 'package:flutter/material.dart';

class CustomSearchGroup extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    ThemeData theme = ThemeData();
    return theme.copyWith(
      appBarTheme: AppBarTheme(backgroundColor: Color(0xff8012DC)),
      scaffoldBackgroundColor: Colors.black,
      inputDecorationTheme: InputDecorationThemeData(
        hintStyle: TextStyle(color: Colors.white),
      ),
      textTheme: TextTheme(titleLarge: TextStyle(color: Colors.white)),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear, color: Colors.white),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back, color: Colors.white),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text("لا يوجد نتائج");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center(
      child: Text("محتوى البحث", style: TextStyle(color: Colors.white)),
    );
  }
}
