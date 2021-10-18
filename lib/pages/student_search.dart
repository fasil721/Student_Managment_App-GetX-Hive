import 'package:flutter/material.dart';
import 'package:student_records/pages/record_adapter.dart';

class StudentSearch extends SearchDelegate<String> {
  final cities = ['Ankara', 'İzmir', 'İstanbul', 'Samsun', 'Sakarya'];
  // var recentCities = ['Ankara'];

  // var box;
  // StudentSearch(this.box);
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) {}

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_city, size: 120),
            const SizedBox(height: 48),
            Text(
              query,
              style: TextStyle(
                color: Colors.black,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = cities.where(
      (city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();

        return cityLower.startsWith(
          queryLower,
        );
      },
    ).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          // Record? record = box.get(title);
          // print(record);
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;

              showResults(context);
            },
            leading: Icon(Icons.location_city),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
