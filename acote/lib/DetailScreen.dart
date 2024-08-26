import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class DetailScreen extends StatelessWidget {
  final String username;

  DetailScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$username\'s Repositories')),
      body: FutureBuilder(
        future:
            http.get(Uri.parse('https://api.github.com/users/$username/repos')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load repositories'));
          }

          final repos = jsonDecode(snapshot.data!.body) as List;

          return ListView.builder(
            itemCount: repos.length,
            itemBuilder: (context, index) {
              final repo = repos[index];
              return ListTile(
                title: Text(repo['name']),
                subtitle: Text(repo['description'] ?? 'No description'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.yellow),
                    Text(repo['stargazers_count'].toString()),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
