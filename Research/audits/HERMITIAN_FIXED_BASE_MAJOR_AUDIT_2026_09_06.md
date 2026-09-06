# Major audit: Hermitian local rigidity over a fixed target

Verdict: PASS for the stated local mathematical package; no breaking issue found.
One nonbreaking terminology correction is recommended below.

Auditor: `/root/hermitian_fixed_base_major_audit`, fresh bounded agent.
Date: 2026-09-06.
Type: independent mathematical prose audit, not formal verification.

## Scope and evidence

Audited the current statement and proof of
[hermitian_local_normality](../../Theorems/Thm_hermitian_local_normality.md)
and its
[proof](../../Solutions/Sol_hermitian_local_normality.md), together with
the statement and full proof of the
[controlled finite-jet dependency](../../Solutions/Sol_finite_jet_local_normality.md).
No old audit body was opened. The review does not address global orbifold
identification, existence of an atlas, or the common-cover problem.

Checked the actual HKG existence and restriction statements in
[Bleher–Chinburg–Poonen–Symonds, Proposition 4.8 and Theorem 4.9, printed p.9](https://math.mit.edu/~poonen/papers/AutK.pdf).
The theorem supplies a realization of a local action up to conjugacy;
the proposition supplies the rational P-quotient and freeness off the
marked point. Neither is being used as fixed-base uniqueness.
Checked the Artin–Schreier setup in
[Lehr–Matignon, printed p.3](https://arxiv.org/pdf/math/0307031).
Checked the support formula and the upper-bound proof itself in
[Nguyen, Definition 2.1 and Proposition 2.8, Step 1](https://www.journalofsing.org/volume10/nguyen.pdf).

## Breaking issues

None found.

## Mathematical checks

1. **HKG realization really forces the pointed Hermitian model.**
   The different of P is 2(p^3-1)+p(p-1), giving genus p(p-1)/2.
   Lower numbering restricts by intersection to the normal subgroup N
   of order p, whose different is (p+2)(p-1). Riemann–Hurwitz then gives
   genus zero for H/N. Freeness away from Q survives restriction to N.
   Thus the one-pole Artin–Schreier presentation has reduced degree p+1.
   The pole orders p and p+1 generate a semigroup with precisely the
   genus number of gaps, so the two displayed Riemann–Roch bases follow.
   These are sufficient for the ensuing coordinate calculation.

   The complement acts faithfully on H/N, since the kernel on its
   function field is N. Its finite affine action diagonalizes after
   translating x. Splitting the tame representation replaces y by
   y+r x+s without changing its leading pole or the degree p+1 of its
   equation. The eigencharacter condition and t>p+1 eliminate every
   lower exponent, including a possible newly introduced degree-p term.
   The leading character lies in F_p^*, giving t|(p^2-1). Scaling the
   two coordinates then gives the plus-sign Hermitian equation. This
   argument needs existence of the HKG realization, not uniqueness.

2. **Identification of the action and the quotient is valid.**
   The pole-space calculation gives exactly the displayed affine
   automorphisms. Their a=1 subgroup has order p^3 and contains every
   p-element in this stabilizer, so it is the given P. The already
   diagonal complement has the asserted subgroup of scalar factors.
   The function u has pole order p^3 and is P-invariant; its degree
   therefore identifies the invariant field. Passing to u^(-t)
   identifies a quotient uniformizer. The two wild displacement
   valuations are 2 and p+2, reproducing the filtration, and the tame
   linear coefficient a^(-p) detects all nonidentity tame elements.

3. **The three-coefficient expansion has no missing support below Q.**
   Here Q=E+B=delta+1. Solving the displayed w-equation gives
   w=z^p(1-z^(p^2-1)+...). Raising w to p^2 t postpones the first
   numerator correction beyond increment B. The first denominator term
   has increments A and B, both with coefficient one before multiplying
   by t; its square starts beyond B. Thus the only supported exponents
   through Q are E,E+A,Q, with coefficients 1,t,t. Their p-adic
   valuations are respectively 3,1,0. In particular the claimed
   derivative order is correct.

4. **The target field is retained.**
   After conjugating the action, the given quotient parameter is h(F_t),
   where h(T)=aT+O(T^2). Applying the controlled lemma to aF_t and
   h(F_t) corrects their discrepancy by a source change, since its order
   is at least 2E and E>2B. This last inequality follows from
   E=p^3 t, t>p+1 and p>=3. It implies the claimed safe determinacy
   inequality. The correction therefore yields an equivalence of the
   actual series over the original target, with a retained. There is
   no inference that the HKG conjugacy alone fixes the base parameter.

   The controlled dependency's Hasse–Taylor bound, Newton convergence,
   and uniqueness all check: q=max(2,delta-e+3), so a correction of
   order at least q makes every nonlinear term strictly higher than
   the linear term. Its finite-jet automorphism-image argument likewise
   recovers exact automorphisms and counts points of that image, not
   positive-dimensional high-jet fibers.

5. **The scalar invariant works in arbitrary source coordinates.**
   For phi=lambda z+..., the contribution of phi^E beyond its leading
   term starts with increment at least p^3>A. Both phi^E and
   phi^(E+A) have only exponents divisible by p, so neither contributes
   at Q, which is prime to p. Higher supported terms cannot contribute
   below their own orders. This proves all three coefficient formulas
   and the asserted initial vanishing for an arbitrary phi. Substitution
   in J cancels lambda because Er=p^3(B-A), leaving a^r.
   Equality of J therefore gives the necessary scalar ratio in mu_r;
   the diagonal Hermitian automorphisms supply every such multiplier,
   proving sufficiency over the fixed target as well.

6. **The short-jet test has both directions and the correct cutoff.**
   The two contributions to Nguyen's maximum are
   ceil(B/(p^3-1))=2 and (B-A)/(p-1)=p+1. Thus K=p+1 and
   D=Q+K-1=delta+p+1. The cited upper-bound proof uses source changes
   and applies to this separating series over algebraically closed k.
   No claim of optimality is needed.

   A change z+O(z^(p+2)) first affects the three displayed monomials
   at degrees at least E+p^3(p+1), E+A+p(p+1), and Q+p+1.
   All exceed D=Q+p; the middle degree is exactly D+1. A supported
   term of degree n>Q changes first at degree at least n+p+1>D.
   Factoring a source automorphism on the appropriate side through
   its degree-(p+1) truncation, and then composing the unchanged jet,
   proves that these source coefficients suffice. Determinacy lifts
   a successful finite comparison to an exact right equivalence.
   The nonzero Q-coefficient also ensures that any series passing the
   test is separating. Consequently the test characterizes the Galois
   locus and equality of J characterizes its fixed-base classes.

## Nonbreaking issue and precision note

The first paragraph calls P semidirect C_t “the infinity stabilizer” on
the Hermitian curve. When t<p^2-1, the full infinity stabilizer is larger,
namely P semidirect C_(p^2-1). Replace this wording by “the subgroup
P semidirect C_t of the infinity stabilizer.” The explicit formula and
the proof already make the intended subgroup unambiguous; this is not
a defect in the classification or the fixed-base conclusion.

The parameter a is a model coefficient; its class modulo mu_r, or a^r,
is intrinsic. The proof consistently retains that distinction. This
audit supplies no evidence for any global conclusion beyond the local
completed-extension condition explicitly stated in the theorem.
