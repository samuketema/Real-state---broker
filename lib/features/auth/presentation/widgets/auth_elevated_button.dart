// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:realstate/core/theme/app_palette.dart';

class AuthElevatedButton extends StatelessWidget {
  const AuthElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.isLoading = false,
  });
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;

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
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text, style: const TextStyle(fontWeight: FontWeight.bold ,fontSize: 18 ),),
      ),
    );
  }
}
