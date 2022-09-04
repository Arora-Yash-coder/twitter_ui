class UserModel {
  final String id;
  final String? bannerImageUrl;
  final String? profileImageUrl;
  final String? name;
  final String? email;

  UserModel({
    required this.id,
    this.bannerImageUrl,
    this.profileImageUrl,
    this.email,
    this.name,
  });
}
