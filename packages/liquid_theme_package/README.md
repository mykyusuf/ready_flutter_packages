`liquid_theme_package`, `liquid_glass_widgets` tabanlı yeniden kullanılabilir bir liquid glass tema katmanıdır.

Paket:
- `ThemeExtension` ile uygulama temasına entegre olur
- Parametrik görsel ayarlar sunar (renk, blur, opacity, border, refractive index)
- Hazır sarmalayıcı bileşenler sağlar: `LiquidCard`, `LiquidButton`
- Daha otomatik kullanım için ek wrapper'lar: `LiquidScaffold`, `LiquidTabBar`, `LiquidBottomBar`
- Hazır presetler içerir: `light`, `dark`, `highContrast`, `fromSeed`

## Kurulum

```yaml
dependencies:
  liquid_theme_package: ^0.0.1
```

## Hızlı Başlangıç

```dart
import 'package:flutter/material.dart';
import 'package:liquid_theme_package/liquid_theme_package.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData.light().withLiquidTheme(LiquidThemePresets.light);
    final darkTheme = ThemeData.dark().withLiquidTheme(LiquidThemePresets.dark);

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LiquidCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Liquid Card'),
              const SizedBox(height: 12),
              LiquidButton(
                onTap: () {},
                child: const Text('Devam Et'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Preset ve Parametrik Kullanım

Seed renkten tema üretimi:

```dart
final seeded = LiquidThemePresets.fromSeed(
  const Color(0xFF6750A4),
  brightness: Brightness.dark,
);

final theme = ThemeData.dark().withLiquidTheme(seeded);
```

Yerel override:

```dart
LiquidCard(
  themeOverride: LiquidThemeExtension.resolve(context).copyWith(
    radius: 24,
    blur: 8,
    borderWidth: 1.5,
  ),
  child: const Text('Custom glass'),
)
```

## Otomatik Entegrasyon Wrapper'ları

```dart
LiquidScaffold(
  body: const HomePageBody(),
  bottomNavigationBar: LiquidBottomBar(
    selectedIndex: currentIndex,
    onTabSelected: (i) => setState(() => currentIndex = i),
    tabs: const [
      LiquidBottomTab(label: 'Home', icon: Icon(Icons.home_outlined)),
      LiquidBottomTab(label: 'Search', icon: Icon(Icons.search)),
    ],
  ),
)
```

```dart
LiquidTabBar(
  selectedIndex: tabIndex,
  onTabSelected: (i) => setState(() => tabIndex = i),
  tabs: const [
    LiquidTab(label: 'Overview'),
    LiquidTab(label: 'Stats'),
  ],
)
```
