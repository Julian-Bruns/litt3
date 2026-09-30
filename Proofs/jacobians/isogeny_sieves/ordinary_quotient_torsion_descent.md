# Proof: torsion rationality descends the actual ordinary quotient

[Statement](../../../Theorems/jacobians/isogeny_sieves/ordinary_quotient_torsion_descent.md).
The argument replaces abelian character multiplicities by actual
prime-primary torsion rationality. It retains the integral norm
isogeny from the second map.

## 1. A finite-order action cannot survive the torsion congruence

Normalize v_ell(ell)=1. If a matrix P lies in1+ell Mat_d(Z_ell),
then every eigenvalue lambda satisfies v_ell(lambda-1)>=1:
(lambda-1)/ell is an eigenvalue of an integral matrix. Its
eigenvalues are units. Hence every eigenvalue of conjugation
by P on End(Q_ell^d) is a ratio lambda/mu and satisfies
\[
v_\ell(\lambda/\mu-1)\ge1.
\tag{4}
\]
For ell>=3, the only root of unity satisfying(4) is1. Indeed a
nontrivial prime-to-ell root has valuation zero after subtracting1,
and a primitive ell^a-root has valuation1/(ell^(a-1)(ell-1))<1.
For ell=2 the identical statement holds with valuation at least2,
using P in1+4 Mat_d(Z_2).

Consequently conjugation by P is the identity on ANY invariant
subspace on which it has finite order. The restricted action is
semisimple in characteristic zero, and all its eigenvalues are1.
This statement is independent of d; it is not a bounded-block
or bounded-character-degree estimate.

Let pi be Frobenius of A/F_q. Conjugation by pi has finite order
on End^0_k(A): the finitely generated geometric endomorphism ring
is defined over some finite extension. For ell!=p the Tate module
is faithful after tensoring with Q_ell. Rational ell-torsion, or
four-torsion at two, puts pi in the required congruence subgroup.
The preceding calculation gives pi u=u pi for EVERY geometric
endomorphism u. Such commutation is equivalent to definition
over F_q. Every abelian subvariety is the image of a rational
idempotent, so it too is defined over F_q. This is the usual
torsion-field endomorphism-descent fact; the argument above proves
the finite-field instance used here directly.

## 2. The characteristic-prime variant sees the ordinary part

Let p>=3 and suppose A[p](k) is rational. Let A_ord be the sum
inside A of all geometric ordinary simple isotypic factors.
This is a canonical abelian subvariety: any isogeny of A preserves
each geometric isotypic type. In particular Frobenius preserves
A_ord, so it is defined over F_q. Its p-torsion geometric points
inject into those of A, and are rational.

The etale p-adic Tate module of A_ord has rank dim(A_ord), and
its Frobenius lies in1+p Mat(Z_p). The action on this Tate module
is faithful on rational geometric homomorphisms BEFORE tensoring
with Q_p. To justify this carefully, a nonzero homomorphism between
ordinary abelian varieties has a positive-dimensional ordinary
image. That image has nonzero etale p-adic Tate module, and an
isogeny is invertible on the rational module. Such a homomorphism
therefore cannot act as zero. We do not assert that
End^0(A_ord) tensor Q_p embeds faithfully: that stronger claim
would fail for the two local CM components of an ordinary elliptic
curve.

Take the Q_p-linear span of the IMAGE of End^0_k(A_ord) inside
End(V_p(A_ord)). It is finite-dimensional, invariant under
conjugation by pi, and that conjugation has finite order. Section1
therefore makes it the identity. Faithfulness on the original
rational homomorphisms now gives
\[
\pi u=u\pi\qquad(u\in\operatorname{End}^0_k(A_{\rm ord})).
\tag{5}
\]
All these endomorphisms descend. All abelian subvarieties of A_ord
are images of rational idempotents, hence descend as well. This
proves the claimed result for every ordinary B inside A, together
with descent of all its endomorphisms.

Only standard isogeny decomposition and ordinary connected/etale
structure enter this step; see
[Oort, Sections5,9 and18](https://math.nyu.edu/~tschinke/books/finite-fields/submitted/oort.pdf).
No conclusion about the invisible p-rank-zero part is inferred.

## 3. A prime-primary cover has the required torsion model

The established
[pro-primary cover theorem](pro_primary_frobenius_exclusion.md),
Sections1-2, supplies the following ACTUAL model. If W->C has
ell-group Galois closure and m is Frobenius order on H1_et(C,F_ell),
then W has a model over F_(q^(m*ell^a)), for some a, with rational
full ell-torsion on J(W). For ell=2, a further two-power extension
makes J(W)[4] rational, since the kernel of reduction from level4
to level2 is a two-group.

This same assertion holds for ell=p with ETale p-torsion; it is
proved explicitly in the
[unit-root theorem](five_by_abelian_unit_root_exclusion.md), Section1.
For clarity, the common group argument is as follows. A rational
point splits the arithmetic fundamental-group sequence. Once
Frobenius is trivial on the Frattini quotient of the finitely
generated maximal pro-ell geometric fundamental group, the closure
of its automorphism action is pro-ell. An actual open subgroup,
and subsequently that subgroup's Frattini quotient, are fixed
over ell-power extensions. The subgroup is the full maximal
pro-ell fundamental group of the cover: taking the Galois closure
of an ell-group cover above it remains an ell-group extension.
Thus the second Frattini quotient controls ALL relevant etale
torsion of the ACTUAL covering Jacobian, not a truncated subgroup
inherited from the base.

For ell=p finite generation is all that is required; the rank of
the Frattini quotient is the p-rank. The connected part of p-torsion
is not asserted rational. A rational point can always be obtained
over an additional ell-power extension, by the Weil bound.

For fixed X the sufficient initial orders have
\[
m_2=171,\qquad m_3\mid36,\qquad
\operatorname{Supp}(m_5)\subseteq\{2,3,5,13\}.
\tag{6}
\]
The first and second are the established fixed-X torsion calculations.
For the third, the unit-root reduction is
(T+1)^2(T^4+T^3+3T^2+3), whose quartic roots have order624;
possible nonsemisimplicity only adds a factor of five.
For arbitrary ell!=5, m_ell divides |GL18(F_ell)|.

## 4. Descending the actual image, norm kernel and polarization

Take the ACTUAL Galois closure W->X of the original X-leg. Its
deck group is an ell-group of order N. The other map is the
composition W->Z->Y, still etale and of degree8N. No Galois
assumption is imposed on that composition.

Choose the field F_(25^(m_ell*ell^a)) from Section3. Section1,
or Section2 when ell=5, descends the actual image
\[
B=\operatorname{im}\bigl(J(Y)\xrightarrow{g^*}J(W)\bigr)
\]
to that SAME field and descends all its geometric endomorphisms.
B is an ordinary abelian surface. The restriction of the canonical
polarization of J(W) is a defined polarization on B, so all
homomorphisms B->B^vee are defined as well, by dividing rationally
by that polarization.

Put d=8N, alpha=g^*:J(Y)->B and beta=g_*|B. The actual norm
identities give
\[
\beta\alpha=[d],\qquad\alpha\beta=[d].
\tag{7}
\]
Hence beta is an isogeny with kernel contained in B[d]. Its prime
support is contained in{2,ell}. This step uses etaleness of BOTH
maps, through the precise equality d=8N.

For lambda!=5, all geometric subgroup schemes of B[lambda^b]
are defined after making its rank-four etale module constant.
The extension degree only has primes dividing
\[
\lambda\prod_{i=1}^4(\lambda^i-1).
\tag{8}
\]
At lambda=5, ordinariness identifies geometric torsion with
mu_(5^b)^2 times (Z/5^b)^2. Over a perfect field its subgroup
schemes are determined by the etale and Cartier-dual multiplicative
modules. Their two GL2 actions only introduce primes2,3,5.
At lambda=2, (8) only introduces2,3,5,7, independent of b.

Thus the kernel of beta descends over an extension with exactly
the indicated prime support. Quotienting B by this kernel gives
a model of the ACTUAL J(Y). Its principal polarization also
descends: its beta-pullback is a homomorphism B->B^vee already
defined over the preceding field, and isogeny pullback is injective
on Hom. Geometric Torelli fixes the isomorphism class of Y.
This proves(1) and, using(6), (2)-(3).

For completeness, this integral passage is the same one checked
in [abelian ordinary quotients](abelian_cover_ordinary_quotient_fields.md),
Section3. The present improvement is that torsion rationality
descends B directly, without any bound on irreducible character
degrees or a restriction to abelian deck groups.

## 5. Main consequence and boundary

The prescribed main partner has prime moduli degree r>K>=3^64,
so none of the finite supports in(2)-(3) contains it. This excludes
all X-leg Galois closures that are2-groups,3-groups or5-groups,
including nonabelian groups of unbounded size. It is a theorem
about the original two maps, not just maps whose two Galois
closures happen to coincide.

For arbitrary ell!=5, use m_ell dividing |GL18(F_ell)| in(1).
Since r>7, a surviving target prime r must equal ell or divide
ell^i-1 for some1<=i<=18. Thus ell>r^(1/18). This applies to
EVERY prime-primary monodromy group, without computing m_ell
or imposing an abelianity assumption.

Mixed-prime monodromy is not covered. The maximal pro-ell group
of a mixed-prime cover is not the subgroup of the base's maximal
pro-ell group: new ell-covers can have a non-ell Galois closure
over the base. Thus the second Frattini step in Section3 cannot
be repeated for an arbitrary cover or a presumed pronilpotent
replacement. The backup's moduli degree is three and survives
this theorem. No unrestricted common-cover verdict is asserted.
