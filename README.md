# VLSI

## Using VSCode Build/Test tasks to compile/simulate your code (COMPILATION FOR VHDL ONLY ⚠️)

### pre-requisites
- VSCode 🤷‍♂️🤷‍♂️
- `vcom` and `vsim` commands should be in your terminal's environment. You can test this by opening a new terminal - `bash` in ubuntu or `cmd.exe` in Windows - and execute `vcom -version` and `vsim -version`. Output like this is expected
```
Model Technology ModelSim ALTERA STARTER EDITION vsim 10.5b Simulator 2016.10 Oct  5 2016
```
- You should have created the library `work` in the project's root directory. In the projects root directory run `vlib work`

### How to run the tasks
- **To Compile** : `Ctrl` + `Shift` + `B`   (or the keybinding you defined to run the default build task)
- **To Simulate** : `Ctrl` + `Alt` + `T` (or the keybinding you defined to run the default tes task)

> WARNING 🛑🛑 : The simulation task will run on the entity which name is **your file name** (e.g. if you are trying to simulate `adder.vhd` it will simulate the entity `work.adder`)  