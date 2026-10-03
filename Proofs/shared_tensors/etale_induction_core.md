# Proof: a nonzero coefficient detects all path permutation representations

[Statement](../../Theorems/shared_tensors/etale_induction_core.md).
All constituent statements mean Jordan--Hölder constituents. The
finite étale functors used here are exact; semisimplicity of the seed
or its induced systems is not needed. Finite permutation representations
in characteristic zero are semisimple. All divisions below take place
in the coefficient field, not the curve's ground field.

## Finite constituent closure controls the full path covers

A word starting on $X$ is represented by an actual path span
\[
X\xleftarrow{p}P\xrightarrow{q}C,
\]
where $C$ is $X$ or $Y$ and $P$ is the possibly disconnected iterated
fiber product of copies of $Z$. Both maps are finite étale. Its
functor is $T=q_*p^*$, and the reverse word is $T^*=p_*q^*$.

In $P\times_C P$, the diagonal copy of $P$ is open and closed,
because $q$ is finite étale. Consequently $T^*T(L)$ contains the
direct summand
\[
p_*p^*L=L\otimes p_*\overline{\mathbf Q}_\ell.
\tag{1}
\]
This is why retaining the complete path scheme matters. Discarding
backtracking paths or passing to outer joint images would lose the
direct summand used here.

Suppose only $R_1,\ldots,R_N$ occur as irreducible constituents on
$X$. Since $L$ has positive rank, coevaluation and normalized trace
split the trivial local system off $L^\vee\otimes L$. Tensoring (1)
therefore shows that every irreducible constituent of the finite-image
permutation system $p_*\overline{\mathbf Q}_\ell$ occurs among the
finitely many constituents of
\[
\bigoplus_{j=1}^N L^\vee\otimes R_j.
\tag{2}
\]
Indeed tensoring with $L^\vee$ is exact, so a Jordan--Hölder filtration
of $T^*T(L)$ gives the same finite list of possible factors. No
semisimple decomposition of that word object has been used.
Multiplicity of the $R_j$ is irrelevant. Keep only the finite-image
irreducible systems in this finite list, and take one connected finite
étale Galois cover $X_0\to X$ trivializing all of them. Every path
permutation representation is trivial on $X_0$. A permutation matrix
representation in characteristic zero is faithful on its underlying
permutation group, so every path cover splits over $X_0$. This proves
(1) implies(2).

## A bounded path-splitting tower supplies a simultaneous Galois refinement

Use the pointed endpoint groups and the actual source subgroup $H$
from the statement.
Let $N_X$ be the intersection of the kernels of the permutation
actions of $G_X$ on ALL finite rooted path sets starting at $x$.
Define $N_Y$ in the same way.

The length-one path covers are $Z\to X$ and $Z\to Y$. Thus
$N_X\subset H$ and $N_Y\subset H$. A path starting at $y$ becomes
a path starting at $x$ by putting the specified edge $z$ first.
For an element of $H$, its action on this subset of paths is exactly
its $G_Y$ action on the remaining rooted path. Hence
\[
N_X\subset N_Y,\qquad N_Y\subset N_X
\quad\text{inside }H.
\tag{3}
\]
Write their common value as $N$. It is normal in both endpoint groups.
By(2), it has finite index in $G_X$, since it contains the subgroup
of $X_0$. It then has finite index in $H$ and $G_Y$ as well.
The connected cover of $Z$ corresponding to $N$ is the required $W$.
Normality makes both original composites Galois. This proves(2)
implies(3) without postulating a common Galois closure.

The deck groups of $W/X$ and $W/Y$ lie in the finite group
$\operatorname{Aut}_k(W)$; finiteness uses $g(W)\ge2$. The function
field fixed by the subgroup they generate is a nonconstant field
contained in both endpoint fields inside $k(W)$. Their intersection
there is the same intersection as inside $k(Z)$. Thus(3) implies(4).

## A core bounds the induction closure

The established [cored orbifold bridge](../../Theorems/quotient_geometry/cored_orbifold_bridge.md)
supplies an actual finite étale refinement $W\to Z$ Galois over both
endpoints. Its finite-envelope input is justified by the core hypothesis;
it is not available for an arbitrary span.

Let $A_X,A_Y\subset\operatorname{Aut}(W)$ be its two deck groups and
let $A=\langle A_X,A_Y\rangle$, a finite group. Put $L_W=h_X^*L$.
For the span with source $W$, every path word, pulled back to $W$, is a
direct sum of translates $a^*L_W$, with $a\in A$.
This follows inductively from the Galois pull-push formula and
finite étale base change: one further passage through the span
introduces only translates by elements of $A_X$ or $A_Y$.

For precision, the original span factors through the finite étale
map $W\to Z$. Its pull-push functor is a direct summand of the
functor defined using $W$ as source, by the trace splitting.
Therefore the preceding finite list of translates also contains
every constituent arising from the ORIGINAL span, even when it is
not jointly minimal.

For a word ending at $C=X$ or $Y$, any resulting constituent is a
summand of the pushforward from $W$ of its pullback, again by trace.
It consequently occurs in one of the finitely many systems
\[
(h_C)_*(a^*L_W),\qquad a\in A.
\tag{4}
\]
Each has finite rank and finitely many irreducible constituents.
This proves(4) implies(1) and completes the path equivalences.

## Faithful profinite gluing is the same core condition

By [Cusinato, Lemma3.4](https://arxiv.org/html/2609.01234v2), properness
of $G_X\amalg_HG_Y$ supplies one common open subgroup $N\subset H$
normal in both vertices. The connected finite étale cover of $Z$
belonging to $N$ is therefore Galois over both original endpoints.
This proves(5) implies(3).

Conversely the cored orbifold bridge gives $S=[W/D]$, with
$D=\langle\operatorname{Gal}(W/X),\operatorname{Gal}(W/Y)\rangle$,
and representable finite étale maps $X,Y\to S$.
Put $A_Z=\operatorname{Gal}(W/Z)$; it is the same subgroup of both
endpoint deck groups. Since $Z=[W/A_Z]$, both composites $Z\to S$
are canonically $2$-isomorphic via the inclusion $A_Z\subset D$.
The resulting compatible basepoints embed $G_X$ and $G_Y$ as open
subgroups of $\pi_1(S)$ whose restrictions agree on the actual $H$.
Their intersection need not equal $H$; no joint minimality is required.
The pushout universal property gives $G\to\pi_1(S)$ whose two
vertex composites are injective. Hence the vertex maps to $G$
are injective, proving(4) implies(5).

Condition(5) plainly implies(6), while [Cusinato, Lemma3.16](https://arxiv.org/html/2609.01234v2)
gives the reverse implication for the full profinite pushout.
Thus all six conditions are equivalent. No faithful compatible
coefficient family or simultaneous closure has been assumed.

## Modular coefficients require control of extension depth

Now use a finite coefficient field $\Lambda$ and retain full word
objects. Suppose the simple types on $X$ form a finite set $\Sigma$
and all word Loewy lengths are at most $h$. Let $N$ be the intersection
of the kernels of the systems in $\Sigma$. It is an open normal
subgroup of $\pi_1(X)$. This fundamental group is topologically
generated by $2g(X)$ elements; one obtains this from smooth proper
specialization and the characteristic-zero presentation, as in
[SGA1, ExposéX](https://arxiv.org/abs/math/0206203).
Schreier's argument gives the stated generator bound for $N$.

Every Loewy layer of a word object is a sum of elements of $\Sigma$,
so $N$ acts trivially on each layer. Therefore a product of $h$
operators of the form $n-1$, with $n\in N$, acts as zero on EVERY
word object. If $I$ is the augmentation ideal in $\Lambda[[N]]$,
all these objects factor on $N$ through
\[
\Lambda[[N]]/\overline{I^h}.
\tag{5}
\]
For topological generators $n_1,\ldots,n_d$, put $x_i=n_i-1$.
Modulo $I^h$, inverses are the finite geometric series in the $x_i$.
Consequently monomials of length below $h$ span(5), giving dimension
at most $1+d+\cdots+d^{h-1}$. Their span is finite and closed, so
density of the abstract subgroup generated by the $n_i$ justifies
the same assertion for the completed algebra. The image of $N$ in
its units lies in $1+I/\overline{I^h}$ and has order at most
$|\Lambda|^{d+\cdots+d^{h-1}}$.

Its kernel $N_0$ is open and normal in $\pi_1(X)$: the construction
is invariant under conjugation, since $N$ is normal. All word objects,
including $L$ itself, become trivial on the cover belonging to $N_0$.
The diagonal summand(1) still exists in modular coefficients; it
requires no trace division. Thus $L\otimes p_*\Lambda$ is trivial
there. Since $L$ is a nonzero trivial system there, $p_*\Lambda$ is
trivial as well. Permutation matrices remain faithful in every
characteristic. Hence all rooted path covers split, and(2)--(4)
give a core. The degree estimate follows from the index of $N_0$.

Conversely start from a core and the simultaneous refinement $W$.
The pullback of the finite-coefficient seed has finite monodromy on
$W$. Intersect the kernels of its finitely many translates under
$A=\langle A_X,A_Y\rangle$. This gives a finite étale cover $U\to W$
to which every element of $A$ lifts. Normality of the common kernel
and invariance under these automorphisms make $U\to X$ and $U\to Y$
Galois. Both are still étale. The seed is trivial on $U$.

All original pull-push words now factor through the fixed finite
endpoint deck groups of $U$: the functors are restrictions and
inductions through the fixed subgroup belonging to $U\to Z$.
Each endpoint group algebra has finitely many simple modules and
nilpotent radical of bounded exponent. This gives both required
bounds without semisimplicity or division by a covering degree.

The finite-closure condition is strictly stronger than the existence
of a selected common coefficient. A common object need not contain
every summand of its pull-push images. The theorem therefore rules
out an exhaustive-induction construction in the coreless case, not
the companion or clump criteria themselves.

## Coefficient Frobenius gives an exact three-way growth criterion

Use $\Lambda=\mathbf F_q$ and extend coefficients to
$\overline{\mathbf F}_q$. Every finite path object still has finite
monodromy. Its absolute simple types are permuted by coefficient
Frobenius $\sigma_q$, because the whole object is defined over
$\Lambda$. This asserts invariance of the whole multiset, not of
each chosen subobject or quotient.

Assume the three bounds $D,L,h$ in the statement. With
$b=\operatorname{lcm}(1,\ldots,L)$, every absolute simple type
is fixed up to isomorphism by $\sigma_q^b$. For a representation
$\rho:\pi_1(X)\to\mathrm{GL}_d(\overline{\mathbf F}_q)$,
this supplies a matrix intertwining $\rho$ with its coefficient
twist. Lang's elementary semilinear descent for $\mathrm{GL}_d$
changes the basis so that all its matrices lie in
$\mathrm{GL}_d(\mathbf F_{q^b})$. One may see this by choosing
a basis of fixed vectors for the corresponding invertible
$q^b$-semilinear operator; its fixed space has dimension $d$
over $\mathbf F_{q^b}$ and spans the original vector space.
There is no ground-field descent of the curves in this step.

Since $\pi_1(X)$ has $2g(X)$ topological generators, the total
number of homomorphisms to $\mathrm{GL}_d(\mathbf F_{q^b})$
is at most $|\mathrm{GL}_d(\mathbf F_{q^b})|^{2g(X)}$.
Summing for $d\le D$ proves finiteness of the simple type set.
All involved group images are finite. Extension of perfect finite
coefficient fields preserves Loewy length: the radical of a finite
group algebra commutes with such scalar extension, since its
semisimple quotient is separable. Thus the same bound $h$ applies
over $\Lambda'=\mathbf F_{q^b}$. The preceding modular proof gives
an open path-splitting kernel and the stated actual core, with its
existing splitting-cover degree bound.

Conversely a core supplies the fixed simultaneous refinement
constructed above, and the seed and all its translates factor
through fixed finite endpoint groups. Their finite group algebras
have only finitely many absolute simple types, finite coefficient
Frobenius orbits, and bounded radical nilpotence. They therefore
give all three bounds. This proves both the criterion and its
coreless growth trichotomy.

The orbit and depth hypotheses cannot be replaced by period of
the whole objects. For example cyclic étale $3^m$ covers of a
positive-genus curve in characteristic five have period-one
$\mathbf F_5$ permutation systems, but primitive absolute
rank-one character types have coefficient orbit length
$\operatorname{ord}_{3^m}(5)=2\cdot3^{m-1}$. Conversely cyclic
étale $5^m$ covers of an ordinary curve have only the trivial
simple type and period one, but their regular modules are
$\mathbf F_5[t]/(t^{5^m})$ and have Loewy length $5^m$.
These are tests of the proposed replacement conditions, not
claims that these particular cover families occur as paths in
either selected common-cover candidate.
