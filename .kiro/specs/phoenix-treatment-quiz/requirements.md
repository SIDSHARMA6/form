# Requirements Document

## Introduction

Phoenix is a responsive Flutter web application that provides treatment selection and eligibility assessment through an interactive quiz system. The application features a clean, minimal design with two main screens: an onboarding screen for treatment selection and a quiz screen for eligibility assessment. The app includes age verification (18+ requirement) and responsive design across desktop, tablet, and mobile devices.

## Requirements

### Requirement 1

**User Story:** As a user, I want to see available treatment options on the onboarding screen, so that I can select the treatment I'm interested in.

#### Acceptance Criteria

1. WHEN the app loads THEN the system SHALL display the onboarding screen with the title "What treatment are you looking for?"
2. WHEN the onboarding screen loads THEN the system SHALL display 5 treatment cards in a responsive grid layout
3. WHEN viewing on desktop THEN the system SHALL display treatment cards in a 5-column layout
4. WHEN viewing on tablet THEN the system SHALL display treatment cards in a 2-3 column layout
5. WHEN viewing on mobile THEN the system SHALL display treatment cards in a 1-2 column layout
6. WHEN displaying each treatment card THEN the system SHALL show the doctor.png image and treatment label
7. WHEN a user taps a treatment card THEN the system SHALL navigate to the quiz screen for that specific treatment

### Requirement 2

**User Story:** As a user, I want to verify my age before taking the quiz, so that only eligible users can proceed with the assessment.

#### Acceptance Criteria

1. WHEN a user selects a treatment THEN the system SHALL prompt for date of birth verification
2. WHEN a user enters their date of birth THEN the system SHALL calculate if they are 18 years or older
3. IF the user is 18 years or older THEN the system SHALL allow access to the quiz
4. IF the user is under 18 years THEN the system SHALL display "You are not eligible" message
5. WHEN age verification fails THEN the system SHALL prevent access to quiz questions

### Requirement 3

**User Story:** As a user, I want to take a quiz specific to my selected treatment, so that I can receive personalized assessment.

#### Acceptance Criteria

1. WHEN a user passes age verification THEN the system SHALL display the quiz screen with Phoenix header
2. WHEN the quiz screen loads THEN the system SHALL display the dark blue header with "PHOENIX" branding
3. WHEN displaying questions THEN the system SHALL show one question at a time with multiple choice answers
4. WHEN displaying answer options THEN the system SHALL format them as full-width rounded buttons
5. WHEN a user selects an answer THEN the system SHALL highlight the selected option
6. WHEN displaying the quiz THEN the system SHALL show a "Previous" button at the bottom
7. WHEN a user clicks "Previous" THEN the system SHALL navigate to the previous question

### Requirement 4

**User Story:** As a user, I want the quiz to be responsive across all devices, so that I can use it on desktop, tablet, or mobile.

#### Acceptance Criteria

1. WHEN viewing quiz on desktop THEN the system SHALL display answer options in a row layout
2. WHEN viewing quiz on tablet THEN the system SHALL display answer options in a 2-column grid
3. WHEN viewing quiz on mobile THEN the system SHALL display answer options in a 1-column stacked layout
4. WHEN the screen size changes THEN the system SHALL automatically adjust the layout
5. WHEN displaying on any device THEN the system SHALL maintain proper spacing and readability

### Requirement 5

**User Story:** As a developer, I want the code to be minimal and high-quality, so that the application is maintainable and performant.

#### Acceptance Criteria

1. WHEN implementing the application THEN the system SHALL use minimal lines of code while maintaining functionality
2. WHEN writing code THEN the system SHALL follow Flutter best practices and clean code principles
3. WHEN creating components THEN the system SHALL make them reusable across different treatments
4. WHEN implementing responsive design THEN the system SHALL use efficient Flutter responsive widgets
5. WHEN structuring the project THEN the system SHALL organize files logically with clear separation of concerns

### Requirement 6

**User Story:** As a user, I want each treatment to have its own comprehensive set of quiz questions, so that I receive a thorough and relevant assessment for my selected treatment.

#### Acceptance Criteria

1. WHEN a user selects "Erectile Dysfunction" THEN the system SHALL load erectile dysfunction specific questions
2. WHEN a user selects "Weight Loss" THEN the system SHALL load weight loss specific questions
3. WHEN a user selects "Hair Loss" THEN the system SHALL load hair loss specific questions
4. WHEN a user selects "Premature Ejaculation" THEN the system SHALL load premature ejaculation specific questions
5. WHEN a user selects "Testosterone Booster" THEN the system SHALL load testosterone booster specific questions
6. WHEN loading questions THEN the system SHALL load multiple comprehensive questions for each treatment type
7. WHEN displaying questions THEN the system SHALL maintain the same quiz interface regardless of treatment type
8. WHEN progressing through questions THEN the system SHALL allow users to navigate forward and backward through all questions
9. WHEN completing all questions for a treatment THEN the system SHALL provide appropriate completion or results handling