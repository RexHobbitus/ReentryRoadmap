# ReentryRoadmap
The Dignifi Reentry Roadmap

Google Maps API Key: AIzaSyCy3mK_j0BkAkVyLUl2eQlCB7rugYIgQIc

Firebase Console: https://console.firebase.google.com/u/4/project/dignifi-4734f/settings/general/android:com.dignifi.elp

Project Plan: https://docs.google.com/document/d/1qh6nYtIoLk3SCgy1w7i65mkEFARC9VW1/edit?usp=sharing&ouid=111932539028769608783&rtpof=true&sd=true

Data Information: https://docs.google.com/document/d/1WB1_4Ag4AhMdLL1pKCAz1oXL769oyNVykCOUNMegWck/edit?usp=sharing

Data structure ideas: https://1drv.ms/w/s!AoAwfpmucUUlhs1ke9VtK3tHkGnkBA?e=dMVQY0

Figma Designs: https://www.figma.com/design/qVIomzGrpswDvT58SzL7B3/Roadmap?node-id=1032-38796&m=dev



# Flutter Information

## Flutter

| Version | Channel | Repository                               |
|---|---------|------------------------------------------|
| 3.24.3   | stable  | [Flutter Repo](https://github.com/flutter/flutter.git) |

### Framework/FEATURES

| Architecture & Services       | 
|-------------------------------|
| CLEAN CODE ARCHITECTURE       |
| FIREBASE                      |
| BLOC (CUBIT) STATE MANAGEMENT |

### Engine

| Revision       |
|----------------|
| 36335019a8     |

## Tools

| Dart Version | DevTools Version |
|--------------|------------------|
| 3.5.3        | 2.37.3           |



------------------------------------------------------------

# Create New screen Steps
#### For example you want to create a new screen for Login page. we will do following steps.
#####     *) create a folder with name "login" inside lib=>presentation=>pages=>authentication
#####    *) now open terminal in current source code folder and run following commands

#####     cd tools/mason_template
#####    mason make page -o ${ENTER_YOUR_PATH_TO_LOGIN_FOLDER} press enter and type name as 'login' and then press enter again.

#####    *) It will take 1-2 second and will create your 5 files inside 'login' folder.
#####    *) Now Goto lib => service_locator => app_cubits.dart
#####    *) Add/Register your respective new files (login_cubit and login_navigator) inside gitIt just like SplashCubit already added
#####    *) Add your new screen route in lib=>core=>routes=>app_router
#####    *) You are done.






