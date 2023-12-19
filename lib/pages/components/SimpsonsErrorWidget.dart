import 'package:anywhere_list_app/bloc/SimpsonsListBloc.dart';
import 'package:anywhere_list_app/main.dart';
import 'package:anywhere_list_app/utils.dart';
import 'package:flutter/material.dart';

class SimpsonsErrorWidget extends StatelessWidget {
  const SimpsonsErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(errorImagePath),
          ),
          const SizedBox(height: 16),
          Text(
            errorText,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          RawMaterialButton(
            fillColor: Colors.lightBlue[300],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            onPressed: () {
              serviceLocator<SimpsonsBloc>()
                  .add(GetSimpsonsCharactersListEvent());
            },
            child: const Icon(Icons.refresh, size: 48, color: Colors.yellow),
          ),
        ],
      ),
    );
  }
}
