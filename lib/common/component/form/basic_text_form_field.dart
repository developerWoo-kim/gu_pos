import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gu_pos/common/component/text/body_text.dart';

import '../../const/colors.dart';

class BasicTextFormField extends StatelessWidget {
  final String? initValue;
  final String? hintText;
  final String? errorText;
  final String? labelText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged; // 값이 바뀔때 마다 실행되는 콜백
  final VoidCallback? onEditingComplete;
  final ValueChanged? onSubmitted;
  final Function? validator;
  final Icon? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;

  const BasicTextFormField({super.key,
      this.initValue,
      this.hintText,
      this.errorText,
      this.labelText,
      this.obscureText = false,
      this.autofocus = false,
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted,
      this.validator,
      this.prefixIcon,
      this.inputFormatters,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    // 테두리가 있는 인풋 보더
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR_01,
        width: 2,
      ),
    );

    return TextFormField(
      focusNode: focusNode,
      initialValue: initValue,
      // 커서 색
      cursorColor: BODY_TEXT_COLOR_04,
      cursorWidth: 1.0,
      cursorHeight: 18.0,
      // 마스킹 되는 속성 (비밀번호 입력에 활용) - 파라미터
      obscureText: obscureText,
      // 화면에 텍스트 폼 필드가 들어왔을때 포커스 되느냐하는 속성 - 파라미터
      textInputAction: TextInputAction.done,
      autofocus: autofocus,
      // 값이 바뀔때마다 실행되는 콜백 - 파라미터
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      style: TextStyle(
        color: BODY_TEXT_COLOR_04,
        fontSize: BodyTextSize.REGULAR.value,
      ),
      // 패딩
      decoration: InputDecoration(
        // 패딩에서 쓰는 파라미터랑 똑같음
        contentPadding: EdgeInsets.all(15),
        labelText: labelText,
        labelStyle: TextStyle(
          color: BODY_TEXT_COLOR_02,
          fontSize: BodyTextSize.REGULAR.value,
        ),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: INPUT_TEXT_COLOR_01,
          fontSize: BodyTextSize.REGULAR.value,
          fontWeight: FontWeight.w300
        ),
        // 모든 Input 상태의 기본 스타일 세팅
        border: baseBorder,
        enabledBorder: baseBorder,
        prefixIcon: prefixIcon,
        // 선택된 Input border
        focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: PRIMARY_COLOR_01,
            )
        ),
      ),
      validator: (value) {
        String? errorMessage = validator?.call(value);
        return errorMessage;
      },
    );
  }
}
