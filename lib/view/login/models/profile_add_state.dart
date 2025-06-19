import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_add_state.freezed.dart';

@freezed
abstract class ProfileAddState with _$ProfileAddState {
  const ProfileAddState._();

  const factory ProfileAddState({
    XFile? profileImage,
    String? nickName,
    @Default(false) bool isNicknameValid,
  }) = _ProfileAddState;
}
