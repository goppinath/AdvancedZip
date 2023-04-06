#!/bin/sh

git clone https://github.com/tukaani-project/xz.git xz

cd xz
cmake -G Xcode

mkdir build

# iOS Simulator (arm64 + x86_64)
xcodebuild build \
  -scheme liblzma \
  -derivedDataPath derived_data \
  -sdk iphonesimulator \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

mkdir -p build/ios_simulators
cp -r Debug/ build/ios_simulators

# iOS Device xcarchive (arm64)
xcodebuild build \
  -scheme liblzma \
  -derivedDataPath derived_data \
  -sdk iphoneos \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

mkdir -p build/ios_devices
cp -r Debug/ build/ios_devices

# macOS Device xcarchive (arm64)
xcodebuild build \
  -scheme liblzma \
  -derivedDataPath derived_data \
  -sdk macosx \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

mkdir -p build/macos_devices
cp -r Debug/ build/macos_devices

# Prepare universal
mkdir -p build/universal
mkdir -p build/universal/include

# Prepare include
cp -r src/liblzma/api/ build/universal/include
# Remove unwanted
rm build/universal/include/Makefile.am

# create xcframework
xcodebuild -create-xcframework \
    -library build/ios_simulators/liblzma.a -headers build/universal/include \
    -library build/ios_devices/liblzma.a -headers build/universal/include \
    -library build/macos_devices/liblzma.a -headers build/universal/include \
    -output build/universal/LZMA.xcframework
    