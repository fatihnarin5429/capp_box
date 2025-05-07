import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:capp_box/feature/home/widgets/capsule_card.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

/// A widget that displays the list of capsules created by the user.
class CreatedCapsulesList extends StatelessWidget {
  final AnimatedMeshGradientController gradientController;
  final Function(CreateCapsuleModel) buildTimeWidget;
  final Function(CreateCapsuleModel) isCapsuleReadyToOpen;

  const CreatedCapsulesList({
    super.key,
    required this.gradientController,
    required this.buildTimeWidget,
    required this.isCapsuleReadyToOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Oluşturulan Kapsüller Başlığı
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 40, bottom: 20),
          child: Text(
            context.tr('Your_Created_Capsules', args: {}),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // Oluşturulan Kapsüller Listesi
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<CreateCapsuleBloc, CreateCapsuleState>(
            builder: (context, state) {
              if (state.myCreatedCapsules.isEmpty) {
                return _buildEmptyCapsulesList(context);
              }

              return _buildCapsulesList(context, state.myCreatedCapsules);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCapsulesList(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inbox_outlined,
            size: 60,
            color: Colors.white54,
          ),
          const SizedBox(height: 16),
          Text(
            context.tr('No_Capsules_Created_Yet'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Urbanist',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCapsulesList(
      BuildContext context, List<CreateCapsuleModel> capsules) {
    return SizedBox(
      height: 300, // CapsuleCard'ın yüksekliğine göre ayarlayın
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: capsules.length,
        itemBuilder: (context, index) {
          final capsule = capsules[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CapsuleCard(
              senderName:
                  capsule.displayName ?? context.tr('anonymous', args: {}),
              imageUrl: "https://picsum.photos/200/300", // varsayılan bir resim
              timerWidget: buildTimeWidget(capsule),
              controller: gradientController,
              isReadyToOpen: isCapsuleReadyToOpen(capsule),
            ),
          );
        },
      ),
    );
  }
}
