# E50 final-line Singular checks

This note records a small CAS reinforcement of the known symbolic e50 kills
from `148`, `150`, and `156`.

## New file

```text
double_fiber_x0_simple_u30_e50_final_line_checks.sing
```

It checks the final one-parameter residual ideals in `F_5[a]` for:

```text
P129,
the three P129 tangent-neighborhood base-zero/e30 hits,
the rho4 base-zero tangent-basin hit.
```

Command:

```text
Singular -q double_fiber_x0_simple_u30_e50_final_line_checks.sing
```

Output:

```text
P129:
_[1]=1
P129 tangent candidate 2:
_[1]=1
P129 tangent candidate 12:
_[1]=1
P129 tangent candidate 14:
_[1]=1
rho4 base-zero hit:
_[1]=1
```

Thus each archived final-line residual ideal is the unit ideal over
`k=\bar F_5`.  This does not replace the symbolic layer certificates proving
that e35/e40/e45 reduce to these final lines; it only makes the last
one-variable no-common-root step independently CAS-checkable.
