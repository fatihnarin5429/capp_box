import 'package:capp_box/feature/home/mixin/home_view_mixin.dart';
import 'package:capp_box/feature/home/widgets/created_capsules_list.dart';
import 'package:capp_box/feature/home/widgets/media_options_grid.dart';
import 'package:capp_box/feature/home/widgets/profile_header_widget.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';

/// The main home screen of the application.
///
/// This screen displays the user's profile, capsule creation options,
/// and the list of created capsules.
class HomeView2 extends StatelessWidget {
  const HomeView2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCapsuleBloc, CreateCapsuleState>(
      builder: (context, state) {
        return const _HomeView2Content();
      },
    );
  }
}

class _HomeView2Content extends StatefulWidget {
  const _HomeView2Content();

  @override
  State<_HomeView2Content> createState() => _HomeView2ContentState();
}

class _HomeView2ContentState extends State<_HomeView2Content>
    with HomeViewMixin {
  MediaType? secilenTip;
  bool premiumOdendi = true; // Bu değer ödeme durumuna göre yönetilmeli

  @override
  void initState() {
    super.initState();
    // Mixin'deki initState metodunu çağırmak gerekmiyor, super.initState() ile otomatik çağrılıyor
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            const BackgroundGradient(),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    const ProfileHeaderWidget(
                      username: 'Erva',
                      profileImageUrl: "https://picsum.photos/200/300",
                    ),

                    // Media Options Grid
                    const MediaOptionsGrid(),

                    // Created Capsules List
                    CreatedCapsulesList(
                      gradientController: gradientController,
                      buildTimeWidget: buildTimeWidget,
                      isCapsuleReadyToOpen: isCapsuleReadyToOpen,
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
