import 'package:capp_box/feature/create_capsul/model/get_capsule_response_model.dart';
import 'package:capp_box/feature/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/home/widgets/capsule_card.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

/// A widget that displays the list of capsules created by the user.
class CreatedCapsulesList extends StatelessWidget {
  final AnimatedMeshGradientController gradientController;
  final Function(CapsuleModel) buildTimeWidget;
  final Function(CapsuleModel) isCapsuleReadyToOpen;

  const CreatedCapsulesList({
    super.key,
    required this.gradientController,
    required this.buildTimeWidget,
    required this.isCapsuleReadyToOpen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
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
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.capsules?.isEmpty ?? true) {
                    return _buildEmptyCapsulesList(context);
                  }

                  return _buildCapsulesList(context, state);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmptyCapsulesList(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_outlined, size: 60, color: Colors.white54),
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
    BuildContext context,
    HomeState state,
  ) {
    return SizedBox(
      height: 300, // CapsuleCard'ın yüksekliğine göre ayarlayın
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.capsules?.length ?? 0,
        itemBuilder: (context, index) {
          final capsule = state.capsules?[index];
          if (capsule == null) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CapsuleCard(
              senderName:
                  capsule?.sender?.name ??
                  context.tr('anonymous', args: {}),
              imageUrl: "https://picsum.photos/200/300", // varsayılan bir resim
              timerWidget: buildTimeWidget(capsule),
              controller: gradientController,
              isReadyToOpen: isCapsuleReadyToOpen(capsule),
              cardSize: CapsuleCardSize.small,
            ),
          );
        },
      ),
    );
  }
}
