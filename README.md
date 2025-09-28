# MovieAppDemoHalcom

## Overview
MovieAppDemoHalcom is a small iOS app that fetches and displays a list of movies from The Movie Database (TMDb) API. Users can search movies, view details, mark favorites, and manage them in a separate favorites screen.

---

## Features

### Movie List Screen
- Displays movies in a scrollable list.
- Pull-to-refresh support.
- Pagination support (loads more movies as you scroll).

### Search
- Search bar filters movies by title (queries the API in real-time).

### Movie Detail Screen
- Shows poster, title, description (overview), rating, release date, original language, vote count and adult content flag.
- Allows marking/unmarking movies as favorite.

### Favorites
- Favorites are stored locally in `UserDefaults`.
- Users can view all favorites in a separate screen.
- Favorites can also be removed from the list, updating `UserDefaults`.

### UI & UX
- SwiftUI-based interfaces.
- Async/await networking.
- Loading indicators and error alerts.

---

## Architecture & Design Choices
- **MVVM Architecture**: Separation of View, ViewModel, and Model for modularity and testability.
- **Networking**: `MovieAPIService` handles API requests using async/await.
- **Data Persistence**: `UserDefaults` used for storing favorite movies.
- **Error Handling**: Alerts display API/network errors and provide retry options.
- **Pagination**: Incremental loading reduces initial load time.
- **Testing**: Includes three Unit tests and three UI tests

**Trade-offs**:
- `UserDefaults` chosen for simplicity over Core Data for favorites persistence.
- SwiftUI chosen for faster development and easier testing; UIKit could allow more customization.

## Requirements
- iOS 16+
- Xcode 15+
- Swift 5.9+

---

## How to Run

1. Clone the repository:
```bash
git clone https://github.com/yourusername/MovieAppDemoHalcom.git
cd MovieAppDemoHalcom

2. Open MovieAppDemoHalcom.xcodeproj

3. Build & Run on a simulator or device.

## Testing

Unit Tests

Fetching popular movies.
Favorites persistence in UserDefaults.
Toggling favorites.

UI Tests

Error alert appears correctly.
Tab navigation works.
Search functionality works as expected.

## Notes

This project covers the key tasks from the test assignment:

Fetching movies from a public API
Search functionality
Movie detail screen
Favorites management with persistent storage and deletion of favourites by swiping.
Pull-to-refresh, pagination, loading/error handling
Unit and UI tests included

Contact

Created by Vladimir Savic – for iOS developer test purposes.


