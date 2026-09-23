# 🔥 Viral Content Studio

A Flutter social-media post simulator where users can interact with a post and increase its engagement. The app tracks likes, comments, shares, saves, and an engagement streak.

## Features

* Like posts
* Add comments
* Share posts
* Save posts
* Track engagement score
* Track engagement streak
* Toggle between Light and Dark mode
* View a real-time virality meter
* Unlock a **TRENDING** state when the engagement target is reached
* Tactile button feedback using `GestureDetector`

## Build Challenge

### Theme

**Viral Content Studio**

The app simulates a social-media post and allows the user to increase its engagement through different actions.

### State Variables

The main state variables are:

* `int likes` — stores the number of likes.
* `int comments` — stores the number of comments.
* `int shares` — stores the number of shares.
* `int saves` — stores the number of saves.
* `int streak` — tracks the number of engagement actions.
* `bool isTrending` — determines whether the post has reached the trending state.

### Engagement Scoring

Each action adds engagement points:

 Action       Points 

 Like    =>    +1 
 Comment =>    +2 
 Share   =>     +3 
 Save    =>     +2 

The total engagement score is calculated from all four engagement types.

### Condition That Changes the Interface

When the engagement score reaches **20 points**, the app:

1. Changes the background color.
2. Sets `isTrending` to `true`.
3. Displays the **"TRENDING "** banner.
4. Updates the virality meter to show that the target has been reached.

## Flutter Architecture

The project uses:

* `StatefulWidget` for application and engagement state.
* `StatelessWidget` for reusable UI components.
* `GestureDetector` for tactile button interactions.
* `setState()` to update the interface in real time.
* Light/Dark theme switching.

## How to Run

1. Open the project in Android Studio or VS Code.
2. Make sure Flutter is installed.
3. Run:

```bash
flutter pub get
flutter run
```

4. Press the engagement buttons to increase the score.
5. Reach **20 engagement points** to unlock the **TRENDING** state.


