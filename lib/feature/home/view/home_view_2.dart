import 'package:capp_box/feature/home/bloc/home_bloc.dart';
import 'package:capp_box/feature/home/mixin/home_view_mixin.dart';
import 'package:capp_box/feature/home/widgets/created_capsules_list.dart';
import 'package:capp_box/feature/home/widgets/media_options_grid.dart';
import 'package:capp_box/feature/home/widgets/profile_header_widget.dart';
import 'package:capp_box/feature/home/widgets/timer_display_widget.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The main home screen of the application.
///
/// This screen displays the user's profile, capsule creation options,
/// and the list of created capsules.
class HomeView2 extends StatefulWidget {
  const HomeView2({super.key});

  @override
  State<HomeView2> createState() => _HomeView2State();
}

class _HomeView2State extends State<HomeView2> with HomeViewMixin {
  @override
  void initState() {
    context.read<HomeBloc>().add(const HomeGetCapsules());
    super.initState();
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
                    ProfileHeaderWidget(
                      username:
                          context.read<HomeBloc>().state.userModel?.name ??
                          'Beyza',
                      profileImageUrl: "https://picsum.photos/200/300",
                    ),

                    // Media Options Grid
                    const MediaOptionsGrid(),

                    // Created Capsules List
                    CreatedCapsulesList(
                      gradientController: gradientController,
                      buildTimeWidget:
                          (capsule) => TimerDisplayWidget(
                            openDate: capsule.openDate.toString(),
                          ),
                      isCapsuleReadyToOpen:
                          (capsule) => isCapsuleReadyToOpen(capsule),
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
