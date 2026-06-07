# Repeated u5 repaired atlas certificate

This note records the local proof that the repaired repeated-`x=0,u^5`
atlas is certified on the clean repeated branch open `Psi=0, Delta0 != 0`.
It is still a local double-fiber layer result, not a complete common-cover
proof.

## Setup

Use the effective repeated-`u^5` columns

```text
I = Col(i00),  J = Col(j00),  L = Col(l01),  M = Col(m00),
P = Col(p),    p = l02 + m01 + n00.
```

The column-recursion certificate proves the common column identity

```text
Col(l02)=Col(m01)=Col(n00)=ell^(-1).
```

After factoring out `P=ell^(-1)`, write

```text
U_I = I/P,  U_L = L/P,  U_M = M/P.
```

The closed response formula from
`81_REPEATED_U5_COLUMN_RECURRENCE_CERTIFICATE.md` is

```text
R(k,b) = ell^(-1) * [u^(15-k-b)] Q^(k-2) T^(-1),
Q = w0/u,
T = ell^(-1)u^(-5)(dF_zero/dw)(u,w0),
T(0)=1.
```

Therefore

```text
U_L = [u^1] Q^11*T^(-1),
U_M = [u^1] Q^12*T^(-1).
```

## Rank(I,P)=2

The Pro run

```text
fresh_repeated_u5_ui_s2_identity
https://chatgpt.com/c/6a21b8c9-e0e4-8333-b59e-5e2c9105eca4
```

proved the explicit formulas

```text
[s^2]U_A = c2^2 + 2*c2*d1 + 4*d2 + 2*e1 + 3,
Li       = 4*c2^2 + 3*c2*d1 + d2 + 3*e1 + 1.
```

Since `[s^2]U_C=1`, this gives

```text
[s^2]U_I = [s^2](U_A + Li*U_C) = [s^2]U_A + Li = 4.
```

The local verifier

```text
python3 double_fiber_x0_repeated_u5_ui_s2_formula_verify.py --limit 200 --stop-on-failure
```

returned

```text
samples checked: 200
failures: []
```

Hence `U_I` is not constant in the `F_5`-basis `1,s,s^2`, and

```text
rank(I,P)=2.
```

## The L/M Difference

Since

```text
Q = 1 + s*u + O(u^2),
T^(-1) = 1 + O(u),
```

the closed formula gives

```text
U_M - U_L
 = [u^1] Q^11*(Q-1)*T^(-1)
 = [u^1] (1+O(u))*(s*u+O(u^2))*(1+O(u))
 = s.
```

This identity uses no expansion of the large coefficient system beyond the
already certified closed column formula.

Now `s` is not in `span_F5{1,U_I}`.  Indeed, if

```text
s = a + b*U_I
```

then the `s^2` coefficient gives `0 = 4*b`, hence `b=0`; then `s=a`, which is
impossible on the clean cubic open `Delta0 != 0`, where `1,s,s^2` are
independent.

Therefore `U_L` and `U_M` cannot both lie in `span_F5{1,U_I}`.  Equivalently,
`L` and `M` cannot both lie in `span_F5{P,I}`.

Since `rank(I,P)=2`, this proves

```text
rank(I,L,M,P)=3.
```

The ambient repeated-`u^5` residual matrix has three rows, so this is exact
rank `3`.

## Atlas Consequence

The repaired chart determinants are

```text
rho1 = det(I,J,P),
rho2 = det(I,L,M),
rho3 = det(I,L,P),
rho4 = det(I,M,P).
```

The rank proof above gives the stronger two-chart statement:

```text
rho3 and rho4 cannot vanish simultaneously.
```

Indeed, if `rho3=rho4=0`, then `L,M in span(I,P)`, contradicting
`rank(I,L,M,P)=3`.

Thus the repaired four-chart atlas is certified locally:

```text
(Psi, rho1, rho2, rho3, rho4) : Delta0^infty = (1)
```

for this repeated-`x=0,u^5` layer, and in fact the two charts

```text
det(I,L,P),  det(I,M,P)
```

already cover the clean open for the effective matrix.

## Verification Trail

The exact inputs are archived in:

```text
81_REPEATED_U5_COLUMN_RECURRENCE_CERTIFICATE.md
84_REPEATED_U5_SIMPLE_BRIDGE_PROOF.md
double_fiber_x0_repeated_u5_base_uc_identity_symbolic.py
double_fiber_x0_repeated_u5_ui_s2_formula_verify.py
double_fiber_x0_repeated_u5_t_quotient_probe.py
```

The command

```text
python3 double_fiber_x0_repeated_u5_t_quotient_probe.py --limit 300
```

now also records the finite check:

```text
UI s2 coefficient counts: [(4, 300)]
UM-UL basis counts: [((0, 1, 0), 300)]
UM-UL != s examples: []
bad rank examples: []
```
