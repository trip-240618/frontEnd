import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tripStory/core/constants/icon_constants.dart';
import 'package:tripStory/core/constants/regex_constants.dart';
import 'package:tripStory/core/util/extension/context_extension.dart';
import 'package:tripStory/core/util/upper_case.dart';
import 'package:tripStory/presentation/common/button/bottom/bottom_button.dart';
import 'package:tripStory/presentation/common/button/icon_button.dart';
import 'package:tripStory/presentation/common/dialog/base_dialog.dart';
import 'package:tripStory/presentation/common/text/input/error_text_form_field.dart';

class CodeInsertDialog extends StatefulWidget {
  final Future<bool> Function(String inviteCode) onConfirmPressed;

  const CodeInsertDialog({
    super.key,
    required this.onConfirmPressed,
  });

  @override
  State<CodeInsertDialog> createState() => _CodeInsertDialogState();

  static void show(
    BuildContext context,
    Future<bool> Function(String inviteCode) onConfirmPressed,
  ) {
    showDialog(
      context: context,
      builder: (_) => CodeInsertDialog(onConfirmPressed: onConfirmPressed),
    );
  }
}

class _CodeInsertDialogState extends State<CodeInsertDialog> {
  final TextEditingController _invitedCodeCon = TextEditingController();

  bool isRegCheck = false;
  bool isEmptyRoom = false;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: AppIconButton(
              assetPath: IconConstants.close,
              onTap: () => Get.back(),
            ),
          ),
          const SizedBox(height: 68),
          Text(
            "초대 코드 입력",
            style: context.style.heading2.copyWith(
              color: context.color.gray800,
            ),
          ),
          const SizedBox(height: 10),
          ErrorTextFormField(
            controller: _invitedCodeCon,
            hintText: "영문+숫자 8자리를 입력해 주세요",
            showError: _invitedCodeCon.text.isNotEmpty && (isEmptyRoom || !isRegCheck),
            errorText: isEmptyRoom ? "존재하지 않는 초대 코드입니다" : "초대 코드는 영문+숫자 8자리입니다",
            textStyle: context.style.body2Normal,
            leadingIconPath: IconConstants.mail,
            leadingIconColor: context.color.gray900,
            backgroundColor: context.color.gray50,
            contentPadding: const EdgeInsets.all(16),
            onChanged: (text) => setState(() {
              isRegCheck = text.length == 8 && RegexConstants.alphanumeric.hasMatch(text);
              isEmptyRoom = false;
            }),
            inputFormatters: [
              LengthLimitingTextInputFormatter(8),
              UpperCaseTextFormatter(),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: BottomButton(
            padding: EdgeInsets.zero,
            text: "연결하기",
            enabled: _invitedCodeCon.text.trim().length == 8 &&
                RegexConstants.alphanumeric.hasMatch(_invitedCodeCon.text.trim()),
            onTap: () async {
              final result = await widget.onConfirmPressed(_invitedCodeCon.text);
              if (!result) {
                setState(() {
                  isEmptyRoom = true;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
