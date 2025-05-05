import 'package:capp_box/core/extensions/localization_extension.dart';
import 'package:capp_box/core/l10n/languages/tr.dart';
import 'package:capp_box/feature/create_capsul/view/create_capsul_view.dart';
import 'package:capp_box/feature/create_capsul/widgets/continue_button.dart';
import 'package:capp_box/feature/create_capsul/widgets/capsule_options_list.dart';
import 'package:capp_box/feature/home/service/capsule_service.dart';
import 'package:capp_box/feature/home/widgets/capsule_card.dart';
import 'package:capp_box/feature/package/widgets/custom_navigation_bar.dart';
import 'package:capp_box/product/constants/color_cons.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:capp_box/product/utility/enums/mediaType_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/create_capsul/bloc/create_capsule_bloc.dart';
import 'package:capp_box/feature/create_capsul/model/create_capsule_model.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

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

class _HomeView2ContentState extends State<_HomeView2Content> {
  MediaType? secilenTip;
  bool premiumOdendi = true; // Bu değer ödeme durumuna göre yönetilmeli
  late AnimatedMeshGradientController _gradientController;

  @override
  void initState() {
    print(
        'state4: ${context.read<CreateCapsuleBloc>().state.myCreatedCapsules}');
    super.initState();
    _gradientController = AnimatedMeshGradientController();
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
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
                    // Üst profil bilgileri
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                'assets/icons/menu.png',
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Container(
                              width: 40,
                              height: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                "https://picsum.photos/200/300",
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Merhaba',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Erva',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Kapsül oluşturma başlığı
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "Bugün ne oluşturmak istersin?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    // Kapsül oluşturma seçenekleri
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildOptionCard(
                                icon: 'assets/icons/write.png',
                                title: 'Yazı',
                                isPremium: false,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateCapsulView(),
                                    ),
                                  );
                                },
                              ),
                              _buildOptionCard(
                                icon: 'assets/icons/video.png',
                                title: 'Video',
                                isPremium: true,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateCapsulView(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildOptionCard(
                                icon: 'assets/icons/ses.png',
                                title: 'Ses',
                                isPremium: true,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateCapsulView(),
                                    ),
                                  );
                                },
                              ),
                              _buildOptionCard(
                                icon: 'assets/icons/galeri.png',
                                title: 'Fotoğraf',
                                isPremium: true,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateCapsulView(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Oluşturulan Kapsüller Başlığı
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, top: 40, bottom: 20),
                      child: Text(
                        "Oluşturduğun Kapsüller",
                        style: TextStyle(
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
                      child: BlocBuilder<CreateCapsuleBloc, CreateCapsuleState>(
                        builder: (context, state) {
                          print('state: ${state.myCreatedCapsules}');

                          if (state.myCreatedCapsules.isEmpty) {
                            return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 30),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.inbox_outlined,
                                    size: 60,
                                    color: Colors.white54,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Henüz oluşturduğun kapsül bulunmuyor",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Urbanist',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return SizedBox(
                            height:
                                300, // CapsuleCard'ın yüksekliğine göre ayarlayın
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.myCreatedCapsules.length,
                              itemBuilder: (context, index) {
                                final capsule = state.myCreatedCapsules[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: CapsuleCard(
                                    senderName: capsule.displayName ?? "Anonim",
                                    imageUrl:
                                        "https://picsum.photos/200/300", // varsayılan bir resim
                                    timerWidget: _buildTimeWidget(capsule),
                                    controller: _gradientController,
                                    isReadyToOpen:
                                        _isCapsuleReadyToOpen(capsule),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
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

  bool _isCapsuleReadyToOpen(CreateCapsuleModel capsule) {
    // Açılma tarihi geçmiş mi kontrolü
    if (capsule.openedDate == null) return false;

    // openedDate bir String olduğu için DateTime'a çevirip kontrol etmemiz gerekiyor
    try {
      final openDateMillis = int.tryParse(capsule.openedDate!);
      if (openDateMillis == null) return false;

      final openDate = DateTime.fromMillisecondsSinceEpoch(openDateMillis);
      return DateTime.now().isAfter(openDate);
    } catch (e) {
      return false;
    }
  }

  Widget _buildTimeWidget(CreateCapsuleModel capsule) {
    // Kapsülün açılma tarihine kalan süreyi gösteren widget
    if (capsule.openedDate == null) {
      return const Text(
        "Tarih Belirsiz",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    // Süre hesaplaması yapılabilir
    return const Text(
      "Yakında\nAçılacak",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildOptionCard({
    required String icon,
    required String title,
    required bool isPremium,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.43,
        height: 140,
        decoration: BoxDecoration(
          color: const Color(0xFF262741),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: title == 'Yazı'
                      ? const Color(0xFF4052EE)
                      : title == 'Video'
                          ? const Color(0xFFD93B3B)
                          : title == 'Ses'
                              ? const Color(0xFF58D65A)
                              : const Color(0xFF9747FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    icon,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isPremium ? 'Premium' : 'Ücretsiz',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
