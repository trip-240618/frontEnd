import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_state.freezed.dart';

@freezed
abstract class EditProfileState with _$EditProfileState {
  const EditProfileState._();

  const factory EditProfileState({
    XFile? profileImage,
    @Default("") String nickName,
    @Default("") String introduce,
    @Default(true) bool isNicknameValid,
  }) = _EditProfileState;

  int get nickNameLength => nickName.length;
}
