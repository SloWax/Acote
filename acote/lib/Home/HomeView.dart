import 'package:acote/Home/HomeVM.dart';
import 'package:acote/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('GitHub Users')),
        body: Consumer<UserVM>(
          builder: (context, provider, _) {
            if (provider.isLoading && provider.users.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: () async => provider.refreshUsers(),
              child: ListView.builder(
                itemCount: provider.users.length + provider.users.length ~/ 10,
                itemBuilder: (context, index) {
                  if (index % 11 == 10) {
                    return GestureDetector(
                      onTap: () =>
                          launchUrl(Uri.parse('https://taxrefundgo.kr')),
                      child:
                          Image.network('https://placehold.it/500x100?text=ad'),
                    );
                  } else {
                    int userIndex = index - index ~/ 11;
                    User user = provider.users[userIndex];
                    return ListTile(
                        leading: Image.network(user.avatarUrl),
                        title: Text(user.login),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         DetailsScreen(username: user.login),
                          //   ),
                          // );
                        });
                  }
                },
              ),
            );
          },
        ));
  }
}
