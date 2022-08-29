<p align="center">
  <img src="https://user-images.githubusercontent.com/63500798/187219188-106339e2-cc02-49f6-81e0-9b1fd30da011.svg">
</p>

# QuizTastic
A REST API server and a mobile application that can store questions with answer options and perform CRUD operation both online and offline.

- The same mobile application is made in both **Kotlin** and **Flutter**

- Used technologies and concepts:

  - Mobile application in **Kotlin**: Jetpack Compose, Room (database)
  - Mobile application in **Dart**: Flutter, Drift (database)
  - Server in **Python**: FastAPI
  
- Functionalities

  - By using WebSockets when the device is online, the list will be updated if questions are added by other online users; if the device is offline and comes back online, the application will automatically atempt to reconnect with the server using WebSockets 

  - Add question (with field validations); if the device is offline, all of the added questions will be stored locally on the device; when the device comes back online, the unsynchronized questions will be added to the server
  
  - Edit a specific question (with field validations)
  
  - Delete a specific question
  
  - Loading icons for each REST API operation
  
  - Toasts for successful or unsuccesful operations
  
  - Logs for each operation
