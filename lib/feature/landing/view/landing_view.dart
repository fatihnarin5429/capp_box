import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capp_box/feature/landing/bloc/landing_bloc.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    // Fade animasyonu
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Pulse animasyonu
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Animasyonları başlat
    _fadeController.forward();
    _pulseController.repeat(reverse: true);
    
    // Sayfa açıldığında initialize event'i tetikle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LandingBloc>().add(LandingInitializeEvent());
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LandingBloc, LandingState>(
      listener: (context, state) {
        if (state.isInitialized && !state.userChecked) {
          // Database başlatıldıktan sonra ve henüz user check yapılmamışsa kullanıcı kontrolü yap
          context.read<LandingBloc>().add(LandingCheckUserEvent());
        }
        
        if (state.navigationPath != null) {
          // Navigation path geldiğinde yönlendir
          Navigator.pushReplacementNamed(context, state.navigationPath!);
        }
      },
      child: BlocBuilder<LandingBloc, LandingState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFB224EF), // Mor
                    Color(0xFFFF15A1), // Pembe
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo animasyonu
                    AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(60),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.asset(
                                      'assets/icons/logo.png',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Yükleniyor yazısı
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: const Text(
                        'Capp Box',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Loading indicator
                    if (state.isLoading)
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: const Column(
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 3,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Yükleniyor...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
