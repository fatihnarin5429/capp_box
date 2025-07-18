import 'package:capp_box/feature/home/view/home_view_2.dart';
import 'package:capp_box/feature/login/bloc/login_bloc.dart';
import 'package:capp_box/feature/login/view/login_form_view.dart';
import 'package:capp_box/feature/login/view/register_form_view.dart';
import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/product/database/hive/core/hive_database_manager.dart';
import 'package:capp_box/product/utility/enums/status_enum.dart';

import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final HiveDatabaseManager hiveDatabaseManager = HiveDatabaseManager();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async{
        if (state.status == StatusEnum.success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeView2()),
          );
          await hiveDatabaseManager.getUserModel();
        }
        if (state.status == StatusEnum.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('İşlem başarısız')));
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              const BackgroundGradient(),
              SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                              right: 0,
                              left: 0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: BackButtonWidget(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTabBar(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _buildTabBarView(),
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
  }

  Widget _buildTabBar() {
    return TabBar(
      unselectedLabelColor: const Color(0xFF929395),
      labelColor: Colors.white,
      indicatorColor: const Color(0xFF832893),
      indicatorWeight: 0,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(
        color: const Color(0xFF832893),
        borderRadius: BorderRadius.circular(20),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
      controller: _tabController,
      tabs: _buildTabs(),
    );
  }

  List<Widget> _buildTabs() {
    return const [
      Tab(
        child: Text(
          'Kayıt Ol',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Tab(
        child: Text(
          'Giriş Yap',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ];
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SingleChildScrollView(
          child: RegisterFormView(
            emailController: _emailController,
            passwordController: _passwordController,
            passwordConfirmController: _passwordConfirmController,
            nameController: _nameController,
            onRegisterSuccess: () {
              print('işlem başarılı');
            },
          ),
        ),
        SingleChildScrollView(
          child: LoginFormView(
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ),
      ],
    );
  }
}
