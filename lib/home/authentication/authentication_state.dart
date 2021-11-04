

part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  final AuthenticationStatus status = AuthenticationStatus.unknown;
  final String userId="";

  @override
  String toString() => 'Authenticated { userId: $userId }';

  @override
  List<Object> get props => [status, userId];

}


class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  const Authenticated(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'Authenticated { userId: $userId }';
}

class Unauthenticated extends AuthenticationState {}