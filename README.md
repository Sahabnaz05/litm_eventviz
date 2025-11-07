# litm_eventviz
Created by Sahabnaz Uddin for the LITM Internship Program Test

This Flutter app lets users register, log in, enter their city, and view 3 local events from Firestore.  
Users can see event details, log out, or delete their account.  
It uses Firebase Authentication and Cloud Firestore.

How to Run the App

1. Clone the repository  
   Open your terminal and run:

git clone https://github.com/Sahabnaz05/litm_eventviz.git
cd litm_eventviz

  
2. Install dependencies  
    Make sure Flutter is installed, then run:

flutter pub get


3. Connect Firebase  
   Run this command:

flutterfire configure

This links your Firebase project and generates the file lib/firebase_options.dart.

4. Add sample events to Firestore  
In the Firebase Console, go to Firestore Database and create a collection named events.  
Add three example event documents that each include a name, date, location, city, and description.

5. Run the app  
Launch the app by running:


flutter run


When the app starts, it will open with a login page.  
After signing up, the user is prompted to enter their city, and the app displays three events for that city with details and account options.


Time Breakdown

Project setup and Firebase configuration - 45 minutes  
Building login and registration screens - 1 hour 10 minutes  
Creating city input, home, and event detail screens - 1 hour 25 minutes  
Connecting Firestore data and testing user flows - 1 hour  
Fixing layout issues and debugging errors - 50 minutes  
Writing README and final cleanup - 33 minutes  
Total time: about 5 hours 43 minutes

