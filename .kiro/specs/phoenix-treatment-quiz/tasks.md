# Implementation Plan

- [ ] 1. Set up Flutter web project structure and dependencies




  - Initialize Flutter project with web support enabled
  - Configure pubspec.yaml with required dependencies (flutter/material)
  - Create folder structure: models, screens, widgets, data, utils
  - Add assets folder and doctor.png image
  - _Requirements: 5.1, 5.5_

- [ ] 2. Create core data models and quiz data
  - [ ] 2.1 Implement Treatment and QuizQuestion models
    - Create Treatment class with id, name, imagePath, and questions properties
    - Create QuizQuestion class with id, question, and options properties
    - Add JSON serialization methods for data handling
    - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_


  


  - [ ] 2.2 Create comprehensive quiz questions data file
    - Define 10-15 questions for Erectile Dysfunction treatment
    - Define 10-15 questions for Weight Loss treatment
    - Define 10-15 questions for Hair Loss treatment
    - Define 10-15 questions for Premature Ejaculation treatment
    - Define 10-15 questions for Testosterone Booster treatment
    - Organize questions in quiz_data.dart file
    - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5, 6.6_

- [ ] 3. Implement responsive design utilities
  - Create responsive.dart utility file with breakpoint constants
  - Implement responsive helper methods for layout calculations
  - Create responsive grid column calculation functions
  - _Requirements: 4.1, 4.2, 4.3, 4.4_

- [ ] 4. Build age verification functionality
  - Create age_validator.dart utility file
  - Implement date of birth input validation
  - Create age calculation logic (18+ verification)
  - Add "not eligible" message handling
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_

- [ ] 5. Create reusable UI components
  - [ ] 5.1 Build treatment card widget
    - Create TreatmentCard widget with image and label
    - Implement tap handling for navigation
    - Add responsive sizing and spacing
    - Style card with proper elevation and borders
    - _Requirements: 1.6, 1.7_
  
  - [ ] 5.2 Create Phoenix header component
    - Build QuizHeader widget with dark blue background (#1a237e)
    - Add "PHOENIX" branding text with proper styling
    - Ensure responsive header sizing
    - _Requirements: 3.2_
  
  - [ ] 5.3 Implement answer button widget
    - Create AnswerButton widget with full-width rounded styling
    - Add selection state management and visual feedback
    - Implement responsive button sizing
    - _Requirements: 3.4, 3.5_

- [ ] 6. Build onboarding screen
  - Create OnboardingScreen widget with "What treatment are you looking for?" title
  - Implement responsive grid layout for treatment cards
  - Add navigation logic to quiz screen with selected treatment
  - Configure responsive breakpoints: desktop (5 columns), tablet (2-3 columns), mobile (1-2 columns)
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5, 1.7_

- [ ] 7. Implement quiz screen with navigation
  - [ ] 7.1 Create quiz screen structure
    - Build QuizScreen widget with Phoenix header
    - Implement question display area with proper typography
    - Add responsive answer options layout
    - Create Previous button at bottom
    - _Requirements: 3.1, 3.2, 3.3, 3.6_
  
  - [ ] 7.2 Add quiz navigation logic
    - Implement question progression state management
    - Add Previous/Next navigation functionality
    - Handle quiz completion flow
    - Ensure proper state preservation during navigation
    - _Requirements: 3.7, 6.8, 6.9_

- [ ] 8. Implement responsive layouts for quiz screen
  - Configure desktop layout with horizontal answer options
  - Implement tablet layout with 2-column answer grid
  - Create mobile layout with vertical stacked answers
  - Add automatic layout switching based on screen size
  - _Requirements: 4.1, 4.2, 4.3, 4.4_

- [x] 9. Integrate age verification with quiz flow



  - Add age verification dialog/screen before quiz access
  - Implement date picker or input field for birth date
  - Connect age validation with quiz screen navigation
  - Display "not eligible" message for users under 18
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_

- [ ] 10. Configure main app and routing
  - Set up main.dart with MaterialApp configuration
  - Implement navigation routing between onboarding and quiz screens
  - Configure app theme with Phoenix branding colors
  - Add responsive design configuration for web
  - _Requirements: 1.1, 3.1, 4.4_

- [ ] 11. Optimize for web deployment
  - Configure Flutter web build settings
  - Optimize assets and images for web performance
  - Add web-specific responsive breakpoints
  - Test cross-browser compatibility



  - _Requirements: 5.1, 5.2, 5.4_

- [-] 12. Set up Firebase hosting configuration

  - Create firebase.json configuration file
  - Configure hosting settings for Flutter web
  - Set up build and deployment scripts
  - Test deployment to Firebase hosting
  - _Requirements: 5.1, 5.4_