import 'package:flutter/material.dart';

class CustomSearch extends SearchDelegate<String> {
  Widget Function(String query) myBuildResult;

  CustomSearch({required this.myBuildResult});

  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // TODO: implement appBarTheme
    return theme.copyWith(
      appBarTheme: const AppBarTheme(color: Color(0xff8012DC)),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
      ),
      textTheme: TextTheme(titleLarge: TextStyle(color: Colors.white)),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close, color: Colors.white),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back, color: Colors.white),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // EducationStageDataBase educationStageDataBase = EducationStageDataBase();
    // Future<List<EducationModel>> data = educationStageDataBase.getSearch(query);
    // return query == '' ? SizedBox() : CustomListSearch(searchList: data);

    return myBuildResult(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("محتوى البحث", style: TextStyle(color: Colors.white)),
    );
  }
}
