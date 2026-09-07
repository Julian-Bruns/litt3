# Proof: the actual cubic deck action on the scalar atlas system

[Statement](../Theorems/Thm_oper_deck_graded_atlas.md).
Use `scalar_hermitian_data`, `wronskian_matrix_pencil`,
`dormant_differential_projection`, `fixed_x_oper_cubic_quotient`, and
`acyclic_alternating_atlas`. All calculations are on the ORIGINAL curve.
Write u=x^3/y for the local uniformizer, reserving t for c4. Thus
kappa=u^-17 and theta=dx/y^2.

## 1. Oper and local-data covariance

The automorphism sigma fixes constants and sends y to zeta*y. Therefore

    sigma(u)=zeta^-1 u,      sigma(theta)=zeta theta,
    delta sigma=zeta sigma delta,      sigma(kappa^5)=zeta kappa^5.

The affine ring and the gap-normalized local remainders are stable under
sigma. The operators aff, rem and rho_n commute with it. Writing

    P(t)=t^2 Ahat+(B+2x^8)y+t Chat*y^2,

one has P(zeta*t)=zeta^2 sigma(P(t)). It follows directly that

    L_(zeta*t) sigma=zeta^2 sigma L_t,
    Q_(zeta*t) sigma=sigma Q_t.                            (1)

In particular sigma transports horizontal sections for the chosen oper
to horizontal sections for the new oper. No simultaneous Galois closure,
Jacobian replacement, or unrelated change of curve is involved.

## 2. Covariance of the full raw N/R criterion

Put U'=sigma U and eta'=zeta sigma eta. Let H=U eta^5,
V=rem H, T=-aff H, and D=-rho32 delta. Then

    H'=zeta^2 sigma H,      V'=zeta^2 sigma V,
    T'=zeta^2 sigma T,      D eta'=zeta^2 sigma(D eta).

The raw N output is therefore zeta^2 sigma(N_U eta^[5]). Its zero locus
is preserved. The two terms of the raw R output transform as

    kappa^5 V' = zeta sigma(kappa^5 V),
    U'(D eta')^5 = zeta sigma(U(D eta)^5).

Consequently

    R_(U') (eta')^[5]=zeta sigma(R_U eta^[5]),

which preserves its equality with eta. Finally

    Wh(U',T')=zeta^3 sigma(Wh(U,T))=Wh(U,T)

when the Wronskian is a constant. In particular Wronskian1 is preserved.
Pole orders are unchanged, so the original infinity conditions are
preserved as well.

The compact normalization is preserved directly by the residue pairing.
If Q_t h=U, equation (1) gives Q_(zeta*t)(sigma h)=sigma U. Hence

    Res_O((zeta sigma eta)(sigma h) theta)
      =Res_O sigma(eta h theta)=Res_O(eta h theta).

This proves the action on all normalized atlas data, including the local
extension normalization that a change of the scalar differential alone
would not check.

## 3. The Q matrix and a minor over the normalized field

On the input and output monomial bases sigma has diagonal matrices with
entries zeta^j_i and zeta^k_r. Equation (1) says

    M(zeta*t)=diag(zeta^k_r) M(t) diag(zeta^-j_i).

Every entry of t^(j_i-k_r) M(t)_(r,i) has t-exponent divisible by three.
Substituting t^3=lambda gives Mhat in (2) of the statement. There are no
negative lambda exponents in Mhat; the following explicit block formula
also proves this and provides a direct construction.

Keep the ORIGINAL derivation delta and relation y^3=F while evaluating
the following linear terms. On an input h=x^i y^j, separate Q into

    Q_B h = delta^3 h+((B+2x^8)y) delta h
                         +3 delta((B+2x^8)y) h,
    Q_A h = Ahat delta h+3 delta(Ahat) h,
    Q_C h = (Chat*y^2) delta h+3 delta(Chat*y^2) h.

The first term stays in y-character j, the second has character j+2,
and the third has character j+1, all taken modulo three. The normalized
matrix column is

    Q_B h + lambda^[j>=1] Q_A h + lambda^[j=2] Q_C h.       (2)

Here a bracket in an exponent is0 or1. The factors account for the wrap
of the y-character in t^(j_i-k_r) times the original t^2 or t coefficient.
This formula is affine in each Ahat,Chat,B block and of total degree at
most2 in those blocks together with lambda. It involves no cube root.
Taking determinants of the row and column diagonal changes proves (3).

The exact script `scripts/orbit11_q_frame.sage` first checks (2) against
the saved first-oper matrix at the selected32-square minor, including
the row and column weights. The normalized coefficient field for orbit11
is then read from the separately verified relative-field artifact. Its
irreducibility is already certified; the script constructs that quotient
directly instead of repeating a degree7324 irreducibility test.

## 4. Descent of the full Q-frame equations

Let I,J select a nonzero minor. Under the action in Section2, the Q-frame
coordinates transform as

    v_i -> zeta^j_i v_i,        b_l -> zeta^-k_l b_l.        (3)

The first assertion follows immediately from the Q matrix covariance.
For the second, recall that i(eta)(U)=b^T U_J. The residue calculation
in Section2 preserves this pairing while U_J is multiplied by
diag(zeta^k_l). Therefore b transforms by the inverse diagonal matrix.

For completeness, the characters of the projected equations are explicit.
Let f=x^2*y, so sigma(f^5)=zeta^2 f^5. The N row paired with f^(5s) h_i
(s=0,1) transforms by

    zeta^(1-j_i-2s).

Indeed its product H contributes zeta^2, while moving sigma across the
residue costs zeta^(j_i+2s+1) from f^(5s) h_i theta. The projected R row
paired with h_i, including its right side (G^T b)_i, transforms by
zeta^-j_i. The normalization has character zero.

Make the substitutions (4) of the statement. Each coefficient of each
row is now a Laurent polynomial in t with exponents in a SINGLE residue
class modulo three. Removing the corresponding common power of t and
replacing every t^3 by lambda gives equations over K. Negative lambda
powers may be cleared because lambda is a proved unit. This operation
uses the fixed-curve residue maps throughout; it makes no assertion that
the monic F formulas apply unchanged to w^3=lambda F.

The diagonal coordinate changes and row rescalings are invertible after
adjoining t. They consequently give an isomorphism of affine schemes,
not only a map on a selected set of rational points. The geometric
solutions, Frobenius residuals, and compact normalization are all retained.
The same argument descends the169-equation raw-N presentation in the
nonacyclic case, using the individual raw row characters instead.

If lambda is already a cube, choosing a root would put the original
oper over K. The construction still avoids COMPUTING that root. If it
is not a cube, the same formulas give a K-model whose scalar extension
is the actual chosen-oper atlas scheme. In neither case does descent
make the normalized point's degree over F25 smaller.

## Orbit11 scope

The previously verified relative-field report has degree7324 over F25,
primitive separator a9, Norm(lambda)=4 and cubic character1. Thus lambda
is a cube in this field, but its extraction is an unnecessary large-field
step. The high-pole Q-minor calculation completes exactly in128.37seconds.
It has26 constant pivots and6 nonconstant pivots; its determinant is
nonzero and its relative norm is1. The row/column index lists, exact
determinant, source hashes, and deck weight6 are saved in
`/Users/julian/Documents/litt3-computation-data/orbit11-structure/q_frame_high_minor.json`.

The26 constant pivots are not an accidental specialization. Running the
same high-pole minor over the polynomial ring in the23 normalized
coordinates also completes26 constant pivots, in0.35seconds. It leaves
a6-square polynomial matrix H with entries of total degree at most9
and determinant identity det Ghat=-det H. The exact remaining matrix
and coefficient counts are in the adjacent `q_frame_symbolic.json`.
This calculation uses no dormant-oper equations; it is a polynomial
matrix identity. In particular H is invertible at orbit0011, by the
independent nonzero determinant computation over that field. It is not
presumed invertible at every point of the oper census.

These are bounded preparation checks, not atlas calculations or emptiness
certificates. No97-equation expanded tensor or new atlas solver was built.

No Frobenius-orbit or cubic-symmetry argument here excludes an oper.
The unmarked common-cover problem remains unsolved; both actual finite
etale legs from the same smooth projective source remain required.
