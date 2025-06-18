import 'package:freezed_annotation/freezed_annotation.dart';

part 'term_state.freezed.dart';

@freezed
abstract class TermState with _$TermState {
  const TermState._();

  const factory TermState({
    @Default(false) bool isServiceTerm,
    @Default(false) bool isPrivateTerm,
    @Default(false) bool isLocationTerm,
    @Default(false) bool isThreeTerm,
    @Default(false) bool isMarketingTerm,
  }) = _TermState;

  bool get isAllTerms => isServiceTerm && isPrivateTerm && isLocationTerm && isThreeTerm;
}
