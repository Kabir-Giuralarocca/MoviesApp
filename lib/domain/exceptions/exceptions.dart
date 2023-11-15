class Unauthorized {
  final String? message;

  Unauthorized({this.message});

  @override
  String toString() {
    return message ?? "";
  }
}

class UserAlredyExist {
  final String? message;

  UserAlredyExist({this.message});

  @override
  String toString() {
    return message ?? "";
  }
}

class GenericError {
  final String? message;

  GenericError({this.message});

  @override
  String toString() {
    return message ?? "";
  }
}
