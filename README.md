# TinyGoalsBigImprovements

The goal of the app is to improve productivity in self improving tasks by setting utterly embarrasingly tiny goals a week. These goals lead to productivity boosts in tasks like workout, reading, studying, development, etc. One of such goal would be: do ten push ups a day, read two pages a day, run once around your house, etc.

<!-- vscode-markdown-toc -->
* 1. [Project structure and setup](#Projectstructureandsetup)
	* 1.1. [How to run and build the application](#Howtorunandbuildtheapplication)
		* 1.1.1. [Run the application in development mode](#Runtheapplicationindevelopmentmode)
		* 1.1.2. [Build the project](#Buildtheproject)
		* 1.1.3. [Test the project](#Testtheproject)
	* 1.2. [Domain models](#Domainmodels)
	* 1.3. [Software architecture](#Softwarearchitecture)
		* 1.3.1. [Responsibilities](#Responsibilities)
		* 1.3.2. [Dependencies](#Dependencies)
* 2. [Project design and structure](#Projectdesignandstructure)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='Projectstructureandsetup'></a>Project structure and setup

###  1.1. <a name='Howtorunandbuildtheapplication'></a>How to run and build the application

####  1.1.1. <a name='Runtheapplicationindevelopmentmode'></a>Run the application in development mode

Go into the directory `tiny_goals_big_improvements` and run one of these commands:

```bash
flutter run -d windows # on windows
flutter run -d linux   # on linux
flutter run -d android # on android
```

####  1.1.2. <a name='Buildtheproject'></a>Build the project

Go into the directory `tiny_goals_big_improvements` and run this command:

```bash
flutter build apk --no-tree-shake-icons # build for android
```

The build file goes into `tiny_goals_big_improvements/build/app/outputs/flutter-apk`.

We need to add the `--no-tree-shake-icons` flag because we use dynamic icons.

####  1.1.3. <a name='Testtheproject'></a>Test the project

Go into the directory `tiny_goals_big_improvements` and run this command:

```bash
flutter test
```

###  1.2. <a name='Domainmodels'></a>Domain models

![](docs/doman_model_graph.png)

###  1.3. <a name='Softwarearchitecture'></a>Software architecture

####  1.3.1. <a name='Responsibilities'></a>Responsibilities

**Repository**

The communication to the database happends in `tiny_goals_big_improvements/lib/repository`


**Database connection**

The database connection will get setup in `tiny_goals_big_improvements/lib/repository/database.dart`.

####  1.3.2. <a name='Dependencies'></a>Dependencies

**Database**

We use `sqflite` for the database communicaion.

##  2. <a name='Projectdesignandstructure'></a>Project design and structure

