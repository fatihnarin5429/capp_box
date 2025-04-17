import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

class GizlilikView extends StatefulWidget {
  const GizlilikView({super.key});

  @override
  State<GizlilikView> createState() => _GizlilikViewState();
}

class _GizlilikViewState extends State<GizlilikView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          BackgroundGradient(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: BackButtonWidget(),
                        ),
                        PageTitle(title: 'Gizlilik'),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        '1. Toplanan Veriler\n\nCappbox, kullanıcı deneyimini geliştirmek ve kapsül hizmetlerini sunmak için aşağıdaki verileri toplayabilir:\n• Ad, soyad, e-posta, telefon numarası\n• Profil fotoğrafı (isteğe bağlı)\n• Kapsül içerikleri (video, fotoğraf, yazı, ses)\n• Cihaz bilgileri ve kullanım analitiği (gizlilik politikaları çerçevesinde)\n\n2. Verilerin Kullanım Amacı\n\n• Kapsül oluşturma ve zamanlama işlemlerini gerçekleştirmek\n• Alıcılara zamanında bildirim ve içerik iletimi sağlamak\n• İçerik güvenliğini sağlamak (şifreleme vb.)\n• Kullanıcıya özel içerik önerileri sunmak (yapay zekâ destekli)\n\n3. Üçüncü Taraflarla Paylaşım\n\nKullanıcı verileri, yalnızca aşağıdaki durumlarda üçüncü taraflarla paylaşılabilir:\n• Yasal yükümlülükler kapsamında resmi mercilere\n• Kullanıcının açık rızasıyla paylaşılması\n• Hizmetin sağlanabilmesi için teknik destek sağlayıcıları ile\n\n4. Veri Güvenliği\n\n• Veriler, endüstri standartlarına uygun olarak şifreli biçimde saklanır.\n• Erişim kontrol sistemleri ve güvenlik duvarları kullanılır.\n• İçerikler yalnızca belirlenen tarih ve alıcılara açılır.\n\n5. Kullanıcı Hakları\n\nKullanıcılar;\n• Verilerine erişme\n• Verilerini düzeltme\n• Verilerini silme\n• Veri işlemeye itiraz etme haklarına sahiptir.\n\n6. Çerez Politikası\n\nUygulama içinde kullanıcı deneyimini geliştirmek için analiz çerezleri kullanılabilir. İzinler kullanıcıdan açıkça alınır.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
