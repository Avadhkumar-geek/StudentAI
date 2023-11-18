import 'custom_app_model.dart';

class UserModel {
  final String displayName;
  final String email;
  final String photoURL;
  final String uid;
  final List<CustomAppModel> customApps;

  UserModel({
    required this.displayName,
    required this.email,
    required this.photoURL,
    required this.uid,
    required this.customApps,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'],
      email: json['email'],
      photoURL: json['photoURL'],
      uid: json['uid'],
      customApps: List<CustomAppModel>.from(
        (json['customApps'] as List).map((e) => CustomAppModel.fromJson(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'email': email,
        'photoURL': photoURL,
        'uid': uid,
        'customApps': customApps,
      };
}
