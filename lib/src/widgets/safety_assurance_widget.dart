import 'package:flutter/material.dart';
import 'package:pickup_load_update/src/widgets/safety_assurance_details.dart';
import 'package:pickup_load_update/src/widgets/status_widget.dart';

class SafetyAssuranceWidget extends StatelessWidget {
  const SafetyAssuranceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatusWidget(
          icon: Icons.health_and_safety_outlined,
          iconColor: Colors.black,
          bgColors: Colors.green.withOpacity(0.3),
          statusTitle: 'Safety Assurance',
          textColor: Colors.black,
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(child: CustomBottomSheetInsuranceWidget());
              },
            );
          },
          child: StatusWidget(
            icon: Icons.arrow_drop_down,
            iconColor: Colors.black,
            bgColors: Colors.greenAccent.withOpacity(0.3),
            statusTitle: 'View Details',
            textColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
