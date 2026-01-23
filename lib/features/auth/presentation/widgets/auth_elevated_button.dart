// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:realstate/core/theme/app_palette.dart';

class AuthElevatedButton extends StatelessWidget {
  const AuthElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          AppPalette.primary,
          AppPalette.secondary
        ],
        begin: AlignmentGeometry.topLeft,
        end: AlignmentGeometry.bottomRight)
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16), 
          shape: RoundedRectangleBorder(
            
          ),
        ),
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 18 ),),
      ),
    );
  }
}
