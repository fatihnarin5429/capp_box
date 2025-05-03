import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:intl/intl.dart';
import 'review_container.dart';

class CapsuleDateInfo extends StatelessWidget {
  final CreateCapsuleState state;

  const CapsuleDateInfo({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: ReviewContainer(
            height: 50,
            width: 330,
            child: Center(
              child: Text(
                context.tr('capsule_open_date') +
                    ': '
                        '${state.createCapsuleModel.openedDate == null ? '' : DateFormat('dd.MM.yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(int.parse(
                                state.createCapsuleModel.openedDate!)),
                          )}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: ReviewContainer(
            height: 50,
            width: 330,
            child: Center(
              child: Text(
                context.tr('capsule_open_time') +
                    ': '
                        '${state.createCapsuleModel.openedDate == null ? '' : DateFormat('HH.mm').format(
                            DateTime.fromMillisecondsSinceEpoch(int.parse(
                                state.createCapsuleModel.openedDate!)),
                          )}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
