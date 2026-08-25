import 'package:flutter/material.dart';
import 'package:intern_hup/core/constant/app_color.dart';

class RememberMeWidgets extends StatefulWidget {
  const RememberMeWidgets({super.key});

  @override
  State<RememberMeWidgets> createState() => _RememberMeWidgetsState();
}

class _RememberMeWidgetsState extends State<RememberMeWidgets> { 

  bool _rememberMe = false; 
  @override
  Widget build(BuildContext context) {
       return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => setState(() => _rememberMe = !_rememberMe),
          child: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: _rememberMe,
                  onChanged: (val) =>
                      setState(() => _rememberMe = val ?? false),
                  activeColor: AppColors.primColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: BorderSide(
                    color: AppColors.neutralColor.withValues(alpha: 0.6),
                    width: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Remember me',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.neutralColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        // Forgot Password link
        GestureDetector(
          onTap: () { 

            
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.primColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
