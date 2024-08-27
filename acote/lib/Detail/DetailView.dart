import 'package:acote/Detail/DetailVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailView extends StatelessWidget {
  final String username;

  DetailView({required this.username});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DetailVM()..fetchUserRepos(username),
        child: Scaffold(
            appBar: AppBar(title: Text('$username\'s Repositories')),
            body: Consumer<DetailVM>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: provider.repos.length,
                  itemBuilder: (context, index) {
                    final repo = provider.repos[index];
                    return ListTile(
                        title: Text(repo.name),
                        subtitle: Text(repo.description),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(repo.language),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, color: Colors.yellow),
                                Text(repo.stargazersCount.toString()),
                              ],
                            )
                          ],
                        ));
                  },
                );
              },
            )));
  }
}
