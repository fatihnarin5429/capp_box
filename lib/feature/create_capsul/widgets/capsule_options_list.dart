import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/widgets/kapsul_secenek_card.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CapsuleOptionsList extends StatelessWidget {
  const CapsuleOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCapsuleBloc, CreateCapsuleState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            KapsulSecenekCard(
              icon: 'assets/icons/write.png',
              baslik: context.tr('Write', args: {}),
              fiyat: context.tr('Free', args: {}),
              onTap: () {
                context.read<CreateCapsuleBloc>().add(
                  const CreateCapsuleMediaTypeAction(MediaType.text),
                );
              },
              tip: MediaType.text,
              secili:
                  state.mediaType ==
                  MediaType.text,
            ),
            KapsulSecenekCard(
              icon: 'assets/icons/video.png',
              baslik: context.tr('Video', args: {}),
              fiyat: '449.99 ₺',
              tip: MediaType.video,
              onTap: () {
                context.read<CreateCapsuleBloc>().add(
                  const CreateCapsuleMediaTypeAction(MediaType.video),
                );
              },
              secili:
                  state.mediaType ==
                  MediaType.video,
            ),
            KapsulSecenekCard(
              icon: 'assets/icons/ses.png',
              baslik: context.tr('Voice', args: {}),
              fiyat: '149.99 ₺',
              tip: MediaType.voice,
              onTap: () {
                context.read<CreateCapsuleBloc>().add(
                  const CreateCapsuleMediaTypeAction(MediaType.voice),
                );
              },
              secili:
                  state.mediaType ==
                  MediaType.voice,
            ),
            KapsulSecenekCard(
              icon: 'assets/icons/galeri.png',
              baslik: context.tr('Photo', args: {}),
              fiyat: '249.99 ₺',
              tip: MediaType.photo,
              onTap: () {
                context.read<CreateCapsuleBloc>().add(
                  const CreateCapsuleMediaTypeAction(MediaType.photo),
                );
              },
              secili:
                  state.mediaType ==
                  MediaType.photo,
            ),
            const SizedBox(height: 30),
          ],
        );
      },
    );
  }
}
