class WeightLossQuiz {
  static const List<Map<String, dynamic>> questions = [
    {
      "question":
          "1. Have you ever taken any of the following medications to help you lose weight?",
      "type": "multiple_choice",
      "options": [
        "I have never taken medication to lose weight",
        "Ozempic",
        "Wegovy",
        "Rybelsus",
        "Mounjaro",
        "Zepbound",
        "Other (please specify)"
      ]
    },
    {
      "question":
          "2. When was the last time you took your weight loss treatment and what dose are you currently on?",
      "type": "text_input",
      "options": ["Enter details (e.g., March 2025, 1mg Ozempic)"]
    },
    {
      "question": "3. What is your height and weight?",
      "type": "height_weight_input",
      "options": [
        "Height (ft) — Required",
        "Height (inches) — Required",
        "Weight (lbs) — Required"
      ]
    },
    {
      "question": "4. Do any of these statements apply to you?",
      "type": "multiple_choice",
      "options": [
        "I have chronic malabsorption syndrome (problems absorbing food)",
        "I have cholestasis",
        "I'm currently being treated for cancer",
        "I have diabetic retinopathy",
        "I have severe heart failure",
        "I have a family history of thyroid cancer and/or I've had thyroid cancer",
        "I have end-stage kidney disease",
        "I have a history of pancreatitis",
        "I have or have had an eating disorder such as bulimia, anorexia nervosa, or a binge eating disorder",
        "I have had surgery or an operation to my thyroid",
        "I have had a bariatric operation such as gastric band or sleeve surgery",
        "None of these statements apply to me"
      ]
    },
    {
      "question": "5. Do any of these statements relate to you?",
      "type": "multiple_choice",
      "options": [
        "I have been diagnosed with a mental health condition such as depression or anxiety",
        "My weight makes me anxious in social situations",
        "I have joint pains and/or aches",
        "I have osteoarthritis",
        "I have GERD and/or indigestion",
        "I have a heart and/or cardiovascular problem",
        "I've been diagnosed with, or have a family history of, high blood pressure",
        "I've been diagnosed with, or have a family history of, high cholesterol",
        "I have fatty liver disease",
        "I have sleep apnea",
        "I have asthma or COPD",
        "I have erectile dysfunction",
        "I have low testosterone",
        "None of these statements apply to me"
      ]
    },
    {
      "question":
          "6. Does your family history include any of the following conditions?",
      "type": "multiple_choice",
      "options": [
        "Medullary Thyroid Carcinoma (MTC)",
        "Multiple Endocrine Neoplasia Syndrome Type 2 (MEN 2)",
        "Diabetes Mellitus (especially Type 2 Diabetes)",
        "Pancreatic Diseases (e.g., pancreatitis, pancreatic cancer)",
        "Cardiovascular Diseases (e.g., heart attack, stroke, hypertension)",
        "None of these statements apply to me"
      ]
    },
    {
      "question": "7. Do you have any other medical conditions not yet listed?",
      "type": "multiple_choice",
      "options": ["Yes", "No"]
    },
    {
      "question": "8. How would you describe your typical dietary habits?",
      "type": "multiple_choice",
      "options": [
        "Balanced omnivore (a mix of plant-based foods and animal products)",
        "Mostly plant-based",
        "High in processed foods and sugars",
        "High-protein, low-carbohydrate",
        "I often skip meals",
        "Other (please specify)"
      ]
    },
    {
      "question": "9. How would you describe your level of physical activity?",
      "type": "multiple_choice",
      "options": [
        "No exercise",
        "Lightly active (0–1 days/week)",
        "Moderately active (2–3 days/week)",
        "Active (4+ days/week)"
      ]
    },
    {
      "question":
          "10. Do you have any allergies or reactions to particular medications? Please list them.",
      "type": "multiple_choice",
      "options": ["I don't have any allergies"]
    },
    {
      "question":
          "11. Do you take any medications, herbals, or supplements? Please list them.",
      "type": "multiple_choice",
      "options": ["I don't take any"]
    },
    {
      "question":
          "12. Is there anything else you want your doctor to know about your condition or health?",
      "type": "multiple_choice",
      "options": ["Yes", "No"]
    },
    {
      "question": "13. Choose your treatment plan",
      "type": "multiple_choice",
      "options": [
        "Ozempic — Weekly Injection — \$374.99/month",
        "Rybelsus — Daily Tablet — \$374.99/month",
        "Mounjaro — Weekly Injection — Starts at \$599.99/month",
        "Zepbound — Weekly Injection — Starts at \$599.99/month",
        "Wegovy — Weekly Injection — \$599.99/month"
      ]
    }
  ];
}
