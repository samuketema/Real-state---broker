// ignore_for_file: public_member_api_docs, sort_constructors_first
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

 
}
