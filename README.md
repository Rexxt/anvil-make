# anvil-make
Anvil is a comprehensive Makefile for building and distributing projects cleanly. Originally geared towards C projects for my university.

Based on a Makefile by [Stéfane Paris](http://stefane.paris.free.fr), Université de Lorraine.

## Why?
It makes creating, building and distributing modular projects a breeze. You simply pick the Makefile you need (depending on your programming language stack of choice), download it as `Makefile`, set some metadata (project title, short identifier, description, authors, creation date, version), the appropriate data for building the project (for C: directories, headers, source files...) and you have a working project!

An additional goal is for the Makefile to be usable as a learning tool for building code projects and understanding how Makefiles work and what they can be used to do.

Anvil Makefiles are written exclusively by humans, for humans, and attempt to explain what they do to potential human readers.

## Features
* Commands for building, running and creating redistributables for your project.
* Commands for cleaning up a working directory after compilation.
* Platform-responsive: Anvil adapts to whatever platform and operating system you use for building your project.
* Automatic info file generation when distributing.
* Possibly colourized output messages to help understand what Make and Anvil do?

## Commands
* `make` or `make build` or `make <PROJECT_ID>`: compile your project to a final file. The default directories are `./obj` for object files, and `./build` for the final binary.
* `make check`: print the data generated by the project for compilation.
* `make info`: display information about the project.
* `make .gitignore`: create rules for ignoring residual build files used by Anvil inside of git.
* `make dirs`: make the directories used for building the project.
* `make run`: automatically build your project, and execute it in the console.
* `make dist`: automatically build your project and an information file, and compress it into a final redistributable package.
* `make clean`: clean residual objects resulting from the compilation process.
* `make delete`: delete the build directory of the project.