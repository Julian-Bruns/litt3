# Proof: acyclicity, a canonical pencil, and an inverse-free atlas frame

[Statement](../Theorems/Thm_acyclic_alternating_atlas.md).
This proof uses `rank_two_extension_pencil`, `dormant_differential_projection`
and `compact_etale_atlas_system`. It does not assume an atlas is absent.

## 1. The characteristic-independent alternating pencil

The basepoint-free canonical pencil has exact evaluation sequence

    0 -> omega^-1 -> O^2 -> omega ->0.

Tensoring by V omega gives

    0 -> V -> (V omega)^2 -> V omega^2 ->0.                  (1)

The chosen determinant identification gives chi(V)=0, so H0(V)=0 also
implies H1(V)=0. Global sections of (1) therefore give the claimed direct
sum. Moreover H1(V omega)=H0(V omega^-1)^vee=0: multiplication by a nonzero
canonical section injects this H0 into H0(V). Similarly H1(V omega^2)=0.
Riemann--Roch gives dimensions4n and8n respectively.

For eta in H1(omega^-3), Serre duality pairs eta with H0(omega^4).
The determinant of u in H0(V omega) and w in H0(V omega^2) is a section
of omega^4. On the summand w=s v its pairing with eta is

    <eta, s det(u,v)>.

This is alternating in u,v, including characteristic two. These two
alternating forms are exactly the determinant extension pencil in the
new basis; no linear row of that pencil is omitted. In characteristic
five, coefficient Frobenius transport preserves the identity and makes
the eta variables enter through their fifth powers, as in the scalar
library conventions.

## 2. The explicit fixed-curve pencil

Here omega=O(16O), and the rational canonical form theta has divisor16O.
The function f=x^2*y has its sole pole at O, of order16. Thus theta and
f theta have no common zero: the first vanishes only at O and the second
is nonzero there. They form the required canonical pencil.

For V=W(8O), the spaces V omega and V omega^2 are W(24O), W(40O).
The scalar Frobenius realizations are S_U and S_40. Multiplication by
the second canonical section is multiplication by f^5 in these scalar
coordinates. This proves

    S_40=S_U direct-sum f^5 S_U.

One can also see the intersection directly. If U_0+f^5 U_1=0 with
U_i in S_U, the pole80 of f^5 forces pole(U_1)<=32. Such a horizontal
function represents H0(W(8O)), which is zero. The64 resulting sections
are therefore independent and exhaust S_40.

For an exceptional oper with h0(W(8O))=3, the intersection instead has
dimension3. The sum has dimension61, so three further rows are required.
This is why the acyclicity hypothesis in the two-copy formulation is
essential, even though the Q-frame construction below remains valid.

## 3. A frame for both32-dimensional spaces

There is one fixed useful choice of the32 output rows throughout the
acyclic locus. For a nonzero horizontal polynomial with leading pole d,
the leading coefficient of L at pole d+34 is

    9d(d+17)-2=4d(d+2)-2.

It must vanish; its roots modulo five are d=1,2. Every affine monomial
has leading local coefficient1 and a distinct pole order. Therefore a
horizontal polynomial whose monomial coefficients at all orders
36,37,41,42,...,111,112 vanish must have pole at most32. It then belongs
to H0(W(8O)), which is zero on the acyclic locus. Projection to the
indicated32 coefficients is injective, hence an isomorphism by dimension.
These are MONOMIAL coefficients in the saved Q matrix; no identification
with all Laurent coefficients is needed. The high-row set used in the
orbit0011 check is exactly this set, in reverse order.

Let h_1,...,h_32 be the chosen monomials of L64 and U_i=Qh_i. The
invertible minor G=M[J,I] proves they form a basis of S_U. The32 selected
coordinate rows of M are a basis of its row space. Consequently

    B=S^-T M[J,:]^T

has image J_r=Ann ker Q in P48, by `dormant_differential_projection`.
Only S is inverted, and its entries depend solely on the fixed curve.
For arbitrary h in L64 one has

    Res_O((Bb)h theta) = b^T M[J,:]h.

In particular, if U=M[:,I]v, then

    i(Bb)(U)=b^T Gv,
    (Res_O((Bb)h_i theta))_i=G^T b.                       (2)

The32 residue functionals against h_i restrict to an isomorphism on J_r,
because G is invertible. Thus, once N=0 forces R into J_r, its equality
with eta=Bb is equivalent to the32 projected R equations in the statement.
Together with b^T Gv=2, this already gives an exact169-equation system
(136+32+1) for every oper, without an acyclicity assumption.

The equivalence is also scheme-theoretic. The full-tensor implication
R(ker N) subset J_r is a linear implication on the tensor space, so every
linear component of R outside J_r is a constant linear combination of
the N equations. The projected R equations and N therefore generate
the same ideal as the full R equality and N, after the displayed linear
coordinate changes.

## 4. Projecting136 raw N rows to64 fixed residue functionals

Let E_128=P128, paired with L144 by Res_O(Y h theta). This is the usual
perfect principal-part pairing. The scalar horizontal cohomology image
inside E_128 is

    J_128=Ann ker(Q:L144->S_40),     dimension64.            (3)

This is the same statement as the P48 annihilator theorem, twisted by
O(-16O). For completeness, Q:L144->S_40 is onto by twisting the exact
dormant complex. A horizontal rational representative Y annihilates
its kernel: write a rational kernel element as Lg and use the
self-adjointness of L under residues. Dimension and the injective
horizontal cohomology map give equality in (3). The pairing with Qh is
represented by Res_O(Y h theta).

The functions h_i and f^5 h_i lie in L144, and Q(f^5 h_i)=f^5 Qh_i.
Their Q-images form the basis in Section2. Therefore the64 fixed residue
functionals against these functions give an isomorphism J_128->k^64.
For every U in S_U and every eta, the raw class

    N_U eta^[5]=rho128(U eta^5)

belongs to J_128: U eta^5 is a rational horizontal representative.
Consequently its vanishing is equivalent to all64 displayed residues.
The affine part removed by rho128 contributes zero to these residues by
the global residue theorem. Its remaining error has valuation at least
128-144+16=0 and also contributes zero. Thus the unreduced product
U eta^5 can be used in the formulas in the statement.

This is a fixed injective linear comparison on the whole tensor space,
not merely a comparison at admissible points. It proves equality of the
N ideals after the fixed coordinate choices. Combining Sections3--4 with
the compact atlas theorem proves exactness, finiteness and reducedness
of the97-equation system. The normalization recovers the Wronskian and
pole admissibility exactly as in that theorem.

## 5. Alternation and coefficient size in the Q frame

For s=0,1 and eta=Bb, put

    A_s(b)_(j,i)=Res_O(f^(5s) eta^5 h_j Qh_i theta).

The residue adjoint of Q is -Q. Multiplication by any fifth power
commutes with Q, including f^(5s) eta^5. Integration by parts gives

    A_s(b)_(j,i)=-A_s(b)_(i,j).

Since the characteristic is five, the diagonal entries vanish as well.
This proves alternation of every coefficient, without any rank or
admissibility assumption on v,b.

In the ORIGINAL24 oper coefficients, M is affine linear: delta and
delta^3 are fixed, while P delta+3 delta(P) is linear in P. Hence both
U=M[:,I]v and B=S^-T M[J,:]^T are affine linear in P. The raw N and R
operators depend only on the curve and are linear in U and eta^[5].
Their composed coefficients have oper degree at most1+5=6; the projected
R right side and G have degree at most1. This degree assertion is NOT
a bound on their degree in the primitive finite-field separator a9.

The formulas can be stored as compositions of fixed F25 residue maps
with the small affine-linear Q matrices. They require no expansion of
all high-field tensor coefficients, no inverse of G, and no computation
of a horizontal basis of S_40. They do not by themselves control the
coefficient growth of a later polynomial elimination algorithm.

## 6. Explicit pure-b Pfaffian consequences

An alternating32-square matrix A has a Pfaffian adjugate A^# satisfying

    A^# A=Pf(A) I.

Take A=X A_0(b)+Y A_1(b), and put beta=G^T b and c=beta^T v-2. Then
the following is a polynomial identity:

    2 Pf(A)=beta^T A^#(X A_0(b)v+Y A_1(b)v)-Pf(A)c.        (4)

Thus every coefficient of the degree16 binary form Pf(A) belongs to
the normalized atlas ideal. No saturation by a v coordinate is needed.
Since A_s is linear in b^[5], these coefficients have b-degree80 and
are fifth powers over the perfect coefficient field. Taking coefficient
fifth roots gives necessary degree16 polynomials in b. The full atlas
ideal is radical, so these roots also belong to that ideal, as explained
in `rooted_atlas_projection`.

The resulting17 equations need not characterize a common kernel: a
singular alternating matrix pencil can have a kernel that varies with
X:Y. Nor have these17 equations been proved finite or sufficient after
the Frobenius residuals. Known positive-dimensional invalid strata of
the weaker incidence remain a real limitation.

## Evidence and scope

`scripts/acyclic_alternating_atlas.sage` reads the existing first-oper
N tensor and independently changes its64-dimensional target basis to
[S_U,f^5 S_U]. It verifies the direct sum, the invertible basis change,
and every alternating tensor coefficient. Eight exact sample contractions
have stacked rank32; both individual blocks attain rank32. Thus the
Pfaffian conditions are nonzero polynomials for that saved oper. These
sample ranks are not an assertion about every point or about orbit0011.

The1.06-second report is external:
`/Users/julian/Documents/litt3-computation-data/orbit11-structure/first_alternating_verification.json`.
No solver was run. No whole oper, including orbit0011, has been excluded.
The original common-cover problem still requires BOTH actual finite etale
maps from the same smooth projective source and remains unsolved.
