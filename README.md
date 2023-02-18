# Gabriel Rico Estudio App

Aplicación de Gabriel Rico version 2.


## IMPORTANTE:

Construir para plataformas

```
flutter create .
```

Construir proyecto general

```
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```


## Proyecto GitHub Flutter - Unity:

- [flutter_unity_widget](https://github.com/juicycleff/flutter-unity-view-widget)

Por el momento, se hace este paso al final. No se puede emular con dicha librería pero sí se puede utilizar dispositivos locales.

# Reiniciar IOS por problema de Flutter-Unity-Framework

Limpiar poryecto de flutter

```
flutter clean
```

En carpeta ios/

```
pod deintegrate
pod cache clean --all
```

De nuevo en carpeta de proyecto /
```
flutter pub get
```

En ios/
```
pod install
pod update
```