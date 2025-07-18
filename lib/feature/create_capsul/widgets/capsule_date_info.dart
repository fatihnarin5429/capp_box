import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:intl/intl.dart';
import 'review_container.dart';

class CapsuleDateInfo extends StatelessWidget {
  final CreateCapsuleState state;

  const CapsuleDateInfo({Key? key, required this.state}) : super(key: key);

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
<<<<<<< HEAD
                '${context.tr('capsule_open_date')}: ${DateFormat('dd.MM.yyyy').format(DateTime.parse(state.createCapsuleResponseModel.data.capsule.openDate.toString()))}',
=======
                '${context.tr('capsule_open_date')}: ${DateFormat('dd.MM.yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(state.createCapsuleBodyModel?.openDate ?? '')))}',
>>>>>>> 69fae8ba02711afe6ca03ebb2bc150fbd4c0113b
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
<<<<<<< HEAD
                '${context.tr('capsule_open_time')}: ${state.createCapsuleResponseModel.data.capsule.openDate == null ? '' : DateFormat('HH.mm').format(DateTime.parse(state.createCapsuleResponseModel.data.capsule.openDate.toString()))}',
=======
                '${context.tr('capsule_open_time')}: ${state.createCapsuleBodyModel?.openDate == null ? '' : DateFormat('HH.mm').format(DateTime.fromMillisecondsSinceEpoch(int.parse(state.createCapsuleBodyModel!.openDate!)))}',
>>>>>>> 69fae8ba02711afe6ca03ebb2bc150fbd4c0113b
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
