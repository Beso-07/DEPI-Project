import 'package:depiproject/features/prophets/views/widgets/prophets_name_list.dart';
import 'package:depiproject/features/prophets/views_model/prophets_cubit/prophets_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProphetsList extends StatelessWidget {
  const ProphetsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProphetsCubit, ProphetsState>(
      builder: (context, state) {
        if (state is ProphetsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProphetsSuccess) {
          final prophets = state.prophets;
          return ProphestNamelist(prophets: prophets);
        } else if (state is ProphetsFailure) {
          return Center(child: Text(state.error));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

