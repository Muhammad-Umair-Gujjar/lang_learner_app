// final Map<String, dynamic> languageData = {
//   "italian": {
//     "beginner": {
//       "chapter_1": {
//         "title": {
//           "en": "Greetings & Basics",
//           "it": "Saluti e Basi"
//         },
//         "quizzes": [
//           {
//             "type": "mcq",
//             "question": {
//               "en": "How do you say 'Hello' in Italian?",
//               "it": "Come si dice 'Hello' in italiano?"
//             },
//             "options": {
//               "en": ["Ciao", "Grazie", "Domani", "Scusa"],
//               "it": ["Ciao", "Grazie", "Domani", "Scusa"]
//             },
//             "correctIndex": 0,
//             "points": 10,
//             "hint": {
//               "en": "Most common informal greeting",
//               "it": "Saluto informale più comune"
//             }
//           },
//           {
//             "type": "mcq",
//             "question": {
//               "en": "What does 'Grazie' mean?",
//               "it": "Cosa significa 'Grazie'?"
//             },
//             "options": {
//               "en": ["Hello", "Thank you", "Goodbye", "Please"],
//               "it": ["Ciao", "Grazie", "Arrivederci", "Per favore"]
//             },
//             "correctIndex": 1,
//             "points": 10
//           },
//           {
//             "type": "fill_blank",
//             "question": {
//               "en": "Complete: Buon ___ (morning)",
//               "it": "Completa: Buon ___ (mattina)"
//             },
//             "correctAnswers": ["giorno", "giorno"],
//             "points": 15
//           },
//           // CHAPTER 1 CONTINUED (7 more quizzes)
//           {
//             "type": "mcq",
//             "question": {
//               "en": "How to respond to 'Grazie'?",
//               "it": "Come rispondere a 'Grazie'?"
//             },
//             "options": {
//               "en": ["Prego", "Ciao", "Si", "No"],
//               "it": ["Prego", "Ciao", "Si", "No"]
//             },
//             "correctIndex": 0,
//             "points": 10
//           },
//           {
//             "type": "fill_blank",
//             "question": {
//               "en": "___ is your name? (Come)",
//               "it": "___ ti chiami? (Come)"
//             },
//             "correctAnswers": ["Come", "Come"],
//             "points": 15
//           },
//           {
//             "type": "mcq",
//             "question": {
//               "en": "Translate 'Goodnight'",
//               "it": "Traduci 'Goodnight'"
//             },
//             "options": {
//               "en": ["Buongiorno", "Buonasera", "Buonanotte", "Arrivederci"],
//               "it": ["Buongiorno", "Buonasera", "Buonanotte", "Arrivederci"]
//             },
//             "correctIndex": 2,
//             "points": 10
//           },
//           {
//             "type": "mcq",
//             "question": {
//               "en": "Which means 'Please'?",
//               "it": "Quale significa 'Please'?"
//             },
//             "options": {
//               "en": ["Per favore", "Grazie", "Scusa", "Ciao"],
//               "it": ["Per favore", "Grazie", "Scusa", "Ciao"]
//             },
//             "correctIndex": 0,
//             "points": 10
//           },
//           {
//             "type": "fill_blank",
//             "question": {
//               "en": "Mi chiamo ___ (my name is John)",
//               "it": "Mi chiamo ___ (il mio nome è John)"
//             },
//             "correctAnswers": ["John", "John"],
//             "points": 15
//           }
//         ]
//       },
//       "chapter_2": {
//         "title": {
//           "en": "Numbers 1-20",
//           "it": "Numeri 1-20"
//         },
//         "quizzes": [
//           {
//             "type": "mcq",
//             "question": {
//               "en": "What is 'Three' in Italian?",
//               "it": "Come si dice 'Three' in italiano?"
//             },
//             "options": {
//               "en": ["Uno", "Due", "Tre", "Quattro"],
//               "it": ["Uno", "Due", "Tre", "Quattro"]
//             },
//             "correctIndex": 2,
//             "points": 10
//           },
//           // CHAPTER 2 QUIZZES 2-10...
//           {
//             "type": "fill_blank",
//             "question": {
//               "en": "Dieci means ___ (10)",
//               "it": "Dieci significa ___ (10)"
//             },
//             "correctAnswers": ["10", "10"],
//             "points": 15
//           },
//           {
//             "type": "mcq",
//             "question": {
//               "en": "Which number is 'Sette'?",
//               "it": "Quale numero è 'Sette'?"
//             },
//             "options": {
//               "en": ["5", "6", "7", "8"],
//               "it": ["5", "6", "7", "8"]
//             },
//             "correctIndex": 2,
//             "points": 10
//           }
//         ]
//       },
//       "chapter_3": {
//         "title": {
//           "en": "Common Objects",
//           "it": "Oggetti Comuni"
//         },
//         "quizzes": [
//           {
//             "type": "mcq",
//             "question": {
//               "en": "Translate 'Water'",
//               "it": "Traduci 'Water'"
//             },
//             "options": {
//               "en": ["Pane", "Acqua", "Vino", "Formaggio"],
//               "it": ["Pane", "Acqua", "Vino", "Formaggio"]
//             },
//             "correctIndex": 1,
//             "points": 10
//           },
//           // CHAPTER 3 QUIZZES 2-10...
//           {
//             "type": "fill_blank",
//             "question": {
//               "en": "Il ___ (book) è sul tavolo",
//               "it": "Il ___ (libro) è sul tavolo"
//             },
//             "correctAnswers": ["libro", "libro"],
//             "points": 15
//           }
//         ]
//       },
//       "chapter_4": {
//         "title": {
//           "en": "Simple Verbs",
//           "it": "Verbi Semplici"
//         },
//         "quizzes": [
//           {
//             "type": "mcq",
//             "question": {
//               "en": "How to say 'I eat'?",
//               "it": "Come si dice 'I eat'?"
//             },
//             "options": {
//               "en": ["Mangio", "Bevo", "Dormo", "Corro"],
//               "it": ["Mangio", "Bevo", "Dormo", "Corro"]
//             },
//             "correctIndex": 0,
//             "points": 10
//           },
//           // CHAPTER 4 QUIZZES 2-10...
//           {
//             "type": "fill_blank",
//             "question": {
//               "en": "Io ___ (drink) acqua",
//               "it": "Io ___ (bevo) acqua"
//             },
//             "correctAnswers": ["bevo", "bevo"],
//             "points": 15
//           }
//         ]
//       },
//       "chapter_5": {
//         "title": {
//           "en": "Daily Phrases",
//           "it": "Frasi Quotidiane"
//         },
//         "quizzes": [
//           {
//             "type": "mcq",
//             "question": {
//               "en": "How to ask 'How are you?'",
//               "it": "Come si chiede 'How are you?'"
//             },
//             "options": {
//               "en": ["Come stai?", "Chi sei?", "Dove vai?", "Quanto costa?"],
//               "it": ["Come stai?", "Chi sei?", "Dove vai?", "Quanto costa?"]
//             },
//             "correctIndex": 0,
//             "points": 10
//           },
//           // CHAPTER 5 QUIZZES 2-10...
//           {
//             "type": "fill_blank",
//             "question": {
//               "en": "___ fa caldo oggi (It)",
//               "it": "___ fa caldo oggi (It)"
//             },
//             "correctAnswers": ["Fa", "Fa"],
//             "points": 15
//           }
//         ]
//       }
//     }
//   }
// };

final Map<String, dynamic> beginnerItalianQuizzes = {
  'language': 'italian',
  'proficiency': 'beginner',
  'quizzes': [
    // ========== CHAPTER 1: GREETINGS ==========
    {
      'chapterId': 'greetings_chapter',
      'order': 1,
      'title': 'Greetings and Basic Phrases',
      'quiz': [
        {
          'question': {
            'italian': 'Come si dice "Hello" in italiano?',
            'english': 'How do you say "Hello" in Italian?'
          },
          'type': 'mcq',
          'options': [
            'Buongiorno',
            'Ciao',
            'Arrivederci',
            'Buonanotte'
          ],
          'correctAnswer': 'Ciao'
        },
        {
          'question': {
            'italian': 'Completa: ___ pomeriggio (Good afternoon)',
            'english': 'Complete: ___ pomeriggio (Good afternoon)'
          },
          'type': 'fill_blank',
          'correctAnswer': 'Buon'
        },
        {
          'question': {
            'italian': 'Qual è la risposta a "Come stai?"',
            'english': 'What is the response to "How are you?"'
          },
          'type': 'mcq',
          'options': [
            'Prego',
            'Sto bene',
            'Grazie',
            'Scusa'
          ],
          'correctAnswer': 'Sto bene'
        },
        {
          'question': {
            'italian': 'Abbina le parole alle traduzioni:',
            'english': 'Match the words to translations:'
          },
          'type': 'matching',
          'pairs': {
            'Buongiorno': 'Good morning',
            'Buonanotte': 'Good night',
            'Arrivederci': 'Goodbye (formal)'
          },
          'correctAnswer': {
            'Buongiorno': 'Good morning',
            'Buonanotte': 'Good night',
            'Arrivederci': 'Goodbye (formal)'
          }
        },
        {
          'question': {
            'italian': 'Come si dice "How are you?" formalmente?',
            'english': 'How do you say "How are you?" formally?'
          },
          'type': 'mcq',
          'options': [
            'Come stai?',
            'Come sta?',
            'Come va?',
            'Come sei?'
          ],
          'correctAnswer': 'Come sta?'
        },
        {
          'question': {
            'italian': "Scegli la frase corretta per dire 'My name is...'",
            'english': "Choose the correct phrase for 'My name is...'"
          },
          'type': 'mcq',
          'options': [
            'Io sono...',
            'Mi chiamo...',
            'Il mio nome è...',
            'Chiamare...'
          ],
          'correctAnswer': 'Mi chiamo...'
        }
      ]
    },

    // ========== CHAPTER 2: BASIC PHRASES ==========
    {
      'chapterId': 'basics_chapter',
      'order': 2,
      'title': 'Essential Expressions',
      'quiz': [
        {
          'question': {
            'italian': 'Come si dice "Thank you" in italiano?',
            'english': 'How do you say "Thank you" in Italian?'
          },
          'type': 'mcq',
          'options': [
            'Prego',
            'Per favore',
            'Grazie',
            'Scusa'
          ],
          'correctAnswer': 'Grazie'
        },
        {
          'question': {
            'italian': 'Qual è la risposta a "Grazie"?',
            'english': 'What is the response to "Thank you"?'
          },
          'type': 'mcq',
          'options': [
            'Prego',
            'Per favore',
            'Grazie',
            'Scusa'
          ],
          'correctAnswer': 'Prego'
        },
        {
          'question': {
            'italian': 'Completa: ___ capisco (I don\'t understand)',
            'english': 'Complete: ___ capisco (I don\'t understand)'
          },
          'type': 'fill_blank',
          'correctAnswer': 'Non'
        },
        {
          'question': {
            'italian': 'Come si dice "Please" in italiano?',
            'english': 'How do you say "Please" in Italian?'
          },
          'type': 'mcq',
          'options': [
            'Grazie',
            'Prego',
            'Per favore',
            'Scusa'
          ],
          'correctAnswer': 'Per favore'
        },
        {
          'question': {
            'italian': 'Come si chiede "Do you speak English?" in italiano?',
            'english': 'How do you ask "Do you speak English?" in Italian?'
          },
          'type': 'mcq',
          'options': [
            'Parla inglese?',
            'Capisci inglese?',
            'Vuoi inglese?',
            'Sai inglese?'
          ],
          'correctAnswer': 'Parla inglese?'
        },
        {
          'question': {
            'italian': 'Abbina le parole alle traduzioni:',
            'english': 'Match the words to translations:'
          },
          'type': 'matching',
          'pairs': {
            'Sì': 'Yes',
            'No': 'No',
            'Scusa': 'Sorry (informal)'
          },
          'correctAnswer': {
            'Sì': 'Yes',
            'No': 'No',
            'Scusa': 'Sorry (informal)'
          }
        }
      ]
    },

    // ========== CHAPTER 3: FOOD & DINING ==========
    {
      'chapterId': 'food_chapter',
      'order': 3,
      'title': 'Food and Restaurants',
      'quiz': [
        {
          'question': {
            'italian': 'Come si dice "I would like..." in un ristorante?',
            'english': 'How do you say "I would like..." in a restaurant?'
          },
          'type': 'mcq',
          'options': [
            'Io voglio...',
            'Vorrei...',
            'Prendo...',
            'Dammi...'
          ],
          'correctAnswer': 'Vorrei...'
        },
        {
          'question': {
            'italian': 'Completa: Un ___, per favore (A coffee, please)',
            'english': 'Complete: Un ___, per favore (A coffee, please)'
          },
          'type': 'fill_blank',
          'correctAnswer': 'caffè'
        },
        {
          'question': {
            'italian': 'Come si chiede il conto?',
            'english': 'How do you ask for the bill?'
          },
          'type': 'mcq',
          'options': [
            'Il menu, per favore',
            'Il conto, per favore',
            'Quanto costa?',
            'Posso pagare?'
          ],
          'correctAnswer': 'Il conto, per favore'
        },
        {
          'question': {
            'italian': 'Come si dice "Water" in italiano?',
            'english': 'How do you say "Water" in Italian?'
          },
          'type': 'mcq',
          'options': [
            'Vino',
            'Pane',
            'Acqua',
            'Latte'
          ],
          'correctAnswer': 'Acqua'
        },
        {
          'question': {
            'italian': 'Cosa significa "Delizioso!"?',
            'english': 'What does "Delizioso!" mean?'
          },
          'type': 'mcq',
          'options': [
            'Too expensive!',
            'Delicious!',
            'More please!',
            'I\'m full!'
          ],
          'correctAnswer': 'Delicious!'
        },
        {
          'question': {
            'italian': 'Come si dice "Cheers!" quando si brinda?',
            'english': 'How do you say "Cheers!" when toasting?'
          },
          'type': 'mcq',
          'options': [
            'Grazie!',
            'Prego!',
            'Salute!',
            'Buono!'
          ],
          'correctAnswer': 'Salute!'
        }
      ]
    },

    // ========== CHAPTER 4: TRAVEL ==========
    {
      'chapterId': 'travel_chapter',
      'order': 4,
      'title': 'Travel and Directions',
      'quiz': [
        {
          'question': {
            'italian': 'Come si chiede "Where is...?" in italiano?',
            'english': 'How do you ask "Where is...?" in Italian?'
          },
          'type': 'mcq',
          'options': [
            'Quando è...?',
            'Dov\'è...?',
            'Perché è...?',
            'Chi è...?'
          ],
          'correctAnswer': 'Dov\'è...?'
        },
        {
          'question': {
            'italian': 'Completa: Dove sono i ___? (Where are the bathrooms?)',
            'english': 'Complete: Dove sono i ___? (Where are the bathrooms?)'
          },
          'type': 'fill_blank',
          'correctAnswer': 'bagni'
        },
        {
          'question': {
            'italian': 'Come si dice "train station" in italiano?',
            'english': 'How do you say "train station" in Italian?'
          },
          'type': 'mcq',
          'options': [
            'Aeroporto',
            'Stazione',
            'Fermata',
            'Binario'
          ],
          'correctAnswer': 'Stazione'
        },
        {
          'question': {
            'italian': 'Cosa significa "Destra"?',
            'english': 'What does "Destra" mean?'
          },
          'type': 'mcq',
          'options': [
            'Left',
            'Right',
            'Straight',
            'Behind'
          ],
          'correctAnswer': 'Right'
        },
        {
          'question': {
            'italian': 'Come si chiede il prezzo di un biglietto?',
            'english': 'How do you ask the price of a ticket?'
          },
          'type': 'mcq',
          'options': [
            'Dov\'è il biglietto?',
            'Quanto costa un biglietto?',
            'Quando parte il treno?',
            'Un biglietto, per favore'
          ],
          'correctAnswer': 'Quanto costa un biglietto?'
        },
        {
          'question': {
            'italian': 'Abbina le parole alle traduzioni:',
            'english': 'Match the words to translations:'
          },
          'type': 'matching',
          'pairs': {
            'Aeroporto': 'Airport',
            'Biglietto': 'Ticket',
            'Treno': 'Train'
          },
          'correctAnswer': {
            'Aeroporto': 'Airport',
            'Biglietto': 'Ticket',
            'Treno': 'Train'
          }
        }
      ]
    },

    // ========== CHAPTER 5: SHOPPING ==========
    {
      'chapterId': 'shopping_chapter',
      'order': 5,
      'title': 'Shopping and Transactions',
      'quiz': [
        {
          'question': {
            'italian': 'Come si chiede "How much does it cost?"',
            'english': 'How do you ask "How much does it cost?"'
          },
          'type': 'mcq',
          'options': [
            'Dov\'è?',
            'Che cos\'è?',
            'Quanto costa?',
            'Posso provarlo?'
          ],
          'correctAnswer': 'Quanto costa?'
        },
        {
          'question': {
            'italian': 'Completa: Posso ___? (Can I try it on?)',
            'english': 'Complete: Posso ___? (Can I try it on?)'
          },
          'type': 'fill_blank',
          'correctAnswer': 'provarlo'
        },
        {
          'question': {
            'italian': 'Cosa significa "Troppo caro"?',
            'english': 'What does "Troppo caro" mean?'
          },
          'type': 'mcq',
          'options': [
            'Very cheap',
            'Too expensive',
            'Good price',
            'On sale'
          ],
          'correctAnswer': 'Too expensive'
        },
        {
          'question': {
            'italian': 'Come si dice "I\'ll take it" in italiano?',
            'english': 'How do you say "I\'ll take it" in Italian?'
          },
          'type': 'mcq',
          'options': [
            'Lo voglio',
            'Lo prendo',
            'Lo compro',
            'Lo guardo'
          ],
          'correctAnswer': 'Lo prendo'
        },
        {
          'question': {
            'italian': 'Come si chiede se accettano carte di credito?',
            'english': 'How do you ask if they accept credit cards?'
          },
          'type': 'mcq',
          'options': [
            'Avete carte?',
            'Dove è la banca?',
            'Accettate carte di credito?',
            'Posso pagare dopo?'
          ],
          'correctAnswer': 'Accettate carte di credito?'
        },
        {
          'question': {
            'italian': 'Abbina le parole alle traduzioni:',
            'english': 'Match the words to translations:'
          },
          'type': 'matching',
          'pairs': {
            'Sconto': 'Discount',
            'Taglia': 'Size',
            'Regalo': 'Gift'
          },
          'correctAnswer': {
            'Sconto': 'Discount',
            'Taglia': 'Size',
            'Regalo': 'Gift'
          }
        }
      ]
    }
  ]
};