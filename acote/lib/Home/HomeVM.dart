import 'package:acote/Model/UserModel.dart';
import 'package:acote/Service/GitService.dart';
import 'package:flutter/material.dart';

class UserVM with ChangeNotifier {
  List<User> _users = [];
  // List<Repository> _repos = [];
  int _since = 0;
  bool _isLoading = false;

  List<User> get users => _users;
  // List<Repository> get repos => _repos;
  bool get isLoading => _isLoading;

  final GitService _gitService = GitService();

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<User> fetchedUsers = await _gitService.fetchUsers(_since);
      _users.addAll(fetchedUsers);
      _since = _users.last.login.hashCode; // 다음 페이지를 위한 값 설정
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> fetchUserRepos(String username) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     _repos = await _apiService.fetchUserRepos(username);
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  void refreshUsers() {
    _users.clear();
    _since = 0;
    fetchUsers();
  }
}
