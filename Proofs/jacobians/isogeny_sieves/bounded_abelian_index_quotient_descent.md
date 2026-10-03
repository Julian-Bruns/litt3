# Proof: an abelian subgroup of bounded index suffices

[Statement](../../../Theorems/jacobians/isogeny_sieves/bounded_abelian_index_quotient_descent.md).
We extend the established
[abelian ordinary quotient argument](abelian_cover_ordinary_quotient_fields.md).
The determinant-normalization lemma in Section3 controls all character
blocks at once. The supporting proof reuses it for the sharper D=1
threshold65 and exponent18. Both retain the actual norm kernel.

## 1. A bounded intermediate curve with a rational point

Pass to the ACTUAL Galois closure W->X of the first leg. The map
W->Z is finite etale, so its composition v:W->Y is still finite
etale. Write N=|G| and d=[G:A]<=D. Form
\[
C=W/A,\qquad C\longrightarrow X\text{ of degree }d,
\qquad W\longrightarrow C\text{ Galois with group }A.
\tag{4}
\]
These are smooth proper curves and finite etale maps. Normality
of A in G is unnecessary: C->X need not be Galois. Riemann--Hurwitz
gives g(C)=1+8d and deg(v)=8N.

Choose a geometric point c of C above the F25-rational point at
infinity of X. For this FIXED degree d, pointed geometric covers
(C,c)->(X,infinity) correspond to index-d subgroups of pi_1(X).
Their number is at most
\[
(d!)^{18}/(d-1)!=d(d!)^{17}\le B_D:=D(D!)^{17}.
\tag{5}
\]
Count transitive homomorphisms to S_d and divide by the relabelings
fixing1. This S_(d-1)-action is free: an element centralizing a
transitive action and fixing1 fixes every letter. Its orbits are
exactly the pointed subgroups. Frobenius preserves the degree, so
no sum over smaller degrees is needed.

Arithmetic F25-Frobenius permutes this finite set. Some power e0,
with e0<=B_D, fixes the given pointed cover. A connected pointed
cover has no nonidentity automorphism preserving its distinguished
point. Its Frobenius isomorphisms therefore have automatic cocycle
compatibility and descend the ACTUAL pointed cover to F_(25^e0).
In particular C has a rational point over this field. This is also
the standard construction using the split arithmetic fundamental
group at infinity and the Frobenius-stable index-d subgroup.

## 2. An abelian-cover model with controlled field-degree primes

Use that rational point to model the ACTUAL abelian cover W->C.
Let n be the exponent of A. For every ell dividing n, the maximal
geometric abelian pro-ell quotient of pi_1(C) has rank
\[
2g(C)=16d+2\le M_D\quad(\ell\ne5),
\qquad f(C)\le g(C)\le G_D\quad(\ell=5).
\tag{6}
\]
Kill arithmetic Frobenius on these abelian quotients modulo the
ell-primary part of n. The given pointed quotient W->C then has
a model, with its entire A-action constant, over F_(25^(e0 e1)).
Every prime divisor of e1 divides
\[
\ell\prod_{i=1}^{M_D}(\ell^i-1)
\quad\text{for some prime }\ell\mid |A|.
\tag{7}
\]
At ell=5 use the smaller rank G_D from(6), so all contributed
primes are less than5^G_D. Cover exponents can increase their powers
but cannot introduce further primes.

This construction is a model of W as a cover of C. It need not
make all of G constant, nor make v or Y rational over that field.
Let pi denote the Frobenius endomorphism of J(W) for this model.
It commutes with A, which is all the character calculation needs.

## 3. The trivial character also has bounded size

The actual free A-action gives, on characteristic-zero etale
cohomology for any auxiliary prime different from five,
\[
H^1(W)\simeq\mathbf Q_\lambda^2
\oplus\mathbf Q_\lambda[A]^{16d}.
\tag{8}
\]
The trivial character has multiplicity16d+2; every nontrivial
absolute character has multiplicity16d. Thus ALL characters have
multiplicity at most M_D. Unlike the abelian cover of X itself,
the invariant part J(C) may contain small ordinary factors. They
are retained here, not discarded using simplicity of J(X).

### A projective block lemma

Let F=K Q(zeta_n), with [K:Q]=kappa. Suppose a nonempty finite
collection of matrices P_j in GL_(m_j)(F), 1<=m_j<=M, has a COMMON scalar power:
P_j^b=a I for the same b>0 and a in K^times.
Then some power makes all blocks the SAME scalar, and its
prime support consists only of primes dividing n or at most
kappa M+1.

Indeed,
\[
T_j=(\det P_j)^{-1}P_j^{m_j},\qquad T_j^b=I.
\]
Every eigenvalue of T_j is a root of unity of degree at most m_j
over F. If a prime r not dividing n divides its order, cyclotomic
disjointness gives r-1<=[F(eigenvalue):Q(zeta_n)]<=kappa m_j.
Thus the lcm v of the orders of all T_j has only the asserted primes.

Put u=lcm_j(m_j). Its prime divisors are at most M, and every
P_j^(uv) is a scalar delta_j in F. Their b-th powers all equal
a^(uv), so delta_j/delta_1 is a root of unity IN F. A new prime r
in such a ratio satisfies r-1<=kappa. Kill these ratios by their
order lcm w. Then the exponent uvw has the asserted prime support
and makes every block the same scalar. If the direct-sum operator
is defined over K, that common scalar belongs to K.

The common scalar-power hypothesis is essential; separate scalar
powers with unrelated values do not give the last comparison.

### Apply the lemma to the small ordinary factors

Let B be any geometrically simple ordinary factor of J(W) of
dimension at most two. Its geometric endomorphism algebra K is
a CM field of degree at most four. On the right K-space
U=Hom^0(B,J(W)), diagonalize A after scalar extension to
F=K Q(zeta_n). Each character block of pi on U_F has size at
most M_D by(8) and the rank-one CM Tate module at each embedding
of K. There is a positive b, not assumed bounded, with
\[
\pi^b|U=a\,\mathrm{id},\qquad a\in K^\times.
\tag{9}
\]
For example, define B, its endomorphisms and a basis of U over a
finite extension and use Frobenius compatibility there. Apply the block
lemma to the nonzero blocks, with kappa<=4 and M=M_D. It gives
an exponent E_B whose prime divisors are at most4M_D+1 or divide
|A|, and pi^E_B is scalar over K on U. Hence it is CENTRAL on
the entire geometric B-isotypic factor. Take the lcm E over the
finitely many small ordinary isotypic factors. Its prime-support
bound is unchanged, despite unbounded numbers of blocks or factors.

## 4. The actual genus-two quotient, not just its isogeny class

Let J=J(Y) and let B0 be the actual image of v^*:J->J(W). It is
ordinary of dimension two. The centrality just proved descends
B0 as an embedded abelian subvariety over F_(25^(e0 e1 E)), and
defines all its geometric endomorphisms over that field. An induced
polarization then defines all rational homomorphisms B0->B0^vee
there as well.

Set alpha=v^*:J->B0 and beta=v_*|B0:B0->J. The two ACTUAL etale
maps give
\[
\beta\alpha=[8N]_J,\qquad
\alpha\beta=[8N]_{B0},\qquad
\ker\beta\subset B0[8N].
\tag{12}
\]
The second equality follows from the first after precomposing
with the surjective alpha. Thus beta is an isogeny whose actual
finite subgroup kernel has prime support contained in2N.

For ell!=5, rationalizing B0[ell^a] needs an extension supported on
the primes of ell times the factors ell^i-1 for i<=4. At five,
ordinariness identifies the geometric torsion with the product
of multiplicative and etale rank-two groups. Rationalizing their
two finite-module actions fixes every subgroup scheme; the needed
prime support is only2,3,5. This is precisely the integral subgroup
argument in the abelian ordinary quotient proof. Consequently the
ACTUAL kernel in(12) descends after an extension E2 supported on
\[
\{2,3,5,7,13\}\ \cup\!
\bigcup_{\substack{\ell\mid N\\\ell\ne5}}
\operatorname{Supp}\left(\ell\prod_{i=1}^{4}(\ell^i-1)\right).
\tag{13}
\]
The displayed fixed set harmlessly overbounds the extra factor8.

The quotient B0/ker(beta) is an actual model of J. Its specified
principal polarization descends: its pullback to B0 is already
defined, and pullback by an isogeny is injective on Hom. Geometric
Torelli therefore implies
\[
m_Y\mid e0 e1 E E2.
\tag{14}
\]
Neither simplicity of J(Y) nor a rational model of the original
map v over this smaller field is required.

## 5. The numerical conclusion and the selected partner

Since 5^G_D>4M_D+1 and13 for G_D>=9, the two terms in L_D
cover every fixed bound. For r>L_D, the factor e0 in(14) cannot contribute r by(5).
The characteristic-primary part of e1 cannot contribute r by(7).
The block lemma excludes a new r from E; if r already divides |A|,
take ell=r in the conclusion. Equation(13) adds no unaccounted
prime except one dividing ell or ell^i-1 for ell|N, ell!=5, i<=4.
Since M_D>=18, all remaining possibilities have
\[
\ell=r\quad\text{or}\quad\operatorname{ord}_r(\ell)\le M_D.
\]
If ell!=r, ell^M_D>=ell^i>r; this proves the strict size bound.

For the main partner put B*=336000, D0=(B*-1)!, G0=1+8D0,
L*=(B*)^2 and M*=floor(B*/8). The already selected moduli prime
r exceeds
\[
K=D0(D0!)^{18}\,3^{4G0^2L*}\,(M*!)^{2G0+L*}.
\tag{15}
\]
Here M_D0=2G0. In particular
\[
K>\max\{L_{D0},\ D0^{M_{D0}}\}.
\tag{16}
\]
For clarity, the first factor handles D0(D0!)^18. The middle
factor alone exceeds5^G_D0 and4M_D0+1, since M_D0>=18 and
its exponent is M_D0^2L*. It also exceeds D0^M_D0: indeed
3^(M_D0 L*)>D0, already because M_D0 L*>=D0 and3^D0>D0.
All factorial factors in(15) are positive integers.

If G has an abelian subgroup of index at most D0, apply the
theorem with D=D0. It forces a prime ell|N larger than r^(1/M_D0),
which by(16) is larger than D0. Thus groups all of whose prime
divisors are at most D0 cannot occur.

Nothing bounds the abelian index of an arbitrary finite quotient
of pi_1(X). In particular large nonabelian simple groups and
groups with unbounded minimal abelian index are not removed.
The proof makes no finite common envelope for the two endpoints
and leaves both unrestricted common-cover problems unresolved.
