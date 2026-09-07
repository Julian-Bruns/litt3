# Non-Galois Jacobian orthogonality and stabilization of actual etale maps

Author/root,2026-09-05; proof compressed2026-09-07, scope unchanged.
Whole-Jacobian descent PASS /root/gluing_cohomology_rigidity2026-09-05;
one-factor non-Galois extension and graph application PASS
/root/x_elliptic_quotient_maps2026-09-05; prior Galois versions also
had focused checks.
[Scoped audit, auditors and qualifications](audits/NONGALOIS_JACOBIAN_STABILIZATION_AUDIT.md).
No novelty or common-cover resolution is claimed.

## 1. Three exact statements

Work over algebraically closed k with smooth projective connected curves,
all Jacobian factors geometric. Hyperbolic means genus≥2. For an ACTUAL
span V←q W→r X, q finite etale, put
P_q=(ker(q_*:J(W)→J(V)))_red^0 and Hom⁰=Hom⊗Q.

**A. Whole-Jacobian descent.** If X is hyperbolic and
Hom(P_q,J(X))=0, EVERY morphism r:W→X descends uniquely through q.
If r is finite etale, its descended map is finite etale. No Galois
hypothesis, or separability of an arbitrary r, is required.

**B. One-factor bounded descent.** Fix hyperbolic X and a simple
isogeny factor A of J(X). There is M=M(X,A)>0 such that if BOTH
q,r are finite etale and Hom(P_q,A)=0, the normalization C of the
joint image in V×X has actual etale maps to V,X and deg(C/V)≤M.
M is independent of V,W and both degrees; no Galoisness is required.

**C. Tower stabilization.** In any nested connected etale tower W_n/B
over fixed hyperbolic B, if m_A(J(W_n)) is bounded for one simple
factor A of J(X), all sufficiently late etale maps to fixed X descend
to ONE finite level. Up to tower pullback, only finitely many actual
maps occur, not merely finitely many abstract source curves.

## 2. Norm on the actual fiber-product relation

Poincare reducibility and q_*q^*=[deg q] give J(W)∼J(V)×P_q.
Hence Hom(P_q,A)=0 makes composition with q_* an isomorphism

    Hom⁰(J(V),A) ≅ Hom⁰(J(W),A).

For any a:X→A and w₀∈W, clearing denominators in this isomorphism
and applying the Albanese property gives an ACTUAL homomorphism ψ
and n>0 such that

    [n](ar(w)−ar(w₀))=ψ([q(w)−q(w₀)]).                    (1)

Each connected component E_j of W×_V W is smooth projective, and
its two projections to W are surjective finite etale. Thus

    ar pr₁−ar pr₂:E_j→A[n]

is constant, say c_j. Indeed A[n] is finite affine and H⁰(E_j,O)=k;
p|n causes no problem and no division on points is used.
For nonconstant r both r pr_i are surjective, so c_j translates
the reduced image a(X) onto itself.

## 3. Abel curves have no geometric translation stabilizer: proof of A

For an Abel embedding i:X→J(X), its translation stabilizer K injects
into finite Aut(X) and acts freely on X. Each element induces the
identity on J(X): translation changes only the Abel basepoint constant.
The actual etale quotient π:X→X/K therefore satisfies

    π^*π_*=Σ_(h∈K)h_*=[|K|].

Multiplication by |K| is surjective even if p divides it, so
g(X/K)≥g(X). Etale Riemann–Hurwitz gives
g(X)−1=|K|(g(X/K)−1); since g(X)≥2, K=1.

Constant r descends. Otherwise use A=J(X),a=i in(1): every c_j=0,
so r pr₁=r pr₂ on the ACTUAL W×_V W. Faithfully flat descent gives
the unique map V→X. If r was finite etale, the factor is finite
separable and etale by the intermediate-cover/ramification argument.
This also proves the arbitrary, possibly inseparable, morphism version
when no etaleness conclusion is requested.

## 4. The finite translation set for a single factor

Choose J(X)→A and its nonconstant Abel image D=a(X), generating A;
let d be the separable degree of X→normalization(D).

If dim A≥2, the geometric stabilizer K_D of D is finite: a
positive-dimensional connected stabilizer would make D a translate
of an elliptic subvariety, contradicting simplicity (or just that D
generates A). Thus all c_j∈K_D and one may take M=|K_D|d.

If A is elliptic, choose a SEPARABLE map a:X→A′ with A′ isogenous
to A, then rename A′. Factor an initial map through its maximal
relative Frobenius on X and inverse-twist the separable factor;
elliptic Frobenius twists are isogenous.
[Stacks Proposition53.13.7](https://stacks.math.columbia.edu/tag/0CD2)
gives the factorization. Orthogonality and multiplicities are unchanged.

Its branch-value set S_a is finite NONEMPTY, since its different has
degree2g(X)−2>0. Both r pr_i are etale, so the different identity in
a tower makes both composite branch-value sets exactly S_a, including
wild ramification of a. Therefore S_a+c_j=S_a. The translation
stabilizer K_(S_a) has size≤|S_a|, by its free action on one point.
Take M=|K_(S_a)|deg a. Arbitrarily ramified r would add branch values
and invalidate this fixed bound; etaleness is substantive here.

## 5. Count the actual joint image: proof of B

For a geometric generic v of V and w₀∈q⁻¹(v), every other w
satisfies a(r(w))=a(r(w₀))+c_j for some fiber-product component.
There are at most |K_D| or |K_(S_a)| possible translated values,
and at most d or deg a geometric points over each. They are generic
values when realized; purely inseparable degree adds no points.
Thus at most M distinct r(w) occur.

The joint-image field is k(C)=k(V)r^*k(X)⊂k(W), a separable
intermediate over k(V). Its degree counts exactly these restrictions
of generic fiber embeddings, so deg(C/V)≤M. Both C/V and C/X
are intermediate covers of the original ACTUAL etale legs and
are therefore etale. No deck group on q or r was introduced.

## 6. Finite embedded fields and maps: proof of C

Norm makes m_A(J(W_n)) nondecreasing. If bounded it is constant
for n≥N, so Hom(P_(W_n/W_N),A)=0. Apply B to every actual map
W_n→X in E∞=⋃k(W_n). There are finitely many connected etale covers
C/W_N of degree≤M, by finite generation of proper π₁. Each has
at most its degree many embeddings over k(W_N) into E∞.

For each such actual embedded C there are finitely many etale maps
to X: their degree is(g(C)−1)/(g(X)−1), there are finitely many
covers of X of that degree, and Aut(C) is finite. Hence only
finitely many image embeddings k(X)→E∞ occur. One finite level
contains all their images; every later map descends there and stays
etale by intermediate-cover descent. Earlier levels add finitely
many maps. This proves C.

## 7. Ordinary new parts: uniformity in the target

If P_q is ordinary and J(X) has NO ordinary simple factor, A applies
to every morphism W→X. If a tower has ordinary Pryms from level N
onward, isogeny additivity makes every composite Prym over W_N ordinary.
Thus the SAME level receives all etale maps to ALL such targets.

A fixed hyperbolic V has only finitely many hyperbolic etale quotient
curves, even allowing the target to vary. For V→X, d≤g(V)−1.
Its one-leg Galois closure U/X has U/V etale of degree≤(d−1)!.
There are finitely many such covers of V; finite Aut(U) has finitely
many subgroups and hence quotients. Earlier tower targets pull up
to W_N, proving uniform finite-target scope.

## 8. Coreless spans force EVERY endpoint factor to grow

For an ACTUAL coreless bi-etale X←Z→Y, choose an X vertex in its
connected two-colored generic graph. Its nested closed-ball fields
are finite Galois extensions of that distinguished field and exhaust
the graph field:
[Krishnamoorthy, Lemma5.4/Corollaries5.5,5.8/Proposition5.10](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).
All finite-level curve maps to X are etale, constructed from finite
etale fiber products and one-leg closures, not a presumed finite
simultaneous closure of the entire span.

Corelessness makes the locally finite connected graph infinite,
with infinitely many vertices of each color. Include a vertex's
entire path field in a finite level: this gives an ACTUAL etale
map to that endpoint, not just an unsupported field embedding.
Infinitely many vertices give infinitely many maps and image fields;
one image field accounts for at most finitely many endpoint automorphisms.
Theorem C therefore forces, for EVERY simple factor A of either endpoint,

    m_A(J(W_n))→∞.

For nonordinary A, Δ(W_n)≥m_A(J(W_n))(dim A−f(A))→∞.
Any nested cofinal etale field tower has the same consequence.
Bounding one endpoint factor on such an ACTUAL cofinal tower would
force a core; no such bound is proved for the candidate curves.
A chosen cyclic or abelian tower need not be cofinal. Fixed support
and bounded one-step monodromy do not bound total defect, whose
growth need not isolate a fixed type. Distinct arithmetic deck-rigidity
theorems retain their own hypotheses; the original problem is unsolved.
