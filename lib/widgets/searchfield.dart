import 'package:flutter/material.dart';

class _StudentSearch extends SearchDelegate<String> {
  final cities = ['Ankara', 'İzmir', 'İstanbul', 'Samsun', 'Sakarya'];
  var recentCities = ['Ankara'];
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.cabin),
      onPressed: () {},
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(
        (Icons.arrow_back),
      ),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      );
}
