class TExceptions implements Exception{

  final String message;
  const TExceptions([this.message = 'An unknown exception occurred.']);

  factory TExceptions.fromCode(String code){
    switch(code){
      case 'email-already-in-use':
        return const TExceptions('Email Already exists.');
      case 'invalid-email':
        return const TExceptions('Email is not valid.');
      case 'weak-password':
        return const TExceptions('Please enter a stronger password.');
      case 'user-disabled':
        return const TExceptions('The user has been disabled. Please contact support.');
      case 'user-not-found':
        return const TExceptions('User does not exist. Please create an account using this email.');
      case 'wrong-password':
        return const TExceptions('Incorrect password. Please try again.');
      case 'too-many-requests':
        return const TExceptions('Service blocked temporarily because of too many requests.');
      case 'invalid-argument':
        return const TExceptions('An invalid argument has been provided to an authentication method.');
      case 'invalid-password':
        return const TExceptions('Incorrect password. Please try again.');
      case 'invalid-phone-number':
        return const TExceptions('Invalid phone number. Please try again.');
      case 'uid-already-exists':
        return const TExceptions('The provided uid is already in use by an existing user.');

      default:
        return const TExceptions();
    }
  }

}