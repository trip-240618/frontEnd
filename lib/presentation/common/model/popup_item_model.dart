import 'package:freezed_annotation/freezed_annotation.dart';

part 'popup_item_model.freezed.dart';

@freezed
abstract class PopupItemModel with _$PopupItemModel {
  const factory PopupItemModel({
    required String nickname,
    String? profileImg,
  }) = _PopupItemModel;
}
