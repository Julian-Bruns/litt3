# Repeated u25 two-minor certificate

This note records the local determinant certificate for the repeated
`x=0,u^25` layer after the solved layers through simple `u^25`.  It is a
local double-fiber layer result, not yet a complete common-cover proof.

## Setup

Use the repeated-`u^5` columns

```text
I=Col(i00),  L=Col(l01),  M=Col(m00),  P=Col(p),
rho3=det(I,L,P),  rho4=det(I,M,P).
```

After dividing by `P`, write

```text
U_L=L/P,  U_M=M/P.
```

The earlier certificates give

```text
[s^2]U_L=0,
U_M-U_L=s.
```

Thus, writing `U_L=a+d*s`,

```text
rho3/P^3=d,
rho4/P^3=d+1.
```

On the selected fallback `rho4` chart, `rho3=0`, hence `d=0` and
`rho4/P^3=1`.

## Vertical Tail Formula

For a new vertical tail perturbation

```text
delta F=(-u+u^2)*u^a*w^b*v,
```

the raw repeated-`u^25` response is

```text
Raw25(a,b)=ell^(-1)*[u^(35-a-b)]Q^(b-2)*T^(-1),
```

where `Q=w0/u` and `T=ell^(-1)u^(-5)dF/dw(u,w0)`.

The actual vertical column includes the solved simple-`u^25` correction:

```text
Col25(v)=Raw25(v)+lambda_v*Raw25(U2(0)).
```

The finite verifier

```text
python3 double_fiber_x0_repeated_u25_tail_formula_verify.py \
  --limit 5 --stop-on-failure
```

returned:

```text
samples checked: 5
failures: []
```

For the columns used below, the simple-`u^25` corrections are:

```text
lambda(u5_3)=1,
lambda(u2_1)=lambda(u1_0)=lambda(u0_0)=0.
```

The formula gives:

```text
u0_0/P = 1,
u2_1/P = [u^1]Q^31*T^(-1) = U_L,
u1_0/P = [u^1]Q^32*T^(-1) = U_L+s,
u5_3/P = [u^2](Q^28+Q^31)T^(-1).
```

The low-degree reductions use characteristic `5`:

```text
Q^31 = Q,
Q^32 = Q^2,
Q^28 = Q^3
```

through the required degrees.

## Scalar Identity

The symbolic certifier

```text
python3 double_fiber_x0_repeated_u25_scalar_identity_symbolic.py
```

proved, after clearing the same `Delta0` denominator as the earlier
old-branch certificates,

```text
[s^2]U_L = 0,
[s^2](u5_3/P) = 4.
```

Its output was:

```text
UL_s2 cleared difference terms: 0
u5_3 cleared difference terms: 0
certified: u25 UL_s2=0 and u5_3_s2=4
```

The `u5_3/P` scalar is the same low-degree expression as in the repeated
`u^15` certificate, since

```text
Q^28+Q^31 = Q^3+Q  mod u^5.
```

## Determinants

Write

```text
u5_3/P = * + 4s^2,
u2_1/P = U_L = a+d*s,
u0_0/P = 1.
```

Then on the `rho3` chart,

```text
det(u5_3,u0_0,u2_1)/P^3
  = det(u5_3/P, 1, U_L)
  = 4d
  = 4*rho3/P^3.
```

Hence

```text
det(u5_3,u0_0,u2_1)=4*rho3.
```

For the fallback chart, `rho3=0`, so `d=0`.  Also

```text
u1_0/P = U_L+s
```

has `s`-coefficient `1`.  Therefore

```text
det(u5_3,u1_0,u0_0)/P^3
  = det(u5_3/P, U_L+s, 1)
  = -4
  = 1
  = rho4/P^3.
```

Thus

```text
rho3 chart:
  det(u5_3,u0_0,u2_1)=4*rho3 != 0,

rho3=0, rho4 chart:
  det(u5_3,u1_0,u0_0)=rho4 != 0.
```

This proves the vertical new-tail rank-three response on the two certified
old charts.

## Finite Checks

The relation probe

```text
python3 double_fiber_x0_repeated_u25_vertical_relation_probe.py --limit 10
```

returned the expected ratios:

```text
('rho3_i00_l01_p', 'rho3_column_guess', 4) 7
('rho4_i00_m00_p', 'rho4_column_guess', 1) 3
```

The fiber relation probe

```text
python3 double_fiber_x0_repeated_u25_fiber_relation_probe.py \
  --limit 3 --assignments 2 --stop-on-failure
```

chooses previous repeated-`u^20` free values, solves the previous pivots
exactly, and tests the same two determinants.  It returned:

```text
samples checked: 3
ratio tuple counts:
  (('rho3_i00_l01_p', (4, 4)), 2)
  (('rho4_i00_m00_p', (1, 1)), 1)
failures: []
```

This supports the same degree-separation mechanism as the earlier vertical
layers: the selected columns require only

```text
Q mod u^3,  T mod u^3.
```

The previous free coordinates enter too late to affect these low-order terms.
Thus repeated `x=0,u^25` imposes no new older residual on the clean charted
branch.

## Consequence

The local chain through repeated `u^25` is now cleared.  Since the original
coefficient range is `F0,...,F35`, the next simple coefficient after `u^25`
has no analogous new `U_{-3}(0)` variable to solve.  The next target should
therefore be an audit of the next simple/repeated ODE coefficient with the
tail exhausted, or a more conceptual recurrence argument explaining why the
observed solvability pattern either terminates in a contradiction or produces
an actual construction.
