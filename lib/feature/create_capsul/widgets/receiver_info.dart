import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/feature/create_capsul/widgets/review_container.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';

class ReceiverInfo extends StatelessWidget {
  final CreateCapsuleState state;

  const ReceiverInfo({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReviewContainer(
      height: 82,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                context.tr('recipient', args: {}),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                state.createCapsuleResponseModel.data?.capsule.recipientUser ??
                    context.tr('recipient_name', args: {}),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                context.tr('mail', args: {}),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                state.createCapsuleResponseModel.recipientEmail,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
