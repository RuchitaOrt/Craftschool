import 'dart:ui';

class ForgetPasswordDTO {
  final String title;
  final String detailText;
  final String emailHint;
  final String buttonText;
  final String signInText;
  final bool isEmailSectionnVisble; // Changed to bool
    final VoidCallback? onTextOnTap;
  final VoidCallback? onButtonOnTap;

  ForgetPasswordDTO( {
    required this.title,
    required this.detailText,
    required this.emailHint,
    required this.buttonText,
    required this.signInText,
    required this.isEmailSectionnVisble, // Accepts bool
   required this.onTextOnTap, 
   required this.onButtonOnTap,
  });

  // Method to convert the DTO into a map
  Map<String, dynamic> toMap() { // Use dynamic for isEmailSectionnVisble
    return {
      'title': title,
      'detailText': detailText,
      'emailHint': emailHint,
      'buttonText': buttonText,
      'signInText': signInText,
      'isEmailSectionnVisble': isEmailSectionnVisble.toString() // Convert bool to string
    };
  }

  // Method to create the DTO from a map
  factory ForgetPasswordDTO.fromMap(Map<String, String> map) {
    return ForgetPasswordDTO(
      title: map['title'] ?? 'Forgot Your Password?',
      detailText: map['detailText'] ?? 'Enter your email to reset your password.',
      emailHint: map['emailHint'] ?? 'Enter your email address',
      buttonText: map['buttonText'] ?? 'Send Reset Link',
      signInText: map['signInText'] ?? 'Back to Sign In',
      // Convert the string to a boolean (assuming "true" or "false" strings)
      isEmailSectionnVisble: map['isEmailSectionnVisble']?.toLowerCase() == 'true', onTextOnTap: () {  }, onButtonOnTap: () {  }, 
    );
  }
}
