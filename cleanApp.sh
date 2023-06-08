#!/bin/bash
flutter clean
echo "Running cleaning"
cd ios
pod deintegrate
pod cache clean --all
cd ..
echo "Reinstalling"
flutter pub get
cd ios
pod install
pod update
