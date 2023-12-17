

class SignUpWithEmailAndPasswordFailure{
  final String message;
  const SignUpWithEmailAndPasswordFailure([this.message = "An Unknown Error Occurred!"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(('Please enter a password using Uppercase, Lowercase, and Numbers.'));
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(('Invalid Email.'));
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(('This Email is already registered to an account.'));
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(('Operation Not Allowed. Please contact GrabSmartly support.'));
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(('User has been disabled. Please contact GrabSmartly support.'));
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}