# Proof: actual connection defects and semilinear cyclic towers

[Statement](../../../Theorems/deformations/section_growth/symplectic_p_cover_section_growth.md).
The generic growth, quadratic-character and block-parity arguments are
proved once in the [symplectic section theorem](cyclic_symplectic_blocks.md).
Here they are applied to the actual tangent bundle; the later exact
abelian classification supplies all selected cyclic directions.

## 1. Actual tangent defects and one-defect Galois sources

The [tangent-bundle theorem](../../projective_connections/tangent_bundle_cyclic_refinements.md)
gives perfect canonical-valued alternating pairings on V_d and E_r
in characteristic five, including split canonical doubles. Both bundles
and their pairings commute with actual finite étale pullback; their
section dimensions are the respective connection defects. Apply the
symplectic section theorem to h^(1) for odd growth and the actual-deck
constraints; no monodromy conclusion is made for a non-Galois leg.

### The genus-two bad-double factorization

For Y_t with parameter degree>9, all active connections are ordinary
on the endpoint, by [genus_two_active_twists](../../projective_connections/genus_two_active_twists.md).
The [symplectic section theorem](cyclic_symplectic_blocks.md), Part4,
forces a source-defect-one Galois cover through a bad double
in the active-twist table. There are only two choices for each
of its five exceptional connections; the other80 have none.

On every such double C_L, the three-dimensional invariant Psi block
is the bijective endpoint block. Its anti-invariant Cartier-dual block
is an invertible2x2 block plus one identically zero scalar. Hence
Psi_(C_L) has a bijective five-dimensional part plus a zero line.
This uses the actual block decomposition proved in the cited table,
not just its numerical corank.

Let q:T->C_L be the remaining Galois cover. The actual-deck bound
makes its degree prime to5; both curves have defect one. The
trace-transfer argument in Section5 therefore makes T a simple-zero
source as well, without a bound on deg q.

## 2. Strict growth across the opposite Galois leg

Let \(s_i=E(r_i)/3\) be the normalized common square-Hasse quartics.
The scalar model gives \(C_3(s_i^4)=s_i\). Put
\[
U_i=\ker[C_1(s_i-):H^0(\omega_i^2)\to H^0(\omega_i^2)].
\]
The dimension of U_i is the actual indigenous defect, by the dual
infinitesimal Verschiebung identification. All these spaces pull back
compatibly under the actual etale maps; no arbitrary kernel of a chosen
bundle operator is substituted.

Suppose G=Gal(Z/Y) and d_Z=d_X>0. A pulled-back basis phi_1,...,phi_d
of U_X is then a basis of U_Z. G preserves this space and s_Z. Hence
the span of \(\phi_i\phi_j/s_Z\) is G-stable and lies in the embedded k(X). For any element w of it,
the polynomial product_(gamma in G)(T-gamma(w)) has coefficients in
BOTH k(X) and k(Y). Corelessness makes all coefficients constant.
Since k is algebraically closed, w itself is constant. In particular
phi_i^2/s_Z is a nonzero constant. Rescale phi_i so that phi_i^2=s_Z.
The twisted Cartier projection formula gives
\[
s_Z=C_3(s_Z^4)=C_3(\phi_i^8)=\phi_i C_1(\phi_i^3).
\]
Thus C_1(s_Z phi_i)=phi_i!=0, contrary to phi_i in U_Z. This proves
d_Z>d_X whenever d_X>0. The Galois group used is the ACTUAL Y-leg
group; no simultaneous normal closure or unrelated cover is invoked.

For source defect one, d_X<=1 by section pullback, so this forces d_X=0.
Together with Section1, it gives an ordinary X endpoint and a simple
zero on every such Galois one-defect source. The later
[defect-preserving descent theorem](../defect_preserving_etale_descent.md)
excludes this branch for the selected main pair.

## 3. Exact semilinear towers from a simple zero

Suppose dim ker(Psi_C)=1 and rank(Psi_C^2)=rank(Psi_C), and let
h_n:C_n->C be an actual cyclic5^n etale tower, n>=1. Set q=5^n,
R=k[e]/(e^q), e=deck-1, and D=dim H1(C,T_C). The audited
[p-cover theorem](../etale_p_witt_obstruction.md) identifies
V_n=H1(C_n,T_(C_n)) with a free R-module of rank D. Psi_n is
semilinear for sigma:R->R which takes coefficients to fifth powers
and FIXES e. It is not the ring map sending e to e^5. Reduction modulo
e, identified with invariant vectors by the norm, is the actual Psi_C.

Take the Fitting decomposition of Psi_n as a semilinear endomorphism
of the finite-dimensional k-space V_n. Its bijective and nilpotent
parts are R-stable: sigma is an automorphism and fixes e. They are
direct summands of a free module over the local Artin ring R, hence
free. The bijective part stays bijective modulo e; the nilpotent part
stays nilpotent. By the simple-zero hypothesis downstairs, their R
ranks are D-1 and1 respectively.

In an R-basis of the latter line, Psi_n is a_n(e)*sigma, where
a_n has e-order l_n (take l_n=q if a_n=0). Therefore
\[
\dim\ker\Psi_n=l_n,\qquad
\operatorname{rank}\Psi_n^j=(D-1)q+\max(q-jl_n,0).
\]
Indeed the coefficient of the jth iterate is
a_n*sigma(a_n)*...*sigma^(j-1)(a_n), with e-order j*l_n until
it vanishes. This uses a Fitting decomposition of the OPERATOR, not
independent row and column changes that would fail to control its powers.

The norm/base-change identity from
[the abelian node proof, Section1](../abelian_covers/abelian_p_defect_node.md) gives
\[
\operatorname{coker}\Psi_1
=k[e]/(e^5)\otimes_R\operatorname{coker}\Psi_n.
\]
The nilpotent line gives coker Psi_n=R/(e^(l_n)). If the first-cover
defect is ell<5, it follows that min(l_n,5)=ell and hence l_n=ell.
Thus l_n=ell at every height. Since ker Psi_C pulls back nontrivially,
ell>0; the cyclic block parity gives ell=2 or4 when ell<5.

Pullback identifies V_C with V_n^(deck), which in a regular module
is e^(q-1)V_n. Its kernel line lies in the nilpotent rank-one summand,
so every nonzero pulled-back kernel vector is a nonzero multiple of
e^(q-1) times its generator. The image of Psi_n^j in this summand is
e^(j*ell)R, or zero. This proves the exact image criterion. Negative-H1 pullback is injective.

Every connected cyclic-five cover extends to nested towers: each
character lifts through \(0\to\mathbf Z/5\to\mathbf Z/5^{n+1}
\to\mathbf Z/5^n\to0\), since \(H^2_{\rm et}(C,\mathbf Z/5)=0\) by
[Stacks, Lemma59.63.5](https://stacks.math.columbia.edu/tag/0A3J).
Its nonzero reduction modulo five makes every lifted character surjective.

## 4. The selected bad doubles and the remaining family range

For any parameter degree \(>9\), let \(r\) be an exceptional active
connection on \(Y=Y_t\), and let \(L,L'\) be its two bad twists.
The [table](../../projective_connections/genus_two_active_twists.md)
gives \(L'=L\otimes\kappa\), where \(\kappa\ne\mathcal O\) defines
the canonical double, and \(E_r\otimes\kappa\simeq E_r\).
Consequently \(F=E_r\otimes L\simeq E_r\otimes L'\) is one bundle
for both doubles: it is stable and symplectic, has \(h^0(F)=1\),
proper theta, and \(F\otimes\kappa\simeq F\).

Apply the general [rank-four theta theorem](../../jacobians/theta_divisors/genus_two_rank_four_theta.md).
Its theta multiplicity \(m\) is2 or4, and at least \(6-m\) of the
six cyclic-five covers \(Y_1\to Y\) have \(h^0(Y_1,F_1)=m\).
These SAME directions work on both bad doubles. Their base changes
\(D_1=D\times_Y Y_1\) are connected, and character decomposition gives
\[
\delta(D_1)=h^0(Y_1,E_{r_1})+h^0(Y_1,F_1)=m.
\]
The first term vanishes by the zero-preservation part of the
[symplectic section theorem](cyclic_symplectic_blocks.md).
Section1 gives a simple zero on \(D\), so Section3 applies to every
cyclic tower extending one of these directions. This retains the
whole degree\(>9\) result without repeating its theta intersection.

For the ten selected main bad doubles, and more generally the same
branch pairs at EVERY parameter degree\(>23\), the later
[abelian defect classification](../abelian_covers/abelian_defect_flags.md)
is stronger: EVERY nontrivial cyclic five-power cover of \(D\) has
defect exactly2. The same holds for all twelve backup bad doubles;
their simple zeros are supplied by
[the backup germ theorem](../abelian_covers/backup_active_double_germs.md).
Thus the Section3 formulas have \(\ell=2\) on EVERY such cyclic tower,
with no excluded direction and no higher-degree computation.

Each \(D\) is ordinary of genus three, so there are31 connected
cyclic-five covers up to isomorphism over \(D\), and each extends
to towers of all heights. Since \(\dim H^1(D,T_D)=6\), for \(q=5^n\)
the operator has
\[
\operatorname{rank}\Psi_{D_n}^{\,j}=5q+\max(q-2j,0).
\]
Its nilpotent summand has index \(\lceil q/2\rceil\).
A nonzero pulled-back base-kernel vector
lies in the \(j\)-th image exactly when \(2j\le q-1\).
For EVERY one of the six \(Y\)-directions, character decomposition
and \(\delta(D\times_Y Y_1)=2\) give \(h^0(Y_1,F_1)=2\), on both
doubles. Any direction avoiding the initial theta term also has
defect \(m\), so \(m=2\). Thus all six work, beyond the four
guaranteed solely by the multiplicity bound.

## 5. Trace transfer and two-leg obstructions

Let q:Z->C be connected finite etale of degree prime to5, with the
active connection pulled back from C. Suppose C has a simple Psi zero
and both C and Z have defect one. On tangent cohomology,
\((\deg q)^{-1}q^*\operatorname{Tr}_q\) projects onto the pulled-back
base space. It commutes with \(\Psi\): the coefficient quartic pulls
back, trace commutes with Frobenius and \((\deg q)^{-1}\in\mathbf F_5\).
Both kernel dimensions are one, so its stable complement has zero
kernel and is bijective. Hence \(Z\) also has a simple zero.

For any cyclic tower C_n->C in Section3, the source Z_n=Z times_C C_n
is connected by coprimality. Apply the Fitting argument separately to
C_n->C and Z_n->Z. Their nilpotent summands both have dimension5^n;
pullback between them is injective and trace-split, hence an isomorphism.
All other summands are bijective. Thus Z_n has the same defect ell and
rank formula, with D=dim H1(Z,T_Z).

This applies in particular to the bad-double towers of Section4
and any prime-to5 defect-preserving Z->C_L. If Z also has two actual
etale maps to endpoints, all refinements retain those maps. A nonzero
\(v\in\ker\Psi_Z\) stays nonzero upstairs and satisfies
\[
h_n^*v\in\operatorname{im}\Psi_{Z_n}^j
\quad\Longleftrightarrow\quad j\ell\le5^n-1.
\]
For any fixed j it eventually lies in that image, but it never lies
in the stable image at any finite level. In particular first-image
Serre residues vanish after the first refinement while v survives.

An actual difference delta of the two canonical W3 source lifts, when
nonzero and in ker Psi_Z, obeys this rule. Ordinary endpoints put the
difference in that kernel by
[forced canonical lifting](../forced_canonical_witt_endpoint.md).
Common etale refinement preserves the original two-map deformation
functor, so this vanishing of residues does not repair nonliftability.
The argument supplies no example realizing such a nonzero delta.

The [focused integration audit](../../../Research/audits/SYMPLECTIC_ALL_CYCLIC_TOWERS_INTEGRATION_AUDIT_2026_10_03.md)
checks the later all-cyclic specialization, paired directions and actual
trace transfer. The original simple-zero operator audit is retained.
