import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

const primaryColor = Color.fromRGBO(206, 1,44, 1);
final titleColor = Color.fromRGBO(250, 92, 92, 1.0);
final primaryColor50 = HexColor('#ffe6e5');
final secondaryColor = Color(0xFF1262b);
final bgColor = Color(0xFFf2f2f2);
final grey = Colors.grey;
final white = Colors.white;
final white54 = Colors.white54;
final black = Colors.black;
final black54 = Colors.black54;
final black45 = Colors.black45;
final transparent = Colors.transparent;

final greyBackgroundColor = HexColor('#f2f2f2');


final List<Map<String, dynamic>> medicalServices = [
  {
    'title': 'পিকআপ লোকেশন কি হাসপাতাল/ডায়াগনস্টিক সেন্টার/ক্লিনিক?',
    'answer': 'হ্যাঁ',
    'icon': Icons.local_hospital,
    'color': Colors.red,
  },
  {
    'title': 'গাড়ির ধরন?',
    'answer': 'রোগী',
    'icon': Icons.airline_seat_recline_normal,
    'color': Colors.blue,
  },
  {
    'title':
    'কতটি অক্সিজেন সিলিন্ডার প্রয়োজন হবে? (১টি সিলিন্ডার সবসময় থাকে)',
    'answer': '২',
    'icon': Icons.medical_services,
    'color': Colors.green,
  },
  {
    'title':
    'মরদেহ/লাশ অপসারণের জন্য আলাদা ফি প্রযোজ্য হবে (বিড মূল্যের অন্তর্ভুক্ত নয়)',
    'answer': 'না',
    'icon': Icons.money_off,
    'color': Colors.orange,
  },
  {
    'title':
    'রোগীকে ওঠা-নামার জন্য কি হুইলচেয়ার প্রয়োজন হবে? (সবসময় ৪ জন সহায়তাকারী থাকে)',
    'answer': 'হ্যাঁ',
    'icon': Icons.wheelchair_pickup,
    'color': Colors.purple,
  },
  {
    'title': 'আইসিইউ-তে ডাক্তার প্রয়োজন, নাকি শুধু অ্যাম্বুলেন্স?',
    'answer': 'না',
    'icon': Icons.medical_information,
    'color': Colors.teal,
  },
];