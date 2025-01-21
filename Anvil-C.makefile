#   _           _ _ __  __      _       
#  /_\  _ ___ _(_) |  \/  |__ _| |_____ 
# / _ \| ' \ V / | | |\/| / _` | / / -_)
#/_/ \_\_||_\_/|_|_|_|  |_\__,_|_\_\___|
#
# Anvil for C, revision 1
# https://github.com/Rexxt/anvil-make
# 20/01/2025
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
DIROBJECTS = obj
# The directory where the binary of the application should be generated.
DIR_BUILD = bin

# The compiler to use.
COMPILER = gcc
# The options to pass to the compiler.
CFLAGS = -Wall -I$(DIR_INCLUDE)

# The header files used by the project.
DEPENDENCIES = exampleHeader
# The objects generated by the project.
OBJECTS = $(DEPENDENCIES) exampleObjectWithNoAssociatedHeader

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
OBJ = $(patsubst %,$(DIROBJECTS)/%.o,$(OBJECTS))

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
	@echo -e "$(FMT_HEADER)Anvil for C\nRevision $(ANVIL_REV)$(FMT_RESET)"

check: anvil-header
	@echo "$(FMT_INFO)Detected platform:$(FMT_RESET) $(PLATFORM)"
	@echo "$(FMT_INFO)Program binary:$(FMT_RESET) $(PROG)"
	@echo "$(FMT_INFO)Required headers:$(FMT_RESET) $(DEP)"
	@echo "$(FMT_INFO)Required objects:$(FMT_RESET) $(OBJ)"

info: anvil-header
	@echo -e "$(PROJECT_TITLE)\n$(PROJECT_DESCRIPTION)\nVersion $(PROJECT_VERSION)\nBy $(PROJECT_AUTHORS)\nCreated on $(PROJECT_CREATION)"

run: dirs $(PROG)
	./$(PROG)

dirs:
	@mkdir -p bin
	@mkdir -p obj

build: $(PROG)
$(PROJECT_ID): $(PROG)

$(PROG): $(OBJ)
	$(COMPILER) $(CFLAGS) -o $@ $^

$(DIROBJECTS)/%.o: $(DIR_SRC)/%.c $(DEP)
	echo $@ " :: " $<
	$(COMPILER) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf $(DIROBJECTS)
	rm -f data/output*

delete: clean
	rm -rf $(DIR_BUILD)
