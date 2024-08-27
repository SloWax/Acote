import 'package:acote/Detail/DetailView.dart';
import 'package:acote/Home/HomeVM.dart';
import 'package:acote/Model/User.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    Provider.of<HomeVM>(context, listen: false).fetchUsers();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isNext = _scrollController.position.pixels >
        (_scrollController.position.maxScrollExtent - 300);

    if (isNext) {
      Provider.of<HomeVM>(context, listen: false).fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('GitHub Users')),
        body: Consumer<HomeVM>(
          builder: (context, provider, _) {
            if (provider.isLoading && provider.users.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: () async => provider.refreshUsers(),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: provider.users.length + provider.users.length ~/ 10,
                itemBuilder: (context, index) {
                  if (index % 11 == 10) {
                    return GestureDetector(
                      onTap: () =>
                          launchUrl(Uri.parse('https://taxrefundgo.kr')),
                      child: CachedNetworkImage(
                          imageUrl: 'https://placehold.it/500x100?text=ad'),
                    );
                  } else {
                    int userIndex = index - index ~/ 11;
                    User user = provider.users[userIndex];
                    return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: user.avatarUrl,
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.cover,
                        ),
                        title: Text(user.login),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailView(username: user.login),
                            ),
                          );
                        });
                  }
                },
              ),
            );
          },
        ));
  }
}
