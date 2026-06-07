# No-highpoint residual gate

Date: 2026-06-05.

This note isolates the current no-highpoint branch of profile 4.

## Status

The no-highpoint case is still open.

The low-degree high-point quotient method in `162` requires a coincidence
`Q_j=P_i`, so it gives no function of degree `<=6` in the no-highpoint case.
The natural constructive route is the residual `(4,4)` ansatz, but the archive
does not yet prove that every no-highpoint solution is equivalent to a member
of this ansatz.

Thus there are two possible ways to close this gate:

```text
1. Prove no no-highpoint profile-4 solution exists directly.
2. Prove a bridge from no-highpoint profile-4 solutions to the full residual
   ansatz, then eliminate the full residual ansatz or construct a valid one.
```

## Full residual ansatz target

The exact finite system from `52_RESIDUAL_44_ANSATZ_NOTES.md` uses

```text
A(X,R)=sum_{0<=i,j<=32} a_ij X^i R^j,
D=X(X-1)R(R-1),
H_A=L^31 P - D A.
```

In characteristic `5`, write

```text
Phi=L^5 L^25,
F=L P.
```

Then

```text
H_A=Phi*F-D*A,
partial_X Phi=partial_R Phi=0.
```

So the ramification equations away from `F=0` are

```text
N_R = F*partial_R(D*A) - D*A*partial_R F = 0,
N_X = F*partial_X(D*A) - D*A*partial_X F = 0.
```

The forced triple-corner equations are

```text
a_0,32 = 2,
a_32,0 = 2.
```

The six graph-branch opens and the residual grid branch counts must also be
imposed.  Finally,

```text
H_A geometrically integral and reduced,
g(normalization(H_A=0))=11.
```

Given the boundary branch conditions, the genus condition forces no interior
ramification by Riemann-Hurwitz: the three 31-fold graph branches already
use the full ramification budget for each projection.

## What is already killed

The following are not live construction families:

```text
- constant A/M subfamily;
- bilinear finite-field candidates as a proof route;
- sparse true-corner low-parameter family from `60`;
- symmetric ordinary-corner low-parameter family, including the 49
  boundary-open candidates killed exactly by the resultant computation in
  `62`.
```

The strongest exact elimination here is `62`: for all 49 candidates in the
ordinary-corner frontier,

```text
Res_R(H_A, partial_R H_A)=X^36 (X-1)^32 Q(X),
deg Q=2276,
Q nonconstant.
```

Thus each candidate has an affine interior ramification point over
`k=\bar F_5`.

## What remains

The full coefficient space for `A` has `33^2=1089` coefficients before
boundary conditions.  The killed subfamilies use only a few symmetric or
low-degree parameters and do not close the full residual route.

The most useful next theorem would be one of:

```text
R1. Residual bridge:
    every no-highpoint profile-4 solution produces an `A` satisfying the full
    residual ansatz system.

R2. Residual elimination:
    the full residual ansatz system has no solution over `k=\bar F_5`.

R3. Residual construction:
    produce one full `A` satisfying the branch, integrality, genus, and
    no-interior-ramification conditions.

R4. Nonresidual obstruction:
    prove no-highpoint nonexistence without passing through the residual
    ansatz.
```

At present, `R1` is not locked and `R2` is much larger than the existing
low-parameter eliminations.

