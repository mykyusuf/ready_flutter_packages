# ready_flutter_packages

Bu repo, birden fazla Flutter package'i tek yerde yonetmek icin hazirlanmis bir monorepo yapisidir.

## Yapi

```text
ready_flutter_packages/
  melos.yaml
  pubspec.yaml
  packages/
    liquid_theme_package/
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

```yaml
dependencies:
  liquid_theme_package:
    git:
      url: https://github.com/<kullanici>/ready_flutter_packages.git
      ref: main
      path: packages/liquid_theme_package
```
