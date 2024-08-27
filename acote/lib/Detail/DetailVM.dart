import 'package:acote/Model/Repository.dart';
import 'package:acote/Service/GitService.dart';
import 'package:flutter/material.dart';

class DetailVM with ChangeNotifier {
  List<Repository> _repos = [];
  bool _isLoading = false;

  List<Repository> get repos => _repos;
  bool get isLoading => _isLoading;

  final GitService _apiService = GitService();

  Future<void> fetchUserRepos(String username) async {
    _isLoading = true;
    notifyListeners();

    try {
      _repos = await _apiService.fetchUserRepos(username);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
