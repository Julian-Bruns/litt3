# Proof: second return global transversality

Canonical statement: [second_return_global_transversality](../../Theorems/cartier_and_spin/second_return_global_transversality.md).
The supplied data and prior hypotheses are recorded in the retained
[inputs](../../../litt3-computation-data/structural_norm_replies_20260924/extracted/return19_global_obstruction/INPUTS.md).
Archive-relative certificate and source filenames below refer to this
[retained evidence directory](../../../litt3-computation-data/structural_norm_replies_20260924/extracted/return19_global_obstruction/).
The new written implications were reviewed locally and the full exact
verifier replay passed on 24 September 2026; see the
[focused integration record](../../Research/audits/STRUCTURAL_NORM_REPLIES_2026_09_24.md).


## 0. Status and scope

**Partial result. The emptiness of the stable strict second-return locus is
not decided.** No geometric return parameter and no invertible return matrix
H are asserted. No exhaustive saturation of the stable invertible incidence
has been performed.

There is, however, a new global restriction, proved over the algebraic
closure rather than by testing rational points:

> Every remaining stable second return is transverse to a distinguished
> rank-two filtration of its second Frobenius pullback. It consequently
> realizes a length-18 elementary modification of the fixed bundle K. The
> modification divisor belongs to an explicitly computed projective
> six-dimensional linear subsystem of |18O|.

The transversality assertion applies to the **whole complement** of the
pure-v P^5, with unrestricted coordinate support and unrestricted residue
extensions. Its proof uses two exact finite-degree module certificates.
It is not another test of an isolated coordinate face.

A second result gives seven explicit relative cofactor polynomials on the
actual quotient incidence. Off the pure-v P^5 their simultaneous vanishing
is **equivalent** to the quotient morphism having generic rank one. Every
such source has a negative line quotient after F^{2*}, and hence has no
positive Frobenius period at all. These are global statements about the
actual morphisms with both lattices retained.

The proofs depend on the supplied geometry recorded in `INPUTS.md`, §2.
Computations newly executed here are identified below and in `claims.json`.
The only supplied special-coordinate exclusion needed for the stable-return
conclusion is the entire pure-v P^5 exclusion.

## 1. Notation and two elementary consequences of the supplied geometry

Write L=O_X(-O), and use O(dO) for the actual divisor line bundle. Put
mathcal E_xi=F^{2*}R_xi. The scalar Laurent polynomial E means e^25; it is
not the bundle mathcal E_xi. Always put z_j=xi_j^25. All matrices with
constant coefficients in this report are over F_25, but all their geometric
parameters range over k=algebraic closure of F_5.

### Lemma 1.1: Every line subbundle of K has degree at most -2

Suppose M is a saturated line subbundle with d=deg M>=-1. Its composition
with K -> O(6O) is nonzero, since a subline contained in O(-5O) has degree
at most -5. Consequently d<=6.

The pullback homomorphism
 Ext^1(K,L) -> Ext^1(M,L)
has nonzero kernel. Indeed, the source has dimension 19. For d>=0,
Riemann--Roch gives h^1(L M^{-1})=9+d<=15, because its degree -1-d is
negative. For d=-1 its degree is zero, so h^1<=9.

Choose a nonzero extension class in this kernel. Splitting its pullback to
M gives an injection M -> R_xi that projects isomorphically onto M in K.
This injection is saturated: its quotient is an extension of K/M by L,
so is locally free. If d>=0 this contradicts the supplied semistability
or the supplied unique maximal line L of R_xi. More explicitly, d>0
contradicts semistability, and d=0 contradicts maximality of the degree -1
line. If d=-1, it gives a second maximal line different from L. This is
again a contradiction. Thus d<=-2.

It follows in particular that Hom(L,K)=0. Also Hom(K,L)=0: a nonzero map
K -> L would have image of degree at most -1 and kernel a line subbundle
of degree at least 2. K is stable, and End(K)=k. For the last statement
one can use the standard stable-bundle argument, or note directly that a
rank-one endomorphism would have image of degree at least 3 as a quotient
and at most -2 as a subbundle; subtracting an eigenvalue from any nonscalar
endomorphism would produce such a map.

### Lemma 1.2: A rank-one actual quotient morphism excludes every period

Let 0!=phi:mathcal E_xi -> K have generic rank one. Its image is a line
bundle I=M(-Z), where M is the saturated image in K and Z is effective.
Lemma 1.1 gives deg I<=-2. Thus mathcal E_xi has a negative-degree line
quotient, and its kernel is a positive-degree rank-two subbundle.

If F^{N*}R_xi were isomorphic to R_xi for any positive N, pull this positive
subbundle back until its Frobenius exponent is a multiple of N. Flatness
of Frobenius on a smooth curve preserves the injection, and degrees are
multiplied by a positive power of five. The result would destabilize the
supplied semistable bundle R_xi. This is impossible.

This argument concerns an **actual nonzero morphism of generic rank one**,
not a numerical rank defect of T alone.

## 2. A fixed positive line inside F^{2*}K

The actual bundle F^{2*}K has rational transition
 (a,b) -> (a-Eb,b)
and infinity orders (125,-150).

A section of F^{2*}K(-8O) therefore has b in L_142,
 a=(Eb)_+,
 [Eb]_-133=0.
There is no free polynomial summand in a: such a summand would belong to
L_-133, which is zero.

The resulting constant matrix has 141 rows and 134 columns and has rank
133. Its one-dimensional kernel supplies a distinguished section
 s_*=(a_*,b_*)=(A_*(x), y B_*(x)).
It is normalized by the coefficient of x^44 y in b_* being one. The exact
ascending rows A_*, B_* are in `data/positive_line.json`; their degrees are
189 and 44. `src/filtration.py` reconstructs them from the actual e, not
from a different extension or its associated graded object.

The executed polynomial and infinity checks are
 gcd(A_*,B_*)=1,
 gcd(A_*,P)=1,
 ord_O(a_*-E b_*)=135,
 ord_O(b_*)=-142.
These prove that s_* is nowhere zero as a section of F^{2*}K(-8O).
At a finite nonbranch point a common zero would contradict the first gcd;
at a cubic branch point it would contradict the second. At O the last
coordinate has exactly its allowed order -142 and leading coefficient one.
The same calculation also checks H^0(F^{2*}K(-9O))=0 in the verifier.

We have therefore constructed an actual exact sequence
 (2.1)  0 -> O(8O) --s_*--> F^{2*}K --psi--> O(17O) -> 0,
where, in rational coordinates,
 psi(a,b)=a_* b-b_* a.
The quotient line follows from det(F^{2*}K)=O(25O).

This line is preserved by the cubic automorphism action on the fixed
bundle. For a cube root zeta, the linearization of K and F^{2*}K is
(a,b) -> (zeta gamma^*a,gamma^*b). It sends s_* to zeta s_*.
We do **not** claim that this line is horizontal for a Cartier connection,
or that it is the Harder--Narasimhan line, or that K is projectively
Frobenius-periodic.

Pulling (2.1) back along mathcal E_xi -> F^{2*}K defines a rank-two subbundle
mathcal B_xi of mathcal E_xi, with exact sequences
 (2.2)  0 -> O(-25O) -> mathcal B_xi -> O(8O) -> 0,
 (2.3)  0 -> mathcal B_xi -> mathcal E_xi -> O(17O) -> 0.
This filtration exists for every xi, without a support or stability
assumption. Its determinant is O(-17O).

## 3. The new dual-line matrix S

Any map L -> mathcal E_xi is a section of mathcal E_xi(O). In rational
coordinates (n,a,b) its infinity conditions are
 ord(n-Ua-Vb)>=24,
 ord(a-Eb)>=124,
 ord(b)>=-151.
Hence
 b in L_151, a=(Eb)_+, [Eb]_-124=0,
 n=(Ua+Vb)_+, [Ua+Vb]_-24=0.
There are no free polynomial terms in a or n because the respective
bounds are negative in L notation.

Let W=H^0(F^{2*}K(O)). The constant matrix
 A_W: L_151 -> the 132 forbidden coefficients [Eb]_-124
has shape 132x143 and rank 132. Thus dim W=11. A basis is the nullspace
basis with free b coordinates
 (47,0),(48,0),(49,0),(50,0),
 (41,1),(42,1),(43,1),(44,1),(45,1),(46,1),(47,1),
where (i,j) means x^i y^j. In particular every b in W has the form
 b=r(x)+y s(x), with no y^2 term.
The character-zero summand has dimension four; the character-one summand
has dimension seven. No character-two summand occurs.

Applying [Ua+Vb]_-24 to this basis gives a matrix
 (3.1)  S(z)=sum_{j=0}^{18} z_j S_j, of size 32x11,
with the exact, functorial identification
 (3.2)  ker S(xi^25) = Hom(L,mathcal E_xi).
All 19 coefficient matrices, A_W, and the W basis are stored in
`data/line_incidence.npz` and in the portable JSON export.

A stable second return necessarily has rank S=10: by the supplied unique
maximal line, Hom(L,R_xi) is one-dimensional. In fact any nonzero section
of R_xi(O) must give that line without zeros; otherwise its saturation
would have degree at least zero.

This rank test is not by itself a return test. Its greater use here is the
fixed-filtration theorem below and its relation to the actual cofactors.

## 4. Global transversality, with exact module certificates

Let the three coordinate groups be
 A={0,6,7},
 B={1,2,3,4,5,8,9,10,11,12},
 C={13,14,15,16,17,18}.
Write P_C for the pure-v P^5 supported on C.

### Theorem 4.1

For every xi outside P_C,
 (4.1)  Hom(L,mathcal B_xi)=H^0(mathcal B_xi(O))=0.

### Proof

By (2.2), a nonzero section in H^0(mathcal B_xi(O)) has nonzero projection
to H^0(O(9O)), since H^0(O(-24O))=0. Write that projection as
 lambda_0+lambda_1 x+lambda_2 x^2+lambda_3 x^3.
Its image in W is s_* times this polynomial. Let C_* be the exact 11x4
matrix of these four sections in the W basis.

The lifting obstruction is S(z) C_* lambda. The 32 rows split into y
characters of sizes 7,11,14. Since a_* has character zero and b_* has
character one, they separate as follows:

- the 11 character-one rows involve only z_A;
- the 14 character-two rows involve only z_B;
- the 7 character-zero rows involve only z_C.

Every other block is zero. These zero identities are checked coefficient
by coefficient by the reconstruction and verifier. Consequently a lift
would imply
 (4.2)  M_A(lambda) z_A=0,  M_B(lambda) z_B=0,
where M_A is an 11x3 matrix and M_B a 14x10 matrix, each linear in the four
lambda coordinates.

Both matrices have full column rank for **every nonzero geometric lambda**.
Here are exact certificates for that assertion. In
 R=F_25[lambda_0,lambda_1,lambda_2,lambda_3], form the cokernels of the
transposes, with linear relations:
 coker(R(-1)^11 -> R^3),
 coker(R(-1)^14 -> R^10).
The degree-two part of the first has coefficient matrix 30x44 of rank 30.
The degree-eight part of the second has coefficient matrix 1650x1680 of
rank 1650. The stored pivot sets select nonzero maximal minors.

For completeness, finite-degree vanishing gives the stated global rank
assertion as follows. If the degree-d part of a module generated in degree
zero vanishes, every lambda_i^d times every generator is a combination of
its relations. At a geometric point with lambda_i!=0, evaluation then
makes the relation columns span the whole target. This works over any
field extension and on every projective chart, including its boundary.
Thus M_A(lambda) and M_B(lambda) have trivial kernels for nonzero lambda.

Equation (4.2) forces z_A=z_B=0. Since z_j=xi_j^25 in a field, it forces
xi_A=xi_B=0, i.e. xi in P_C. This proves the theorem.

**Executed certificates:** `src/macaulay.py`,
`data/filtration_matrices.npz`, `data/macaulay_A.npz`,
`data/macaulay_B.npz`, and `logs/macaulay.log`. These are coefficient-module
rank computations, not evaluations at finitely many lambda or xi points.

The theorem is a global restriction on the position of the distinguished
line in a fixed filtration. It does not assert that every point outside
P_C is excluded from the return locus.

## 5. The seven-dimensional degree-18 linear system

Twisting (2.1) by O(O) and taking sections gives
 0 -> H^0(O(9O)) -> W --J--> H^0(O(18O)).
Here dim H^0(O(9O))=4, dim W=11, and the image of J has dimension seven.
On a section (a,b), J is the actual determinant a_*b-b_*a.

Use the L_18 basis
 (1,x,x^2,x^3,x^4,x^5,x^6,y,xy,x^2y).
The image V_18 is
 (5.1) span{v_0,v_1,v_2,v_3,y,xy,x^2y},
where all bracketed constants below are F_25 codes:
 v_0=1+[17]x^4+[2]x^5+x^6,
 v_1=x+[22]x^4+[21]x^5+[22]x^6,
 v_2=x^2+[13]x^4+[18]x^5+[23]x^6,
 v_3=x^3+[16]x^4+x^5+[15]x^6.

Equivalently, if the polynomial part is sum_{i=0}^6 d_i x^i, it satisfies
 [13]d_0+[8]d_1+[17]d_2+[14]d_3+d_4=0,
 [3]d_0+[9]d_1+[12]d_2+[4]d_3+d_5=0,
 [4]d_0+[8]d_1+[7]d_2+[10]d_3+d_6=0.
The three y coefficients are unrestricted within this vector space.
They and the d_i range over k, not just F_25.

`src/modification_model.py` checks all determinant cancellations exactly:
the high-degree polynomials reduce to L_18, the map J has rank seven, its
kernel is the four-dimensional image of s_* H^0(O(9O)), and its image is
precisely (5.1).

### Theorem 5.2: Necessary modification model for every stable return

For any stable strict second return, there exists a nonzero
 delta in V_18 and an effective divisor
 D_delta=div(delta)+18O of degree 18 such that
 (5.2)  0 -> O(-25O) -> mathcal B_xi -> O(8O) -> 0,
 (5.3)  0 -> mathcal B_xi -> K -> O_{D_delta}(17O) -> 0.
In particular D_delta belongs to the fixed P(V_18)=P^6 inside |18O|.

### Proof

Let H:mathcal E_xi -> R_xi be an isomorphism, and let phi be its composition
with R_xi -> K. It is an actual surjection with kernel isomorphic to L.
Let w:L -> mathcal E_xi be its nowhere-zero kernel inclusion.
A stable return lies outside P_C by the supplied pure-v exclusion.
Theorem 4.1 therefore says that the composition
 L --w--> mathcal E_xi -> O(17O)
is nonzero. It is a section delta of O(18O), and its projection through
F^{2*}K puts it in V_18.

The kernel of mathcal E_xi -> O(17O) is mathcal B_xi. Since its intersection
with w(L) is zero as a sheaf, phi restricts to an injection
mathcal B_xi -> K. The cokernel is
 O(17O) / delta L = O_{D_delta}(17O).
This proves (5.2)--(5.3).

The divisor is allowed to be nonreduced and to contain O or branch points.
No squarefreeness or affine-chart assumption has been introduced. Theorem
5.2 is **necessary**, not sufficient: arbitrary modifications (5.2)--(5.3)
are not claimed to come from the required Frobenius fixed point.

## 6. Actual cofactors: a global relation between quotient and line tests

Let phi be an actual map reconstructed from a nonzero m in ker T(z):
 phi=[[a,q,r],[f,g,h]].
Its cofactor column is
 (6.1) w_phi=(q h-r g, r f-a h, a g-q f)^t.
Exterior powers give w_phi in H^0(mathcal E_xi(O)), because det mathcal E_xi
is trivial and det K=O(O). This can also be checked directly: under the
unipotent rational transitions, the cofactor transforms by G_xi^{(25)}.
Its infinity orders as a section are exactly (24,124,-151).

Write beta=(beta_0,...,beta_10) for the W coordinates of the lower pair
(r f-a h,a g-q f). They are just the eleven free b coefficients listed
in §3. We obtain the global relations, on the **actual** quotient incidence,
 (6.2) S(z) beta=0,
 (6.3) phi w_phi=0.
Moreover,
 (6.4) beta!=0 if and only if phi has generic rank two.
Indeed the cofactor of a 2x3 matrix is nonzero exactly in generic rank two.
If beta=0, its lower pair is zero by the W reconstruction; its first
coordinate would then be a section of O(-24O), so is zero as well.

### Exact polynomial tensor for beta

Let p=a-ef, and use the supplied actual recovery g_0,q_0. The identity
 a g-q f = p (Uf)_- + p g_0 + f(eg-Up)_- - f q_0
holds before imposing residual equations. The first and third terms have
pole weight at most 37 and 48, respectively: p has weight at most 20,
f at most 31, and a negative-x Laurent polynomial has weight at most 17.
The eleven free b monomials have weights at least 133. Their coefficients
are consequently exactly those of p g_0-f q_0.

Recovery makes g_0,q_0 bilinear in (z,m), while p,f are linear in m.
Thus
 (6.5) beta_l=sum_{j,a,b} B[l,j,a,b] z_j m_a m_b.
The unsymmetrized tensor B has shape (11,19,35,35). Both off-diagonal
orders a,b are included in this sum; no implicit factor 1/2 is used.
It is supplied in `data/cofactors.npz`, with the full recovery tensor.
The verifier independently reconstructs its coefficients using monomial
Laurent multiplication and matrix contraction, not evaluations at points.

Project J beta to the four leading polynomial coordinates and the three
y coordinates. This gives seven explicit polynomials
 (6.6) d_l=sum_{j,a,b} D[l,j,a,b] z_j m_a m_b,
with tensor shape (7,19,35,35), stored in `data/global_coupling.npz`.
On the actual incidence they are the coefficients of
 (6.7) delta_phi=a_*(a g-q f)-b_*(r f-a h)
in the basis (5.1). This is also the determinant of the 3x3 matrix with
rows phi and (0,-b_*,a_*). Outside the actual incidence, (6.6) remains a
well-defined polynomial tensor, but no sheaf/cofactor interpretation is
claimed without the residual equations.

### Theorem 6.1: Exhaustive rank-one stratum off the pure-v plane

For xi outside P_C and nonzero actual phi,
 (6.8) d_0=...=d_6=0 if and only if generic rank(phi)=1.
Every point of this locus has no positive Frobenius period.

If the seven coordinates vanish, w_phi is a section of mathcal B_xi(O).
Theorem 4.1 makes it zero, so phi has rank one. The converse follows from
its zero cofactor. Lemma 1.2 gives the period exclusion. Over P_C every
nonzero quotient already belongs to the supplied rank-drop locus with a
negative line quotient. Thus the union of that entire closed stratum and
the seven-polynomial-zero stratum off it is excluded globally.

This settles a globally defined part of the actual quotient incidence; no
claim that an irreducible decomposition of the whole incidence has been
computed is made.

## 7. Surjectivity, Q, liftability, and invertibility are still distinct

For an actual generic-rank-two phi, let Z_phi be the common zero divisor
of its cofactor section w_phi. A local Smith normal form over each DVR
shows that
 length(coker phi)=deg Z_phi,
 ker phi=O(Z_phi-O),
and phi is surjective precisely when Z_phi=0. The finite common zeros and
the infinity fiber must both be checked. At O the relevant regular fiber
coordinates of w_phi are
 t^-24(w_1-Uw_2-Vw_3),
 t^-124(w_2-Ew_3),
 t^151 w_3.
A nonzero delta_phi alone does not ensure these do not vanish together.

Off P_C, delta_phi is nonzero for every actual generic-rank-two map.
It gives an injection mathcal B_xi -> K with torsion cokernel of length 18.
Without surjectivity of phi, that cokernel need not be the cyclic sheaf
O_{D_delta}(17O) of Theorem 5.2. Also Z_phi is contained in D_delta, so
one obtains the additional bound deg Z_phi<=18 in this region.

When phi is surjective, its kernel cofactor identifies an exact extension
 (7.1) 0 -> L -> mathcal E_xi -> K -> 0,
with class eta in Ext^1(K,L), well defined up to the relevant scalar
identifications. Since Hom(K,L)=0, applying Hom(-,L) yields
 0 -> Hom(mathcal E_xi,L) -> k --(1 maps to eta)--> Ext^1(K,L).
Therefore on the surjective quotient locus,
 (7.2) ker Q=0 exactly when eta!=0;
 if eta=0, ker Q has dimension one and the source splits as L direct-sum K.
For a nonsplit source the supplied geometry makes it R_eta, with
 dim ker T=dim ker S=1 and ker Q=0.

More generally there is a scalar pairing
 Hom(mathcal E_xi,L) x Hom(L,mathcal E_xi) -> k
by composition. Evaluated on w_phi, it is identically zero if Z_phi>0.
If Z_phi=0 it detects the split extension as in (7.2). Thus full rank of Q
by itself neither proves surjectivity nor replaces the fixed-point test.

Finally, in the nonsplit surjective situation the return question is
 (7.3) [eta]=[xi], with xi outside Sigma.
Equivalently one must solve the actual top-lift equations. Once the source
is known to be a nonzero R_eta and the target R_xi is stable, a nonzero lift
is automatically invertible: a lower-rank image would have degree at least
zero as a quotient of a semistable source and negative degree as a proper
subsheaf of the stable target. A full-rank map has nonzero constant
 determinant. This conditional simplification does **not** apply to a
nonzero map from an unverified, possibly unstable source.

No step establishing (7.3) globally, or excluding it globally, has been
completed here.

## 8. Computations actually executed and independent verification

The following are new executed calculations, not supplied facts:

1. Reconstruction of the full coefficient tensors T and Q, including
   constant matrix ranks 235 and 116 and their actual recovery maps.
2. The 132x143 section matrix A_W has rank 132, giving W and S of size 32x11.
3. The normalized nowhere-zero s_* in H^0(F^{2*}K(-8O)), both polynomial
   gcd checks, its infinity check, and the four-dimensional s_* L_9 inclusion.
4. All character zero blocks used in Theorem 4.1.
5. Module ranks: A in degree 2 is 30/30; B in degree 7 is 1176/1200;
   B in degree 8 is 1650/1650. Degree 7 is recorded only as a diagnostic;
   it is degree 8 that proves the global B assertion.
6. The rank-seven image J and its explicit subsystem V_18.
7. The full recovery and cofactor tensors, and their seven-coordinate
   projection, with coefficientwise verification.
8. The exploratory projective-period calculation described below.

`python src/verify.py` verifies the hash manifest when present, checks exact
arithmetic and the certificates, regenerates the core data in a temporary
copy, and compares the arrays. It does not overwrite the archived evidence.
The final verification log records the checks that actually ran.

Every stored NPZ array is also exported, with shape and dtype, to
`data/portable_arrays.json`. All entries are integer F_25 codes except
indices/degrees/pivots. The archive requires no source attachments, computer
algebra server, finite-field point database, or external array.

## 9. Failed or incomplete approaches

### Projective second periodicity of K

One possible construction would have required F^{2*}K isomorphic to
K(12O), since both have degree 25. This avenue fails for the actual e.
For a map F^{2*}K -> K(12O), choose c in L_143 and alpha in L_132, set
 a=(ec)_+ +alpha, p=a-ec,
 d=-(Ec)_+,
 b=-(-ed+Ep)_+,
and require [Ec]_-132=[-ed+Ep]_-143=0. The exact matrix has shape 291x259
and trivial kernel. Thus even Hom(F^{2*}K,K(12O)) is zero. The source and
execution log are included. This does not obstruct rank-three returns in
general, and it is not used in Theorems 4.1, 5.2, or 6.1.

### What was not done

There was no finite-field search for return points, no Gröbner-basis
saturation of the full 123x51 lift system, no enumeration of geometric
components of its stable invertible open subset, and no candidate stability
calculation on Sigma. No unexecuted generator is presented as a completed
certificate. The supplied coordinate-face exclusions and supplied finiteness
and reducedness are hypotheses here, not newly checked results.

## 10. Exact remaining problem

After the supplied pure-C exclusion and Theorem 6.1, one must analyze the
actual quotient incidence T(xi^25)m=0 where the seven relative cofactor
coordinates are nonzero. A valid return must additionally have a nowhere-zero
cofactor section (surjective quotient), nonzero induced extension class eta,
[eta]=[xi], and xi outside Sigma. Equivalently it must satisfy the supplied
full lift equations with det H!=0 and the supplied stability test.

Theorem 5.2 forces every such point into the fixed degree-18 modification
model with D in P(V_18). Whether any modification in that model satisfies
all the Frobenius, fixed-extension, invertibility, and stability conditions
is the unresolved step. The new restrictions do not determine the
cardinality of the finite stable return locus.

