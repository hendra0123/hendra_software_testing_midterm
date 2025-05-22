# 🧪 Flutter Auth Testing Application

A simple Flutter authentication application created for **software testing coursework**, featuring:

- Login functionality with validation
- Session handling (login/logout)
- UI designed with animations
- Comprehensive unit tests for the authentication logic

---

## 🚀 Application Overview

This Flutter app implements a basic login/logout workflow using `ChangeNotifier` for state management and `Provider` for dependency injection. It includes input validation for username and password, error handling for failed logins, and a clean animated UI for better user experience.

### 🛠 Technologies Used
- Flutter
- Provider
- ChangeNotifier
- Unit Testing (`flutter_test`)
- Animated Widgets (e.g., `AnimatedOpacity`, `AnimatedScale`)

---

## 🧪 Complete Test Cases

| Test Case ID       | Description                                      | Steps                                                                                     | Expected Result                                         |
|--------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------|---------------------------------------------------------|
| TC_AUTH_VM_001     | Validate Empty Username                          | Call `validateUsername('')`                                                               | Returns "Username cannot be empty."                    |
| TC_AUTH_VM_002     | Validate Short Password                          | Call `validatePassword('123')`                                                            | Returns "Password must be at least 6 characters long." |
| TC_AUTH_VM_003     | Successful Login                                 | Call `login('testuser', 'password123')` with mocked success                               | Returns `null`, `user` is set                          |
| TC_AUTH_VM_004     | Login with Invalid Credentials                   | Call `login('invaliduser', 'wrongpassword')` with mocked error                            | Returns "Invalid username or password."                |
| TC_AUTH_VM_005     | Logout Functionality                             | Call `logout()` after successful login                                                    | Clears user session, triggers `logout` in service      |
| TC_AUTH_VM_006     | Username Length Boundary Values                  | Validate usernames with 2, 21, and 8 characters                                            | Returns errors for invalid, null for valid             |
| TC_AUTH_VM_007     | Password Length Boundary Values                  | Validate passwords with 5 and 6 characters                                                 | Returns error for 5, `null` for 6                      |
| TC_AUTH_VM_008     | Login with Special Characters in Username        | Call `validateUsername('user@name')`                                                      | Returns "Username contains invalid characters."        |
| TC_AUTH_VM_009     | Login with SQL Injection Attempt                 | Call `login("'; DROP TABLE users; --", 'password123')` with mocked failure                | Returns "Invalid username or password."                |
| TC_AUTH_VM_010     | Login with Empty Fields                          | Call `validateUsername('')` and `validatePassword('')`                                    | Returns respective "cannot be empty" errors            |

---

## 📷 Screenshots

![Screenshot 2025-05-22 112308](https://github.com/user-attachments/assets/c8082101-27e5-47a7-8798-74aecf166886)


### ✅ Login View  
Modern design with input validation and animation.

### ✅ Logout View  
Elegant success screen with logout option and transitions.

---

## 📂 Folder Structure

lib/

├── models/

│ ├── auth_service.dart

│ └── user.dart

├── viewmodels/

│ └── auth_view_model.dart

├── views/

│ ├── login_view.dart

│ └── logout_view.dart

└── main.dart


test/
── auth_view_model_test.dart

---

## 👨‍💻 How to Run

1. Install Flutter and dependencies
2. Run app with:
   ```bash
   flutter run
3. Run test with:
   ```bash
   flutter test

  ---
   
## 📌 Author
Created by Hendra Oktarizal Couwandy for Software Testing Midterm Project.


