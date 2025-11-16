import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final String clientId;
  final String token;
  final String expiresAt;
  final int expiresTimestamp;
  final int ttlMinutes; // in minutes

  const AuthSuccess({
    required this.clientId,
    required this.token,
    required this.expiresAt,
    required this.expiresTimestamp,
    required this.ttlMinutes,
  });

  @override
  List<Object?> get props => [token, expiresAt, expiresTimestamp, ttlMinutes];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
