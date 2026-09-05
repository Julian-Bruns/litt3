# Boxall-style Prüfer torsion finiteness and every cyclic tower

Date: 2026-09-05.
Author: canonical-trace-algebra agent.
Status: Sections 1--3 independently checked **PASS**, with no breaking
objection, by `/root/gluing_cohomology_rigidity`, 2026-09-05. Section 4
is a bounded author source comparison, not covered by that verdict.
Not a novelty claim.
[Audit record: scope, auditor, date and retained hypothesis](audits/BOXALL_PRUFER_CYCLIC_TOWER_AUDIT.md).
The fixed curves of file 76 are unchanged.

## 1. Exact torsion statement

Let k be an algebraic closure of a finite field of characteristic p,
let A/k be an abelian variety, let ell be a prime different from p,
and let Gamma be any subgroup of A(k) isomorphic to Q_ell/Z_ell.
No invariance of Gamma under any arithmetic Frobenius is assumed.

**Theorem.** For any closed subvariety D of A, exactly one of the following
occurs:

1. D(k) intersect Gamma is finite;
2. Gamma is contained in D(k).

In particular, if 0 is not in D, the intersection is finite.
The same statement holds for the support of a nonreduced closed subscheme.
This is a rank-one consequence of the Boxall method, not a claim about
all prime-to-p torsion or about arbitrary torsion groups.

### 1.1. The elementary finite-field translation lemma

Enlarge a finite field of definition F_q so that its Frobenius M acts as
the identity on A[ell], and on A[4] when ell=2. Write T=T_ell(A).
Thus M-I is in ell End(T), and in 4 End(T) when ell=2.

For any P in A[ell^infinity](k) not in A(F_q), put Q=(M-I)P and let
ell^s be its exact order. Then s is positive and

    (M^(ell^(s-1))-I)P

is a nonzero point of A[ell]. Consequently some power sigma of the
arithmetic Frobenius satisfies sigma(P)=P+T_P, with
T_P in A[ell](k) minus {0}.

Here is a direct check, including ell=2. For n=ell^r, the binomial
identity gives

    M^n-I = n (M-I) U,
    U = I + sum_(j=2)^n (binom(n,j)/n)(M-I)^(j-1).

Every summand after I is divisible by ell. Indeed
v_ell(binom(ell^r,j)/ell^r) >= -v_ell(j), whereas
(j-1)-v_ell(j)>=1 for odd ell and j>=2. For ell=2 use instead
2(j-1)-v_2(j)>=1. Hence U is an invertible integral endomorphism of T,
commuting with M. Taking r=s-1, the displayed difference is
ell^(s-1) UQ, of exact order ell. The case s=1 has U=I.

### 1.2. Induction on the dimension of D

It suffices first to prove finiteness when 0 is not in D. Reduce to an
irreducible component and induct on dim D; dimension zero is immediate.

Let S be the full reduced translation stabilizer of D, a smooth closed
subgroup of A, possibly disconnected. Form the abelian quotient
pi:A -> A/S and its closed image Dbar. Set-theoretically
pi^(-1)(Dbar)=D, so 0 is not in Dbar. The reduced translation stabilizer
of Dbar is trivial: a stabilizing point lifts to a point of A preserving
D, hence belongs to S. All these objects descend to some finite field.

Every proper subgroup of Q_ell/Z_ell is finite. Therefore either
Gamma intersect S(k)=Gamma, in which case D intersect Gamma is empty,
or that intersection is finite. In the latter case pi(Gamma) is again
a Prüfer ell-group, and pi has finite fibers on Gamma. It suffices to
prove finiteness for (Dbar,pi(Gamma)). If dim Dbar<dim D, use induction.
Otherwise replace (A,D,Gamma) by this quotient: D now has trivial reduced
stabilizer, without increasing its dimension.

Choose F_q as in the translation lemma, also defining D. For every
P in D intersect Gamma outside the finite set A(F_q), that lemma gives

    P in D intersect (D-T_P),  T_P in A[ell](k) minus {0}.

Each such intersection is a proper closed subvariety of D because the
reduced stabilizer is trivial. It still avoids 0. There are only finitely
many possible T_P, so induction proves finiteness.

Notice that sigma(P) is used only as a point of D, not as a point of
Gamma. This is why a prescribed geometric tower need not descend to a
single finite field, nor have a Frobenius-stable defining direction.

Finally, if Gamma is not contained in a general D, choose
gamma_0 in Gamma minus D. The subvariety D-gamma_0 avoids 0, and

    (D-gamma_0) intersect Gamma = (D intersect Gamma)-gamma_0.

The already proved case gives the full dichotomy.

**Simple-ambient variant.** If A is geometrically simple and D is proper,
then D intersect A[ell^infinity](k) is finite, without a rank-one
restriction. The same induction proves this: the reduced stabilizer of
every proper subvariety is finite; quotienting by it has finite fibers
on the full ell-primary torsion, and preserves geometric simplicity.
The finite-field translation lemma then reduces dimension as before.
This variant does not require 0 to be absent from D.

## 2. Consequence for actual unramified cyclic towers

Let C/k be a smooth proper connected curve of genus at least two. On
the relative Frobenius twist C^(1), put

    B_C = F_(C/k)* O_C / O_(C^(1)),
    D = Theta_(B_C) in J(C^(1)).

Raynaud's theta divisor is defined by
L in D iff H^0(C^(1),B_C tensor L) is nonzero. For a prescribed compatible
connected cyclic Z_ell-tower C_m/C, its character line bundles form
nested cyclic groups Gamma_m of order ell^m, with union Gamma a Prüfer
ell-group. Relative Frobenius transports the actual étale covers between
C and C^(1); these are not hypothetical character data.

The last new Jacobian factor J(C_m)/Im J(C_(m-1)) is ordinary exactly
when D misses Gamma_m minus Gamma_(m-1). This follows from character
decomposition, projection formula, and the étale pullback identity for B.
The twists and the Frobenius permutation of characters are explained in
[the earlier exact character criterion](CYCLIC_TOWER_NEW_ORDINARITY_AND_FIXED_SUPPORT_BOUNDARY.md#2-exact-criterion-for-a-specified-cyclic-tower).

**Corollary.** If C is ordinary, every prescribed cyclic Z_ell-tower is
eventually new-ordinary. Equivalently, g(C_m)-f(C_m) is bounded and
eventually constant. No generic choice of the tower is needed.

Proof: ordinarity gives 0 not in D, so Theorem 1 makes D intersect Gamma
finite. Isogeny additivity of dimension and p-rank gives the equivalence
with eventual constancy of the defect.

More generally, for an arbitrary C and a prescribed cyclic tower, either
the defect is bounded, or every character line bundle in Gamma belongs
to D. In the latter case

    g(C_m)-f(C_m) >= a(C_m) >= ell^m.

Indeed the direct sum expressing H^0(B_(C_m)) has at least one nonzero
summand for each of its ell^m character line bundles. In particular this
alternative requires C itself to be nonordinary.

This strengthens the earlier note's Haar-generic conclusion over the
algebraic closure of a finite field. It does NOT assert that all C_m are
ordinary, that the bound is uniform among all towers, or that the entire
maximal abelian ell-power tower has bounded defect. Rank-one directions
can have different finite exceptional sets.

For every fixed nonordinary simple abelian variety A, the bounded-defect
alternative implies a bound for its multiplicity:

    m_A(J(C_m)) (dim A-f(A)) <= g(C_m)-f(C_m).

## 3. Boundary for a fixed étale Z/C

For a constant abelian variety A/k, properness and the Albanese universal
property give

    A(k(Z_m))/A(k) = Hom(J(Z_m),A).

For simple A this group's rank is m_A(J(Z_m)) times dim_Q End^0(A).
It is this geometric constant-variety rank, not a non-isotrivial or
finite-constant-field arithmetic rank, that is at issue here.

If Z is nonordinary and Z_m is a compatible connected component of
Z times_C C_m, then after a finite initial stage the tower Z_m/Z_M is
a cyclic Z_ell-tower. Apply the dichotomy to this ACTUAL base Z_M.
Its character direction can be entirely contained in Theta_(B_(Z_M));
ordinarity of C does not prevent that. Raynaud's no-theta examples already
give actual initial covers with unbounded total defect after such
base changes; see the earlier note's Section 4.

Thus the new cyclic theorem does not settle boundedness of one fixed
nonordinary isogeny factor in these base-changed towers. Even exponential
growth of total defect can be accounted for by changing isogeny types.
No actual fixed-type unbounded example, nor a universal fixed-type bound
in this general unramified setting, was established in this bounded check.

There is nevertheless an exact useful conditional maximal-abelian result.
Suppose J(C) is geometrically simple and let

    B = Im(J(C^(1)) -> J(Z^(1))).

The pullback map to B has finite kernel, since norm composed with
pullback is multiplication by deg(Z/C). Hence B is simple. If
Theta_(B_Z) does NOT contain B, the simple-ambient variant shows that
only finitely many ell-primary character line bundles on C pull back
into Theta_(B_Z). Thus in the maximal abelian ell-power base-change
tower, all sufficiently high-order character summands are ordinary.
The nonordinary part is already present at a finite stage, so total
defect, and therefore every fixed nonordinary factor multiplicity,
is bounded. This also bounds every cyclic subtower.

For precision, the full fiber products may be disconnected. The number
of their components stabilizes, because the finite extension k(Z)/k(C)
has only finitely many subextensions inside the abelian tower. Use its
finite connected-component base change as the initial stage. Character
decomposition on the full fiber products gives the same bound on each
actual connected component. Absence of bad high-order characters makes
Frobenius injective on each entire new character-orbit block, not merely
a bound on the dimension of its kernel.

The required properness is exactly what no-theta finite-cover examples
can fail. It is not implied by Hom(A,J(C))=0, and no such implication
is claimed. For Z=C and simple J(C), this argument gives bounded total
defect in the maximal abelian ell-power tower even without ordinarity
of C. No analogous general statement for non-simple Jacobians is proved.

## 4. Primary-source provenance and near-match limits

John Boxall, *Sous-variétés algébriques de variétés semi-abéliennes sur un
corps fini*, Number Theory (Paris 1992-3), LMS Lecture Note Series 215
(1995), 69-80,
[publisher record and first-page preview](https://doi.org/10.1017/CBO9780511661990.005).
The preview was inspected; the full chapter was not accessible. Therefore
the precise theorem above is supplied with its own proof, rather than
claimed to be a verbatim reading of a numbered theorem in that chapter.
The preview refers to preceding abelian-variety work; the earlier
reference, also identified by Voloch below, is Boxall,
*Autour d'un problème de Coleman*, CRAS 315 (1992), 1063-1066.

J. F. Voloch, *Integrality of torsion points on abelian varieties over
p-adic fields*, the lemma and proof on p. 3 of the
[author PDF](https://www.math.canterbury.ac.nz/~f.voloch/Pdfs/torsion.pdf),
explicitly reproduce the Galois-translation method of Boxall. Section 1.1
above proves exactly the finite-field version needed here, with the
2-primary congruence checked directly.

T. Scanlon and J. F. Voloch, *Difference subgroups of commutative
algebraic groups over finite fields*,
[primary preprint](https://arxiv.org/pdf/math/9809188), introduction and
Theorem 2, explain that their difference-group method recovers only part
of Boxall's m-power torsion theorem. Failure of their modular-group
construction is not a counterexample to the torsion intersection result.

For the original fixed-isogeny multiplicity question, the inspected near
matches do not apply:

- J. Ellenberg, *Selmer groups and Mordell-Weil groups of elliptic curves
  over towers of function fields*, Theorem 4.4 and Remark 4.6
  ([author PDF](https://people.math.wisc.edu/~ellenberg/CMECTFF.pdf)),
  require a non-isotrivial elliptic curve and an arithmetic large-image
  condition. Remark 4.6 explicitly says that theorem never applies over
  a finite constant field. A constant A over geometric function fields
  is not within those hypotheses.
- A. Bandini and I. Longhi, *Selmer groups for elliptic curves in
  Z_l^d-extensions of function fields of characteristic p*, setup and
  Theorem 1.2
  ([primary PDF](https://www.numdam.org/item/10.5802/aif.2491.pdf)),
  also assume a non-isotrivial elliptic curve; torsionness additionally
  needs a finite initial Selmer group. This is not a constant-A theorem.
- D. Ulmer, *Jacobi sums, Fermat Jacobians, and ranks of abelian varieties
  over towers of function fields*, Theorem 3.3 and proof in Section 3.9
  ([primary preprint](https://arxiv.org/pdf/math/0609716)), bounds the
  multiplicities of fixed bounded-dimensional positive-p-rank factors
  in Fermat Jacobians. The proof uses explicit Jacobi sums and their
  valuations. The supersingular exception is real, but these Fermat
  towers ramify. Neither direction establishes the assertion for the
  proper étale towers in Section 3.
