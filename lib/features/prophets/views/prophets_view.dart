import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/prophets/views/widgets/prophets_list.dart';
import 'package:depiproject/features/prophets/views_model/prophets_cubit/prophets_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProphetsView extends StatelessWidget {
  const ProphetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProphetsCubit()..fetchProphets(),
      child: const Scaffold(
        body: Column(
          children: [
            MainAppBar(title: 'الأنبياء'),
            Expanded(
              child: ProphetsList(),
            ),
          ],
        ),
      ),
    );
  }
}
