mixin Onboard1Mixin {
  void init() {
    print('init');
  }

  bool isLoading = false;
}

class MyClass with Onboard1Mixin {
  // ... sınıf içeriği
}
