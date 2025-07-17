import 'package:flutter/material.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:capp_box/core/extensions/localization_extension.dart';
import 'review_container.dart';

class CapsuleTitle extends StatelessWidget {
  final CreateCapsuleState state;

  const CapsuleTitle({Key? key, required this.state, required String title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReviewContainer(
      child: Column(
        mainAxisAlignment:
            state.mediaType ==
                    MediaType.text
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.createCapsuleBodyModel?.title ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w800,
              height: 1.50,
            ),
          ),
          const SizedBox(height: 8),
          ExpandableText(
            text: state.createCapsuleBodyModel?.message ?? '',
            collapsedLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.52,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int collapsedLines;
  final TextStyle style;

  const ExpandableText({
    Key? key,
    required this.text,
    this.collapsedLines = 2,
    required this.style,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : widget.collapsedLines,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: widget.style,
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? context.tr('show_less') : context.tr('show_more'),
            style: widget.style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
