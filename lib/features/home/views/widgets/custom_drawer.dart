import 'package:depiproject/core/widgets/logout_dialog.dart';
import 'package:depiproject/features/qiblah/views/qiblah_view.dart';
import 'package:depiproject/features/settings/model_view/cubit/theme_cubit.dart';
import 'package:depiproject/features/Archives/View/archive_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    final isDark = cubit.state.brightness == Brightness.dark;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: ListView(
          children: [
            // const Row(
            //   children: [
            //     Icon(Icons.account_circle, color: Colors.green, size: 30),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           'يمني سيد',
            //           style: TextStyle(fontSize: 18),
            //         ),
            //         Text(
            //           'example@gmail.com',
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         )
            //       ],
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: height * 0.05,
            // ),

            const SizedBox(
              height: 40,
            ),
            CustomDrawerItem(
              icon: Icons.home,
              text: 'الرئيسية',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            CustomDrawerItem(
              icon: Icons.explore,
              text: "القبلة",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QiblahView()),
                );
              },
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
              icon: Icons.logout,
              text: 'تسجيل الخروج',
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LogoutDialog();
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: cubit.toggleTheme,
                icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
                label: Text(
                    isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode'),
              ),
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
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
