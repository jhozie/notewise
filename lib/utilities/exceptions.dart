// Login Exceptions

class WrongPasswordException implements Exception {}

class UserNotFoundException implements Exception {}

class LoginInvalidEmailException implements Exception {}

// Registration Exceptions

class WeakPasswordException implements Exception {}

class RegisterInvalidEmailException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

//Generic Exceptions

class GenericException implements Exception {}

class UserNotLoggedInException implements Exception {}

class GoogleSignInException implements Exception {}
