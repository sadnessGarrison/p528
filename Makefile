CXX = g++
CXXFLAGS = -std=c++11 -O2 -fPIC -Iinclude
LDFLAGS = -shared -Wl,-soname,libp528.so
MATHLIB = -lm

OBJDIR = build/obj
SRC = $(wildcard src/p528/*.cpp src/p676/*.cpp src/p835/*.cpp)
OBJ = $(patsubst src/%.cpp,$(OBJDIR)/%.o,$(SRC))
LIB = apps/libp528.so
EXEC = apps/p528

.PHONY: all clean

all: $(LIB) $(EXEC)
$(LIB): $(OBJ)
	$(CXX) $(LDFLAGS) -o $@ $(OBJ) $(MATHLIB)

$(EXEC): apps/src/P528Linux.cpp
	$(CXX) $(CXXFLAGS) $< -o $@ -ldl

$(OBJDIR)/%.o: src/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -rf $(OBJDIR) $(LIB) $(EXEC)
