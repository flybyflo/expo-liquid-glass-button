# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

- `npm run build` - Build the Expo module using expo-module scripts
- `npm run clean` - Clean build artifacts 
- `npm run lint` - Run linting using expo-module scripts
- `npm run test` - Run tests using expo-module scripts
- `npm run prepare` - Prepare module for publishing
- `npm run open:ios` - Open iOS example project in Xcode
- `npm run open:android` - Open Android example project in Android Studio

## Architecture Overview

This is a cross-platform Expo module that provides a liquid glass button component for React Native applications. The architecture follows platform-specific implementations:

### Key Components

**TypeScript/React Layer (src/)**
- `ExpoLiquidGlassButtonView.tsx` - Main React component for iOS (native implementation)
- `ExpoLiquidGlassButtonView.android.tsx` - Android React Native implementation
- `ExpoLiquidGlassButtonView.web.tsx` - Web React Native implementation with CSS glass effects
- `ExpoLiquidGlassButton.types.ts` - TypeScript type definitions
- `ExpoLiquidGlassButtonModule.ts` - Native module interface
- `index.ts` - Main export file

**iOS Native Implementation (ios/)**
- `ExpoLiquidGlassButtonView.swift` - Native iOS view implementation with protocol-based architecture
- Uses `ButtonImplementation` protocol for iOS version compatibility
- `LiquidGlassButton` class for iOS 26.0+ using `UIButton.Configuration.prominentGlass()`
- `FallbackButton` class for older iOS versions using standard filled button style
- Icon support uses SF Symbols system names

**Android & Web Implementation**
- Pure React Native components using TouchableOpacity and Text
- Android: Standard Material Design styling with elevation
- Web: Glass effect using CSS backdrop-filter and rgba backgrounds
- Both platforms support the same customizable properties as iOS

**Configuration**
- `expo-module.config.json` - Expo module configuration (all platforms: apple, android, web)
- `ExpoLiquidGlassButton.podspec` - iOS CocoaPods specification

### Platform-Specific Features

**iOS**: Native liquid glass button using iOS 26.0+ APIs with fallback to standard buttons
**Android**: Material Design styled button with elevation and shadows
**Web**: CSS glass morphism effects with backdrop-filter and transparency

### Supported Properties
All platforms support: title, isRound, textSize, icon, iconOnly, iconSize, onButtonPress

### Example App Structure
The `example/` directory contains a full React Native app demonstrating the module usage with proper Expo setup.