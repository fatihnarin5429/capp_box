import 'package:flutter/material.dart';
import 'package:capp_box/feature/package/widgets/profile_widgets.dart';
import 'package:capp_box/feature/profile/view/gizlilik_view.dart';
import 'package:capp_box/feature/profile/view/help_View.dart';

class PrivacySectionWidget extends StatelessWidget {
  const PrivacySectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            'Gizlilik & Güvenlik',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileListTile(
                leadingIcon: 'assets/images/secure.png',
                title: 'Gizlilik',
                subtitle: 'Gizlilik',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const GizlilikView())),
              ),
              ProfileListTile(
                leadingIcon: 'assets/images/help.png',
                title: 'Yardım',
                subtitle: 'Yardım',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HelpView())),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
