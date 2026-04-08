# ready_flutter_packages

Bu repo, birden fazla Flutter package'i tek yerde yonetmek icin hazirlanmis bir monorepo yapisidir.

## Yapi

```text
ready_flutter_packages/
  melos.yaml
  pubspec.yaml
  packages/
    liquid_theme_package/
    splash_onboarding_package/
```

## Baslangic

```bash
dart pub get
dart run melos bootstrap
```

## Yararlı Komutlar

```bash
dart run melos run analyze
dart run melos run test
dart run melos run format
```

## Paket Kullanimi (Dis Projede)

Bu monorepo icindeki paketler Git uzerinden tek tek cekilir.

### liquid_theme_package

```yaml
dependencies:
  liquid_theme_package:
    git:
      url: https://github.com/mykyusuf/ready_flutter_packages.git
      ref: main
      path: packages/liquid_theme_package
```

### splash_onboarding_package

```yaml
dependencies:
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

## Hızlı Entegrasyon Notu (Liquid)

`splash_onboarding_package`, liquid UI kullandigi icin uygulama baslangicinda su akisi onerilir:

```dart
import 'package:flutter/material.dart';
import 'package:liquid_theme_package/liquid_theme_package.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize();
  runApp(LiquidGlassWidgets.wrap(const MyApp()));
}
```
