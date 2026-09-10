---
title: "Basic Makefile"
date: 2026-09-10T11:23:00
description: "The first step to understand makefile"
tags: ["ci-cd", "makefile"]
categories: ["Tech notes"]
---

> 🔔 **Prelude:**
> I often noticed Makefile files in the root directory when browsing open-source projects on GitHub. For a long time, I thought it was some kind of sophisticated "magic tool". So during my spare time at my internship, I decided to learn some basic syntax... only to discover that it's actually like a "recipe" for compilation - to get a target file (the dish), you need some dependencies (ingredients) and commands (cooking instructions). Anyway, at least now I can understand it (mostly).

## Make

### Basic Rules

```makefile
target: dependencies ..
[tab][Command]

TARGET = main
main: hello.o world.o   # will be run by default as the first target
    gcc $^ -o $(TARGET) # treat these as normal bash commands

hello.o: hello.c
    gcc -c hello.c      # -c for compile only

world.o: world.c
    gcc -c world.c

clean:                  # will not be run unless "make clean"
    rm -f $(wildcard *.o) $(TARGET)

.PHONY: clean

```

### Common CLI Parameters

```makefile
-v
-n --just-print        # Print commands without executing
-p                     # Output makefile data (lots of info)
-t --touch             # Update file timestamps without changing targets (dry run)
-q --question          # Check if target exists. Do nothing if yes, print error if no
                       # Usually used with -qp
-W --what-if <file>    # Pretend this file was just modified, trigger related rules
-B                     # Rebuild everything
-b -m                  # Used to ignore compatibility between different make versions
-debug=[option]        # Debug mode
                       # option can be: a(all), b(basic), v(verbose)
                       # i(implicit), j(jobs), m(makefile)
                       # -d = -debug=a
-e var=sth             # Override environment variable values
-h                     # Help me!
-f <file>              # Execute specific makefile
-i                     # Ignore errors
-I --include-dir <dir> # Specify make search directory
-k --keep-going        # Continue on errors, except missing dependencies
-s --silent
-j --jobs              # Parallel compilation when dependencies allow
                       # make will try to parallelize as much as possible by default

```

### Special Syntax

```makefile
$<                  # First item in dependencies
                    # Note: if target is matched via %,
                    # $< represents all matched items
$^                  # All dependencies
$?                  # All dependencies that are newer than target
$+                  # All dependencies without deduplication
$*                  # The part matched by %
$@                  # The target
$%                  # Target member name (only for archive files)
$$                  # Escape $ character
$(wildcard *.c)     # Use wildcards
$(source:.c=.o)     # Change suffix of variable

:=                  # Immediate expansion of $() expressions (no variable hoisting)
?=                  # Assign only if not already defined
+=                  # Append to variable value (with leading space)

%                   # Wildcard in pattern rules

@[command]          # Execute command silently
-[command]          # Ignore errors, continue running
[command];[command] # Similar to pipeline ("|")
                    # If written on separate lines, executed separately

override var := new-value

# $ with uppercase D(Directory) and F(File)
# Further specify the scope of dependency strings

dir/foo.o: ...

# Need parentheses to avoid ambiguity
$(@D)               # dir/foo.o -> dir
$(@F)               # dir/foo.o -> foo.o

```

### Pattern Rules

```makefile
%.o: %.c    # % means "match", represents "any string"
            # Meaning: to build .o file, its dependency is corresponding .c file
            # No directory search performed

# Study these examples for better understanding

src/eat
e%t
% -> src/a

# then, % is passed to another place...

c%r -> csrc/ar

# but if there is a nested % pattern on the original side...

c%r -> src/car  # % should be "src/a"
                # but "src/" will be removed before matching patterns
                # so in this situation, % is "a"
                # this rule also applies to the first step

```

### Functions

```makefile
# Basic syntax
$(<function> <arguments>)

# Can also be written as
${<function> <arguments>}   # Perhaps more readable

$(patsubst %.c,%.o,$(source))  # Better demonstrates % syntax behavior
                               # patsubst = pattern substitute
                               # For any .c file, replace with corresponding .o file
                               # Scope is $(source), which should be text

# Common functions

subst <from>,<to>,<text>    # Substitute text
strip <text>                # Remove spaces
findstring <find>,<in>      # Find substring, return <find> if found
filter <pattern...>,<text>  # Can pass multiple patterns
filter-out <pattern...>,<text> # Reverse filter, keeps unmatched items
sort <list>                 # Default ascending order
word <n>,<text>             # Get nth word (a.c b.c c.c -> b.c)
wordlist <s>,<e>,<text>     # Slice
words <text>                # Count words
firstword <text>

dir <names...>              # Extract directory from filename
notdir <names...>           # Remove directory part, keep filename only
suffix <names...>           # Extract suffix
basename <names...>         # Extract name without suffix (prefix)
addsuffix <suffix>,<names...> # Add suffix
addprefix <prefix>,<names...>
join <list1>,<list2>

origin <variable>           # Where did this variable come from?

shell <command>             # Execute command in shell

error <text ...>            # Generate error message, but doesn't abort
warning <text ...>          # Generate warning message

# Iteration
foreach <var>,<list>,<text>

names := a b c d
files := $(foreach n,$(names),$(n).o)  # a.o b.o c.o d.o

```

### Custom Functions with call

```makefile
call <expression>,<parm1>,<parm2>,...,<parmn>

# Examples are easier to understand
reverse = $(2) $(1)
foo = $(call reverse,a,b)  # $(foo) -> b a

```

### Special Variables

```makefile
VPATH                            # Set default search path
# Syntax: vpath <pattern> <directories>
# Example: vpath %.h src:../headers:lib  # Directories separated by colon (:)

# Can actively set paths
# Advantage: if file not found, will search in VPATH
VPATH = src
BUILD_DIR = build

$(BUILD_DIR)/%.o: %.c
    gcc -c $< -o $@

```

### Sub-Makefiles

```makefile
subsystem:
    cd subdir && $(MAKE)

# Equivalent to

subsystem:
    $(MAKE) -C subdir

# Execute make in subsystem

export VAR = value     # Pass VAR to subsystem
unexport VAR_PRIVATE   # Don't pass this variable

# $(SHELL) and $(MAKEFLAGS) are always passed to subsystems

```

### Define Directive

```makefile
define reusable
dosth..
dosth..
endef

$(reusable)

```

### Conditionals

```makefile
# Similar to bash syntax
ifeq (var1, var2)
    [command]
else
    [command]
endif

# Available keywords
ifeq ifneq ifdef ifndef

# if as a function
$(if <condition>,<then-part>)
$(if <condition>,<then-part>,<else-part>)

```

### Implicit Rules

```makefile
# Implicit rules use these predefined variables:

CC = gcc        # C compiler
CXX = g++       # C++ compiler
CFLAGS =        # C compile options
CXXFLAGS =      # C++ compile options
LDFLAGS =       # Linker options

# Only need to define dependencies, compile rules apply automatically
CFLAGS = -Wall -O2

main: main.o utils.o  # Implicit rules automatically compile .c → .o
    $(CC) $^ -o $@    # Linking rules need to be written manually
                      # (implicit rules only handle single file compilation)

# View all implicit rules
make -p | grep "^%"  # Display all pattern rules

```

### Include Directive

```makefile
include file1.mk file2.mk
-include optional.mk  # Don't error if file doesn't exist

```

### Special Targets

```makefile
.PHONY: clean test install      # Declare phony targets
.PRECIOUS: %.o                  # Preserve intermediate files
.SECONDARY:                     # All intermediate files are secondary
.DELETE_ON_ERROR:               # Delete target file if command errors

```

### Tips and Tricks

```makefile
all: $(object)                      # make finds dependencies then executes commands
                                    # doesn't have to compile to 'all'
$(object) : ...
    ...

gcc -MM hello.c                     # Find header dependencies for hello.c

dev: mymodule.so
    @echo "Development build complete"

test: dev                           # Set prerequisite tasks for multi-language development
    $(PYTHON) -c "import mymodule; print(mymodule.hello())"

```

---
