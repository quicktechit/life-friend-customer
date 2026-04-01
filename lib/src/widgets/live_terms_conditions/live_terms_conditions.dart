import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool?> showLiveTerms(BuildContext context) {
  return showModalBottomSheet<bool>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar for better UX
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "যাত্রী বুকিং শর্তাবলী",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    icon: const Icon(Icons.close),
                    splashRadius: 24,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Terms text with improved formatting
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Text(
                          "যাত্রী বুকিং কনফার্ম করার সময় সূত্র মেনে একটা বুকিং মানি জমা হবে। আর ওই সময় আমরা জানাবঃ আমি নিশ্চিত করছি যে- \n\n"
                              "• গাড়ি পৌঁছানোর পর পিক আপ লোকেশনে ২০ মিনিট, মাঝের প্রতিটি স্টপ লোকেশনে ১০ মিনিট (যদি বুকিং এর সময় এড করা থাকে তাহলে প্রযোজ্য হবে) ও ড্রপ অফ লোকেশনে ২০ মিনিটের বেশি সময় ওয়েটিং হলে আমি Riderr কর্তৃক নির্ধারিত হারে ওয়েটিং চার্জ (বিডিং কৃত ভাড়ায় অন্তর্ভুক্ত নয়) ড্রাইভারকে সরাসরি প্রদান করিব (যদি প্রযোজ্য হয়)। আপ-ডাউন ট্রিপে মাঝের পূর্ব নির্ধারিত সময়ের জন্য আলাদা ওয়েটিং চার্জ প্রযোজ্য নয়, তবে নির্ধারিত সময়ের বেশি হলে আলাদা ওয়েটিং চার্জ প্রযোজ্য । \n\n"
                              "• আমি Riderr কর্তৃক নির্ধারিত হারে লেবার চার্জ (বিডিং কৃত ভাড়ায় অন্তর্ভুক্ত নয়) ড্রাইভারকে সরাসরি প্রদান করিব (যদি প্রযোজ্য হয়)।\n\n"
                              "• আমি Riderr প্লাটফর্মের সেবার সকল শর্তাবলীতে রাজি। Riderr প্লাটফর্মের বাহিরে / বুকিং এর সময় উল্লিখিত সেবার বাহিরের জন্য Riderr কে দায়ী/ অনুরোধ করিব না এবং কোনোপ্রকার রিফান্ড দাবি করিব না / প্রদান করা হইবে না। \n\n"
                              "• আমি বুঝেছি যে, এই বুকিং এ যা যা সেবা উল্লেখ আছে তাহা অপরিবর্তনীয়। আমার দ্বারা এই ট্রিপের জন্য প্রদত্ত সকল তথ্য সঠিক এবং কোনোরুপ ভুল বা অসম্পূর্ণ তথ্যের জন্য Riderr কর্তৃপক্ষ সেবা প্রদানে ব্যর্থ হলে তার সম্পূর্ণ দায়ভার আমার। আমার ভুলের জন্য Riderr কোম্পানিকে দায়ী থাকিবে না এবং কোনোপ্রকার রিফান্ড দাবি করিব না/ প্রদান করা হইবে না। \n\n"
                              "এরপর সম্মত থাকলে পেমেন্ট গেটওয়েতে নিয়ে যান। বুকিং মানি রাখেন। ড্রাইভার, পেসেঞ্জার নাম্বার ,নাম শেয়ার করেন।  বুকিং মানি নেবার আগে এই নাম্বারটা কেউ কারোটা জানবে না।",
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Info Cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoCard(
                              context,
                              title: "লেবার চার্জ",
                              icon: Icons.construction,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildInfoCard(
                              context,
                              title: "ওয়েটিং চার্জ",
                              icon: Icons.timer,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text(
                                "কনফার্ম",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: const BorderSide(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text(
                                "বাতিল",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Disclaimer
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18,
                              color: Colors.amber[700],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "শর্তাবলী পড়ে নিশ্চিত করুন। কনফার্ম করার পর বুকিং ফি নেয়া হবে।",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.amber[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildInfoCard(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Color color,
}) {
  return GestureDetector(
    onTap: () {
      if (title == "লেবার চার্জ") {
        _showLaborChargeDialog(context);
      } else if (title == "ওয়েটিং চার্জ") {
        _showWaitingChargeDialog(context);
      } else {
        showOptionDialog(context, title);
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_forward_ios, size: 12, color: color),
        ],
      ),
    ),
  );
}

void _showWaitingChargeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text(
        "ওয়েটিং চার্জ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "অতিরিক্ত সময় অপেক্ষার চার্জের হার:",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Table(
                border: TableBorder.all(color: Colors.grey[300]!),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    children: [
                      _buildTableCell("ক্যাটাগরি", isHeader: true),
                      _buildTableCell("প্রতি মিনিট (টাকা)", isHeader: true),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildTableCell("এসি এযাম্বেলল"),
                      _buildTableCell("৮"),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildTableCell("লাশবাহী জিলিঃ সিংগেল কেবিন"),
                      _buildTableCell("৮"),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildTableCell("লাশবাহী জিলিঃ ডাবল কেবিন"),
                      _buildTableCell("৮"),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildTableCell("আইসিড এযাম্বেলল"),
                      _buildTableCell("১০"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "নোট: নির্ধারিত সময়ের অতিরিক্ত ওয়েটিং এর জন্য এই চার্জ প্রযোজ্য হবে।",
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("বন্ধ করুন"),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

void _showLaborChargeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text(
        "লেবার চার্জ",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "মালামাল উঠানো/ নামানোর চার্জের হার:",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Table(
                border: TableBorder.all(color: Colors.grey[300]!),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1.5),
                  2: FlexColumnWidth(1.5),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    children: [
                      _buildTableCell("ক্যাটাগরি", isHeader: true),
                      _buildTableCell(
                        "১ জন লেবার ১ ফ্লোর  ১ বার উঠাতে (টাকা)",
                        isHeader: true,
                      ),
                      _buildTableCell(
                        "১ জন লেবার ১ ফ্লোর  ১ বার নামাতে (টাকা)",
                        isHeader: true,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildTableCell("এসি এযান্সেল"),
                      _buildTableCell("১০০"),
                      _buildTableCell("১০০"),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildTableCell("লাশবাহী জিলিঃ সিংগল কেবিন"),
                      _buildTableCell("১০০"),
                      _buildTableCell("১০০"),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildTableCell("লাশবাহী জিলিঃ ডাবল কেবিন"),
                      _buildTableCell("১০০"),
                      _buildTableCell("১০০"),
                    ],
                  ),
                  TableRow(
                    children: [
                      _buildTableCell("আইসিটি এযান্সেল"),
                      _buildTableCell("১০০"),
                      _buildTableCell("১০০"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "নোট: প্রতি বার উঠানো/ নামানোর জন্য এই চার্জ প্রযোজ্য হবে।",
                style: TextStyle(fontSize: 12, color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("বন্ধ করুন"),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

Widget _buildTableCell(String text, {bool isHeader = false}) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal,
        color: isHeader ? Colors.black87 : Colors.grey[800],
      ),
      textAlign: TextAlign.center,
    ),
  );
}

void showOptionDialog(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: const Text("Text will be provided later."),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    ),
  );
}
