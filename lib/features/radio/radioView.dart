import 'package:depiproject/features/radio/cubit/cubit/radio_cubit.dart';
import 'package:depiproject/features/radio/cubit/cubit/radio_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stations = [
      {
        "name": "راديو ترتيل القرآن ",
        "url": "https://Qurango.net/radio/tarateel"
      },
    ];

    return BlocProvider(
      create: (_) => RadioCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text(" راديو القرآن الكريم")),
        body: BlocBuilder<RadioCubit, RadioState>(
          builder: (context, state) {
            final cubit = context.read<RadioCubit>();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: stations.length,
                    itemBuilder: (context, index) {
                      final station = stations[index];
                      final isPlaying = state is RadioPlaying &&
                          (state.stationName == station["name"]);

                      return ListTile(
                        leading: Icon(
                          isPlaying ? Icons.radio : Icons.play_arrow,
                          color: isPlaying ? Colors.green : Colors.grey,
                        ),
                        title: Text(
                          station["name"]!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          cubit.playStation(station["name"]!, station["url"]!);
                        },
                      );
                    },
                  ),
                ),
                const Divider(),
                if (state is RadioLoading)
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(color: Colors.green),
                  ),
                if (state is RadioPlaying)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "تشغيل: ${(state).stationName}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: cubit.stop,
                          icon: const Icon(Icons.stop),
                          label: const Text("إيقاف الإذاعة"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                      ],
                    ),
                  ),
                if (state is RadioError)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
