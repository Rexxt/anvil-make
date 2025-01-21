#    _           _ _ __  __      _       
#   /_\  _ ___ _(_) |  \/  |__ _| |_____ 
#  / _ \| ' \ V / | | |\/| / _` | / / -_)
# /_/ \_\_||_\_/|_|_|_|  |_\__,_|_\_\___|
#
# Anvil for C, revision 2
# https://github.com/Rexxt/anvil-make
# 21/01/2025
# by Mizu
# Adapted from work by Stéfane Paris, https://stefane.paris.free.fr

# ----------------------------------------------------------------
# PROJECT METADATA:
# Fill out information about the project below.
# ----------------------------------------------------------------

# Example: "GNU project C and C++ compiler"
PROJECT_TITLE = ...
# Example: gcc
PROJECT_ID = ...
# Example: "Compiles C and C++ projects."
PROJECT_DESCRIPTION = ...
# Example: 14.2
PROJECT_VERSION = 0.0.0

# Example: "GNU Project, Richard Stallman"
PROJECT_AUTHORS = ...

# Example: 1986-10-30
PROJECT_CREATION = YYYY-MM-DD

# ----------------------------------------------------------------
# ANVIL CONFIGURATION:
# Fill out information about how the project must be compiled.
# ----------------------------------------------------------------

# Directories:
# The directory where your source code files (.c) are stored.
DIR_SRC = src
# The directory where your header files (.h) are stored.
DIR_INCLUDE = include
# The directory where object files should be generated.
DIR_OBJECTS = obj
# The directory where the binary of the application should be generated.
DIR_BUILD = bin

# The compiler to use.
COMPILER = gcc
# The options to pass to the compiler.
CFLAGS = -Wall -I$(DIR_INCLUDE)

# The header files used by the project.
DEPENDENCIES = exampleDependency
# The objects generated by the project.
OBJECTS = $(DEPENDENCIES) main

# ----------------------------------------------------------------
# INNER WORKINGS OF ANVIL
# /!\ It is not recommended to modify this part unles your project
# has specific needs not automatically achieved by Anvil.
# ----------------------------------------------------------------

# ================================================================
# BUILD CONSTANTS
# ================================================================

# Revision number of the Makefile.
ANVIL_REV = 1

# The final binary of the project.
# Prepends the build directory to the related executable path.
PROG = $(patsubst %,$(DIR_BUILD)/%,$(PROJECT_ID))
# Prepends the include directory and the ".h" extension to every specified header.
DEP = $(patsubst %,$(DIR_INCLUDE)/%.h,$(DEPENDENCIES))
# Prepends the object directory and the ".o" extension to every specified object.
OBJ = $(patsubst %,$(DIR_OBJECTS)/%.o,$(OBJECTS))

# Automatic platform detection.
# https://stackoverflow.com/questions/714100/os-detecting-makefile
ifeq ($(OS),Windows_NT)
    PLATFORM = Windows
else
	UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        PLATFORM = Linux
    endif
    ifeq ($(UNAME_S),Darwin)
        PLATFORM = macOS
    endif
    ifeq ($(UNAME_S),Solaris)
		PLATFORM = Solaris
	endif
endif


# ================================================================
# FORMATTING CONSTANTS
# ================================================================

# Reset formatting
FMT_RESET = $(shell tput sgr0)
# Blue
FMT_HEADER = $(shell tput setaf 4)
# Cyan
FMT_INFO = $(shell tput setaf 6)
# Magenta
FMT_COMPLEMENTARY = $(shell tput setaf 5)
# Green
FMT_OK = $(shell tput setaf 2)
# Yellow
FMT_WARN = $(shell tput setaf 3)
# Red
FMT_NG = $(shell tput setaf 1)

# Declare commands (i.e. don't treat the following targets as actual files).
.PHONY: anvil-header check info build $(PROJECT_ID) dirs run clean delete

# By defult, when "make" is run without a target, 
default: $(PROG)

anvil-header:
	@echo "$(FMT_HEADER)Anvil for C"
	@echo "Revision $(ANVIL_REV)$(FMT_RESET)"
	@echo

check: anvil-header
	@echo "$(FMT_INFO)Detected platform:$(FMT_RESET) $(PLATFORM)"
	@echo "$(FMT_INFO)Program binary:$(FMT_RESET) $(PROG)"
	@echo "$(FMT_INFO)Required headers:$(FMT_RESET) $(DEP)"
	@echo "$(FMT_INFO)Required objects:$(FMT_RESET) $(OBJ)"
	@echo

info: anvil-header
	@echo "$(PROJECT_TITLE)"
	@echo "$(PROJECT_DESCRIPTION)"
	@echo "Version $(PROJECT_VERSION)"
	@echo "By $(PROJECT_AUTHORS)"
	@echo "Created on $(PROJECT_CREATION)"
	@echo

dirs: anvil-header
	@mkdir -p $(DIR_BUILD) $(DIR_OBJECTS)

.gitignore: anvil-header
	@echo "$(FMT_INFO)Setting up $(FMT_COMPLEMENTARY)$@$(FMT_INFO)...$(FMT_RESET)"
	@echo "# Generated by Anvil" >> .gitignore
	@echo "$(DIR_OBJECTS)/" >> .gitignore
	@echo "$(DIR_BUILD)/" >> .gitignore
	@echo >> .gitignore
	@echo "$(FMT_COMPLEMENTARY)$@$(FMT_OK) set up!$(FMT_RESET)"
	@echo

$(PROG): anvil-header dirs $(OBJ)
	@echo "$(FMT_INFO)Building project into $(FMT_COMPLEMENTARY)$@$(FMT_INFO)...$(FMT_RESET)"
	$(COMPILER) $(CFLAGS) -o $@ $(OBJ)
	@echo "$(FMT_OK)Build completed!$(FMT_RESET)"
	@echo
build: $(PROG)
$(PROJECT_ID): $(PROG)

run: dirs $(PROG)
	./$(PROG)

$(DIR_OBJECTS)/%.o: $(DIR_SRC)/%.c $(DEP)
	@echo "$(FMT_INFO)Compiling object $(FMT_COMPLEMENTARY)$@$(FMT_INFO) from target $(FMT_COMPLEMENTARY)$<$(FMT_INFO).$(FMT_RESET)"
	$(COMPILER) $(CFLAGS) -c -o $@ $<
	@echo "$(FMT_OK)Target compiled!$(FMT_RESET)"
	@echo

clean: anvil-header
	@echo "$(FMT_INFO)Cleaning up...$(FMT_RESET)"
	rm -rf $(DIR_OBJECTS)
	@echo "$(FMT_OK)Cleanup complete!$(FMT_RESET)"
	@echo

delete: anvil-header clean
	@echo "$(FMT_INFO)Deleting build files...$(FMT_RESET)"
	rm -rf $(DIR_BUILD)
	@echo "$(FMT_OK)Deletion complete!$(FMT_RESET)"
	@echo
