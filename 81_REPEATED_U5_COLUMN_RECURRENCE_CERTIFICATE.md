# Repeated u5 column recurrence certificate

This note tracks the focused column-recursion target for the repaired
repeated-`x=0,u^5` atlas.

## Finished Pro Run

```text
label: fresh_repeated_u5_column_recurrence_certificate
url: https://chatgpt.com/c/6a21ac12-8d40-832f-a620-434e3abbd063
prompt: pro_prompts/fresh_repeated_u5_column_recurrence_certificate.md
status: finished at 2026-06-04T19:05:18+0200
status files:
  pro_outputs/fresh_repeated_u5_column_recurrence_certificate_guard_status.json
  pro_outputs/fresh_repeated_u5_column_recurrence_certificate_status.json
```

The prompt asks for an exact straight-line certificate for the seven visible
columns of the repeated-`u^5` affine matrix:

```text
i00, j00, l01, l02, m00, m01, n00.
```

The key required local theorem is the common-column identity

```text
Col(l02)=Col(m01)=Col(n00)=ell^(-1),
```

plus implementation-ready recurrences for

```text
I=Col(i00), J=Col(j00), L=Col(l01), M=Col(m00), P=Col(l02+m01+n00).
```

This is deliberately one level below the repaired-atlas saturation.  Its
useful formula has been folded into
`pro_prompts/fresh_repeated_u5_repaired_atlas_certificate.md` as the next
broader proof target.

The visible Pro output did not give a hidden-formula-independent certificate
for all seven columns.  Instead it identified the missing exact datum:

```text
H(u) = (d/dw F_old)(u,w0) = u^5 * ell * T(u),  T(0)=1.
```

The diagonal branch fact only fixes `T(0)=1`; the columns `I,J,L,M` can depend
on `T_1,...,T_4`.  This is a valid correction to the prompt, not a
counterexample to the real local problem, because the actual base equation
does determine `T` by straight-line differentiation.

With `Q=q0=w0/u`, Pro's closed raw-response formula is:

```text
R(k,b) = ell^(-1) * [u^(15-k-b)] Q^(k-2) T^(-1)
```

for a visible perturbation `delta F_k=(-u+u^2)u^b`.  Hence:

```text
Col(i00) = R(11,0) + Li*R(13,0),
Col(j00) = R(12,0) + Lj*R(13,0),
Col(l01) = R(13,1),
Col(l02) = R(13,2),
Col(m00) = R(14,0),
Col(m01) = R(14,1),
Col(n00) = R(15,0).
```

The common-column identity follows because the three common columns use
coefficient degree zero:

```text
R(13,2)=R(14,1)=R(15,0)=ell^(-1).
```

## Local Dual-Number Check

The script

```text
double_fiber_x0_repeated_u5_column_recurrence_verify.py
```

computes the same columns by differentiating the branch recursion over dual
numbers `a+eps*b`, `eps^2=0`, at finite clean split samples.

It compares those derivative columns against the older unit-vector residual
matrix from `double_fiber_x0_repeated_u5_linear_probe.py`, and also checks the
common column against explicit `ell^(-1)` root values.

The command

```text
python3 double_fiber_x0_repeated_u5_column_recurrence_verify.py --limit 50 --stop-on-failure
```

returned:

```text
samples checked: 50
failures: []
```

This is not a symbolic proof over `bar F_5`, but it is a stronger sign check
than unit-vector sampling alone: it verifies the straight-line derivative
recursion and signs directly on the finite diagnostic stream.

The follow-up script

```text
double_fiber_x0_repeated_u5_t_formula_verify.py
```

computes the actual unit

```text
T(u) = ell^(-1) * u^(-5) * (d/dw F_zero)(u,w0)
```

through degree `4`, evaluates the closed formula above, and compares every
visible column against the dual-number recursion.  The command

```text
python3 double_fiber_x0_repeated_u5_t_formula_verify.py --limit 100 --stop-on-failure
```

returned:

```text
samples checked: 100
failures: []
```

## Common-Column Sign Proof

The common-column identity itself has a short formal proof from leading terms.
At `x=0`,

```text
x*(x-1) = -u + u^2,
w0 = u + O(u^2).
```

The three variables

```text
l02=[u^2]U22(u),  m01=U21'(0),  n00=U20(0)
```

enter as:

```text
F13(l02) = (-u+u^2)*l02*u^2,
F14(m01) = (-u+u^2)*m01*u,
F15(n00) = (-u+u^2)*n00.
```

Multiplying by the corresponding powers of `w0` gives the first visible
contribution in the branch equation `C16=[u^16]F(u,w)=0`:

```text
F13(l02)*w0^13 = -l02*u^16 + O(u^17),
F14(m01)*w0^14 = -m01*u^16 + O(u^17),
F15(n00)*w0^15 = -n00*u^16 + O(u^17).
```

These variables do not affect any earlier branch coefficient `B3,...,B10`.
Since

```text
C16 = ell*B11 + C16^[11],
```

the first-order branch perturbation for any of `l02,m01,n00` is

```text
delta B11 = ell^(-1).
```

Finally,

```text
z = 1/w = u^(-1) * q^(-1),  q=1+s*u+B3*u^2+...,
```

so a perturbation `delta w = ell^(-1)*u^11` contributes

```text
delta z = -ell^(-1)*u^9*q^(-2).
```

Thus `delta Z5=delta Z6=delta Z7=delta Z8=0` and

```text
delta Z9 = -ell^(-1).
```

For

```text
E = Z1^5 - Z5 - Z6 - Z7 - Z8 - Z9,
```

the derivative of `Z1^5` is zero in characteristic `5`, hence

```text
delta E = -delta Z9 = ell^(-1).
```

Therefore

```text
Col(l02)=Col(m01)=Col(n00)=ell^(-1).
```

This proof does not use the expanded old coefficients `F0,...,F10`; it uses
only the triangular branch coefficient `ell` and the visible leading terms.

## Straight-Line Column Recurrence

For any visible variable `v`, define its coefficient perturbation
`delta F_a^v` by:

```text
delta F11^i = (-u+u^2),
delta F13^i = (-u+u^2)*Li,

delta F12^j = (-u+u^2),
delta F13^j = (-u+u^2)*Lj,

delta F13^l01 = (-u+u^2)*u,
delta F13^l02 = (-u+u^2)*u^2,

delta F14^m00 = (-u+u^2),
delta F14^m01 = (-u+u^2)*u,

delta F15^n00 = (-u+u^2).
```

All other `delta F_a^v` are zero.  Write

```text
delta_v w = sum_{r=3}^{11} d_r(v)*u^r.
```

The triangular derivative recursion is:

```text
d_r(v) =
  -ell^(-1) *
  [eps*u^(r+5)]
    sum_a (F_a^0 + eps*delta F_a^v)
          (w0 + eps*sum_{q=3}^{r-1} d_q(v)*u^q)^a,
  r=3,...,11,
  eps^2=0.
```

Equivalently, when computing the coefficient of `u^(r+5)`, set the
new derivative `d_r(v)` to zero and use the already computed
`d_3(v),...,d_{r-1}(v)`.

After the branch derivatives are known, set

```text
q0 = w0/u,
delta_v q = sum_{r=3}^{11} d_r(v)*u^(r-1).
```

Since

```text
z = u^(-1)*q^(-1),
delta_v z = -u^(-1)*q0^(-2)*delta_v q,
```

and `d(Z1^5)=0` in characteristic `5`, the column is:

```text
Col(v)
 = -sum_{n=5}^9 [u^n] delta_v z
 =  sum_{n=5}^9 [u^(n+1)] q0^(-2)*delta_v q.
```

Equivalently, if

```text
q0^(-2) = sum_{k>=0} Q_k*u^k,
```

then

```text
Col(v) = sum_{r=3}^{11} d_r(v) * S_r,
S_r = sum_{k=max(0,7-r)}^{11-r} Q_k.
```

In particular `S_11=Q_0=1`, which is the last sign check in the common-column
proof.

This recurrence is what
`double_fiber_x0_repeated_u5_column_recurrence_verify.py` implements over
dual numbers at finite split samples.

The leading visible terms also give the first nonzero branch perturbations:

```text
d_7(i00)  = ell^(-1),   from F11(i00)*w0^11 at C12,
d_8(j00)  = ell^(-1),   from F12(j00)*w0^12 at C13,
d_10(l01) = ell^(-1),   from F13(l01*u)*w0^13 at C15,
d_10(m00) = ell^(-1),   from F14(m00)*w0^14 at C15,
d_11(l02) = ell^(-1),   from F13(l02*u^2)*w0^13 at C16,
d_11(m01) = ell^(-1),   from F14(m01*u)*w0^14 at C16,
d_11(n00) = ell^(-1),   from F15(n00)*w0^15 at C16.
```

The later `d_r` for each variable are then forced by the triangular recurrence
and the already-computed earlier perturbations.

## Raw Response Diagnostic

The script

```text
double_fiber_x0_repeated_u5_raw_response_probe.py
```

separates the visible columns into raw coefficient-response columns:

```text
I = R(F11 const) + Li*R(F13 const),
J = R(F12 const) + Lj*R(F13 const),
L = R(F13 u),
M = R(F14 const),
P = R(F13 u^2) = R(F14 u) = R(F15 const).
```

The command

```text
python3 double_fiber_x0_repeated_u5_raw_response_probe.py --limit 100
```

returned:

```text
samples checked: 100
rank tuple counts (all, A/C/E, A/E):
  ((3, 2, 1), 3)
  ((3, 2, 2), 15)
  ((3, 3, 2), 82)
universal equal raw pairs:
  (E_F13_u2, G_F14_u),
  (E_F13_u2, H_F15_const),
  (G_F14_u, H_F15_const)
```

After adding the `I=A+Li*C` mechanism count, the same command returned:

```text
IP mechanism counts (rankAE, rankCE, Li_nonzero, rankIE, rankACE):
  (1, 2, 1, 2, 2) 3
  (2, 2, 0, 2, 2) 1
  (2, 2, 0, 2, 3) 18
  (2, 2, 1, 2, 2) 14
  (2, 2, 1, 2, 3) 64
```

This confirms the common raw response behind `P`, but it also warns against a
too-simple rank proof: the raw pair `R(F11 const),P` has rank `1` in some
samples.  The observed `rank(I,P)=2` uses the actual simple-`u^5` mixing
coefficient `Li` in

```text
I = R(F11 const) + Li*R(F13 const).
```

In these samples `rank(C,P)=2` always.  When `rank(A,P)=1`, the coefficient
`Li` is nonzero and rescues `rank(I,P)`.  This suggests a possible symbolic
route for the `rank(I,P)=2` half of the repaired-atlas proof:

```text
prove rank(C,P)=2, and prove that rank(A,P)=1 implies Li != 0.
```

The closed `T`-formula sharpens this route.  Since

```text
P = ell^(-1),  C = ell^(-1) * U_C,
U_C = [u^2] Q^11*T^(-1),
```

the pair `(C,P)` has rank `2` exactly when `U_C` is not a scalar in `F_5`.
The diagnostic

```text
python3 double_fiber_x0_repeated_u5_t_quotient_probe.py --limit 300
```

returned no bad rank examples and found:

```text
quotient pattern counts (UA_const, UC_const, Li_nonzero, UI_const):
  (False, False, 0, False) 64
  (False, False, 1, False) 224
  (True, False, 1, False) 12
UC nonconstant coefficient counts (s, s2):
  ((0, 1), 52), ((1, 1), 69), ((2, 1), 56),
  ((3, 1), 57), ((4, 1), 66)
bad rank examples: []
```

Thus every checked quotient has

```text
U_C = c0 + c1*s + s^2.
```

The next small theorem to prove is therefore:

```text
[s^2] [u^2] Q^11*T^(-1) = 1
```

on the clean repeated-u5 open.  This would prove `rank(C,P)=2` immediately.

Even better, the identity appears to belong to the old base branch alone.  The
script

```text
python3 double_fiber_x0_repeated_u5_base_uc_identity_probe.py --limit 5000 --stop-on-failure
```

uses only `F0,...,F7`, before the phi layer and before the simple-u5 solve.  It
returned:

```text
base-only checked: 5000
failures: []
```

Thus the symbolic target should be phrased without `F8,...,F13`:

```text
For the base repeated branch of F0,...,F7, prove
U_C=[u^2](w0/u)^11*T^(-1) has s^2 coefficient 1.
```

The same script also has an arbitrary-cubic mode matching the focused Pro
prompt:

```text
python3 double_fiber_x0_repeated_u5_base_uc_identity_probe.py --arbitrary-cubics --limit 1000 --stop-on-failure
```

It returned:

```text
arbitrary-cubic base-only checked: 1000
failures: []
```

The symbolic certificate script

```text
python3 double_fiber_x0_repeated_u5_base_uc_identity_symbolic.py
```

then proved the identity exactly for arbitrary cubics `U30,U29,U28`.  It uses
the expansion

```text
F(u,u+y*u^2)=u^7*(P0(y)+u*P1(y)+u^2*P2(y)+...)
```

and computes `B3,B4,T1,T2` symbolically in
`K[s]/(P0)`, clearing the `Delta0` denominators from `ell^(-1)`.  It returned:

```text
Delta power cleared: 4
U_C numerator term counts [1,s,s2]: [435579, 348996, 13598]
s2 numerator minus Delta^power terms: 0
certified: coeff_s2(U_C) = 1
```

Consequently

```text
U_C = c0 + c1*s + s^2,
C = ell^(-1)*U_C,
P = ell^(-1),
```

so `C` and `P` are linearly independent over `F_5` on the clean open
`Delta0 != 0`.  This proves the raw-response lemma `rank(C,P)=2`, and leaves
the remaining `rank(I,P)=2` task as the interaction with the simple-u5 mixing
coefficient

```text
I = A + Li*C.
```

The focused Pro run

```text
fresh_repeated_u5_base_uc_identity
https://chatgpt.com/c/6a21b461-4b80-8332-8765-c1946dedfdb4
```

finished at `2026-06-04T19:46:46+0200` and supplied a more compact hand
derivation.  It writes

```text
F(u,u+z*u^2)=u^7*(P0(z)+u*P1(z)+u^2*P2(z)+...)
```

up to an irrelevant `z`-independent lower term, sets

```text
L=P0'(s), C=s+alpha, N=-P1(s), A=P2(s),
B=P1'(s), D=P2'(s), E=P1''(s),
B3=N/L,
B4=-(A+B*B3+C*B3^2)/L,
T1=(B+2*C*B3)/L,
T2=(D+E*B3+B3^2+2*C*B4)/L,
U_C=B3-s*T1+T1^2-T2.
```

After clearing `L^4`, it obtains `U_C=R/L^4`.  If `LJ=Delta`, then the
universal reduction is:

```text
[s^2](R*J^4) - Delta^4 = -(p4-1)^2 * Delta^4,
p4 = [z^4]P1(z).
```

For the actual `F0,...,F7`, `p4=1`, hence `[s^2]U_C=1`.  This agrees with the
local symbolic script and is the preferred hand-checkable form of the lemma.

The quotient probe now also tracks this interaction.  For

```text
U_A = A/P,  U_I = I/P = U_A + Li*U_C,
```

the command

```text
python3 double_fiber_x0_repeated_u5_t_quotient_probe.py --limit 300
```

returned:

```text
UI s2 coefficient counts: [(4, 300)]
UI s2 != 4 examples: []
bad rank examples: []
```

Thus the next exact lemma is:

```text
[s^2](U_A + Li*U_C) = 4.
```

This would prove `rank(I,P)=2` immediately, just as the proved
`[s^2]U_C=1` proves `rank(C,P)=2`.

The dependency diagnostic

```text
python3 double_fiber_x0_repeated_u5_ui_s2_dependency_probe.py --limit 300
```

then checked whether `[s^2]U_A` depends on the phi layer or on the simple
constant `Lc`.  It returned:

```text
samples checked: 300
pattern counts (Li, UA_full_s2, UA_phi_no_lc_s2, UA_old_s2, Li+UA_old_s2):
  (0, 4, 4, 4, 4) 64
  (1, 3, 3, 3, 4) 53
  (2, 2, 2, 2, 4) 49
  (3, 1, 1, 1, 4) 83
  (4, 0, 0, 0, 4) 51
failures: []
```

Thus `[s^2]U_A` is already an old-branch quantity, unchanged after adding the
phi layer or `Lc`, and the remaining exact identity can be phrased as:

```text
Li = 4 - [s^2]U_A_old.
```

The simple-branch response diagnostic

```text
python3 double_fiber_x0_repeated_u5_simple_li_response_probe.py --limit 200
```

then isolated the row that defines `Li`.  For the simple branch with tangent
`-u`, perturbing `l00` changes only the ODE residual coefficient `u^5`, by the
constant `2`.  Perturbing `i00` also changes only this same row, and `Li`
cancels it:

```text
samples checked: 200
patterns (col_i, col_l, col_i+Li*col_l, Li):
  ((0,0,0,0,0,0), (0,0,0,0,0,2), 0-row, 0) 39
  ((0,0,0,0,0,3), (0,0,0,0,0,2), 0-row, 1) 37
  ((0,0,0,0,0,1), (0,0,0,0,0,2), 0-row, 2) 34
  ((0,0,0,0,0,4), (0,0,0,0,0,2), 0-row, 3) 53
  ((0,0,0,0,0,2), (0,0,0,0,0,2), 0-row, 4) 37
failures: []
```

Thus `Li=-col_i/2=2*col_i`.  The identity `Li=4-[s^2]U_A_old` is equivalent
to proving the old-branch/simple-branch bridge

```text
col_i(u^5 simple residual) = 2 + 2*[s^2]U_A_old.
```

The focused Pro run

```text
fresh_repeated_u5_ui_s2_identity
https://chatgpt.com/c/6a21b8c9-e0e4-8333-b59e-5e2c9105eca4
```

finished at `2026-06-04T20:09:36+0200` and proved the identity directly.  It
gave the explicit formulas

```text
[s^2]U_A = c2^2 + 2*c2*d1 + 4*d2 + 2*e1 + 3,
Li       = 4*c2^2 + 3*c2*d1 + d2 + 3*e1 + 1.
```

Their sum is identically `4` in `F_5`, so with `[s^2]U_C=1`:

```text
[s^2](I/P) = [s^2](U_A + Li*U_C) = [s^2]U_A + Li = 4.
```

The proof also explains this as a residue identity:

```text
[s^2]U_A + Li
 = [u^2] 2 * sum_over_four_local_roots G_q(u,q)*q^9
 = [q^(-1)] 2*q^9/G(u,q)
 = 4.
```

It computes the simple-branch contribution from

```text
q_-(u)=-1+a*u+b*u^2+O(u^3),
a=3*c2+3*d1+1,
b=c2^2+c2*d1+d1+e1+4,
```

and derives the displayed formula for `Li`.

The finite verifier

```text
python3 double_fiber_x0_repeated_u5_ui_s2_formula_verify.py --limit 200 --stop-on-failure
```

checked these explicit formulas against the local straight-line branch code:

```text
samples checked: 200
failures: []
```

An earlier scratch run checked `500` samples with no failures.  This certifies
the second sufficient rank condition:

```text
rank(I,P)=2
```

on the clean open `Delta0 != 0`.

The sharper bridge run

```text
fresh_repeated_u5_simple_bridge_identity
https://chatgpt.com/c/6a21bd6a-54bc-832d-9d8e-e44313e798dd
```

finished at `2026-06-04T20:25:19+0200` and proved the equivalent identity

```text
col_i(simple u^5 residual) = 2 + 2*[s^2]U_A.
```

It gives the same formulas, written modulo `5` as

```text
[s^2]U_A = c2^2 + 2*c2*d1 - d2 + 2*e1 - 2,
Li       = 1 - c2^2 + 3*c2*d1 + d2 + 3*e1.
```

This direct bridge proof is archived in
`84_REPEATED_U5_SIMPLE_BRIDGE_PROOF.md`.

## Relation To Repaired Atlas

The repaired atlas target remains:

```text
rho1 = det(I,J,P),
rho2 = det(I,L,M),
rho3 = det(I,L,P),
rho4 = det(I,M,P).
```

The strongest sufficient pattern supported by finite diagnostics was:

```text
rank(I,J,L,M,P)=3,
rank(I,P)=2
```

on `Psi=0, Delta0 != 0`.  The second condition is now proved by the
`[s^2]U_I=4` identity above, and the first condition has a short consequence
from the same closed response formula.

Indeed,

```text
U_L = L/P = [u^1] Q^11*T^(-1),
U_M = M/P = [u^1] Q^12*T^(-1).
```

Since `Q=1+s*u+O(u^2)` and `T^(-1)=1+O(u)`,

```text
U_M - U_L
 = [u^1] Q^11*(Q-1)*T^(-1)
 = s.
```

But `s` is not in `span_F5{1,U_I}`: if `s=a+b*U_I`, then comparing the
`s^2` coefficient gives `0=4*b`, so `b=0`, and then `s=a`, impossible on the
clean cubic open `Delta0 != 0`.

Thus `L` and `M` cannot both lie in `span(I,P)`, so

```text
rank(I,L,M,P)=3.
```

Consequently `rho3=det(I,L,P)` and `rho4=det(I,M,P)` cannot vanish
simultaneously.  This proves the repaired repeated-`u^5` atlas locally, and in
fact the two charts `rho3,rho4` already cover the effective matrix.  The
standalone certificate is recorded in
`83_REPEATED_U5_REPAIRED_ATLAS_CERTIFICATE.md`.
