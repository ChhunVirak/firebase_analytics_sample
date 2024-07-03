#!/bin/bash
flutter clean
flutter pub get
dart run build_runner build -d
flutter build apk --release --no-tree-shake-icons