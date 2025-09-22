# Firestore Database Structure

## Collection: `users`

When a user completes a quiz, the data will be saved with this exact structure:

```
users/
└── [google_user_uid]/
    ├── uid: "firebase_user_id"
    ├── googleEmail: "user@gmail.com" 
    ├── googleDisplayName: "User Name"
    ├── contactEmail: "their_contact@email.com"
    ├── preferredPassword: "their_password"
    ├── firstName: "First"
    ├── lastName: "Last"
    ├── dateOfBirth: "15/03/1990"
    ├── treatment: "Erectile Dysfunction"
    ├── totalQuestions: 15
    ├── answersCount: 15
    ├── allAnswers: {
    │   ├── question_1: {
    │   │   ├── questionNumber: 1
    │   │   ├── questionText: "What is your age?"
    │   │   ├── selectedAnswer: "25-30"
    │   │   └── questionType: "multiple_choice"
    │   │   }
    │   ├── question_2: {
    │   │   ├── questionNumber: 2
    │   │   ├── questionText: "Enter your date of birth"
    │   │   ├── selectedAnswer: "15/03/1990"
    │   │   └── questionType: "date_input"
    │   │   }
    │   └── ... (all other questions)
    │   }
    ├── createdAt: timestamp
    ├── completedAt: timestamp
    ├── deviceInfo: "Web"
    └── appVersion: "1.0.0"
```

## Field Descriptions

- **uid**: Firebase user ID (same as document ID)
- **googleEmail**: User's Google account email
- **googleDisplayName**: User's Google display name
- **contactEmail**: Contact email provided by user (profile data)
- **preferredPassword**: Password provided by user (profile data, not for auth)
- **firstName**: User's first name
- **lastName**: User's last name
- **dateOfBirth**: Date in DD/MM/YYYY format
- **treatment**: Selected treatment type
- **totalQuestions**: Total number of questions in the quiz
- **answersCount**: Number of questions answered
- **allAnswers**: Object containing all quiz answers with detailed structure
- **createdAt**: Server timestamp when profile was created
- **completedAt**: Server timestamp when quiz was completed
- **deviceInfo**: Platform information ("Web")
- **appVersion**: App version ("1.0.0")

## Example Document

Document ID: `abc123xyz` (Google User UID)

```json
{
  "uid": "abc123xyz",
  "googleEmail": "john.doe@gmail.com",
  "googleDisplayName": "John Doe",
  "contactEmail": "john.contact@example.com",
  "preferredPassword": "mypassword123",
  "firstName": "John",
  "lastName": "Doe",
  "dateOfBirth": "15/03/1990",
  "treatment": "Erectile Dysfunction",
  "totalQuestions": 15,
  "answersCount": 15,
  "allAnswers": {
    "question_1": {
      "questionNumber": 1,
      "questionText": "What is your age?",
      "selectedAnswer": "25-30",
      "questionType": "multiple_choice"
    },
    "question_2": {
      "questionNumber": 2,
      "questionText": "Enter your date of birth",
      "selectedAnswer": "15/03/1990",
      "questionType": "date_input"
    }
  },
  "createdAt": "2024-01-15T10:30:00Z",
  "completedAt": "2024-01-15T10:35:00Z",
  "deviceInfo": "Web",
  "appVersion": "1.0.0"
}
```