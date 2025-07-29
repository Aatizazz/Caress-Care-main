class UserModel {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? dob;
  final String? gender;
  final String? avatarPath;

  UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.gender,
    this.avatarPath,
  });

  /// Converts this user object to a JSON map
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'dob': dob,
    'gender': gender,
    'avatarPath': avatarPath,
  };

  /// Creates a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    dob: json['dob'],
    gender: json['gender'],
    avatarPath: json['avatarPath'],
  );

  /// Creates a copy of the current UserModel with optional new values
  UserModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? dob,
    String? gender,
    String? avatarPath,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}
