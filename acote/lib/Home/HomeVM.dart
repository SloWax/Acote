import 'package:acote/Model/User.dart';
import 'package:acote/Service/GitService.dart';
import 'package:flutter/material.dart';

class HomeVM with ChangeNotifier {
  final List<User> _users = [];
  int _since = 0;
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  final GitService _apiService = GitService();

  Future<void> fetchUsers() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      List<User> fetchedUsers = await _apiService.fetchUsers(_since);
      _users.addAll(fetchedUsers);
      if (fetchedUsers.isNotEmpty) {
        _since = _users.last.id;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void refreshUsers() {
    _users.clear();
    _since = 0;
    fetchUsers();
  }
}
