import 'package:flutter/material.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';

class CapsuleHeaderWidget extends StatelessWidget {
  final MediaType type;

  const CapsuleHeaderWidget({super.key, required this.type});

  String _getTitleKey() {
    switch (type) {
      case MediaType.photo:
        return 'photo_selection';
      case MediaType.video:
        return 'video_selection';
      case MediaType.voice:
        return 'audio_selection';
      case MediaType.text:
        return 'text_selection';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButtonWidget(),
        Expanded(child: PageTitle(title: context.tr(_getTitleKey()))),
      ],
    );
  }
}
