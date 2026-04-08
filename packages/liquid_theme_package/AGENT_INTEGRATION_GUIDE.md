# Liquid Theme Package - Agent Integration Guide

Bu doküman, bir kod agent'ının `liquid_theme_package` paketini **yeni bir Flutter projesine** doğru şekilde entegre etmesi için hazırlanmıştır.

Amaç: "TabBar'ı liquid yap", "Card'ları liquid yap", "Button'ları liquid yap" gibi görevleri minimum yorumla, standart bir yöntemle uygulamak.

## 1) Hızlı Kurulum

Hedef projede `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  liquid_theme_package: ^0.0.1
```

Ardından:

```bash
flutter pub get
```

## 2) Tema Entegrasyonu (Zorunlu)

Agent, ilk iş olarak uygulama temasına `LiquidThemeExtension` eklemelidir.

```dart
import 'package:flutter/material.dart';
import 'package:liquid_theme_package/liquid_theme_package.dart';

MaterialApp(
  theme: ThemeData.light().withLiquidTheme(LiquidThemePresets.light),
  darkTheme: ThemeData.dark().withLiquidTheme(LiquidThemePresets.dark),
  home: const HomePage(),
)
```

### Seed tabanlı tema gerekiyorsa

```dart
final seededLight = LiquidThemePresets.fromSeed(
  const Color(0xFF6750A4),
  brightness: Brightness.light,
);

final seededDark = LiquidThemePresets.fromSeed(
  const Color(0xFF6750A4),
  brightness: Brightness.dark,
);
```

## 3) Agent Karar Kuralları

Agent bu paketi kullanırken aşağıdaki kuralları izlemelidir:

- Önce global tema: `withLiquidTheme(...)`
- Sonra ihtiyaç varsa lokal override: `themeOverride: LiquidThemeExtension.resolve(context).copyWith(...)`
- Bileşen dönüşümünde mevcut işlevselliği bozma (event, navigation, state)
- Görsel dönüşüm yaparken mevcut padding/margin ve erişilebilirlik davranışını koru

## 4) Sık Görevler İçin Tarifler

## 4.1 "Card'ları liquid yap"

### Dönüşüm kuralı

- `Card`, `Container`, `DecoratedBox` gibi yüzeyleri `LiquidCard` ile sar.
- İçerik hiyerarşisini değiştirme, sadece yüzeyi liquid hale getir.

### Örnek

```dart
LiquidCard(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Text('Başlık'),
      SizedBox(height: 8),
      Text('İçerik'),
    ],
  ),
)
```

### Lokal override örneği

```dart
LiquidCard(
  themeOverride: LiquidThemeExtension.resolve(context).copyWith(
    radius: 24,
    blur: 7,
    borderWidth: 1.4,
  ),
  child: const Text('Özelleştirilmiş kart'),
)
```

## 4.2 "Button'ları liquid yap"

### Dönüşüm kuralı

- `ElevatedButton`, `FilledButton`, `OutlinedButton` yerine (veya etrafına) `LiquidButton` kullan.
- `onPressed` davranışını `onTap` içine taşı.
- Metin stilini tema üzerinden al, ekstra zorunlu değilse elle sabitleme yapma.

### Örnek

```dart
LiquidButton(
  onTap: () {
    // mevcut action
  },
  child: const Text('Kaydet'),
)
```

## 4.3 "TabBar'ı liquid yap"

Agent öncelikle hazır `LiquidTabBar` wrapper'ını kullanmalıdır.

### Örnek (önerilen)

```dart
LiquidTabBar(
  selectedIndex: tabIndex,
  onTabSelected: (i) => setState(() => tabIndex = i),
  tabs: const [
    GlassTab(label: 'Overview'),
    GlassTab(label: 'Stats'),
    GlassTab(label: 'Activity'),
  ],
)
```

### Fallback (mevcut TabController/TabBar yapısını korumak gerekiyorsa)

```dart
class LiquidTabBarShell extends StatelessWidget {
  const LiquidTabBarShell({
    super.key,
    required this.controller,
    required this.tabs,
  });

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final lt = LiquidThemeExtension.resolve(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: LiquidCard(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        themeOverride: lt.copyWith(radius: 20, blur: 6),
        child: TabBar(
          controller: controller,
          tabs: tabs,
          dividerColor: Colors.transparent,
          labelColor: lt.palette.accent,
          unselectedLabelColor: lt.palette.accent.withValues(alpha: 0.65),
          indicator: BoxDecoration(
            color: lt.palette.surface.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: lt.palette.border,
              width: lt.borderWidth,
            ),
          ),
        ),
      ),
    );
  }
}
```

Bu sayede "TabBar liquid yap" görevi, bileşeni bozmadan görsel olarak liquid hale gelir.

## 4.4 "BottomNavigationBar'ı liquid yap"

Agent öncelikle hazır `LiquidBottomBar` wrapper'ını kullanmalıdır.

```dart
LiquidBottomBar(
  selectedIndex: currentIndex,
  onTabSelected: (i) => setState(() => currentIndex = i),
  tabs: const [
    GlassBottomBarTab(label: 'Home', icon: Icon(Icons.home_outlined)),
    GlassBottomBarTab(label: 'Search', icon: Icon(Icons.search)),
    GlassBottomBarTab(label: 'Profile', icon: Icon(Icons.person_outline)),
  ],
)
```

## 5) ThemeExtension Erişim Standardı

Agent, tema değerini her zaman şu sırayla çözmelidir:

1. `themeOverride` verilmişse onu kullan
2. Yoksa `LiquidThemeExtension.resolve(context)`
3. Bu da yoksa preset fallback (paket kendi içinde çözer)

## 6) Yapılmaması Gerekenler

- Uygulama genel `ThemeData` akışını bypass etme
- Liquid görünüm için sabit, tema dışı hardcoded renkler ekleme
- Var olan widget davranışını (tap, disabled, semantics) kırma
- Tüm ekranı gereksiz `useOwnLayer: true` ile doldurma (performans riski)

## 7) Agent Çalışma Checklist'i

Her görev sonunda agent şunları yapmalıdır:

1. Değiştirilen widgetlar derleniyor mu?
2. `flutter analyze` temiz mi?
3. `flutter test` (veya ilgili widget testleri) geçiyor mu?
4. Açık ve koyu modda görünüm kontrol edildi mi?
5. Tema override verilen yerlerde fallback bozulmadı mı?

## 8) Kısa Görev Prompt Şablonları

Bu şablonlar, farklı agent'lara doğrudan verilebilir:

- "Bu projede ana ekran kartlarını `LiquidCard` kullanarak liquid görünüme çevir. Mevcut layout ve spacing bozulmasın."
- "Settings sayfasındaki aksiyon butonlarını `LiquidButton` ile değiştir. Mevcut `onPressed` davranışlarını koru."
- "Home ekranındaki `TabBar` yapısını kaldırmadan, `LiquidCard` ile sarıp liquid bir görünüm ver. Seçili/normal renkleri `LiquidThemeExtension` palette'inden al."

## 9) Minimum Entegrasyon Örneği

```dart
final theme = ThemeData.light().withLiquidTheme(
  LiquidThemePresets.fromSeed(const Color(0xFF2563EB)),
);
```

```dart
LiquidCard(
  child: LiquidButton(
    onTap: () {},
    child: const Text('Continue'),
  ),
)
```

Bu kadar entegrasyon bile paketi kullanmaya başlamak için yeterlidir.
