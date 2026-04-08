`liquid_theme_package`, `liquid_glass_widgets` paketini tek import ile kullanmanizi saglayan bir facade pakettir.

Paket:
- `liquid_glass_widgets` API'sini oldugu gibi disari aktarir
- Tuketici projede tek import ile kullanim saglar

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
    return MaterialApp(
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
        child: GlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Liquid Card'),
              const SizedBox(height: 12),
              GlassButton(
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

Detayli kullanim icin:
- https://github.com/sdegenaar/liquid_glass_widgets
