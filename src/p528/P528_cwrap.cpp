// Minimal wrapper: avoid including the public header here to prevent
// conflicting linkage (header declares `P528` with C++ linkage).

struct Result {
    int propagation_mode;
    int warnings;
    double d__km;
    double A__db;
    double A_fs__db;
    double A_a__db;
    double theta_h1__rad;
};

// Declaration of the C++ implementation (defined in another TU).
int P528(double d__km, double h_1__meter, double h_2__meter,
    double f__mhz, int T_pol, double p, Result* result);

// C-callable wrapper which forwards to the C++ implementation.
extern "C" int p528_cwrap(double d__km, double h_1__meter, double h_2__meter,
    double f__mhz, int T_pol, double p, Result* result)
{
    return P528(d__km, h_1__meter, h_2__meter, f__mhz, T_pol, p, result);
}

// Create a plain global symbol `P528` that points to `p528_cwrap` so
// consumers can `dlsym("P528")` or link against the symbol name.
extern "C" {
__asm__(
    ".global P528\n"
    "P528 = p528_cwrap\n"
);
}
