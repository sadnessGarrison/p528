CXX = g++
CXXFLAGS = -std=c++11 -O2 -fPIC -Iinclude
LDFLAGS = -shared -Wl,-soname,libp528.so
MATHLIB = -lm

SRC = $(wildcard src/p528/*.cpp src/p676/*.cpp src/p835/*.cpp)
OBJ = $(patsubst %.cpp,%.o,$(SRC))
LIB = libp528.so
DRIVER = P528Drvr_bin

.PHONY: all clean

all: $(LIB) $(DRIVER)

$(LIB): $(OBJ)
	$(CXX) $(LDFLAGS) -o $@ $(OBJ) $(MATHLIB)

$(DRIVER): apps/P528Linux.cpp
	$(CXX) $(CXXFLAGS) $< -o $@ -ldl

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(LIB) $(DRIVER)
