import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color, // 버튼의 색상 속성을 추가
    this.textColor, // 버튼 텍스트 색상 속성 추가
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor, // 색상이 지정되지 않은 경우 기본색상 사용
        foregroundColor: textColor ?? Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder( // 모양을 둥글게
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text),
    );
  }
}