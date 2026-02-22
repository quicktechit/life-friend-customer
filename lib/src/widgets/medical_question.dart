import 'package:flutter/material.dart';

Widget buildMedicalServiceItem({
  required IconData icon,
  required Color iconColor,
  required String title,
  required String answer,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconColor.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getAnswerColor(answer).withAlpha(50),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _getAnswerColor(answer).withAlpha(60),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'উত্তর: ',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      _translateAnswer(answer),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _getAnswerColor(answer),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


Color _getAnswerColor(String answer) {
  switch (answer.toLowerCase()) {
    case 'হ্যাঁ':
    case '২':
    case '২টি':
      return Colors.green;

    case 'না':
      return Colors.red;

    case 'রোগী':
      return Colors.blue;

    case 'লাশ':
      return Colors.purple;

    default:
      return Colors.grey;
  }
}

String _translateAnswer(String answer) {
  switch (answer.toLowerCase()) {
    case 'yes':
    case 'হ্যাঁ':
      return 'হ্যাঁ';

    case 'no':
    case 'না':
      return 'না';

    case 'patient':
    case 'রোগী':
      return 'রোগী';

    case 'corpse':
    case 'লাশ':
      return 'লাশ';

    case '2':
    case '২':
      return '২টি';

    default:
      return answer;
  }
}
