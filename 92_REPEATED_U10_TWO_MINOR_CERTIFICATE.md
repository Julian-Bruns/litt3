# Repeated u10 two-minor certificate

This note records the local determinant certificate for the repeated
`x=0,u^10` layer after the repeated-`u^5` atlas and the simple-`u^10` solve.
It is a local double-fiber layer result, not yet a complete common-cover proof.

## Setup

Use the old repeated-`u^5` columns

```text
I=Col(i00),  L=Col(l01),  M=Col(m00),  P=Col(p),
rho3=det(I,L,P),  rho4=det(I,M,P).
```

The repeated-`u^5` certificate gives `P=ell^(-1)` and, after dividing by
`P`,

```text
U_I=I/P,  U_L=L/P,  U_M=M/P,
[s^2]U_I=4,
U_M-U_L=s.
```

The repeated-`u^10` tail formula, including the simple-`u^10` Schur
correction, gives

```text
u18_3/P = 1,
u17_1/P = U_L,
u19_2/P = F := [u^2](Q^14+4Q^16)T^(-1),
u19_3/P = G := [u^1]Q^14T^(-1),
```

where `Q=w0/u`, `T=ell^(-1)u^(-5)dF/dw(u,w0)`, and `T(0)=1`.

## Scalar Identities

The symbolic certifier

```text
double_fiber_x0_repeated_u10_scalar_identity_symbolic.py
```

proves, after clearing the same `Delta0` denominator as the earlier old-branch
certificate,

```text
[s^2]U_L = 0,
[s^2]F   = 2.
```

The command

```text
python3 double_fiber_x0_repeated_u10_scalar_identity_symbolic.py
```

returned:

```text
UL_s2 Delta power cleared: 2
UL_s2 cleared difference terms: 0
F_s2 Delta power cleared: 2
F_s2 cleared difference terms: 0
certified: UL_s2=0 and F_s2=2
```

Because `Q=1+s*u+O(u^2)`, and fifth powers have no terms of degrees
`1,...,4` in characteristic `5`,

```text
[u^1]Q^16T^(-1)=[u^1]Q^11T^(-1)=U_L,
G=[u^1]Q^14T^(-1)=U_L+3s.
```

Together with `U_M=U_L+s`, write

```text
U_L = a + d*s.
```

The scalar identity `[s^2]U_L=0` is what permits this notation.

## Determinants

In the basis `(1,s,s^2)`, write `U_I=*+4s^2`, `U_L=a+d*s`, and
`F=*+2s^2`.  Then

```text
rho3/P^3 = det(U_I,U_L,1) = d,
rho4/P^3 = det(U_I,U_M,1) = d+1.
```

For the first repeated-`u^10` minor,

```text
det(u19_2,u18_3,u17_1)/P^3
  = det(F,1,U_L)
  = 2d
  = 2*rho3/P^3.
```

Hence

```text
det(u19_2,u18_3,u17_1)=2*rho3.
```

For the fallback minor, assume `rho3=0`.  Then `d=0`, so
`rho4/P^3=d+1=1`, and `G=U_L+3s` has `s`-coefficient `3`.  Therefore

```text
det(u19_2,u19_3,u18_3)/P^3
  = det(F,G,1)
  = -3*2
  = 4
  = 4*rho4/P^3.
```

Thus, on the fallback locus,

```text
rho3=0, rho4!=0  =>  det(u19_2,u19_3,u18_3)=4*rho4 != 0.
```

## Consequence

Since the repeated-`u^5` atlas already proves that `rho3` and `rho4` cannot
vanish simultaneously, the two minors

```text
det(u19_2,u18_3,u17_1),
det(u19_2,u19_3,u18_3)
```

cover the repeated-`u^10` layer:

```text
rho3 != 0:
  det(u19_2,u18_3,u17_1)=2*rho3 != 0,

rho3 = 0:
  rho4 != 0 and det(u19_2,u19_3,u18_3)=4*rho4 != 0.
```

This closes the local repeated-`x=0,u^10` rank obstruction in the clean
charted branch.
