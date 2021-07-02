# maha_photo_booth_app

Maha Coding Challenge - Photo Booth App

## Approach
- Make a conceptual design of the task.
- Check which libraries I could need for the development of the app.
- With the design, I could know the pages that would form the app. Therefore, once libraries had been added and project set up, I created the different pages and added internationalization.
- Since the first part would be the Home page, I created a customized button widget and added it to the page. After, I developed the functionalities (camera + gallery opening), creating previously the sqflite database.
- Once Home page was developed, I started with the gallery. Fetching data from database was the first step, continuing with the design of the layout. Since I had many items, I decided to add a basic functionality: item deletion by swiping to the left and clicking the delete button. After it, I added the click item feature and completed the page development.
- The last point was programming the photo page. In this case I created the photo Widget and added the photo data (though it was not asked) at the bottom of the page.

## Improvements
- Photo edition: Allow user to edit photo data and even change the picture.
- Photo deletion (already developed): Allow user to edit the photo.
- Pagination on data fetching: Right now, all photos al loaded from the database into the listview. I would add pagination so not all are loaded but only the ones the user sees.
- Gridview: I would replace the listview by a gridview, so more pictures can be seen "per page". Photo data can be show above the photo (via Stack).
- Photos in Home page: I would remove the Gallery page and show the photos in the Home page. "View photos" button would disappear and the "Take photo" button would be replaced by a FloatingActionButton.

## Run the app
- Install Flutter.
- Download project.
- Connect device to computer (emulator should not be used since pictures need to be taken).
- Get pubspec libraries by running in terminal: flutter pub get
- Run in terminal at project folder level: flutter run lib/main.dart

## Automated testing
Automated testing was not implemented.