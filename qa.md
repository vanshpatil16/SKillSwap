# Skill Profile and Rating Feature: Beginner-Friendly Presentation & Viva Guide

This guide explains the profile, skills, Skill Passport, and rating parts of the SkillSwap demo in simple language. You do not need to memorize the code. Focus on what a student can do in the app, what happens when they tap a button, and what is still only a demo.

## 1. Short project explanation

**Simple version to say:**

> “SkillSwap is an app concept where students can teach each other skills. My feature lets a student describe themselves, list what they can teach and want to learn, and rate a session after it is completed. The Skill Passport puts their skills, activity, and ratings together.”

The app is built with Flutter. For this demo, information is kept temporarily while the app is open. It is not saved to an online account or database.

## 2. What to show your professor

You can present the feature in this order:

1. **My Skills:** explain the two lists: things I can teach and things I want to learn.
2. **My Profile:** show the name, college, and bio fields. Save a change, and optionally try leaving the name blank to show the warning.
3. **My Sessions:** open **Completed** and select **Rate your experience** for a session that has not been rated yet.
4. **Rating:** choose a number of stars, optionally write a review, and submit.
5. **Skill Passport:** show that the rating count and average changed, and that the review appears in the feedback section.

If you forget a technical term, describe what the user sees and what changes after they tap. That is a perfectly reasonable way to explain a software feature.

## 3. What the feature does

### Profile

- The **My Profile** page lets a student edit their full name, college or university, and bio.
- Saving trims surrounding whitespace. A blank name or college is rejected with a message; the bio is limited to 200 characters.
- **Cancel changes** restores the text fields to the values currently held in app state.
- The page links to the student's Skill Passport and shows completed-session count, average rating, and rating count.
- The profile-photo button currently displays a demo message; it does not select or upload an image.

### Skills

- The **My Skills** page keeps two separate lists: skills the student can teach and skills they want to learn.
- Each list supports adding and removing skill chips.
- New entries are trimmed; blank values are ignored, and duplicates are detected without regard to letter case within the selected list. The same text can still appear in both lists.
- The page also shows the number of completed exchanges and links to the Skill Passport.

### Skill Passport

The **My Skill Passport** page combines:

- The student's initials, name, college, and bio.
- Counts for sessions taught, sessions learned, and completed sessions.
- Average rating, number of ratings, and a five-point progress bar.
- Teaching and learning skill lists.
- Up to five completed sessions as recent activity, with an indicator for rated sessions.
- Three milestones: **First Lesson**, **Knowledge Sharer**, and **Exchange Champion** (five completed exchanges).
- Up to three latest rating entries, including the partner name, date, stars, and review.

### Ratings and reviews

- A session can be rated from the **Completed** section of **My Sessions**. Upcoming and cancelled sessions do not show the rating action.
- After rating a completed session, the session card changes to **Rating submitted** and disables the action.
- A rating is required and uses one to five stars: **Poor**, **Fair**, **Good**, **Very Good**, and **Excellent**.
- A written review is optional and limited to 500 characters.
- The submit button stays disabled until a star value is selected. During submission it shows a loading indicator; the demo waits 450 milliseconds, then shows a success state.
- A submitted entry stores the session ID, partner, skill, star value, trimmed review text, and a demo date of **Today**.
- A session ID is checked before insertion so the same session cannot add a second rating through the shared rating list.
- The average is the arithmetic mean of all stored star values. It is displayed to one decimal place. An empty list produces an average of zero.

## 4. Suggested live demonstration

1. Launch the app and use the demo sign-in shown on the login screen: `demo@skillswap.edu` / `demo123`.
2. Open **Skills**. Show the separate teaching and learning lists. Add one item, try adding it again with different capitalization, and remove an item.
3. Open **Profile**. Edit the name, college, and bio; save, then show that blank name or college is rejected. Demonstrate **Cancel changes** if time permits.
4. Open the **Skill Passport**. Point out the profile summary, skill lists, exchange counts, milestones, rating summary, recent activity, and feedback.
5. Open **Sessions**, select **Completed**, and choose **Rate your experience** on a session that has not already been rated.
6. Try submitting before selecting stars; show that the button is disabled. Select a star score, optionally write a review, and submit.
7. Open the Skill Passport again. Show the new rating, feedback entry, changed count, and recalculated average. Return to the completed session to show **Rating submitted**.

The app starts with two sample ratings: 5 and 4 stars. Their average is `(5 + 4) / 2 = 4.5`. If you submit a new 5-star rating, it becomes `(5 + 4 + 5) / 3 = 4.67`, which the screen rounds to **4.7**.

**If the demo steps do not work as expected:** the sample data may already have a rating for the session you picked. Choose another completed session that still has the **Rate your experience** button.

## 5. Implementation map

| Area | Where to look | What it contains |
|---|---|---|
| Demo data models and shared app state | `lib/main.dart` — `DemoSession`, `DemoRating`, `DemoState` | Session/rating fields, initial sample data, profile and skill mutations, average calculation, and duplicate-session check |
| Main navigation | `lib/main.dart` — `MainShell` | Navigation destinations for Matches, Requests, Sessions, Skills, and Profile |
| Session rating entry point | `lib/main.dart` — `SessionsPage`, `SessionCard` | Status filtering and conditional completed-session rate action |
| Skill editing | `lib/main.dart` — `SkillsPage` | Teaching/learning list UI, add dialog, duplicate check, and removal |
| Editable student details | `lib/main.dart` — `ProfilePage` | Name, college, and bio fields, validation, save, cancel, and profile summary |
| Rating interaction | `lib/main.dart` — `RatingPage` | Star selection, labels, optional review, submission state, and success view |
| Passport display | `lib/main.dart` — `PassportPage` | Profile, stats, skills, activity, milestones, rating summary, and feedback |
| Existing widget test | `test/widget_test.dart` | Demo login/navigation and a submitted rating updating the Skill Passport |

In plain language: the app creates one shared place to keep the demo student's name, skills, sessions, and ratings while the app is running. The app uses that information to fill in the pages. The average is worked out from the list of ratings instead of being saved as a separate number.

## 6. Existing automated test

The widget test `a submitted rating updates the skill passport` exercises the main rating flow: sign in, open completed sessions, choose five stars, submit, and verify that the Skill Passport reflects three ratings and an average of 4.7. A second widget test checks that demo login opens the matches page.

Run the tests from the project root:

```shell
flutter test test/widget_test.dart
```

## 7. Viva questions and beginner-friendly answers

### What problem does the profile feature solve?

> “It gives students one place to introduce themselves and show what they can teach or want to learn. That makes it easier to understand what kind of skill exchange they are looking for.”

### Why have separate teaching and learning lists?

> “They are different things: a student may be able to teach one skill and want to learn another. Separate lists make that clear.”

### How are skills added and duplicates handled?

> “The student types a skill and taps Add. The app ignores an empty entry and warns if the same skill is already in that list, even if the capital letters are different.”

### What information is captured in a rating?

> “It keeps the session, the other student's name, the skill, the star score, the written review if one was added, and the date. Stars are required; the review is optional.”

### How is the average rating calculated?

> “It adds up the stars and divides by how many ratings there are. For example, 5 and 4 stars make an average of 4.5. If there are no ratings, the average is 0.”

### How does the app prevent duplicate ratings?

> “The app checks whether that session already has a rating. If it does, the session shows **Rating submitted** instead of letting the student rate it again.”

### Why can only completed sessions be rated?

> “The app only shows the rating button for completed sessions. It would not make sense to review a session that has not happened yet or was cancelled.”

### What happens if the user submits without choosing stars?

> “The Submit button stays disabled until the student chooses stars. The screen tells them to select a rating.”

### Is the data persistent?

> “Not yet. This is a demo, so the information is temporary and resets when the app is restarted. A real version would need to save it in a database or online service.”

### Is the login a real authentication system?

> “No. It uses demo login details to let someone explore the app. It is not connected to a real account system.”

### Does “Add profile photo” upload a photo?

> “No. That button is a placeholder for a future feature. It currently only shows a message.”

### How would you extend this for production?

> “I would add a database so information stays saved, give each student their own account and profile, and make sure only students in a completed session can submit a rating. I would also add checks for inappropriate reviews and test what happens if the internet connection fails.”

### What does “in-memory” mean?

> “It means the information is held temporarily while the app is running, rather than saved permanently to a file or database.”

## 8. A few coding words in simple language

| Word | Simple meaning |
|---|---|
| **Flutter** | The toolkit used to build the app screens. |
| **Widget** | A building block on the screen, such as a button, text label, or page. |
| **State** | Information the app is currently using, such as the student's name or selected star score. |
| **Model** | A description of what information belongs to one thing. For example, a rating has stars, a review, a session, and a date. |
| **Validation** | Checking that information is acceptable before the app saves or uses it. |
| **Backend / database** | The online service or storage that a real app would use to keep information after it closes. |
| **Widget test** | An automated check that taps through parts of the app and checks that the expected screen appears. |
| **Session** | One planned or completed meeting where students exchange a skill. |
| **Skill Passport** | The page that summarizes a student's skills, sessions, achievements, and ratings. |

## 9. Scope and limitations to state clearly

- This feature is a demo, not a production profile or rating service.
- Profile, skill, session, and rating data are seeded or modified in memory; no backend or database persistence is present.
- Demo login does not authenticate a real student.
- The profile-photo action is a placeholder.
- Rating entries are held in one shared demo list and shown on the current demo Skill Passport. The code does not implement separate accounts or a production model of which student's profile owns a rating.
- Rating submission uses a short simulated delay, not a network request.
- The code calls `notifyListeners` on `DemoState`, but the current widget tree does not subscribe to that notifier. Do not describe this as a fully reactive persistence layer; pages display the shared state when they rebuild or are opened.
- The existing widget tests cover demo login and the main rating-to-passport flow, not every validation, persistence, or error case.

## 10. One-minute presentation script

> “I am presenting the profile and rating feature of SkillSwap. Students can update their profile, add skills they can teach or want to learn, and rate a session after it is completed. The Skill Passport shows their skills, completed sessions, and average rating. A written review is optional. This is a demo, so the information is not permanently saved yet. A real version would need a database and real student accounts.”

## 11. Extra-short version if you feel nervous

> “My feature is the student profile and rating part of SkillSwap. Students can add skills they teach or want to learn, update their profile, and rate a session after it is completed. Their Skill Passport shows their skills, activity, and average rating. It is a demo, so the information is not permanently saved yet.”
