# Gita App

A simple iOS app that brings daily wisdom from the Bhagavad Gita right to your home screen through an elegant widget.

## What it does

The app features a home screen widget that displays random quotes from the Bhagavad Gita, automatically refreshing every hour to give you fresh inspiration throughout the day. Each quote includes its chapter and verse reference, so you can explore further if something resonates with you.

## Features

- **Widget Support**: Available in both small and medium sizes
- **Auto-refresh**: New quotes appear hourly without any interaction needed
- **Authentic Content**: 10 carefully selected verses from the Bhagavad Gita
- **Clean Design**: Minimalist interface that fits well with any home screen setup
- **Accessibility**: Full VoiceOver support for screen readers

## Technical Details

Built with SwiftUI and WidgetKit for iOS 18.2+. The app uses a timeline provider to manage quote rotation and ensures the widget stays updated even when the main app isn't running.

The quotes are stored locally, so no internet connection is required for the widget to function.

## Installation

1. Clone this repository
2. Open `GitaApp.xcodeproj` in Xcode
3. Build and run on your iOS device or simulator
4. Add the widget to your home screen by long-pressing an empty area and selecting the Gita Wisdom widget

## Widget Sizes

- **Small**: Perfect for a single quote with minimal space usage
- **Medium**: Larger text and more breathing room for longer verses

## Requirements

- iOS 18.2 or later
- Xcode 16.2 or later for development

## Contributing

Feel free to suggest additional verses or improvements to the design. The app is intentionally kept simple to maintain focus on the wisdom being shared.