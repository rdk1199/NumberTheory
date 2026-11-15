SRC_DIRS := . ./Lib
SRC_FILES := $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.cpp) $(wildcard $(dir)/*.h))
ASM_SRC_FILES := $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.asm))
vpath %.asm $(SRC_DIRS)
LDFLAGS := -lpthread
CXXFLAGS := -g -mavx -mfma -O3 -std=c++23 -I./Lib
ASM_CXXFLAGS := -S $(CXXFLAGS)

OBJ_FILES := $(addprefix build/,$(notdir $(ASM_SRC_FILES:.asm=.o)))

.PHONY: test build gdb clean

test: build/test.bin makefile
	./build/test.bin

build: build/test.bin

gdb: build/test.bin
	gdb ./build/test.bin

build/test.bin: $(SRC_FILES) $(OBJ_FILES)
	mkdir -p build
	g++ $(CXXFLAGS) $(SRC_FILES) $(OBJ_FILES) $(LDFLAGS) -o $@

build/%.o: %.asm
	mkdir -p build
	nasm -f elf64 $< -o $@

clean:
	rm -f build/*.o build/test.bin
