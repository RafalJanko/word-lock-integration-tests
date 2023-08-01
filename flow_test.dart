import 'package:dictionary/main.dart';
import 'package:dictionary/methods/similar_word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

void main() {
  group('home page tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('finding the search bar on the main page',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar on the main page
      Finder searchBar = find.byType(TextField);

      //Assert
      //Expect only one search bar on the main page
      expect(searchBar, findsOneWidget);
    });

    testWidgets('finding the title on the main page',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the title on the main page + checking spelling
      Finder appTitle = find.text('Word Lock');

      //Assert
      //Expect only one title on the main page
      expect(appTitle, findsOneWidget);
    });

    testWidgets('finding the description on the main page',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the description on the main page + checking spelling
      Finder appDesc = find.text('Over 100,000 Definitions and Pronunciations');

      //Assert
      //Expect only one description on the main page
      expect(appDesc, findsOneWidget);
    });

    testWidgets('finding the footer on the main page',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the footer on the main page + checking spelling
      Finder appFoot = find.text('Powered by Merriam Webster © 2023');

      //Assert
      //Expect only one footer on the main page
      expect(appFoot, findsOneWidget);
    });

    testWidgets('finding the home button on the main page',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the home button on the main page
      Finder appHomeBut = find.text('Home');

      //Assert
      //Expect only one footer on the main page
      expect(appHomeBut, findsOneWidget);
    });

    testWidgets('finding the about button on the main page',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the about button on the main page
      Finder appAboutBut = find.text('About');

      //Assert
      //Expect only one About button on the main page
      expect(appAboutBut, findsOneWidget);
    });
  });

  group('valid search page tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets(
        'entering valid search page and checking if it displays as title',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, 'house');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Checking if the searched word appears on the new page
      Finder searchedWord = find.text('house');
      expect(searchedWord, findsOneWidget);
    });

    testWidgets(
        'tapping the search bar and hitting enter without providing input in the field',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, '');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Checking if the page after hitting enter without providing input is still the main page
      Finder appTitle = find.text('Word Lock');
      expect(appTitle, findsOneWidget);
    });

    testWidgets(
        'providing 1 letter input "y" and checking if it finds the word by checking if the font of the word on the next page is the title font',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, 'y');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Checking if the word searched appears as title on the new page
      Finder wordFinder = find.text('y');
      TextStyle? textStyle = tester.widget<Text>(wordFinder).style;
      expect(textStyle!.fontSize, 48);
    });

    testWidgets(
        'providing 10 letter input "substitute" and checking if it finds the word by checking if the font of the word on the next page is the title font',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, 'substitute');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Checking if the word searched appears as title on the new page
      Finder wordFinder = find.text('substitute');
      TextStyle? textStyle = tester.widget<Text>(wordFinder).style;
      expect(textStyle!.fontSize, 48);
    });

    testWidgets(
        'FAILED: providing 45 (longest word in the English language) letter input and checking if it finds the word by checking if the font of the word on the next page is the title font',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(
          searchBar, 'pneumonoultramicroscopicsilicovolcanoconiosis');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Checking if the word searched appears as title on the new page
      Finder wordFinder =
          find.text('pneumonoultramicroscopicsilicovolcanoconiosis');
      TextStyle? textStyle = tester.widget<Text>(wordFinder).style;
      expect(textStyle!.fontSize, 48);
    });

    testWidgets(
        'providing only capital letter input and checking if it finds the word by checking if the font of the word on the next page is the title font',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, 'CAT');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Checking if the word searched appears as title on the new page
      Finder wordFinder = find.text('CAT');
      TextStyle? textStyle = tester.widget<Text>(wordFinder).style;
      expect(textStyle!.fontSize, 48);
    });

    testWidgets(
        'providing only lower case letter input and checking if it finds the word by checking if the font of the word on the next page is the title font',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, 'cat');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Checking if the word searched appears as title on the new page
      Finder wordFinder = find.text('cat');
      TextStyle? textStyle = tester.widget<Text>(wordFinder).style;
      expect(textStyle!.fontSize, 48);
    });

    testWidgets(
        'providing mixed case letter input and checking if it finds the word by checking if the font of the word on the next page is the title font',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, 'CAts');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Checking if the word searched appears as title on the new page
      Finder wordFinder = find.text('CAts');
      TextStyle? textStyle = tester.widget<Text>(wordFinder).style;
      expect(textStyle!.fontSize, 48);
    });

    testWidgets(
        'providing only digit "7" input and checking if it finds the word by checking if the font of the word on the next page is the title font',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, '7');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Checking if the word searched appears as title on the new page
      Finder wordFinder = find.text('7');
      TextStyle? textStyle = tester.widget<Text>(wordFinder).style;
      expect(textStyle!.fontSize, 48);
    });

    testWidgets(
        'providing only special character "!" input and checking if it finds the word by checking if the font of the word on the next page is the title font',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, '!');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Checking if the word searched appears as title on the new page
      Finder wordFinder = find.text('!');
      TextStyle? textStyle = tester.widget<Text>(wordFinder).style;
      expect(textStyle!.fontSize, 48);
    });

    testWidgets('checking for the presence of the pronunciation icon',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, 'house');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));

      //Assert
      //Looking for the pronunciation buttons
      Finder wordPronun = find.byType(IconButton);
      expect(wordPronun, findsNWidgets(2));
    });

    testWidgets(
        'entering valid search page and checking if the "noun", "verb" etc buttons work',
        (WidgetTester tester) async {
      //Arrange
      //Running the main application - starts with the home screen by default
      await tester.pumpWidget(const MaterialApp(home: MyApp()));

      //Act
      //Finding the search bar
      Finder searchBar = find.byType(TextField);
      //Entering the text in the search bar
      await tester.enterText(searchBar, 'sun');
      //Hitting submit and waiting for the searched word page to load
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 3));
      //Expecting the initial selected meaning to be the first one
      expect(
          find.text("the heat or light radiated from the sun"), findsOneWidget);
      //Tapping on the second meaning option
      await tester.tap(find.text("verb"));
      await tester.pumpAndSettle();
      //Expecting the selected meaning
      expect(find.text("to sun oneself"), findsOneWidget);
      //Tapping on the third meaning option
      await tester.tap(find.text("abbreviation"));
      await tester.pumpAndSettle();

      //Assert
      //Expecting the selected meaning
      expect(find.text("Sunday"), findsOneWidget);
    });

    group('invalid search page tests', () {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      testWidgets(
          'entering invalid search page and checking if it displays the no such word page',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'asdadfsdfas');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word page" is viewed on the loaded page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
      });

      testWidgets(
          'entering invalid search page and checking if it displays the suggestion text',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'asdadfsdfas');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word" is viewed on the loaded page
        expect(
            find.text('However, here are three words with similar spellings:'),
            findsOneWidget);
      });

      testWidgets(
          'entering invalid search page and checking if it displays the suggestion words (3)',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'asdadfsdfas');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if there are 3 widgets called simmilar word (suggestions) on the loaded page
        Finder suggestions = find.byType(SimilarWord);
        expect(suggestions, findsNWidgets(3));
      });

      testWidgets(
          'entering invalid search page and clicking on the suggestion and checking if the suggestion definition shows up',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'asdadfsdfas');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Looking for the suggested word "the" (easter egg)
        final Finder button = find.text('the');
        //Clicking the "the" button and waiting for the new page to load
        await tester.tap(button);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the new page has a title "the"
        Finder wordFinder = find.text('the');
        TextStyle? textStyle = tester.widget<Text>(wordFinder).style;
        expect(textStyle!.fontSize, 48);
      });

      testWidgets(
          'providing 46+ letter input and checking if it displays the no such word screen',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search button
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(
            searchBar, 'pneumonoultramicroscopicsilicovolcanoconiosisies');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word page" is viewed on the loaded page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
      });

      testWidgets(
          'providing misspelled word input "hosue" instead of "house" and checking if it displays the no such word screen',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'hosue');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word page" is viewed on the loaded page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
      });

      testWidgets(
          'providing letter and digit "asd4" input and checking if it displays the no such word screen',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'asd4');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word page" is viewed on the loaded page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
      });

      testWidgets(
          'providing another language letter input "Straße" and checking if it displays the no such word screen',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'Straße');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word page" is viewed on the loaded page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
      });

      testWidgets(
          'providing input with a space "mammals and reptiles" and cand checking if it displays the no such word screen',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'mammals and reptiles');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word page" is viewed on the loaded page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
      });

      testWidgets(
          'providing input used for XSS injection and cand checking if it displays the no such word screen',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, '<body onload=alert("test1")>');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word page" is viewed on the loaded page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
      });

      testWidgets(
          'providing input used for SQL injection and cand checking if it displays the no such word screen',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(
            searchBar, 'SELECT * FROM Users WHERE UserId = 105 OR 1=1');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word page" is viewed on the loaded page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
      });

      testWidgets(
          'providing input used for JavaScript injection and cand checking if it displays the no such word screen',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'javascript:alert(‘Executed!’);');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word page" is viewed on the loaded page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
      });

      testWidgets(
          'providing input used for HTML injection and cand checking if it displays the no such word screen',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar,
            "<html>\n <body>\n <script>\n alert( 'Hello, world!' );\n <script>\n <body>\n <html>\n");
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Checking if the text from "so such word page" is viewed on the loaded page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
      });
    });

    group('"About" page tests', () {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      testWidgets('finding the "title" in the About section to verify spelling',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the "About" button
        Finder aboutBtn = find.text('About');
        //Clicking the about button and waiting for the new page to load
        await tester.tap(aboutBtn);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Finding the Title text
        Finder reportBug = find.text('\nCreated with ❤️ by Dhruv Badaya');

        //Assert
        //Expecting only 1 widget with the exact text
        expect(reportBug, findsOneWidget);
      });

      testWidgets(
          'finding the "description" in the About section to verify spelling',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the "About" button
        Finder aboutBtn = find.text('About');
        //Clicking the about button and waiting for the new page to load
        await tester.tap(aboutBtn);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Finding the description text
        Finder reportBug = find.text(
            '\nI do not generate any profit from this app. I need your support to keep this app running free. Buy me a coffee to support me.\n');

        //Assert
        //Expecting only 1 widget with the exact text
        expect(reportBug, findsOneWidget);
      });

      testWidgets(
          'finding the "Buy me a Coffee" in the About section to verify spelling',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the "About" button
        Finder aboutBtn = find.text('About');
        //Clicking the about button and waiting for the new page to load
        await tester.tap(aboutBtn);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Finding the text
        Finder coffeeSpelling = find.text('Buy me a Coffee');

        //Assert
        //Expecting only 1 widget with the exact text
        expect(coffeeSpelling, findsOneWidget);
      });

      testWidgets(
          'finding the "View developer Website" in the About section to verify spelling',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the "About" button
        Finder aboutBtn = find.text('About');
        //Clicking the about button and waiting for the new page to load
        await tester.tap(aboutBtn);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Finding the text
        Finder devWebsite = find.text('View Developer Website');

        //Assert
        //Expecting only 1 widget with the exact text
        expect(devWebsite, findsOneWidget);
      });

      testWidgets(
          'finding the "Hire me for a Project" in the About section to verify spelling',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the "About" button
        Finder aboutBtn = find.text('About');
        //Clicking the about button and waiting for the new page to load
        await tester.tap(aboutBtn);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Finding the text
        Finder hireMe = find.text('Hire me for a Project');

        //Assert
        //Expecting only 1 widget with the exact text
        expect(hireMe, findsOneWidget);
      });

      testWidgets(
          'finding the "Report a bug" in the About section to verify spelling',
          (WidgetTester tester) async {
        //Arrange
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the "About" button
        Finder aboutBtn = find.text('About');
        //Clicking the about button and waiting for the new page to load
        await tester.tap(aboutBtn);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Finding the text
        Finder reportBug = find.text('Report a bug');

        //Assert
        //Expecting only 1 widget with the exact text
        expect(reportBug, findsOneWidget);
      });

      testWidgets(
          'entering the aboout page from the main page and looking for the title to confirm',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));
        Finder aboutText = find.text('\nCreated with ❤️ by Dhruv Badaya');

        //Act
        //Finding the "About" button
        Finder aboutBtn = find.text('About');
        //Clicking the about button and waiting for the new page to load
        await tester.tap(aboutBtn);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Assert
        //Expecting only 1 widget with the exact text
        expect(aboutText, findsOneWidget);
      });
      testWidgets(
          'FAILED: opening the buy me coffee link in about section - WARNING: Please check if the page loads. Flutter does not check http codes.',
          (WidgetTester tester) async {
        //Arrange
        //Setting up the application
        await tester.pumpAndSettle();

        //Act
        //Preparing the exact url to open
        final String url = 'https://dhruvbadaya.com/coffee';
        //Opening the URL to manuually test if the page displays
        await url_launcher.launch(url, webOnlyWindowName: '_blank');
        await tester.pumpAndSettle(Duration(seconds: 5));
        // Test written for semi-automated testing (as it open the link but the tester needs to check if the website loads)
      });

      testWidgets(
          'opening the View Developer Website link in about section - WARNING: Please check if the page loads. Flutter does not check http codes.',
          (WidgetTester tester) async {
        //Arrange
        //Setting up the application
        await tester.pumpAndSettle();

        //Act
        //Preparing the exact url to open
        final String url = 'https://dhruvbadaya.com';
        //Opening the URL to manuually test if the page displays
        await url_launcher.launch(url, webOnlyWindowName: '_blank');
        await tester.pumpAndSettle(Duration(seconds: 5));
        // Test written for semi-automated testing (as it open the link but the tester needs to check if the website loads)
      });

      testWidgets(
          'FAILED: opening the report a bug link in about section - WARNING: Please check if the page loads. Flutter does not check http codes.',
          (WidgetTester tester) async {
        //Arrange
        //Setting up the application
        await tester.pumpAndSettle();

        //Act
        //Preparing the exact url to open
        final String url = 'https://dhruvbadaya.com/reportbug';
        //Opening the URL to manuually test if the page displays
        await url_launcher.launch(url, webOnlyWindowName: '_blank');
        await tester.pumpAndSettle(Duration(seconds: 5));
        // Test written for semi-automated testing (as it open the link but the tester needs to check if the website loads)
      });

      testWidgets(
          'FAILED: opening the contact link in about section - WARNING: Please check if the page loads. Flutter does not check http codes.',
          (WidgetTester tester) async {
        //Arrange
        //Setting up the application
        await tester.pumpAndSettle();

        //Act
        //Preparing the exact url to open
        final String url = 'https://dhruvbadaya.com/contact';
        await url_launcher.launch(url, webOnlyWindowName: '_blank');
        await tester.pumpAndSettle(Duration(seconds: 5));
        // Test written for semi-automated testing (as it open the link but the tester needs to check if the website loads)
      });

      testWidgets('Check if Links in About section open in new browser window',
          (WidgetTester tester) async {
        //Arrange
        //Runing the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Finding the about button and clicking it
        Finder aboutBtn = find.text('About');
        await tester.tap(aboutBtn);
        await tester.pumpAndSettle(Duration(seconds: 3));

        //Act
        //tap the about button from the main page
        //tap each CustomAboutListTile widget to open the URLs
        await tester.tap(find.text('Buy me a Coffee'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('View Developer Website'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Hire me for a Project'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Report a bug'));
        await tester.pumpAndSettle();

        // Assert
        // Verify if links open in a new browser Window
        expect(await canLaunch('https://dhruvbadaya.com/coffee'), isTrue);
        expect(await canLaunch('https://dhruvbadaya.com'), isTrue);
        expect(await canLaunch('https://dhruvbadaya.com/contact'), isTrue);
        expect(await canLaunch('https://dhruvbadaya.com/reportbug'), isTrue);
      });
    });

    group('"Back" button tests', () {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

      testWidgets(
          'Checking if flow of going the the "About" page and back causes any issues',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the "About" button
        Finder aboutBtn = find.text('About');
        //Clicking the about button and waiting for the new page to load
        await tester.tap(aboutBtn);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Finding the Title text
        Finder titleWidget = find.text('\nCreated with ❤️ by Dhruv Badaya');
        //Expecting only 1 widget with the exact text
        expect(titleWidget, findsOneWidget);
        //Finding the "Back" button
        final backButton = find.byTooltip("Back");
        //Clicking the "Back" button and waiting for the page to load
        await tester.tap(backButton);
        await tester.pumpAndSettle();
        //Finding the description on the main page + checking spelling
        Finder appDesc =
            find.text('Over 100,000 Definitions and Pronunciations');

        //Assert
        //Expect only one description on the main page
        expect(appDesc, findsOneWidget);
      });

      testWidgets(
          'entering invalid search page and clicking on the suggestion and checking if using the back button twice works',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'asdadfsdfas');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Looking for the suggested word "the" (easter egg)
        final Finder button = find.text('the');
        //Clicking the "the" button and waiting for the new page to load
        await tester.tap(button);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Checking if the new page has a title "the"
        Finder wordFinder = find.text('the');
        TextStyle? textStyle = tester.widget<Text>(wordFinder).style;
        expect(textStyle!.fontSize, 48);
        //Finding the "Back" button
        final backButton = find.byTooltip("Back");
        //Clicking the "Back" button and waiting for the page to load
        await tester.tap(backButton);
        await tester.pumpAndSettle();
        //Check if the loaded page is the "no such word" page
        expect(find.text('Sorry Buddy, We did not find your word. 🥺'),
            findsOneWidget);
        //Clicking the "Back" button and waiting for the page to load
        await tester.tap(backButton);
        await tester.pumpAndSettle();
        //Finding the description on the main page + checking spelling
        Finder appDesc =
            find.text('Over 100,000 Definitions and Pronunciations');

        //Assert
        //Expect only one description on the main page
        expect(appDesc, findsOneWidget);
      });

      testWidgets(
          'entering valid search page and checking if the "noun", "verb" etc buttons work and then clicking back buton expecting to land on home page',
          (WidgetTester tester) async {
        //Arrange
        //Running the main application - starts with the home screen by default
        await tester.pumpWidget(const MaterialApp(home: MyApp()));

        //Act
        //Finding the search bar
        Finder searchBar = find.byType(TextField);
        //Entering the text in the search bar
        await tester.enterText(searchBar, 'sun');
        //Hitting submit and waiting for the searched word page to load
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle(Duration(seconds: 3));
        //Expecting the initial selected meaning to be the first one
        expect(find.text("the heat or light radiated from the sun"),
            findsOneWidget);
        //Tapping on the second meaning option
        await tester.tap(find.text("verb"));
        await tester.pumpAndSettle();
        //Expecting the selected meaning
        expect(find.text("to sun oneself"), findsOneWidget);
        //Tapping on the third meaning option
        await tester.tap(find.text("abbreviation"));
        await tester.pumpAndSettle();
        //Expecting the selected meaning
        expect(find.text("Sunday"), findsOneWidget);
        //Finding the "Back" button
        final backButton = find.byTooltip("Back");
        //Clicking the "Back" button and waiting for the page to load
        await tester.tap(backButton);
        await tester.pumpAndSettle();
        Finder appDesc =
            find.text('Over 100,000 Definitions and Pronunciations');

        //Assert
        //Expect only one description on the main page
        expect(appDesc, findsOneWidget);
      });
    });
  });
}
