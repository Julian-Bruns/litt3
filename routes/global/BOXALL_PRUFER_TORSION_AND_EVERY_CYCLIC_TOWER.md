# Boxall finite-support torsion, Pruefer directions, and abelian-defect growth

Version2,2026-09-07, consolidated author proof.
Original single-prime translation/Pruefer/simple-ambient results and
their cyclic/base-change consequences: focused PASS
/root/gluing_cohomology_rigidity2026-09-05,
[verdict, scope and qualifications](audits/BOXALL_PRUFER_CYCLIC_TOWER_AUDIT.md).
The finite-prime isolation lemma separately received focused PASS
/root/canonical_trace_algebra2026-09-05.
The full finite-support torsion-coset theorem was already collaborative
AUTHOR work in the two-leg rectangle proof. This record consolidates it;
extending maximal-abelian growth from one prime to finite S below is
NEW AUTHOR-only2026-09-07.
The audited single-Pruefer statement retains its direct proof in Section2.
No whole-record audit or novelty claim is made.

Let k=bar(F_p), A/k abelian, and S a fixed FINITE set of primes≠p.
Write A[S∞] for its geometric torsion with orders supported on S,
not for a Tate module. All points of A(k) are torsion. Nonreduced
subvarieties below are treated through their supports.

## 1. Checked finite-field translation and prime isolation

Choose F_q defining A and the closed subvariety under discussion,
with Frobenius M fixing A[ℓ] for each ℓ∈S and A[4] if2∈S.
On T_ℓA, M−1∈ℓ End(T_ℓA), or4 End(T₂A) at2.

For P∈A[ℓ∞] not fixed by M, let Q=(M−1)P have exact orderℓ^s.
For n=ℓ^r the binomial identity gives

    M^n−1=n(M−1)U,
    U=1+Σ_(j=2)^n (binom(n,j)/n)(M−1)^(j−1) ≡1modℓ.

Indeed v_ℓ(binom(ℓ^r,j)/ℓ^r)≥−v_ℓ(j).
For odd ℓ, (j−1)−v_ℓ(j)≥1; at2 use2(j−1)−v₂(j)≥1.
Thus U is integral invertible and commutes with M. With r=s−1,

    (M^(ℓ^(s−1))−1)P=ℓ^(s−1)UQ ∈ A[ℓ]∖{0}.              (1)

This includes s=1, U=1. No arithmetic invariance of a geometric
Pruefer direction is needed.

For mixed S-primary P=ΣP_ℓ, choose ℓ with(M−1)P_ℓ≠0.
The orbit length of each P_j under M is a j-power, since M lies
in the indicated congruence subgroup. Let a be the PRODUCT of the
other orbit lengths; it is prime toℓ and M^a fixes those components.
Since1+M+⋯+M^(a−1)≡a modℓ is invertible, (M^a−1)P_ℓ has the
same exact orderℓ^s as(M−1)P_ℓ. Apply(1) to M^a:

    (M^(aℓ^(s−1))−1)P=T, 0≠T∈A[ℓ].                      (2)

Thus every non-F_q-rational S-primary point is shifted by some
Frobenius power through ONE of the finite set⋃_(ℓ∈S)(A[ℓ]∖{0}).
In particular P∈D implies P∈D∩(D−T). The translated point need
not belong to any specified subgroup containing P.

## 2. Direct audited Pruefer dichotomy and simple-ambient case

For any geometric subgroup Γ≅Q_ℓ/Z_ℓ, and ANY closed D⊂A,

    either D(k)∩Γ is finite, or Γ⊂D(k).                    (3)

In particular0∉D gives finiteness. Γ need not be Frobenius-stable.
Here is the original direct proof, independent of the broader author
torsion-coset theorem below.

First assume0∉D, reduce to irreducible D and induct on its dimension.
Let H be its full reduced translation stabilizer and π:A→A/H.
It is smooth, possibly disconnected, and
π⁻¹(πD)=D set-theoretically; πD avoids0 and has trivial reduced
stabilizer. Every proper subgroup of Γ is finite. If Γ⊂H then
D∩Γ is empty; otherwise Γ∩H is finite, πΓ is again Pruefer
and π has finite fibers on Γ. If dim πD decreases use induction;
otherwise replace by this quotient, with trivial stabilizer.
Outside the finite set A(F_q), (1) puts every relevant point in
one of finitely many lower-dimensional D∩(D−T), still avoiding0.
Induction proves finiteness. For general D not containing Γ, choose
γ₀∈Γ∖D and translate D by−γ₀ to reduce to that case.

If A is geometrically SIMPLE and D proper, D∩A[S∞] is finite.
For S={ℓ} this is the separately checked simple-ambient variant;
the checked prime-isolation argument gives the finite-S version.
Every proper irreducible D has finite reduced stabilizer. Quotient
by it; the ambient remains simple and fibers are finite. S-primary
points lift through this quotient by taking the S-primary part of
a torsion lift. Now (2) and dimension induction prove finiteness.
Infinitesimal stabilizers cause no issue: all translations used
are nonzero geometric prime-to-p points.

## 3. Full finite-support torsion cosets — author generalization

For EVERY closed D⊂A there are finitely many S-primary t_i and
abelian subvarieties B_i, possibly0, such that

    D(k)∩A[S∞]=⋃_i(t_i+B_i[S∞]),   t_i+B_i⊂D.              (4)

The union may be empty. For S={ℓ} this retains the earlier author
coset theorem; the extension uses(2), not a claim for all primes.

For a reduced subgroup H and quotient π:A→A/H, every S-primary
point lifts: take the S-primary part of any torsion lift.
For an abelian subvariety Bbar downstairs, π⁻¹(Bbar) is smooth;
its identity component B is abelian and its component group finite.
The S-primary points of that inverse image are a finite union
of h_j+B[S∞], one for each S-primary component. Therefore each
torsion coset downstairs lifts to finitely many cosets as in(4),
all geometrically contained in its inverse image. Components whose
orders are not supported on S do not contribute.

Induct on dim D, component by component. Quotient by its full
reduced stabilizer H, so π⁻¹(πD)=D. If dimension decreases use
induction and the preceding lifting argument; otherwise reduce
to trivial reduced stabilizer. Outside finitely many F_q-rational
points, (2) places D∩A[S∞] in finitely many strictly smaller
D∩(D−T). Induction supplies their cosets, and the remaining rational
S-primary points are zero-dimensional cosets. This proves(4),
including nonreduced residual stabilizers on supports.

For nonempty S, each B_i[S∞] is Zariski dense in B_i: its closure
is a subgroup, and a positive-dimensional quotient would have
nonzero ℓ-primary torsion for ℓ∈S, contradicting torsion surjectivity.
Thus b=max_i dim B_i is the dimension of the torsion closure,
independent of the chosen decomposition.

Let e_i be the order of scalar multiplication by p on t_i, and set

    Σ=⋃_i⋃_(j=0)^(e_i−1)([p]^j t_i+B_i[S∞]), R=Σ_i e_i.
    N_n=∏_(ℓ∈S)ℓ^n.

Scalar[p], NOT arithmetic Frobenius, permutes Σ. Each nonempty
coset intersection with A[N_n] is a coset of B_i[N_n], so

    |Σ∩A[N_n]|≤R N_n^(2b).                                (5)

For all sufficiently large n, killing some t_i of maximal dimension,
|D∩A[N_n]|≥N_n^(2b). S=∅ is the separate trivial finite-group case.

## 4. One Frobenius-block argument and exact maximal-abelian growth

Let C/k be smooth projective connected of genus g≥2. On the scalar
twist put A=J(C^(1)), B_C=F_(C/k)*O_C/O_(C^(1)), D=Θ_(B_C).
The [Raynaud/etale character conventions](CYCLIC_TOWER_NEW_ORDINARITY_AND_FIXED_SUPPORT_BOUNDARY.md)
make D a proper effective divisor. For a finite prime-to-p
character subgroup Λ, its ACTUAL connected cover C_Λ/C has

    a(C_Λ)=Σ_(L∈Λ)h⁰(B_C⊗L).                              (6)

In H¹(C_Λ,O), each nontrivial character space has dimension g−1,
the trivial one g. Label a space by L=N_χ^(1), where N_χ is its
line on C. Absolute Frobenius sends L to L^p. Transporting covers
across relative Frobenius only permutes this subgroup by[p].
Tensoring0→O→F_*O→B_C→0 by L identifies the Frobenius kernel
on that source block with H⁰(B_C⊗L), up to scalar twist; both
degree-zero H⁰ terms vanish unless L=O, when their map is an
isomorphism. Hence this statement includes the trivial character.

If a[p]-stable envelope contains all bad characters, Frobenius
has zero kernel on the complementary invariant block and is
bijective there. The WHOLE nilpotent part, not just its first
kernel, lies in the envelope. Its dimension is Δ=g−f.

For maximal exponent-N_n covers C_n/C, degree N_n^(2g), if
D∩A[S∞] is empty all levels are ordinary. Otherwise(4)–(6) give

    N_n^(2b)≤Δ(C_n)≤gR N_n^(2b) for n≫0,   0≤b≤g−1.        (7)

The upper bound uses Σ, each block's dimension≤g; the lower uses
a(C_n)≥|D∩A[N_n]| and Δ≥a. Thus Δ=Θ(N_n^(2b)), with logarithmic
exponent2b. This is an exponent, NOT convergence of the normalized
ratio or an eventual exact polynomial. The bounded b=0 case
stabilizes as an integer by isogeny monotonicity, with ordinary
successive and composite Pryms thereafter.

For a PRESCRIBED cyclic Z_ℓ-tower, its characters form Γ≅Q_ℓ/Z_ℓ.
By the direct audited(3), either D∩Γ is finite, giving eventually
ordinary new Pryms by the same block argument, or Γ⊂D and

    Δ(C_m)≥a(C_m)≥ℓ^m.

For ordinary C,0∉D, so EVERY prescribed tower is eventually
new-ordinary. The bound is not uniform among directions and does
not say every level is ordinary. This old checked consequence is
retained independently of the general finite-support growth formula.

## 5. Finite-rank directions and actual base changes

For a SINGLE ℓ, let Γ≅(Q_ℓ/Z_ℓ)^r⊂A[ℓ∞],1≤r≤2g.
For each coset in(4) meeting Γ choose γ_i in the intersection.
Then Γ∩(t_i+B_i[ℓ∞])=γ_i+H_i, with

    H_i=Γ∩B_i[ℓ∞]≅(Q_ℓ/Z_ℓ)^(s_i)⊕F_i,
    s_i=dim_(Q_ℓ)(U_Γ∩V_ℓB_i), F_i finite.

Smith form of the Z_ℓ matrix Γ→(A/B_i)[ℓ∞] proves this and
|H_i[ℓ^n]|=|F_i|ℓ^(s_i n) for n≫0. Killing γ_i then identifies
the finite intersections with cosets of those groups.
Scalar[p] preserves Γ and its finite orbit enlargement has the
same maximal s=max_i s_i. The proof of(7) gives
Δ(C_(Γ,n))=Θ(ℓ^(sn)); if D∩Γ is empty every level is ordinary.

For Haar-generic rational r-planes U_Γ in V_ℓA, simultaneous
transversality to finitely many V_ℓB_i gives

    dim(U_Γ∩V_ℓB_i)=max(0,r+2dim B_i−2g).

The exceptions are proper Schubert loci of measure zero.
This does NOT assert that any translated coset meets Γ.
Because dim B_i≤g−1, generic ranks1 and2 have bounded defect
for EVERY C. Ordinary C has bounded defect along EVERY rank1
direction by(3). No arithmetic-Frobenius invariance is needed.

For an ACTUAL finite etale Z→C, not necessarily Galois, replace D by

    D_Z={L∈J(C^(1)):h⁰(Z^(1),B_Z⊗L|Z^(1))≠0}.

It may be all of A. The same coset/block proof gives total defect
Θ(N_n^(2b)) in the full fiber products Z×_C C_n, with upper constant
g(Z)R; empty bad set makes all components ordinary. The abelian deck
group is transitive on components. Their number stabilizes, since
k(Z)∩k(C_n) stabilizes inside a fixed finite separable extension.
Thus every compatible connected-component tower has the same exponent
and retains its ACTUAL maps to Z and C_n.

If J(C) is simple and D_Z proper, Section2 gives b=0 and bounded
defect, even without ordinary C. The single-ℓ case and ordinary
new-Prym conclusion here are among the original checked results;
finite S follows from the checked prime-isolation variant.
No-theta examples can make D_Z ALL of A despite ordinary C or
a Hom-zero condition. Such base changes can have unbounded defect.

For a fixed nonordinary simple A₀, m_(A₀)(J(V))·(dim A₀−f(A₀))≤Δ(V).
Bounded defect bounds this multiplicity; exponential TOTAL growth
does not isolate a fixed isogeny type. The geometric constant-variety
identity A₀(k(V))/A₀(k)=Hom(J(V),A₀) has rank
m_(A₀)(J(V))dim_Q End⁰(A₀). Neither a fixed-type unbounded example
nor a universal fixed-type bound in arbitrary etale base changes
is proved here. The [uniform actual-target consequence](FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md)
requires its stated finite bad CHARACTER set, not finite bad cosets.

## 6. Primary provenance and limits

[Boxall's publisher preview](https://doi.org/10.1017/CBO9780511661990.005)
was checked, not the inaccessible full chapter (*Sous-variétés
algébriques…*,1995,pp.69–80). The earlier source is *Autour d'un
problème de Coleman*,CRAS315(1992),1063–1066. The precise theorem
here has its own proof, not a claimed verbatim numbered citation.
[Voloch, p.3](https://www.math.canterbury.ac.nz/~f.voloch/Pdfs/torsion.pdf)
reproduces Boxall's Galois-translation method; Section1 supplies
the needed finite-field version including2.
[Scanlon–Voloch, introduction/Theorem2](https://arxiv.org/pdf/math/9809188)
recover only part of the m-power result; failure of that
difference-group construction does not refute the torsion theorem.

Nearby arithmetic-rank results do not close the fixed-type gap:
[Ellenberg, Theorem4.4/Remark4.6](https://people.math.wisc.edu/~ellenberg/CMECTFF.pdf)
requires non-isotrivial elliptic/large-image data and explicitly
does not apply over finite constants;
[Bandini–Longhi, Theorem1.2](https://www.numdam.org/item/10.5802/aif.2491.pdf)
is also non-isotrivial, with a finite-initial-Selmer condition;
[Ulmer, Theorem3.3/Section3.9](https://arxiv.org/pdf/math/0609716)
uses Jacobi sums in RAMIFIED Fermat towers and bounded-dimensional
positive-p-rank factors. None is a constant-A₀ proper-etale theorem.

S must be fixed finite and avoid p; the union of its finite
exceptional sets over all S need not be finite. Rank-one results
do not make a chosen cyclic tower cofinal in a core tower. Nothing
controls arbitrary nonabelian towers or proves a common-cover exclusion.
