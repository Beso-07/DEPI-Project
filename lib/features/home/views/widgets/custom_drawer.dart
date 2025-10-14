import 'package:depiproject/core/constants/assets.dart';
import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/Archives/View/archive_view.dart';
import 'package:depiproject/features/Auth/views/login_screen.dart';
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ArchiveView()),
                );
              },
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
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "تقوى",
                              style: TextStyle(
                                fontFamily: "lateef",
                                fontSize: 20,
                              ),
                            ),
                            Image.asset(
                              Imagespath.quran,
                              width: 60,
                              height: 35,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "هل حقًا تريد تسجيل الخروج؟",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.kPrimaryColor2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("تم تسجيل الخروج بنجاح✅"),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  child: const Text("نعم",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("لا",
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
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
