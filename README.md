# TodoPro

A beautiful, modern todo list application for iOS built with SwiftUI. TodoPro features a clean glassmorphic design, smart sorting, powerful filtering, and seamless data persistence.

## ✨ Features

- **Create & Manage Tasks** - Add, edit, and delete todos with ease
- **Priority Levels** - Organize tasks by Low, Medium, or High priority
- **Due Dates** - Set optional due dates with date and time
- **Smart Sorting** - Sort by smart (active first + due date), priority, creation date, or due date
- **Advanced Filtering** - Filter by All, Active, or Done tasks
- **Search** - Quickly find tasks by searching titles and notes
- **Swipe Actions** - Mark complete/incomplete or delete with intuitive swipes
- **Modern UI** - Beautiful glassmorphic design with smooth animations
- **Data Persistence** - Tasks saved locally using JSON storage

## 🎨 Screenshots

<!-- Add your app screenshots here -->

## 🛠 Technologies

- **SwiftUI** - Modern declarative UI framework
- **MVVM Architecture** - Clean separation of concerns
- **Codable** - Type-safe JSON encoding/decoding
- **@Published** - Reactive state management
- **FileManager** - Local data persistence

## 📋 Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## 🚀 Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/TodoPro.git
```

2. Open the project:
```bash
cd TodoPro
open TodoPro.xcodeproj
```

3. Build and run:
   - Select your target device/simulator
   - Press `⌘+R` to build and run

## 📁 Project Structure

```
TodoPro/
├── TodoProApp.swift          # App entry point
├── ContentView.swift         # Root view
├── Models/
│   └── TodoItem.swift       # Todo data model & priority enum
├── ViewModels/
│   └── TodoListViewModel.swift  # Business logic & state management
├── Views/
│   ├── Components.swift     # Reusable UI components
│   ├── TodoListView.swift   # Main list view
│   ├── TodoRowView.swift    # Individual todo row
│   └── TodoEditorView.swift # Add/edit todo sheet
└── Data/
    └── TodoStore.swift      # Data persistence layer
```

## 🏗 Architecture

TodoPro follows the **MVVM (Model-View-ViewModel)** pattern:

- **Model** (`TodoItem`) - Represents todo data structure
- **View** (`TodoListView`, `TodoRowView`, etc.) - UI components
- **ViewModel** (`TodoListViewModel`) - Business logic, state management, and data operations
- **Store** (`TodoStore`) - Handles data persistence with JSON

### Key Components

- **TodoStore** - Protocol-based storage with async/await
- **TodoListViewModel** - ObservableObject managing app state
- **Smart Sorting** - Intelligently prioritizes active tasks with approaching due dates
- **Glassmorphic UI** - Custom view modifiers for modern aesthetic

## 🎯 Usage

### Creating a Todo
1. Tap the `+` button in the navigation bar
2. Enter a title (required) and optional notes
3. Set priority level
4. Optionally add a due date
5. Tap "Save"

### Managing Todos
- **Tap** a todo to edit it
- **Swipe right** to mark complete/incomplete
- **Swipe left** to delete
- **Search** using the search field
- **Filter** by tapping All/Active/Done
- **Sort** using the sort menu

## 📝 License

This project is available under the MIT License.

## 👨‍💻 Author

**Arkin Azizi**

---

Made with ❤️ using SwiftUI
