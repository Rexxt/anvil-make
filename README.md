# anvil-make
Anvil is a comprehensive Makefile for building and distributing projects cleanly. Originally geared towards C projects for my university.

Based on a Makefile by [Stéfane Paris](http://stefane.paris.free.fr), Université de Lorraine.

## Why?
It makes creating, building and distributing modular projects a breeze. You simply pick the Makefile you need (depending on your programming language stack of choice), download it as `Makefile`, set some metadata (project title, short identifier, description, authors, creation date, version), the appropriate data for building the project (for C: directories, headers, source files...) and you have a working project!

## Features
* Commands for building, running and creating redistributables for your project.
* Platform-responsive: Anvil adapts to whatever platform and operating system you use for building your project.
* Automatic info file generation when distributing.

## Commands
* `make [project_name]`: compile your project to a final file. The default directories are `./obj` for object files, and `./build` for the final binary.
* `make run`: automatically build your project, and execute it in the console.
* `make dist`: automatically build your project and an information file, and compress it into a final redistributable package.
* `make info`: display information about the project.
