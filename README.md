# TechEx
NY Times Most Popular Articles (iOS)

A simple iOS application built using SwiftUI and Combine that displays the New York Times Most Popular Articles.
The app fetches data from the NY Times Most Viewed Articles API and presents it using a master–detail interface.

### iOS Technical Assessment – SwiftUI
Overview

This project is a SwiftUI-based iOS application that displays a list of articles and allows users to navigate to a detailed view.
The app focuses on clean architecture, modern Swift concurrency, testability, and scalability.

### How to run the APP
Just run the project don't have any third party dependency 

### Architecture & Design

MVVM architecture is used to separate UI, business logic, and data handling.

SwiftUI NavigationStack with a Coordinator pattern is used for navigation to keep views decoupled from routing logic.

Views are kept lightweight; navigation and side effects are handled outside the UI layer.

### Navigation

Implemented a HomeCoordinator using NavigationPath.

Routes are defined as enums and conform to Hashable for type-safe navigation.

This approach supports future flows like Login → Home → Detail without changing existing views.

### State Management & Concurrency

Uses async/await for network calls and background work.

UI updates are safely handled on the MainActor.

Loading, success, and error states are explicitly modeled and reflected in the UI.

### Image Loading & Caching

Custom CachedImageLoader handles image loading with:

In-memory caching

Disk caching

Network fallback

Dependencies (URLSession, memory cache, disk cache) are abstracted using protocols for easy testing.

Caching logic avoids duplicate downloads and improves performance.

### Theming & Styling

Centralized font system using custom fonts with Dynamic Type support.

Centralized color palette for consistent branding and easy theme changes.

Reusable view modifiers are used to keep UI code clean and consistent.

### Pull to Refresh

Pull-to-refresh is scoped only to the list view, avoiding unintended refresh propagation to detail views.

Ensures correct UX and avoids unnecessary API calls.

### Testing

Unit tests focus on CachedImageLoader behavior.

External dependencies are replaced with stubs and mocks:

Network session

Memory cache

Disk cache

Tests are deterministic, fast, and isolated from real network or file system state.

### Key Highlights

Modern SwiftUI navigation (NavigationStack)

Coordinator-based routing

Async/await concurrency

Protocol-oriented dependency injection

Clean theming system

Testable image caching layer

### How to generate and access the coverage report

### 1. Enable Code Coverage: Enable in Xcode project settings.

### 2. Run Tests: Use Cmd + U.

### 3. View Coverage: Open Report Navigator (Cmd + 9) and select Coverage.

👤 Author
Ali Saeed
Senior iOS Developer

