# Vulcan
RISC-V Instruction Set Simulator Built For Education.

## Features
- [x] RV32I Extension.
- [x] Visualization of programming counter(pc), machine code and original instructions side-by-side.
- [x] Embedded editor inside Vulcan.
- [x] Integer registers visualization.
- [x] Single precision floating-point registers visualization.
- [x] Memory visualization.

## To do (In a near future).
- [x] Include Syntax Error Alert Analysis.
- [ ] RV32M Extension. __(Working on it...)__
- [ ] RV32F Extension.
- [ ] Add Suport to Assembly Directives.

## Limitations
* Unfortunately, by the time that I did the initial version, Flutter Web does not support responsive web apps. Because of it, one must use Vulcan in fullscreen mode. Otherwise, the app will throw overflow exceptions.

## Usage
### Web Browser Status
- [x] Google Chrome
- [ ] Mozilla Firefox
- [ ] Microsoft Edge

### How to use it?
* You must be familiar with RISC-V Assembly in order to use Vulcan properly. If you want to learn about it, you can check the documentation folder inside this repository.

### How to simulate my RISC-V Assembly code?
* You must go to the "Editor" tab and write your code inside the editor. When you are done, press the "Simulate" button.

### Local Usage
* First of all, you must install the Dart SDK in your computer: https://dart.dev/
* Then, you need to install the Flutter framework: https://flutter.dev/
* Since Vulcan is a Flutter WebApp, you must install the Web extension. More info can be found here: https://flutter.dev/docs/get-started/web
* After that, you can download this repository as a zip folder. Extract it in your machine. In the command line, get inside it and finally run the following command:
```
flutter run -d chrome
```
* Then you can use it as you please.
* __This is the version 1.0 (not the final).__

### Web usage
* You can use Vulcan online by the following link: https://vmmc2.github.io/vulcan
* __This is the version 1.0 (not the final).__

## Bugs and Errors
* __If you find any bugs, errors or strange behavior, feel free to open an issue. The only thing that I ask is to provide a detailed explanation of the bug/error/strange behavior. If possible, provide a screenshot.__

## Screenshots
### Home Page
![[homepage](https://http://riscv.org/)](vulcan_homepage.png)
### Editor Page
![[editorpage](https://http://riscv.org/)](vulcan_editorpage.png)
### Simulator Page 1
![[simpage1](https://http://riscv.org/)](vulcan_simulatorpage1.png)
### Simulator Page 2
![[simpage2](https://http://riscv.org/)](vulcan_simulatorpage2.png)
### Simulator Page 3
![[simpage3](https://http://riscv.org/)](vulcan_simulatorpage3.png)
### Simulator Page 4
![[simpage4](https://http://riscv.org/)](vulcan_simulatorpage4.png)
