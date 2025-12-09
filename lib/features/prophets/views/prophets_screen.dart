import 'package:depiproject/core/constants/colors.dart';
import 'package:depiproject/core/widgets/main_app_bar.dart';
import 'package:depiproject/features/prophets/views/widgets/prophets_card.dart';
import 'package:depiproject/features/prophets/views_model/prophets_cubit/prophets_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProphetsScreen extends StatefulWidget {
  const ProphetsScreen({super.key});

  @override
  State<ProphetsScreen> createState() => _ProphetsScreenState();
}

class _ProphetsScreenState extends State<ProphetsScreen> {
  String searchText = "";

  @override
  void initState() {
    super.initState();
    context.read<ProphetsCubit>().fetchProphets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const MainAppBar(title: 'قصص الأنبياء'),
          const SizedBox(height: 16),
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "ابحث عن نبي...",
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.kPrimaryColor2,
                  size: 24,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: AppColors.kPrimaryColor2, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: AppColors.kPrimaryColor2, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: AppColors.kPrimaryColor2, width: 2)),
              ),
              onChanged: (value) {
                setState(() => searchText = value);
              },
            ),
          ),

          Expanded(
            child: BlocBuilder<ProphetsCubit, ProphetsState>(
              builder: (context, state) {
                if (state is ProphetsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProphetsFailure) {
                  return Center(child: Text("Error: ${state.error}"));
                }

                if (state is ProphetsSuccess) {
                  final filtered = state.prophets.where((p) {
                    return p.name.contains(searchText);
                  }).toList();

                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final prophet = filtered[index];
                      return ProphetCard(prophet: prophet);
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
