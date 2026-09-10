# Proof: characteristic-five base points and the actual active bundles

[Statement](../Theorems/Thm_genus_two_active_theta.md).
Pro answer2026-09-10, expanded locally by /root. Focused medium audit
PASS /root/audit_genus_two_active_theta, no blocking objections.
[Audit record](../Research/audits/GENUS_TWO_ACTIVE_THETA_AUDIT_2026_09_10.md).

The characteristic-zero classification is used ONLY after constructing
a lift of the hypothetical base point that REMAINS a base point. It
is not silently imported into characteristic5. No assertion about
flatness, cardinality or reducedness of the moduli base-point locus
is needed. The argument works with underlying bundles, not lifts of
opers or either leg of a correspondence.

## 1. Evaluation reconstruction in characteristic5

Write K=omega_C and T=B^dual K. Stability gives H0(B)=0, so H1(T)=0
and h0(T)=4. No-theta and Serre duality imply h0(T(-x))>0 for every
x, hence evaluation of T has rank at most3. Its image I is globally
generated, locally free, and h0(I)=4.

Elementary fact: if a globally generated rank-s bundle H has H0(H^dual)=0,
then h0(det H)>=s+1. Choose s+1 generating sections: such a general
choice generates on a curve because the bad locus has codimension2.
The dual evaluation sequence injects k^(s+1) into H0(det H).

A globally generated line subsheaf of T has degree<=1 by stability;
it must therefore be trivial. A globally generated rank2 subsheaf S
has degree<=3. If H0(S^dual)=0, the elementary fact forces h0(det S)>=3,
hence degree>=4 in genus2, impossible. Otherwise a nonzero map S->O
is surjective: compositions with the generating sections are constants,
one of them nonzero. That section splits it; its complementary line is
globally generated and a subsheaf of T, hence trivial. Thus h0(S)<=2.
This excludes rank(I)<=2. A nonzero I->O would similarly leave a
globally generated rank2 subsheaf with three sections. Hence rank I=3
and H0(I^dual)=0.

Put M=det I. Dual evaluation gives h0(M)>=4, so deg M>=5. Stability
of T, of slope2, gives deg I<=5; thus deg M=5 and I is saturated in T.
Define G_M by the COMPLETE degree-five evaluation sequence

    0 -> G_M^dual -> H0(M) tensor O -> M -> 0.

The same sequence for I identifies I=G_M. Consequently

    0 -> G_M -> T -> K^4 M^-1 -> 0.                       (1)

G_M is stable in characteristic5: every locally free quotient Q is
globally generated and H0(Q^dual)=0. The elementary fact bounds a
rank1 quotient's degree by>=2 and a rank2 quotient's degree by>=4.
Thus line subbundles have degree<=1 and rank2 subbundles degree<=3,
both below slope5/3. The extension in(1) is nonzero since a split
quotient of degree3 would contradict stability of T.

Let A_M=G_M^dual K^5 M^-1. It is stable, rank3, degree10. Riemann--Roch
and stability give h0(A_M)=7 and h0(A_M(-x))=4. For general x,y the
pencil calculation below gives h0(A_M(-x-y))=1; denote that line in
H0(A_M) by ell_(x,y). The extension class e is a nonzero functional on
H0(A_M). Tensoring(1) by K^-4 M(x+y) shows

    e(ell_(x,y))=0                                      (2)

for general x,y. Indeed the quotient is O(x+y), with one section;
the subbundle has h0=0,h1=1, dual to that displayed line. No-theta
forces its connecting map to vanish.

## 2. Why M^2=K^5, including the degeneracy multiplicities

Suppose M^2!=K^5. Choose general x and write

    K^4 M^-1(-x)=O(p+q), N=K^5 M^-1(-x)=K(p+q),
    A_x=A_M(-x).

The two residual points are distinct and not hyperelliptic conjugates.
Evaluation gives

    H0(A_x(-y)) = ker[H0(M) tensor H0(N(-y)) -> H0(MN(-y))].

The degree3 pencil N(-y) has a base point exactly when y=p or q. Its
kernel then has dimension h0(MK^-1)=2. Otherwise the pencil trick gives
H0(M^2 K^-5(x+y)), of degree2 and dimension1 unless O(x+y)=K^6 M^-2.
Under the supposition this last degree2 line is not K, so its unique
effective divisor (if any) is fixed. General x avoids it. Thus A_x,
rank3 degree7 with four sections, drops evaluation rank by one exactly
at p and q.

Here is the scheme-theoretic simplicity check, avoiding an inference
from set-theoretic rank drops. Choose a,b a basis of H0(K), let s vanish
on p+q, and complete sa,sb to a basis sa,sb,t of H0(N). In the inclusion
A_x -> H0(M) tensor N, its evaluated image at p, after trivializing N,
is H0(M(-p-q)). A multiplication relation has t-coefficient vanishing
at p,q, and every such coefficient occurs because multiplication
H0(M) tensor H0(K)->H0(MK) is surjective. The latter follows directly
from the canonical pencil trick: dimensions8-2=6.

Choose c in H0(MK^-1) nonzero at q. The multiplication relation
(bc) tensor(sa)-(ac) tensor(sb) defines a section of A_x vanishing at p.
Its first coefficient at p is, up to a nonzero scalar,
a(p)bc-b(p)ac. Its value at q is nonzero because p,q are not conjugates
and c(q)!=0. Thus this coefficient is outside H0(M(-p-q)). A maximal
minor has a simple zero at p. The same argument at q gives a simple
zero there. The choice of c is legitimate for general x: the only
exception would be a base point z of MK^-1, meaning M=K^2(z). Then
p+q=iota(z)+iota(x); M^2!=K^5 implies z is not Weierstrass, so the pair
avoids z for general x. Distinctness and the other generic conditions
exclude only proper loci; no characteristic-zero generic smoothness
assertion is used.

The image J_x of evaluation of A_x therefore has degree5. It has no
map to O: such a map would split and leave a rank2 degree5 subsheaf
of the stable A_x of slope7/3. Dual evaluation then identifies the
kernel-line map y->ell_(x,y) with the complete degree5 series of det J_x.
It spans PH0(A_x). For two general x,x', these four-dimensional spaces
intersect in the one-dimensional H0(A_M(-x-x')), hence span all seven
dimensions of H0(A_M). This contradicts the nonzero annihilator(2).
Thus M^2=K^5.

Write M=K^2 rho, rho^2=K, and W=H0(M). Now

    H0(A_M)=ker[W tensor W -> H0(M^2)]

has dimension7, and contains wedge^2 W of dimension6. For general
x,y, the pencil trick identifies ell_(x,y)=wedge^2 H0(M(-x-y)).
These lines span wedge^2 W: use four general points with independent
evaluations and the six complementary pairs. Hence e is precisely
the unique projective annihilator of wedge^2 W.

This is the algebraic reconstruction in
[Pauly, Section2.1, Propositions2.1--2.4](https://arxiv.org/pdf/0804.3001),
with stability and the simple-rank-drop step supplied above in char5.
Pauly's paper states its global classification for COMPLEX curves.

## 3. A lift that retains the no-theta condition

Lift the genus2 curve to a complete mixed-characteristic DVR by its
six distinct hyperelliptic branch points. Lift rho through the finite
etale square-root torsor in the relative Picard scheme. Form the
relative M=K^2 rho and evaluation bundle G_M.

The relevant H0 modules have ranks4 and7 on both fibers and commute
with base change: the H1 vanishings follow from the above stability
and degree argument on each fiber. The exterior-square inclusion has
rank6 and locally free quotient: it is a direct summand of W tensor W
when2 is invertible. Its annihilator in the relative extension space
is a free line. A generator gives a relative extension lifting(1),
and therefore a lift of B.

The generic fiber is stable by openness. It REMAINS without theta:
the same wedge annihilator gives sections for general degree1 twists,
and the proper semicontinuous theta locus therefore contains all twists.
We may now apply Pauly's characteristic-zero Raynaud classification
to this generic fiber, after choosing a finitely generated field of
definition and embedding it in C. This use does not assume that an
arbitrary special-fiber base point lifts inside its base-point locus.

## 4. Specialization of the actual Raynaud model

The Raynaud construction is defined over the DVR with2 invertible.
On the relative Jacobian J, the bundle O_J(2Theta) tensor H0(2Theta)^dual
has a J[2]-linearization: theta-group central scalars cancel. It descends
along[2] to a rank4 bundle P satisfying

    [2]^*P = O_J(2Theta) tensor O^4.

After finite DVR extension the generic theta-characteristic label
extends. Restricting along its Abel map and twisting by that inverse
theta characteristic gives a relative normalized Raynaud bundle R
with generic fiber isomorphic to the lifted B. On EVERY fiber a finite
etale cover makes R a sum of four equal degree-zero lines. In particular
R_k is semistable. See Pauly Section2.2 for this algebraic construction.

Scale a generic isomorphism R_eta->B_eta by a uniformizer power until
it extends primitively; properness gives a finite module of morphisms.
Its special fiber is nonzero. Its image cannot have rank<4: as a quotient
of semistable degree0 R_k it has nonnegative degree, but as a proper
subsheaf of stable degree0 B it has negative degree. Full rank and equal
degrees then give an isomorphism. Thus B=R_k and has the asserted etale
splitting. Frobenius pullbacks have the same splitting after etale
base change, so are all semistable.

## 5. Application to actual active tangent bundles

For connected canonical double, E_r is stable rank4 and det E_r=omega^2.
The determinant statement follows from the jet transition with its
trace-zero connection and Cartier descent: det V_d=omega, followed by
the etale-double determinant/norm formula. Equivalently the wedge
pairing on V_d followed by trace gives E_r a nondegenerate omega-valued
alternating pairing. Choose a theta characteristic eta and set
B=E_r eta^-1; its determinant is trivial.

If E_r had no proper theta divisor, Part1 makes it strongly semistable.
But after pulling F^*E_r to the canonical double one obtains the direct
sum of two copies of J1(omega^2), each with subline omega^3 and quotient
omega^2. This is unstable. Semistability is preserved by finite etale
pullback, so it contradicts strong semistability of E_r.

For the split double E_r is the sum of the two stable rank2 dormant
tangent bundles. Each has a proper theta divisor by the characteristic-
independent rank2 theorem already used in tangent_bundle_cyclic_refinements.
Their sum is a proper theta divisor for E_r. No ordinariness assumption
enters either argument.

## 6. Multiplicity at most four and at least two cyclic5 covers

Now assume J(C) ordinary, the double connected, h0(E_r)=1. The
nonzero2-torsion kappa of the double satisfies E_r tensor kappa=E_r,
so translation by kappa preserves its theta DIVISOR, including scheme
multiplicities. Its omega-valued symplectic pairing makes its theta
section even in |4Theta| under normalized inversion.

For the parity identity in char5 one may lift the UNDERLYING symplectic
bundle and theta characteristic: the Sp4 torsor has coherent H2=0,
and properness supplies an acyclic twist that also lifts. Formal GAGA
algebraizes, and the characteristic-zero evenness identity specializes
with the normalized determinant-line involution. Its sign cannot
change with2 invertible. This is not a connection or correspondence lift.
The characteristic-zero identity is in
[Hitching, Section1](https://arxiv.org/pdf/math/0604637); algebraic
even4Theta conventions in characteristic!=2 are in
[Kopeliovich--Pauly--Serman, Sections1--2](https://math.univ-cotedazur.fr/~pauly/theta.pdf).

Let B_2 be the reduced image[2](Theta) of a symmetric Abel theta curve.
Its normalization is C: otherwise a nonzero2-torsion translate would
stabilize Theta, giving a fixed-point-free involution on a genus2 curve,
impossible by etale Hurwitz. Its numerical class is4Theta. The six
odd theta characteristics give six distinct smooth branches at0,
so mult_0(B_2)>=6.

If mult_0(D_r)>=5, evenness gives>=6. Unless D_r contains B_2, their
intersection at0 is>=36, exceeding D_r.B_2=32. Containment and their
equal ample numerical classes force D_r=B_2. But translation by the
nonzero kappa would then act freely on its genus2 normalization, again
impossible. Therefore mult_0(D_r)<=4, also for reducible/nonreduced D_r.

The connected kernel of Frobenius on the ordinary Jacobian is mu5^2.
Its six subgroup schemes mu5 correspond by Cartier duality to the six
actual connected cyclic5 covers. Their tangent lines are P1(F5) in a
suitable basis. A nonzero homogeneous initial theta term of degree m<=4
vanishes on at most m of these six lines. Hence at least two restrictions
to mu5 are nonzero in k[e]/(e^5).

Since h0(E_r)=h1(E_r)=1, the minimal local two-term determinant complex
has a single entry f. On a character subgroup H=mu5 its kernel/cokernel
dimensions are length(k[e]/(e^5,f))<5. Pushing the Poincare character
line family over H gives the actual torsor's regular representation
bundle h_*O_T; projection formula identifies this dimension with
h0(T,h^*E_r). The natural Frobenius transport of the cover identifies
it with h0(E_(h*r)). The audited p-group theorem now proves the stated
obstruction removal. No k-point test of the nonreduced character group
and no simultaneous two-leg lift is substituted for this calculation.

## Scope

The properness assertion upgrades all genus2 active instances of the
existing good cyclic-refinement theorem, including nonordinary ones.
The degree5 conclusion is a one-source removal mechanism, not indigenous
ordinariness and not map-compatible repair. The full common-cover
problem remains unsolved.
