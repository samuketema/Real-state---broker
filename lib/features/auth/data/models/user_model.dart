import 'package:realstate/core/common/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.profileId,
    required super.userId,
    required super.username,
    super.fullName,
    super.avatarUrl,
    super.website,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
  });

  /// From Supabase (Postgres row)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      profileId: json['profile_id'] as String,
      userId: json['user_id'] as String,
      username: json['username'] as String,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      website: json['website'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }
 UserModel copyWith({
    String? profileId,
    String? userId,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? website,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return UserModel(
      profileId: profileId ?? this.profileId,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      website: website ?? this.website,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
  /// To Supabase insert/update
  Map<String, dynamic> toJson() {
    return {
      'profile_id': profileId,
      'user_id': userId,
      'username': username,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'website': website,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}

