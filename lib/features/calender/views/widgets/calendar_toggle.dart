import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/features/calender/views/widgets/custom_choise_chip.dart';
import 'package:depiproject/features/calender/views_model/calendar_cubit/calendar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarToggle extends StatelessWidget {
  const CalendarToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final cubit = context.read<CalendarCubit>();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomChoiceChip(
              label: "الهجري",
              isSelected: cubit.isHijri,
              onTap: () => cubit.toggleCalendar(true),
              primaryColor: AppColors.kPrimaryColor,
              selectedColor: AppColors.kPrimaryColor2,
            ),
            const SizedBox(width: 12),
            CustomChoiceChip(
              label: "الميلادي",
              isSelected: !cubit.isHijri,
              onTap: () => cubit.toggleCalendar(false),
              primaryColor: AppColors.kPrimaryColor,
              selectedColor: AppColors.kPrimaryColor2,
            ),
          ],
        );
      },
    );
  }
}

