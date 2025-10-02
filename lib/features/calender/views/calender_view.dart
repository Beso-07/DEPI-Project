import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/calender/views/widgets/calendar_toggle.dart';
import 'package:depiproject/features/calender/views/widgets/calendar_widget.dart';
import 'package:depiproject/features/calender/views_model/calendar_cubit/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => CalendarCubit(),
      child: Scaffold(
        body: Column(
          children: [
            const MainAppBar(title: 'التقويم'),
            SizedBox(height: height * .01),
            const CalendarToggle(),
            SizedBox(height: height * .03),
            const CalendarWidget(),
          ],
        ),
      ),
    );
  }
}
