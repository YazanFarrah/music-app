class AppFailure {
  final String message;

  AppFailure([this.message = "Sorry, an unexpected error occurred!"]);
  

  @override
  String toString() => 'AppFailure(message: $message)';
}

class NetworkFailure extends AppFailure {
  NetworkFailure([super.message = "Network error occurred!"]);
}

class ServerFailure extends AppFailure {
  ServerFailure([super.message = "Server error occurred!"]);
}

class ValidationFailure extends AppFailure {
  ValidationFailure([super.message = "Validation error occurred!"]);
}

class UnknownFailure extends AppFailure {
  UnknownFailure([super.message = "An unknown error occurred!"]);
}
