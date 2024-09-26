Team 41 - House Targaryen

Project 18 - RemindMate

Project description:

This project involves creating a mobile application designed to help users maintain and strengthen their social connections. The app will offer the
following key functionalities:
Add Friends: Users can easily add their friends' names and contact information, whether they are local or abroad.
Customisable Reminders: Users can set personalized reminders at chosen intervals to prompt them to reach out and send messages to their
friends, ensuring regular communication. No message sending within the app though.
Friendship Notes: Users can store detailed information about each friend, including birthdays, important dates, and notes on past
conversations, serving as a comprehensive "friendship journal."
Notifications: The app sends timely notifications based on the set reminders, helping users never miss an opportunity to connect with their
friends.
User-Friendly Interface: The app should feature an intuitive design, allowing users to effortlessly navigate, add friends, set reminders, and
manage notes.

Project managment:

https://uoa-cs399-team-41.atlassian.net/jira/software/projects/KAN/boards/1

Technologies used in this project:

- Flutter
- Springboot
- Java
- GRPC (4.0)
- Dart
- Auth0
- Firebase (1.7.2)
- Isar (3.1.0)
- UUID (4.5.0)

Install instructions:

To install and setup this project you need Java and Flutter installed. 
The Mobile application can be run by setting the base url of the backend via the ENV variable "GRPC_BASE_URL" and by running the command flutter run . in the Mobile directory of this project.
To run the Springboot backend you can run ./gradlew clean run in the Server directory

Future plans:

In future releases we want to automate the creation of key event for contacts based on what type of contact they are for example we want mothers and fathers to have fathers day and mothers day pre created when a contact is created. As well as contacts birthdays being created as reminders. We also want to intergrate deeper into the mobile operating system so that you can link to a text chain or call a contact directly from the app. 