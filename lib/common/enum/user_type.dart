enum UserType {
  register,
  login;

  factory UserType.fromString(String? value) => UserType.values.firstWhere(
        (e) => e.name == value,
        orElse: () => UserType.register,
      );
}
