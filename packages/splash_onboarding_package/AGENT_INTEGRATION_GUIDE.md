# Splash Onboarding Package - Agent Integration Guide

Bu dokuman, bir kod agent'inin `splash_onboarding_package` paketini yeni bir Flutter projesine dogru sekilde entegre etmesi icin hazirlanmistir.

## 1) Hizli Kurulum

Hedef projede `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  splash_onboarding_package:
    git:
      url: https://github.com/mykyusuf/ready_flutter_packages.git
      ref: main
      path: packages/splash_onboarding_package
```

Ardindan:

```bash
flutter pub get
```

## 2) Import Standardi

Tek import kullan:

```dart
import 'package:splash_onboarding_package/splash_onboarding_package.dart';
```

Not: UI liquid glass ile calistigi icin ana uygulamada `liquid_theme_package` importu da gerekir.

## 3) Zorunlu Baslangic (initialize + wrap)

Agent, uygulama girisinde bu akisi uygulamalidir:

```dart
import 'package:flutter/material.dart';
import 'package:liquid_theme_package/liquid_theme_package.dart';
import 'package:splash_onboarding_package/splash_onboarding_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize();
  runApp(LiquidGlassWidgets.wrap(const MyApp()));
}
```

## 4) Temel API

Paketin public API'si:

- `OnboardingPageData`
- `SplashScreen`
- `OnboardingScreen`
- `SplashOnboardingFlow`

## 5) Onerilen Kullanim (Flow)

```dart
final pages = const [
  OnboardingPageData(
    title: 'Welcome',
    description: 'Discover features quickly.',
    icon: Icons.waving_hand_rounded,
  ),
  OnboardingPageData(
    title: 'Personalize',
    description: 'Set up your preferences.',
    icon: Icons.tune_rounded,
  ),
  OnboardingPageData(
    title: 'Ready',
    description: 'Start using the app.',
    icon: Icons.rocket_launch_rounded,
  ),
];

SplashOnboardingFlow(
  pages: pages,
  onFinished: () {
    // home ekranina gecis
  },
)
```

## 6) Agent Karar Kurallari

- Splash ve onboarding akisini tek yerden yonetmek icin once `SplashOnboardingFlow` tercih et
- Ozellestirme gerekirse `SplashScreen` ve `OnboardingScreen` ayri ayri kullan
- `pages` listesi bos birakilmaz
- Mevcut navigation/state akislarini bozma

## 7) Sik Gorevler

### 7.1 "Sadece splash ekrani lazim"

```dart
SplashScreen(
  duration: const Duration(seconds: 2),
  title: 'My App',
  subtitle: 'Preparing your experience',
  onFinished: () {
    // devam aksiyonu
  },
)
```

### 7.2 "Onboarding'i tek basina kullan"

```dart
OnboardingScreen(
  pages: pages,
  onDone: () {
    // tamamlandi
  },
  onSkip: () {
    // atlandi
  },
)
```

## 8) Yapilmamasi Gerekenler

- `LiquidGlassWidgets.initialize()` cagrisini atlama
- `LiquidGlassWidgets.wrap(...)` kullanmadan dogrudan app calistirma
- `OnboardingScreen` icin bos `pages` gonderme

## 9) Checklist

Her entegrasyon sonunda:

1. `flutter analyze` temiz mi?
2. `flutter test` geciyor mu?
3. Splash -> onboarding -> home gecis akisi sorunsuz mu?
4. Kucuk cihazda metin tasmasi var mi?
