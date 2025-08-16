import 'package:drift/drift.dart';
import 'package:quoting/infrastructure/settings/drift/drift_db.dart';
import 'package:quoting/init_dependencies.dart';

import 'dart:math';

Future<void> seedDatabase({int count = 500}) async {
  final db = serviceLocator<DriftDB>();
  final random = Random();

  // Realistic authors
  final authors = [
    'Albert Einstein',
    'Maya Angelou',
    'Oscar Wilde',
    'Mark Twain',
    'Jane Austen',
    'Friedrich Nietzsche',
    'Virginia Woolf',
    'Confucius',
    'Socrates',
    'Lao Tzu',
    'Rumi',
    'George Orwell',
    'Leo Tolstoy',
    'Emily Dickinson',
    'Walt Whitman',
    'Simone de Beauvoir',
    'James Baldwin',
    'Carl Jung',
    'Hannah Arendt',
    'Nelson Mandela',
  ];

  // Realistic labels
  final labels = [
    'Inspiration',
    'Wisdom',
    'Love',
    'Life',
    'Courage',
    'Philosophy',
    'Humor',
    'Friendship',
    'Motivation',
    'Happiness',
    'Change',
    'Success',
    'Hope',
    'Truth',
    'Freedom',
    'Peace',
    'Art',
    'Education',
    'Justice',
    'Kindness',
  ];

  // Realistic sources
  final sources = [
    'Book',
    'Speech',
    'Interview',
    'Essay',
    'Poem',
    'Letter',
    'Article',
    'Autobiography',
    'Novel',
    'Play',
    'Lecture',
    'Memoir',
    'Journal',
    'Film',
    'Song',
    'Podcast',
    'Conference',
    'Debate',
    'Documentary',
    'Blog',
  ];

  // Realistic quotes
  final quotes = [
    "Life is what happens when you're busy making other plans.",
    "Be yourself; everyone else is already taken.",
    "If you judge people, you have no time to love them.",
    "The only way to do great work is to love what you do.",
    "To be yourself in a world that is constantly trying to make you something else is the greatest accomplishment.",
    "Not everything that is faced can be changed, but nothing can be changed until it is faced.",
    "The unexamined life is not worth living.",
    "Happiness depends upon ourselves.",
    "We accept the love we think we deserve.",
    "The only thing necessary for the triumph of evil is for good men to do nothing.",
    "You must be the change you wish to see in the world.",
    "What we think, we become.",
    "Do not go where the path may lead, go instead where there is no path and leave a trail.",
    "The best way out is always through.",
    "It is never too late to be what you might have been.",
    "The mind is everything. What you think you become.",
    "To live is the rarest thing in the world. Most people exist, that is all.",
    "We are what we repeatedly do. Excellence, then, is not an act, but a habit.",
    "The only true wisdom is in knowing you know nothing.",
    "Turn your wounds into wisdom.",
    "Success is not final, failure is not fatal: it is the courage to continue that counts.",
    "In the end, we will remember not the words of our enemies, but the silence of our friends.",
    "The greatest glory in living lies not in never falling, but in rising every time we fall.",
    "The purpose of our lives is to be happy.",
    "Get busy living or get busy dying.",
    "You only live once, but if you do it right, once is enough.",
    "Many of life’s failures are people who did not realize how close they were to success when they gave up.",
    "If you want to live a happy life, tie it to a goal, not to people or things.",
    "Never let the fear of striking out keep you from playing the game.",
    "Money and success don’t change people; they merely amplify what is already there.",
    "Your time is limited, don’t waste it living someone else’s life.",
    "Not how long, but how well you have lived is the main thing.",
    "If life were predictable it would cease to be life, and be without flavor.",
    "The whole secret of a successful life is to find out what is one’s destiny to do, and then do it.",
    "In order to write about life first you must live it.",
    "The big lesson in life, baby, is never be scared of anyone or anything.",
    "Curiosity about life in all of its aspects, I think, is still the secret of great creative people.",
    "Life is not a problem to be solved, but a reality to be experienced.",
    "The way I see it, if you want the rainbow, you gotta put up with the rain.",
    "Do not let making a living prevent you from making a life.",
    "Life is really simple, but we insist on making it complicated.",
    "Life itself is the most wonderful fairy tale.",
    "The healthiest response to life is joy.",
    "Keep smiling, because life is a beautiful thing and there’s so much to smile about.",
    "The best way to predict your future is to create it.",
    "You do not find the happy life. You make it.",
    "Sometimes you will never know the value of a moment until it becomes a memory.",
    "The only impossible journey is the one you never begin.",
    "In the middle of every difficulty lies opportunity.",
    "What lies behind us and what lies before us are tiny matters compared to what lies within us.",
    "The only limit to our realization of tomorrow will be our doubts of today.",
    "Act as if what you do makes a difference. It does.",
    "Dwell on the beauty of life. Watch the stars, and see yourself running with them.",
    "The future belongs to those who believe in the beauty of their dreams.",
    "It does not matter how slowly you go as long as you do not stop.",
    "Everything you can imagine is real.",
    "Whatever you are, be a good one.",
    "The journey of a thousand miles begins with one step.",
    "You must do the things you think you cannot do.",
    "The only person you are destined to become is the person you decide to be.",
    "Believe you can and you're halfway there.",
    "What you get by achieving your goals is not as important as what you become by achieving your goals.",
    "Dream big and dare to fail.",
    "It always seems impossible until it’s done.",
    "Don’t watch the clock; do what it does. Keep going.",
    "Keep your face always toward the sunshine—and shadows will fall behind you.",
    "Opportunities don't happen, you create them.",
    "Don’t be afraid to give up the good to go for the great.",
    "I find that the harder I work, the more luck I seem to have.",
    "Success is not in what you have, but who you are.",
    "The road to success and the road to failure are almost exactly the same.",
    "Success usually comes to those who are too busy to be looking for it.",
    "Don’t be distracted by criticism. Remember—the only taste of success some people get is to take a bite out of you.",
    "Success is walking from failure to failure with no loss of enthusiasm.",
    "If you are not willing to risk the usual, you will have to settle for the ordinary.",
    "I never dreamed about success. I worked for it.",
    "Try not to become a man of success. Rather become a man of value.",
    "Stop chasing the money and start chasing the passion.",
    "Success is not how high you have climbed, but how you make a positive difference to the world.",
    "Success is liking yourself, liking what you do, and liking how you do it.",
    "Success isn’t just about what you accomplish in your life; it’s about what you inspire others to do.",
    "Fall seven times and stand up eight.",
    "The harder you work for something, the greater you’ll feel when you achieve it.",
    "Dream bigger. Do bigger.",
    "Don’t stop when you’re tired. Stop when you’re done.",
    "Wake up with determination. Go to bed with satisfaction.",
    "Do something today that your future self will thank you for.",
    "Little things make big days.",
    "It’s going to be hard, but hard does not mean impossible.",
    "Push yourself, because no one else is going to do it for you.",
    "Great things never come from comfort zones.",
    "Success doesn’t just find you. You have to go out and get it.",
    "The harder you work, the luckier you get.",
    "Don’t wait for opportunity. Create it.",
    "Sometimes we’re tested not to show our weaknesses, but to discover our strengths.",
    "The key to success is to focus our conscious mind on things we desire not things we fear.",
    "Success is the sum of small efforts, repeated day in and day out.",
    "The only place where success comes before work is in the dictionary.",
    "Don’t be afraid to give up the good to go for the great.",
    "I find that the harder I work, the more luck I seem to have.",
    "Success is not in what you have, but who you are.",
    "The road to success and the road to failure are almost exactly the same.",
    "Success usually comes to those who are too busy to be looking for it.",
    "Don’t be distracted by criticism. Remember—the only taste of success some people get is to take a bite out of you.",
    "Success is walking from failure to failure with no loss of enthusiasm.",
    "If you are not willing to risk the usual, you will have to settle for the ordinary.",
    "I never dreamed about success. I worked for it.",
    "Try not to become a man of success. Rather become a man of value.",
    "Stop chasing the money and start chasing the passion.",
    "Success is not how high you have climbed, but how you make a positive difference to the world.",
    "Success is liking yourself, liking what you do, and liking how you do it.",
    "Success isn’t just about what you accomplish in your life; it’s about what you inspire others to do.",
    "Fall seven times and stand up eight.",
    "The harder you work for something, the greater you’ll feel when you achieve it.",
    "Dream bigger. Do bigger.",
    "Don’t stop when you’re tired. Stop when you’re done.",
    "Wake up with determination. Go to bed with satisfaction.",
    "Do something today that your future self will thank you for.",
    "Little things make big days.",
    "It’s going to be hard, but hard does not mean impossible.",
    "Push yourself, because no one else is going to do it for you.",
    "Great things never come from comfort zones.",
    "Success doesn’t just find you. You have to go out and get it.",
    "The harder you work, the luckier you get.",
    "Don’t wait for opportunity. Create it.",
    "Sometimes we’re tested not to show our weaknesses, but to discover our strengths.",
    "The key to success is to focus our conscious mind on things we desire not things we fear.",
    "Success is the sum of small efforts, repeated day in and day out.",
    "The only place where success comes before work is in the dictionary."
  ];

  // Insert Authors
  final authorIds = <int>[];
  for (final author in authors) {
    final id = await db.into(db.authors).insert(
          AuthorsCompanion(name: Value(author)),
        );
    authorIds.add(id);
  }

  // Insert Labels
  final labelIds = <int>[];
  for (final label in labels) {
    final id = await db.into(db.labels).insert(
          LabelsCompanion(content: Value(label)),
        );
    labelIds.add(id);
  }

  // Insert Sources
  final sourceIds = <int>[];
  for (final source in sources) {
    final id = await db.into(db.sources).insert(
          SourcesCompanion(content: Value(source)),
        );
    sourceIds.add(id);
  }

  // Insert Quotes
  for (int i = 0; i < count; i++) {
    final quoteText = quotes[random.nextInt(quotes.length)];
    final authorId = authorIds[random.nextInt(authorIds.length)];
    final labelId = labelIds[random.nextInt(labelIds.length)];
    final sourceId = sourceIds[random.nextInt(sourceIds.length)];
    final details =
        'Page ${random.nextInt(400) + 1}, Paragraph ${random.nextInt(8) + 1}';
    await db.into(db.quotes).insert(
          QuotesCompanion.insert(
            content: quoteText,
            details: details,
            authorId: Value(authorId),
            labelId: Value(labelId),
            sourceId: Value(sourceId),
          ),
        );
  }
}
