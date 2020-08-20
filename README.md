# Vulcan
RISC-V Instruction Set Simulator Built For Education.

## Features
- [x] RV32I Extension.
- [x] RV32A Extension.
- [x] RV32M Extension.
- [x] Visualization of programming counter (PC), machine code and original instructions side-by-side.
- [x] Embedded editor inside Vulcan.
- [x] Integer registers visualization.
- [x] Single precision floating-point registers visualization.
- [x] Memory visualization.
- [x] Syntax Error Alert.

## Implemented Instructions
### RV32I Extension
- [x] lui
- [x] auipc
- [x] jal
- [x] jalr
- [x] beq
- [x] bne
- [x] blt
- [x] bge
- [x] bltu
- [x] bgeu
- [x] lb
- [x] lh
- [x] lw
- [x] lbu
- [x] lhu
- [x] sb
- [x] sh
- [x] sw
- [x] addi
- [x] slti
- [x] sltiu
- [x] xori
- [x] ori
- [x] andi
- [x] slli
- [x] srli
- [x] srai
- [x] add
- [x] sub
- [x] sll
- [x] slt
- [x] sltu
- [x] xor
- [x] srl
- [x] sra
- [x] or
- [x] and
- [ ] fence
- [ ] fence.i
- [ ] ecall
- [ ] ebreak
- [ ] csrrw
- [ ] csrrs
- [ ] csrrc
- [ ] csrrwi
- [ ] csrrsi
- [ ] csrrci

### RV32M Extension
- [x] mul
- [x] mulh
- [x] mulhsu
- [x] mulhu
- [x] div
- [x] divu
- [x] rem
- [x] remu

### RV32F Extension
- [ ] flw
- [ ] fsw
- [ ] fmadd.s
- [ ] fmsub.s
- [ ] fnmsub.s
- [ ] fnmadd.s
- [ ] fadd.s
- [ ] fsub.s
- [ ] fmul.s
- [ ] fdiv.s
- [ ] fsqrt.s
- [ ] fsgnj.s
- [ ] fsgnjn.s
- [ ] fsgnjx.s
- [ ] fmin.s
- [ ] fmax.s
- [ ] fcvt.w.s
- [ ] fcvt.wu.s
- [ ] fmv.x.w
- [ ] feq.s
- [ ] flt.s
- [ ] fle.s
- [ ] fclass.s
- [ ] fcvt.s.w
- [ ] fcvt.s.wu
- [ ] fmv.w.x

### RV32A Extension
- [x] lr.w
- [x] sc.w
- [x] amoswap.w
- [x] amoadd.w
- [x] amorxor.w
- [x] amoand.w
- [x] amoor.w
- [x] amomin.w
- [x] amomax.w
- [x] amominu.w
- [x] amomaxu.w

## To do (In a near future)
- [ ] RV32F Extension. (__Studying how to do it in a proper way...__)
- [ ] RV32A Extension. (__Maybe...__)

## Limitations
* Unfortunately, by the time that I did the initial version, Flutter Web does not support responsive web apps. Because of it, one must use Vulcan in fullscreen mode. Otherwise, the app will throw overflow exceptions.

## Usage
### Web Browser Status
- [x] Google Chrome
- [x] Mozilla Firefox
- [x] Microsoft Edge

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
