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
    if (_isLoading) return; // 이미 로딩 중이면 중복 요청을 방지
    _isLoading = true;
    notifyListeners();

    try {
      List<User> fetchedUsers = await _apiService.fetchUsers(_since);
      _users.addAll(fetchedUsers);
      if (fetchedUsers.isNotEmpty) {
        _since = _users.last.id; // 다음 페이지를 위한 값 설정
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
