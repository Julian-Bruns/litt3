# Repeated u15 fiberwise vertical certificate

This note records the vertical new-tail determinant certificate for the
repeated `x=0,u^15` layer.  It proves the new-tail fiber response after the
previous solves.  It is not a statement that the whole residual is affine in
the older free coordinates.

## Setup

Use the repeated-`u^5` columns

```text
I=Col(i00),  L=Col(l01),  M=Col(m00),  P=Col(p),
rho3=det(I,L,P),  rho4=det(I,M,P).
```

After dividing by `P`, write

```text
U_I=I/P,  U_L=L/P,  U_M=M/P.
```

The repeated-`u^5` certificate gives

```text
[s^2]U_I=4,
[s^2]U_L=0,
U_M-U_L=s.
```

Thus, writing `U_L=a+d*s`,

```text
rho3/P^3=d,
rho4/P^3=d+1.
```

On the selected fallback `rho4` chart, the earlier charting convention means
`rho3=0`, hence `d=0` and `rho4/P^3=1`.

## Vertical Tail Formula

For a new vertical tail perturbation

```text
delta F=(-u+u^2)*u^a*w^b*v,
```

the raw repeated-`u^15` response is

```text
Raw15(a,b)=ell^(-1)*[u^(25-a-b)]Q^(b-2)*T^(-1),
```

where `Q=w0/u` and `T=ell^(-1)u^(-5)dF/dw(u,w0)`.

The actual vertical column includes the solved simple-`u^15` correction:

```text
Col15(v)=Raw15(v)+lambda_v*Raw15(U12(0)).
```

The finite verifier

```text
python3 double_fiber_x0_repeated_u15_tail_formula_verify.py \
  --limit 20 --stop-on-failure
```

returned:

```text
samples checked: 20
failures: []
```

For the columns used below, the simple-`u^15` corrections are:

```text
lambda(u15_3)=1,
lambda(u13_3)=lambda(u12_1)=lambda(u14_3)=0.
```

The formula gives:

```text
u13_3/P = 1,
u12_1/P = U_L,
u14_3/P = U_L + 3s.
```

For `u15_3`, the correction gives

```text
u15_3/P = [u^2](Q^18+Q^21)T^(-1).
```

The symbolic certifier

```text
python3 double_fiber_x0_repeated_u15_vertical_scalar_symbolic.py
```

proved, after clearing the same `Delta0` denominator as the earlier
old-branch certificates,

```text
[s^2](u15_3/P)=4.
```

Its output was:

```text
Delta power cleared: 4
s2 numerator minus Delta^power terms: 0
certified: coeff_s2(u15_3/P)=4
```

## Determinants

Write

```text
u15_3/P = * + 4s^2,
u12_1/P = U_L = a+d*s,
u13_3/P = 1.
```

Then on the `rho3` chart,

```text
det(u15_3,u13_3,u12_1)/P^3
  = det(u15_3/P, 1, U_L)
  = 4d
  = 4*rho3/P^3.
```

Hence

```text
det(u15_3,u13_3,u12_1)=4*rho3.
```

For the fallback chart, `rho3=0`, so `d=0`.  Also

```text
u14_3/P = U_L+3s
```

has `s`-coefficient `3`.  Therefore

```text
det(u15_3,u14_3,u13_3)/P^3
  = det(u15_3/P, U_L+3s, 1)
  = -4*3
  = 3
  = 3*rho4/P^3.
```

Thus

```text
rho3 chart:
  det(u15_3,u13_3,u12_1)=4*rho3 != 0,

rho3=0, rho4 chart:
  det(u15_3,u14_3,u13_3)=3*rho4 != 0.
```

This proves the vertical new-tail rank-three response on the two certified
old charts.

## Finite Ratio Check

The relation probe

```text
python3 double_fiber_x0_repeated_u15_vertical_relation_probe.py --limit 30
```

returned:

```text
ratio counts:
  (rho3_i00_l01_p, 4) 23
  (rho4_i00_m00_p, 3) 7
ratio failures: []
```

The same probe found `[s^2](u15_3/P)=4` in all 30 samples.

## Remaining Issue

This certificate is vertical: for each fixed old/repeated-`u^10` point on the
previous solved graph, it varies only the new `u^15` tail variables.  The full
old/free-coordinate residual is non-affine in the current coordinates, as
recorded in `95_REPEATED_U15_CHARTED_DIAGNOSTIC.md`; however, this
non-affinity does not by itself obstruct the repeated-`u^15` solve if the
vertical determinants are fiberwise nonzero.

The reason the same determinant computation is expected fiberwise is a degree
separation.  The columns used above require only

```text
Q mod u^3,  T mod u^3.
```

Indeed, the highest coefficient extracted is a coefficient of degree `2` in
`Q^(*)T^(-1)`.  The old/repeated-`u^10` free coordinates occur in
`F11,F12,F13,...,F20`.  A perturbation in `Fa` has leading order

```text
(-u+u^2) * u^b * w^a,
```

so for `a >= 11` it contributes to the repeated branch equation only from
degree at least `12`.  Such terms cannot affect `Q mod u^3`, whose last needed
coefficient is determined by branch equations through degree `8`, nor can they
affect `T mod u^3`, because their derivative contributions begin beyond
degree `u^7` in `u^5*T`.  The fixed `F8,F9,F10` layer also begins too late to
alter `Q mod u^3` or `T mod u^3`: `F8*w^8` starts at degree `9`, and
`d(F8*w^8)/dw` contributes to `T` only from degree `u^3` onward.

Therefore the scalar identities used in the determinant calculation depend
only on the old low branch data already handled by the symbolic certificates,
not on the older free coordinates being varied along the previous solved
graph.

A finite fiberwise check supports exactly that stronger interpretation:

```text
python3 double_fiber_x0_repeated_u15_fiber_relation_probe.py \
  --limit 20 --assignments 3 --stop-on-failure

samples checked: 20
ratio tuple counts:
  (rho3_i00_l01_p, (4,4,4)) 14
  (rho4_i00_m00_p, (3,3,3)) 6
failures: []
```

Here the three entries in each ratio tuple are three nonzero deterministic
old/repeated-`u^10` free assignments, solved exactly through the previous
repeated-`u^10` graph before forming the new-tail vertical columns.

Together with the degree-separation argument above, this upgrades the
displayed determinant proof from the zero old/free slice to the full previous
solved graph.  Therefore the repeated-`u^15` layer is locally a fiberwise
linear solve despite the non-affine older-coordinate dependence.

## Consequence

The repeated-`u^15` residual imposes no new older-variable residual equation
on the clean charted branch.  For each point of the previous solved graph, the
new `u^15` tail variables contain a three-dimensional affine fiber whose
vertical coefficient matrix has rank `3`, covered by the two determinant
identities above.
