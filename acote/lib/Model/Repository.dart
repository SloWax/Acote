class Repository {
  final String name;
  final String description;
  final int stargazersCount;
  final String language;

  Repository({
    required this.name,
    required this.description,
    required this.stargazersCount,
    required this.language,
  });

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      name: json['name'],
      description: json['description'] ?? '',
      stargazersCount: json['stargazers_count'],
      language: json['language'] ?? 'Unknown',
    );
  }
}
