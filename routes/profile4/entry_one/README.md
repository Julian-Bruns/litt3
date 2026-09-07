# Entry-one route

The branch is open, including all lower-degree strata created by additional
high-point coincidences. Start with:

1. [File 175](175_ENTRY1_LOGARITHMIC_EXACTNESS_TARGET.md) for the precise Cartier
   logarithmic primitive and divisor-lifting obstruction. In particular,
   `[R]=0` is only necessary; the actual obstruction is a class in
   `Pic^0(C)` whose fifth multiple is `[R]`, and the required divisor of
   `r-1` remains a separate condition.
2. [File 176](176_ENTRY1_X_NORM_SHADOW.md) for norm consequences of an actual lifted
   `r` and the explanation that the first trace identity is automatic.

For the representative `Q1=P0`, distinctness within each high-point triple
and the three exclusions in `../162_PROFILE4_HIGHPOINT_FIBER_COUNT_LEMMA.md`
leave exactly these possible further coincidences:

```text
Q0=P1,   Qinfty=P1,   Qinfty=Pinfty.
```

Only `Q0=P1` and `Qinfty=Pinfty` can occur together. A single further
coincidence lowers the quotient `z` from degree `5` to degree `4`; that one
allowed pair lowers it to degree `3`. None of these lower-degree strata is
excluded by the files in this directory.
[File 162](../162_PROFILE4_HIGHPOINT_FIBER_COUNT_LEMMA.md) also proves that
`x` and this quotient generate `k(C)` in degrees `5`, `4`, and `3`.

Load the remaining files only for a matching local approach:

| Approach | File | Established outcome |
| --- | --- | --- |
| Double finite pole `c=d` | [file 171](171_ENTRY1_DOUBLE_FINITE_POLE_EDGE.md) | Exact factorization, conditional on coefficient identities inherited from missing note `165`; the tangent equation solves `l0`. |
| Simple finite pole `c!=d` | [file 172](172_ENTRY1_SIMPLE_FINITE_POLE_ODE.md) | Reproducible formal calculation: the first ODE equation prescribes `xi6`, with no local contradiction. |
| Low-`z` infinity corner | [file 174](174_ENTRY1_LOWZ_INFINITY_CORNER.md) | Conditional on the inherited normal form, gives `h21!=0` and the leading high branch. |
| Continue that high branch | [file 177](177_ENTRY1_PINFTY_HIGH_BRANCH_ODE.md) | Reproducible formal calculation: the first ODE equation prescribes `a35`; global compatibility and later equations remain untested. |

The local statements that a coefficient is "solved" do not assert that the
coefficient is free in the global bidegree equation. None of files
`171`, `172`, `174`, or `177` excludes a stratum.

Files `171` and `174` still depend on normal-form inputs from missing
predecessor note `165`; check
[MISSING_INPUTS.md](../../../MISSING_INPUTS.md).

One discarded shortcut is worth recording: local fiber partitions do not
exclude the representative degree-five case. For the formal equation
`delta^4 z=z-z^5`, `delta=(x-1)d/dx`, a fiber over `lambda in F5` can have
order `1,2,3,5` at an ordinary point of delta, or `1,2,3,4` at a simple
zero of delta. The forced points above `1` and `-1` admit compatible
degree-five partitions (complete the first with simple points; the four
forced points of the second can all be simple with one further point).
This is only compatibility, not existence of a global solution. The
automatic trace identity is already explained in file `176`.
