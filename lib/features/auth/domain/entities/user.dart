class User {
  final String profileId;
  final String userId;
  final String username;
  final String? fullName;
  final String? avatarUrl;
  final String? website;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const User({
    required this.profileId,
    required this.userId,
    required this.username,
    this.fullName,
    this.avatarUrl,
    this.website,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  bool get isDeleted => deletedAt != null;

  User copyWith({
    String? username,
    String? fullName,
    String? avatarUrl,
    String? website,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return User(
      profileId: profileId,
      userId: userId,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      website: website ?? this.website,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
