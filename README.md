# BostaTask

## Overview
BostaTask is an iOS application built using **Swift** and **UIKit** that fetches user albums and photos from a remote API. The app follows the **MVVM architecture** and utilizes **RxSwift** for reactive programming.

---

## Features
- **Profile Screen**: Displays user information (name, address) and a list of the user’s albums.
- **Album Details Screen**: Shows photos in an Instagram-like grid when selecting an album.
- **Search Feature**: Allows filtering images by title in real-time using a search bar.
- **Image Viewer**: Opens images in a zoomable, shareable viewer (Bonus Feature).
- **Networking**: Uses **Moya** to handle API requests efficiently.
- **Reactive Programming**: Implements **RxSwift** and **RxCocoa** for data binding and UI updates.
- **Swift Package Manager**: Used for dependency management.

---

## Technologies & Dependencies
- **UIKit**
- **MVVM Architecture**
- **RxSwift / RxCocoa**
- **Moya** (For networking)
- **SDWebImage** (For efficient image loading & caching)

---

## Folder Structure
BostaTask/
│── Models/
│   ├── User.swift
│   ├── Album.swift
│   ├── Photo.swift
│── ViewModels/
│   ├── ProfileViewModel.swift
│   ├── AlbumViewModel.swift
│── Views/
│   ├── ProfileViewController.swift
│   ├── AlbumViewController.swift
│   ├── ImageViewerViewController.swift
│── Networking/
│   ├── APIService.swift
│   ├── APIServiceManager.swift
│── Utility/
│   ├── APIEndpoints.swift
│── Resources/


---

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/ayamashalyy/BostaTask.git
