SRC_DIRS := . ./Lib
SRC_FILES := $(foreach dir, $(SRC_DIRS), $(wildcard $(dir)/*.cpp))
LDFLAGS := -lpthread
CXXFLAGS := -g -mavx -mfma -O0 -std=c++23 -I./Lib
ASM_CXXFLAGS := -S $(CXXFLAGS)

test: test.bin
	 ./build/test.bin


build: test.bin

gdb: test.bin
	gdb ./build/test.bin

test.bin: $(SRC_FILES)
	g++ $(CXXFLAGS) $^ $(LDFLAGS) -o build/$@

clean:
	rm -f build/*.o *.bin
