# Supporting proof: the sharper abelian quotient bound

[Combined statement](../../../Theorems/jacobians/isogeny_sieves/bounded_abelian_index_quotient_descent.md).
Use the established geometric simplicity of J(X), genus nine and
five-rank six, together with the actual free-action character formula
in [endomorphism packets](etale_endomorphism_packets.md).
Neither ordinariness of T nor simplicity of J(Y) is assumed.

## 1. A field model for the actual abelian cover

Fix the F25-rational point at infinity of X. The maximal geometric
abelian pro-ell quotient of its etale fundamental group is Z_ell^18
for ell!=5, and Z_5^6 for ell=5. The rational point splits the
arithmetic fundamental-group sequence. For a prescribed exponent,
take the quotient killing that exponent, and then kill the action
of arithmetic Frobenius on this finite abelian group by a finite
constant extension. Every pointed quotient cover then descends,
and all of its deck transformations are rational over that field.

Apply this to the ACTUAL q:T->X, choosing a point of T over infinity.
It has a model over F_(25^e) with constant deck group P such that
every prime divisor of e divides one of
\[
|\operatorname{GL}_{18}(\mathbf Z/\ell^a)|\quad(\ell\ne5),
\qquad |\operatorname{GL}_6(\mathbf Z/5^a)|.
\tag{3}
\]
Here ell runs through primes of N; a may be its exponent in N,
which suffices even if it exceeds the exponent of P.
The prime support of a general-linear group over Z/ell^a is the
support of ell times the factors ell^i-1 at the indicated ranks.
At five, use the ACTUAL Frobenius order on the unit-root module
modulo five instead of the whole GL6 order. The established order
has prime support
\[
\operatorname{Supp}(m_5)\subseteq\{2,3,5,13\}.
\tag{4}
\]
The congruence kernel at each higher five-power level is a five-group,
so the same support suffices at every exponent. This is the fixed-X
input in [torsion descent, Section3](ordinary_quotient_torsion_descent.md):
the unit-root polynomial is (T+1)^2(T^4+T^3+3T^2+3), its quartic
roots have order624, and nonsemisimplicity adds only five.
The model is the actual cover; the second map and its target are
not yet asserted defined over this field.

Put Q=25^e and write pi for the Q-Frobenius endomorphism of J(T).
It commutes with P because all deck transformations are rational.

## 2. Bounded blocks on each small ordinary isotypic factor

Let A be any geometrically simple ordinary isogeny factor of J(T)
of dimension d<=2. The geometric endomorphism algebra K=End^0(A)
is a CM field of degree2d<=4. This is the absolutely-simple
ordinary case of the Honda--Tate formulas; see
[Oort, Sections5 and18](https://math.nyu.edu/~tschinke/books/finite-fields/submitted/oort.pdf).
It is not a claim that a merely simple ordinary variety stays
simple after a constant extension.

Put W=Hom^0(A,J(T)), as a right K-space, with P and pi acting on
the left. No trivial P-character occurs: the invariant abelian
factor of J(T) is J(X), and J(X) is simple of dimension nine.

The characteristic-zero character formula for the actual free
P-action is
\[
H^1_{\rm et}(T,\mathbf Q_\lambda)
\simeq\mathbf Q_\lambda^2\oplus
\mathbf Q_\lambda[P]^{16},\qquad\lambda\ne5.
\tag{5}
\]
It also holds when five divides |P|: the fixed-point Lefschetz
calculation takes place in characteristic-zero cohomology.
Since P is abelian, every nontrivial absolute character has
multiplicity sixteen.

Let n be the exponent of P, and set F=K Q(zeta_n) inside a chosen
algebraic closure of Q. After extending scalars to F, diagonalize
P on W. For every character chi, its summand W_chi has dimension
at most sixteen. Indeed, the Tate module of the CM variety A has
rank one over K; at each embedding of K the corresponding part
of W occurs in(5). Left multiplication by pi consequently has
blocks of size at most sixteen over F:
\[
\pi_\chi\in\operatorname{Mat}_{m_\chi}(F),
\qquad m_\chi\le16.
\tag{6}
\]
The total dimension of W may be unbounded. Only these character
multiplicities are bounded.

There is an integer b>0 for which
\[
\pi^b|W=a\,\mathrm{id},\qquad a\in K^\times.
\tag{7}
\]
To prove this without an arithmetic assumption on A, choose a
finite field F_(Q^b) defining A, all its endomorphisms and a basis
of Hom^0(A,J(T)). Commutation with that field's Frobenius gives
pi^b u=u pi_A, and pi_A lies in K. The integer b is not yet
bounded and is not assumed to avoid any prime.

Apply the [projective block lemma](bounded_abelian_index_quotient_descent.md#3-the-trivial-character-also-has-bounded-size)
with M=16 and [K:Q]<=4. Some exponent E_A, whose prime divisors
are at most65 or divide n, makes pi scalar over K on the entire
Hom space. It is consequently CENTRAL on the whole geometric
A-isotypic factor. This removes the unknown b without constructing
pairwise eigenvalue fields.

Take the lcm E for all geometrically simple ordinary factors of
dimension at most two. Its prime support is still at most65 or
divides N. Arbitrarily many factors and character blocks are allowed.

## 3. Descending the actual image and the integral norm isogeny

Write J=J(Y) and let B be the image of the actual pullback
\[
g^*:J\longrightarrow J(T).
\]
The norm identity makes this map an isogeny onto its image. B is
ordinary of dimension two, even if it is geometrically decomposable.
All its simple constituents are among those considered above.
Centrality of pi^E on their isotypic factors preserves EVERY
abelian subvariety inside them, so in particular pi^E(B)=B.
Frobenius invariance descends this actual embedded abelian subvariety
to F_(Q^E). This is not a choice of an unrelated isogenous factor.

On B, the Frobenius is central in End^0(B). Hence all geometric
endomorphisms of B are defined over this field. Its polarization
induced from the canonical polarization of J(T) is also defined
there. Consequently EVERY rational homomorphism B->B^vee is
defined there: divide by that polarization and use End^0(B).

Now the second map's etaleness supplies the crucial degree:
\[
d_g=\deg g=8N.
\tag{10}
\]
Let alpha:J->B be g^* onto its image, and beta:B->J the restriction
of g_*. Then
\[
\beta\alpha=[d_g]_J,\qquad
\alpha\beta=[d_g]_B.
\tag{11}
\]
The second equality follows after composition with the surjective
alpha. Thus beta is an isogeny and its ACTUAL kernel K_beta lies
in B[d_g]. In particular its prime support is contained in the
support of2N. Rational isogeny occurrence alone would not give this.

We next descend this finite subgroup, retaining its integral type.
For ell!=5, B[ell^a](k) has rank four over Z/ell^a. The reciprocal
Frobenius-root argument in
[torsion descent, Section4](ordinary_quotient_torsion_descent.md#4-descending-the-actual-image-norm-kernel-and-polarization)
makes its actual arithmetic action constant over an extension
with degree supported on
\[
\ell(\ell-1)(\ell^2-1)(\ell^4-1).
\tag{12}
\]
It does not require the induced polarization on B to be principal.
At five, ordinariness gives over k the finite group scheme
\[
B[5^a]\simeq\mu_{5^a}^{\,2}\times(\mathbf Z/5^a)^2.
\]
Over a perfect field the connected and etale parts split, and
subgroups are classified by the finite modules on the etale part
and on the Cartier dual of the multiplicative part. Killing the
two GL_2(Z/5^a) actions fixes EVERY geometric subgroup scheme.
The needed degree has prime factors only2,3,5. There is no
positive-dimensional alpha_p choice in this ordinary situation.

Accordingly K_beta descends after an extension of degree E' whose
prime support is given by(12) for ell dividing2N, together with
2,3,5. Its quotient B/K_beta is an actual abelian variety model
of J over F_(Q^(EE')).

The PRINCIPAL polarization of J descends too. Its pullback through
beta is a homomorphism B->B^vee, already defined over F_(Q^E).
Over the field defining beta, Galois invariance of this pullback
forces invariance of the polarization, since pullback by an isogeny
is injective on Hom. By geometric Torelli the curve Y therefore
has its isomorphism class defined over F_(Q^(EE')). In particular
\[
m_Y\mid eEE'.
\tag{13}
\]
No assertion that the original map g is defined over this smaller
field is needed.

## 4. Prime support and the main endpoint

Combine(3),(4), the block lemma, (12) and(13). A prime r>65 in m_Y
cannot come
from the five-primary deck or ordinary torsion actions. Nor can
it arise from the extra factor eight in d_g: the actual surface
Frobenius action at two only adds2,3,5. Thus some ell dividing N,
ell!=5, has
\[
r\mid\ell\prod_{i=1}^{18}(\ell^i-1).
\]
This is exactly the asserted alternative ell=r or ord_r(ell)<=18.

The [main partner selection](../../quotient_geometry/bounded_atlas_partner_finiteness.md)
has m_Y equal to its selected prime r>K>=3^64. If N is supported
on2,3,5, then ell=2 or3 and ell^i-1<3^18<r for every i<=18.
Neither alternative can hold. Hence no such ACTUAL common span
exists, including a non-Galois genus-two leg.

For general abelian N the same inequality shows that an allowed
ell must exceed r^(1/18): if ell!=r, a positive multiple of r
equal to ell^i-1 requires ell^18>r. The conclusion leaves large
degree primes and nonabelian X-leg monodromy unexcluded.

## 5. Why ordinariness and unramifiedness were retained

An ordinary simple factor has a commutative geometric CM field
of degree at most four. A nonordinary factor may have a division
algebra, and its five-power subgroups may vary in positive-dimensional
families; neither replacement is made here. The argument treats
two elliptic factors separately when J(Y) is not simple.

A ramified map T->Y only gives deg(g)<=8N. Its norm-isogeny kernel
can then involve new primes, which(12) would have to retain. Thus
the theorem is consistent with hyperelliptic universality and does
not assert that no etale cover of an endpoint can DOMINATE the
other curve. Both actual etale maps are used in(5) and(10).
