import 'package:acote/DetailScreen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

// Event
abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UserEvent {
  final int since;

  FetchUsers(this.since);

  @override
  List<Object> get props => [since];
}

// State
abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;

  UserLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object> get props => [message];
}

// Model
class User {
  final String login;
  final String avatarUrl;

  User({required this.login, required this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      avatarUrl: json['avatar_url'],
    );
  }
}

// Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final response = await http.get(
          Uri.parse(
              'https://api.github.com/users?since=${event.since}&per_page=30'),
        );
        if (response.statusCode == 200) {
          List<User> users = (jsonDecode(response.body) as List)
              .map((data) => User.fromJson(data))
              .toList();
          emit(UserLoaded(users));
        } else {
          emit(UserError("Failed to load users"));
        }
      } catch (e) {
        emit(UserError("Failed to load users"));
      }
    });
  }
}

class HomeScreen extends StatelessWidget {
  final UserBloc _userBloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GitHub Users')),
      body: BlocProvider(
        create: (_) => _userBloc..add(FetchUsers(0)),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  _userBloc.add(FetchUsers(0)); // 첫 페이지 리로드
                },
                child: ListView.builder(
                  itemCount:
                      state.users.length + (state.users.length ~/ 10), // 광고 포함
                  itemBuilder: (context, index) {
                    if (index % 11 == 10) {
                      // 광고 배너 위치 계산
                      return InkWell(
                        onTap: () =>
                            launchUrl(Uri.parse('https://taxrefundgo.kr')),
                        child: Image.network(
                            'https://placehold.it/500x100?text=ad'),
                      );
                    }
                    final user = state.users[index - (index ~/ 11)];
                    return ListTile(
                      leading: CachedNetworkImage(
                          imageUrl: user.avatarUrl,
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.cover),
                      title: Text(user.login),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DetailScreen(username: user.login)));
                      },
                    );
                  },
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
