# Gabriel Rico Estudio App

Aplicación de Gabriel Rico version 1.6.6


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

# Detalles Android
Limpiar poryecto de flutter

```
flutter clean
```

android/settings.gradle

```
include ':app'
include ":unityLibrary"
project(":unityLibrary").projectDir = file("./unityLibrary")

def localPropertiesFile = new File(rootProject.projectDir, "local.properties")
def properties = new Properties()

assert localPropertiesFile.exists()
localPropertiesFile.withReader("UTF-8") { reader -> properties.load(reader) }

def flutterSdkPath = properties.getProperty("flutter.sdk")
assert flutterSdkPath != null, "flutter.sdk not set in local.properties"
apply from: "$flutterSdkPath/packages/flutter_tools/gradle/app_plugin_loader.gradle"


include ":unityLibrary"
project(":unityLibrary").projectDir = file("./unityLibrary")

```
agregar en android/local.properties

```
ndk.dir=C:\\Program Files\\Unity\\Hub\\Editor\\2021.3.8f1\\Editor\\Data\\PlaybackEngines\\AndroidPlayer\\NDK
```

android/app/build.gradle

```
apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"
def keystoreProperties = new Properties() //Para keystore
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }
android{
    ...
        defaultConfig {
        applicationId "com.VorticeVR.GabrielRico"
        minSdkVersion 24
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
    signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
    buildTypes {
        release {
            signingConfig signingConfigs.debug
        }
        debug {
           signingConfig signingConfigs.debug
        }
        profile {
            signingConfig signingConfigs.debug
        }
        innerTest {
            matchingFallbacks = ['debug', 'release']
        }
    }
```

IMPORTANTE para 2021> de Unity version, quitar en android/unityLibrary/build.gradle:
```
commandLineArgs.add("--enable-debugger")
    commandLineArgs.add("--profiler-report")
    commandLineArgs.add("--profiler-output-file=" + workingDir + "/build/il2cpp_"+ abi + "_" + configuration + "/il2cpp_conv.traceevents")
```

-keep class com.unity3d.plugin.UnityAndroidPermissions** { *; }


Configurar icono y splash image.
storePassword=ibanez30
keyPassword=ibanez30
keyAlias=upload
storeFile=A:\\Documents\\key\\flutter\\grDenver\\upload-keystore.jks