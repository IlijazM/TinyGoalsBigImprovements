# TinyGoalsBigImprovements

The goal of the app is to improve productivity in self improving tasks by setting utterly embarrasingly tiny goals a week. These goals lead to productivity boosts in tasks like workout, reading, studying, development, etc. One of such goal would be: do ten push ups a day, read two pages a day, run once around your house, etc.

<!-- vscode-markdown-toc -->

- 1. [Project structure and setup](#Projectstructureandsetup)
  - 1.1. [How to run and build the application](#Howtorunandbuildtheapplication)
    - 1.1.1. [Run the application in development mode](#Runtheapplicationindevelopmentmode)
    - 1.1.2. [Build the project](#Buildtheproject)
  - 1.2. [Domain models](#Domainmodels)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

## 1. <a name='Projectstructureandsetup'></a>Project structure and setup

### 1.1. <a name='Howtorunandbuildtheapplication'></a>How to run and build the application

#### 1.1.1. <a name='Runtheapplicationindevelopmentmode'></a>Run the application in development mode

```bash
flutter run -d windows # on windows
flutter run -d linux   # on linux
flutter run -d android # on android
```

#### 1.1.2. <a name='Buildtheproject'></a>Build the project

```bash
flutter build apk --no-tree-shake-icons # build for android
```

### 1.2. <a name='Domainmodels'></a>Domain models

![](docs/doman_model_graph.png)
