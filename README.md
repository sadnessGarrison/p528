# Recommendation ITU-R P.528-5 - U.S. Reference Implementation (Linux) #

This code repository contains a Linux-based fork of the U.S. Reference Software Implementation of Recommendation ITU-R P.528. This Recommendation contains a method for predicting basic transmission loss in the frequency range 100-30 000 MHz for aeronautical services.  The software implements Annex 2 of Rec P.528, the Step-by-Step method to computing propagation loss for air-to-ground paths.

## Inputs ##

| Variable          | Type   | Units | Limits       | Description  |
|-------------------|--------|-------|--------------|--------------|
| `d__km`           | double | km    | 0 <= `d__km` | Great circle path distance between terminals |
| `h_1__meter`      | double | meter | 1.5 <= `h_1__meter` <= 20 000 | Height of the low terminal |
| `h_2__meter`      | double | meter | 1.5 <= `h_2__meter` <= 20 000 | Height of the high terminal |
| `f__mhz`          | double | MHz   | 100 <= `f__mhz` <= 30 000 | Frequency |
| `T_pol`           | int    |       |              | Polarization <ul><li>0 = Horizontal</li><li>1 = Vertical</li></ul> |
| `time`            | double |       | 1 <= `time` <= 99 | Time percentage |
 
## Outputs ##

Outputs to P.528 are contained within a defined `Results` structure.

| Variable   | Type   | Units | Description |
|------------|--------|-------|-------------|
| `d__km`    | double | km    | Great circle path distance.  Could be slightly different than specified in input variable if within LOS region |
| `A__db`    | double | dB    | Basic transmission loss |
| `A_fs__db` | double | dB    | Free space basic transmission loss |
| `A_a__db`  | double | dB    | Median atmospheric absorption loss |
| `theta_h1__rad` | double | rad | Elevation angle of the ray at the low terminal |
| `propagation_mode` | int |  | Mode of propagation <ul><li>1 = Line of Sight</li><li>2 = Diffraction</li><li>3 = Troposcatter</li></ul> |
| `warnings` | int    |       | Warning flags |

## Error Codes and Warning Flags ##

P.528 supports a defined list of error codes and warning flags.  A complete list can be found [here](ERRORS_AND_WARNINGS.md).

## Example Values ##

The below table includes a select set of example inputs and outputs for testing purposes. The [P.528 CSV data files](https://www.itu.int/rec/R-REC-P.528/en) contain an extensive set of validation example values.

| `d__km` | `h_1__meter` | `h_2__meter` | `f__mhz` | `T_pol` | `time` | `A__db` |
| --------|--------------|--------------|----------|---------|--------|---------|
|      15 |           10 |        1 000 |      500 |       0 |     50 |   110.0 |
|     100 |          100 |       15 000 |    3 600 |       0 |     90 |   151.6 |
|   1 500 |           15 |       10 000 |    5 700 |       0 |     10 |   293.4 |
|      30 |            8 |       20 000 |   22 000 |       1 |     50 |   151.1 |

## Notes on Code Style ##

 * In general, variables follow the naming convention in which a single underscore denotes a subscript (pseudo-LaTeX format), where a double underscore is followed by the units, i.e. h_1__meter.
 * Variables are named to match their corresponding mathematical variables in the underlying Recommendation text.
 * Wherever possible, equation numbers are provided.  It is assumed that a user reviewing this source code would have a copy of the Recommendation's text available as a primary reference.

## Configure and Build ##

### C++ Software

The software is designed to be built into a Linux system and has been tested with single point to point calculations on Ubuntu 24.04. The original compile environment was built for Windows operation systems. Software is compiled with the Makefile in the root of the repo and the "make" command. An executable (p528) and corresponding library (libp528.so) are built into the root repo directory.

## References ##

 * [Recommendation ITU-R P.528](https://www.itu.int/rec/R-REC-P.528/en)
 * [Rec ITU-R P.528 GUI](https://github.com/NTIA/p528-gui)

