import 'package:equatable/equatable.dart';

class TokenPair extends Equatable {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  const TokenPair({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  TokenPair copyWith({
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
  }) {
    return TokenPair(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, expiresIn];

  @override
  String toString() {
    return 'TokenPair(accessToken: ${accessToken.substring(0, 20)}..., refreshToken: ${refreshToken.substring(0, 20)}..., expiresIn: $expiresIn)';
  }
}