# Liquid Theme Package - Agent Integration Guide

Bu dokuman, `liquid_theme_package` paketini yeni bir Flutter projesine dogru sekilde entegre etmek icin hazirlanmistir.

Onemli not: Bu paket artik bir **facade** pakettir. `liquid_theme_package`, kendi widget/tema katmanini sunmaz; bunun yerine `liquid_glass_widgets` API'sini oldugu gibi re-export eder.

## 1) Hizli Kurulum

Hedef projede `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  liquid_theme_package:
    git:
      url: https://github.com/mykyusuf/ready_flutter_packages.git
      ref: main
      path: packages/liquid_theme_package
```

Ardindan:

```bash
flutter pub get
```

## 2) Import Standardi

Kod tarafinda tek import kullan:

```dart
import 'package:liquid_theme_package/liquid_theme_package.dart';
```

Bu import, `liquid_glass_widgets` tiplerine erisim saglar.

## 3) Zorunlu Baslangic (initialize + wrap)

Agent, uygulama girisinde asagidaki akisi kullanmalidir:

```dart
import 'package:flutter/material.dart';
import 'package:liquid_theme_package/liquid_theme_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize();
  runApp(LiquidGlassWidgets.wrap(const MyApp()));
}
```

Neden:
- `initialize()` shader/pipeline hazirligini erkene alir
- `wrap()` glass surface'lerde ortak backdrop capture kullanir (ozellikle Impeller'da daha stabil)

## 4) Agent Karar Kurallari

Agent bu paketi kullanirken su kurallari izlemelidir:

- `Liquid*` wrapper siniflari bekleme; dogrudan `Glass*` bilesenlerini kullan
- Mevcut event/navigation/state akislarini bozma
- Gorunum degisikligi yaparken mevcut layout ve erisilebilirlik davranisini koru
- Hardcoded degerleri minimumda tut; once mevcut Theme/ColorScheme ile uyumlu ol

## 5) Sik Gorevler Icin Tarifler

### 4.1 "Card'lari liquid yap"

```dart
GlassCard(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Text('Baslik'),
      SizedBox(height: 8),
      Text('Icerik'),
    ],
  ),
)
```

### 4.2 "Button'lari liquid yap"

`GlassButton` ikon-temelli kurucudur. Metin/ozel icerik icin `GlassButton.custom` kullan:

```dart
GlassButton.custom(
  onTap: () {
    // mevcut action
  },
  child: const Text('Kaydet'),
)
```

### 4.3 "TabBar'i liquid yap"

```dart
GlassTabBar(
  selectedIndex: tabIndex,
  onTabSelected: (i) => setState(() => tabIndex = i),
  tabs: const [
    GlassTab(label: 'Overview'),
    GlassTab(label: 'Stats'),
    GlassTab(label: 'Activity'),
  ],
)
```

Not: Kucuk cihazlarda veya buyuk yazi olceginde tasma olmamasi icin `height` degerini artir:

```dart
GlassTabBar(
  height: 52,
  selectedIndex: tabIndex,
  onTabSelected: (i) => setState(() => tabIndex = i),
  tabs: const [
    GlassTab(label: 'Ana Sayfa', icon: Icon(Icons.home_outlined)),
    GlassTab(label: 'Ara', icon: Icon(Icons.search_outlined)),
  ],
)
```

### 4.4 "BottomNavigationBar'i liquid yap"

```dart
GlassBottomBar(
  selectedIndex: currentIndex,
  onTabSelected: (i) => setState(() => currentIndex = i),
  tabs: const [
    GlassBottomBarTab(label: 'Home', icon: Icon(Icons.home_outlined)),
    GlassBottomBarTab(label: 'Search', icon: Icon(Icons.search)),
    GlassBottomBarTab(label: 'Profile', icon: Icon(Icons.person_outline)),
  ],
)
```

## 6) Yapilmamasi Gerekenler

- Uygulama genel `ThemeData` akislarini gereksiz bypass etme
- Tum ekrani sebepsiz `useOwnLayer: true` ile doldurma (performans riski)

## 7) Agent Calisma Checklist'i

Her gorev sonunda:

1. Degisen ekranlar derleniyor mu?
2. `flutter analyze` temiz mi?
3. `flutter test` (veya ilgili widget testleri) geciyor mu?
4. Kucuk ekran ve buyuk text scale durumunda tasma var mi?

## 8) Referans

Detayli API dokumani:

- https://github.com/sdegenaar/liquid_glass_widgets
