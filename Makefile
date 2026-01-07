CXX = g++
CXXFLAGS = -std=c++11 -O2 -fPIC -Iinclude
LDFLAGS = -shared -Wl,-soname,libp528.so
MATHLIB = -lm

SRC = $(wildcard src/p528/*.cpp src/p676/*.cpp src/p835/*.cpp)
OBJ = $(patsubst %.cpp,%.o,$(SRC))
LIB = apps/libp528.so
EXEC = apps/p528

.PHONY: all clean

all: $(LIB) $(EXEC)
$(LIB): $(OBJ)
	$(CXX) $(LDFLAGS) -o $@ $(OBJ) $(MATHLIB)

$(EXEC): apps/src/P528Linux.cpp
	$(CXX) $(CXXFLAGS) $< -o $@ -ldl

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(LIB) $(EXEC)
