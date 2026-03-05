import '../models/quiz_question.dart';

const List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    question: 'Which of the following is one of the New Seven Wonders of the World?',
    options: ['Jerash', 'Wadi Rum', 'Petra', 'Dead Sea'],
    correctIndex: 2,
    explanation: 'Petra was voted one of the New Seven Wonders of the World in 2007!',
  ),
  QuizQuestion(
    question: 'What is the Dead Sea known for?',
    options: [
      'Being the deepest sea in the world',
      'Its extreme saltiness that lets you float',
      'Having the most fish species',
      'Being the largest lake in Asia'
    ],
    correctIndex: 1,
    explanation: 'The Dead Sea has about 34% salinity, making it easy to float on the surface!',
  ),
  QuizQuestion(
    question: 'Wadi Rum is also known as the "Valley of the ___"?',
    options: ['Sun', 'Stars', 'Moon', 'Sand'],
    correctIndex: 2,
    explanation: 'Wadi Rum is nicknamed the "Valley of the Moon" due to its lunar-like landscape.',
  ),
  QuizQuestion(
    question: 'Which ancient empire built most of the ruins found in Jerash?',
    options: ['Greek', 'Roman', 'Ottoman', 'Egyptian'],
    correctIndex: 1,
    explanation: 'Jerash flourished under Roman rule, earning it the nickname "Pompeii of the East".',
  ),
  QuizQuestion(
    question: 'What colour gives Petra its nickname "The Rose City"?',
    options: ['White limestone', 'Red sandstone', 'Pink marble', 'Golden granite'],
    correctIndex: 1,
    explanation: 'Petra is carved from rose-red sandstone cliffs, giving it the famous nickname.',
  ),
  QuizQuestion(
    question: 'The Dead Sea is approximately how many metres below sea level?',
    options: ['-100m', '-200m', '-300m', '-430m'],
    correctIndex: 3,
    explanation: 'The Dead Sea shore is about 430 metres below sea level — the lowest point on Earth!',
  ),
  QuizQuestion(
    question: 'Which famous structure is the most iconic image of Petra?',
    options: ['The Monastery', 'The Treasury', 'The Colosseum', 'The Siq'],
    correctIndex: 1,
    explanation: 'Al-Khazneh (The Treasury) is the most photographed monument in Petra.',
  ),
  QuizQuestion(
    question: 'Wadi Rum was used as a filming location for which famous movie?',
    options: ['Star Wars', 'Jurassic Park', 'The Martian', 'Avatar'],
    correctIndex: 2,
    explanation: 'Wadi Rum\'s Mars-like landscape was used in "The Martian" (2015) starring Matt Damon!',
  ),
  QuizQuestion(
    question: 'In which part of Jordan is Wadi Rum located?',
    options: ['Northern Jordan', 'Western Jordan', 'Central Jordan', 'Southern Jordan'],
    correctIndex: 3,
    explanation: 'Wadi Rum is located in southern Jordan, near the city of Aqaba.',
  ),
  QuizQuestion(
    question: 'Which organisation designated Petra as a World Heritage Site?',
    options: ['United Nations', 'UNESCO', 'World Bank', 'Arab League'],
    correctIndex: 1,
    explanation: 'UNESCO designated Petra as a World Heritage Site in 1985.',
  ),
];
