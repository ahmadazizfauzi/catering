import 'package:flutter/material.dart';
import 'package:catering_1/core/colors/app_colors.dart';

class InputTextShared extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final IconData? icon;
  final bool action; 

  const InputTextShared({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.validator,
    this.icon,
    this.action = false,
  });

  @override
  State<InputTextShared> createState() => _InputTextSharedState();
}

class _InputTextSharedState extends State<InputTextShared> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(14),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.action ? _obscureText : false,
          decoration: InputDecoration(
            prefixIcon: widget.icon != null
                ? Icon(widget.icon, color: AppColors.brand['default'])
                : null,
            labelText: widget.label,
            labelStyle: TextStyle(
              color: AppColors.brand['default'],
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
            filled: true,
            fillColor: AppColors.white['default'],
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.brand['default']!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.brand['default']!, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.red[400]!, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.red[700]!, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            suffixIcon: widget.action
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.brand['default'],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
          keyboardType: widget.keyboardType,
          validator: widget.validator,
        ),
      ),
    );
  }
}