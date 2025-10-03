import 'package:depiproject/core/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: ListView(
          children: [
            const Row(
              children: [
                Icon(Icons.account_circle, color: Colors.green, size: 30),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'يمني سيد',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'example@gmail.com',
                      style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            CustomDrawerItem(
              icon: Icons.home,
              text: 'الرئيسية',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            CustomDrawerItem(
              icon: Icons.account_circle,
              text: 'الحساب الشخصي',
              onTap: () {},
            ),
            CustomDrawerItem(
              icon: Icons.bookmark_border,
              text: 'المحفوظات',
              onTap: () {},
            ),
            CustomDrawerItem(
              icon: Icons.notifications_on_sharp,
              text: 'الاشعارات',
              onTap: () {},
            ),
            CustomDrawerItem(
              icon: Icons.settings,
              text: 'الاعدادات',
              onTap: () {},
            ),
            CustomDrawerItem(
              icon: Icons.logout,
              text: 'تسجيل الخروج',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final IconData icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.kPrimaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: AppColors.kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
