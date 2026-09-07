# Restricted Raynaud theta: sufficient conditions and stability boundary

Author elementary deductions2026-09-05; not independently audited.
Work over algebraically closed k of characteristic p>2 with smooth
proper connected curves of genus≥2. Write
B_C=coker(O_C^(1)→F_C*O_C); the proper Raynaud divisor Θ_C has support
{L∈J(C^(1)):H⁰(B_C⊗L)≠0}.
Properness of a RESTRICTION is distinct from ordinarity at L=O.
The divisor input is [Raynaud, Theorem4.1.1](https://www.numdam.org/article/BSMF_1982__110__103_0.pdf).

## 1. Exact character-filtration criterion and divisor formula

Let f:Z→X be actual finite etale, with connected Galois closure W→X,
group G and Z=W/H. Suppose G has a normal p-subgroup P with abelian
quotient. Then f^(1)*J(X^(1)) is not contained in Θ_Z, regardless
of ordinarity, Galoisness of f or divisibility of its degree by p.

Every simple kG-module is a character: a simple module's P-invariants
are nonzero, normality makes them G-stable, and the abelian quotient
has one-dimensional simples. The permutation module k[G/H] therefore
gives E=f^(1)_*O_Z^(1) a vector-subbundle filtration with character-line
quotients L_χ, repeated [k[G/H]:χ] times. Each L_χ has finite
prime-to-p order. Etale Frobenius base change and projection formula give

    H^i(Z^(1),B_Z⊗f^(1)*L)=H^i(X^(1),B_X⊗L⊗E).

Outside the finitely many inverse translates
Θ_X,χ={L:H⁰(B_X⊗L⊗L_χ)≠0}, every quotient is acyclic, since χ=0.
The whole bundle is then acyclic, proving properness. Additivity of
determinant of cohomology gives the EXACT effective-divisor identity

    (f^(1)*)^*Θ_Z=∑_χ [k[G/H]:χ] Θ_X,χ.                    (1)

The displayed support fixes the translation sign. Its union is exact
even set-theoretically: a section of the first nonacyclic quotient
lifts past all previous acyclic pieces, then injects into the full
bundle. Properness just proved makes the divisor pullback defined.

The precise group-class boundary is the equivalence of:

- a normal p-subgroup with abelian quotient;
- G' a p-group;
- a normal Sylow p-subgroup with abelian prime-to-p quotient;
- all simple kG-modules being characters.

The first three follow by absorbing the p-part of an abelian quotient;
the first implies the fourth as above. Conversely a composition-series
basis triangularizes the faithful regular representation, making G'
upper unitriangular and hence a finite p-group. The same converse
works for the faithful core-free permutation representation k[G/H].
Thus its factors are all lines EXACTLY in this class.
Outside it the proof fails; properness need not fail.

For any second actual g:Z→Y, the mixed theta locus is proper by its
M=O axis. The [socle/p-refinement tests](SOCLE_CRITERION_FOR_RESTRICTED_RAYNAUD_THETA.md)
allow weaker hypotheses on the ACTUAL defect module, but do not
assert(1) under only a socle hypothesis.

## 2. Ordinary-complement sufficient condition

If A⊂J(C) and Q=J(C)/A is ordinary, then A^(1) is not contained
in Θ_C. Indeed the connected identity component K of ker(V_J)
maps into the etale ker(V_Q), hence maps to identity and lies
scheme-theoretically in A^(1). Tong's Dirac property makes a local
equation of Θ_C NONZERO on K, where it generates the socle. It
therefore cannot vanish identically on A^(1).
See [Tong, Definition1.2.7.1/Theorem1.2.7.7](https://arxiv.org/pdf/0712.2046).

This needs no birational map to a dual abelian variety. It applies to
the mixed image im(f^(1)*+g^(1)*) if its complementary quotient is
ordinary; it does NOT establish that missing ordinarity.

## 3. Joint minimality gives generic stability, not theta properness

Suppose actual finite etale f:Z→X,g:Z→Y are jointly minimal:
k(Z)=k(X)k(Y) inside k(Z). Then E_M=f_*g^*M is stable of degree zero
for M in a nonempty open of J(Y), and likewise on Frobenius twists.
No Hom-zero or prime-to-p monodromy hypothesis is used.

Take the Galois closure π:W→X of f, with sheets r_i:W→Z.
The maps h_i=g r_i are distinct by joint minimality. Their pullbacks
h_i^*:J(Y)→J(W) are distinct too: equality, by duality, would make
AJ_Y h_i and AJ_Y h_j differ by a constant translation preserving
AJ_Y(Y). Its induced automorphism of Y acts trivially on regular
one-forms. For p≠2 this forces identity: the canonical map embeds
a nonhyperelliptic curve, while the only possible extra kernel on a
hyperelliptic curve is its involution, acting as−1. Thus h_i=h_j,
a contradiction.

Avoid the finitely many proper kernels of h_i^*−h_j^*. Then

    π^*E_M=⊕_i h_i^*M

is a sum of pairwise nonisomorphic degree-zero lines. It is semistable,
hence so is E_M. A nontrivial proper slope-zero subbundle would pull
back to a direct sum of a subset of those stable factors: a subobject
of their semisimple object in the abelian slope-zero category.
Descent makes that subset G-invariant, but G acts transitively on
the sheets. It must be empty or full, proving stability without
averaging by |G|.

The mixed theta test is H⁰(B_X⊗L⊗f^(1)_*g^(1)*M). Stability of
the special pushforward family supplies NO generalized theta divisor
for its tensor product with B_X. Sections1–2 remain sufficient
conditions, not consequences of this stability theorem.

The [relative Gauss-map proof](MINIMAL_BIETALE_CORRESPONDENCE_HAS_BIRATIONAL_RELATIVE_GAUSS_MAP.md)
gives birationality if either endpoint is nonhyperelliptic, not the
missing theta assertion. Raynaud's full-Jacobian proof uses all genus
parameters; restricting to a smaller abelian subvariety loses them.
Pareschi's [Theorem1.5](https://arxiv.org/pdf/1401.7442) concerns ordinary
generic vanishing for embedded normal Cohen–Macaulay subvarieties,
not one-step Frobenius injectivity. The
[rank-one Cartier-crystal boundary](BIRATIONAL_RANK_ONE_CARTIER_CRYSTAL_DOES_NOT_CLOSE_THETA_GAP.md)
retains the precise failed upgrade and a concrete pointwise counterexample.
No literature-wide nonexistence or novelty claim is made.
