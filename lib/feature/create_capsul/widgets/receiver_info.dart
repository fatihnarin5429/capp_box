import 'package:capp_box/feature/create_capsul/widgets/review_container.dart';
import 'package:flutter/material.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';

class ReceiverInfo extends StatelessWidget {
  final CreateCapsuleState state;

  const ReceiverInfo({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReviewContainer(
      height: 82,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Alıcı: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                state.createCapsuleModel.displayName ?? 'Alıcı Adı',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text(
                'Mail: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                state.createCapsuleModel.email ?? 'E-posta sağlanmadı',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
