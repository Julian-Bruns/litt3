# Cyclic tower new-ordinarity: exact quantifiers and fixed-support boundary

Date: 2026-09-05.
Status: bounded primary-source comparison and author proofs by the
canonical-trace-algebra agent; not an independent audit or a novelty claim.
The fixed curves in file 76 are unchanged.

## 1. Primary statements and their quantifiers

Akio Tamagawa, *The Grothendieck conjecture for affine curves*, Compositio
109 (1997), 135–194, Lemma 1.9, p. 145
([primary PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/1992BA14A2D63FA076DB39A34EC45E83/S0010437X97000614a.pdf/grothendieck_conjecture_for_affine_curves.pdf)),
proves the following. For a smooth proper curve C of genus g at least two
in characteristic p and a prime ell different from p, if
\[
 \ell^m>
 \frac{\ell^{2g}-\ell^{2g-1}}{\ell^{2g}-1}(p-1)g,
\]
there exists a connected cyclic degree-\(\ell^m\) étale cover C_m/C whose
last new factor
\[
 J(C_m)/\operatorname{Im}J(C_{m-1})
\]
is ordinary. The intermediate cover has degree \(\ell^{m-1}\) over C.

The proof modifies Raynaud's divisor-counting argument. It selects a cyclic
torsion subgroup avoiding the Raynaud theta divisor at its primitive
points. It neither prescribes the lower levels nor asserts compatibility
between the choices for different m. The quotation in OWR 2023-42,
p. 2467, Theorem 3, has this same existence quantifier.

Michel Raynaud, *Sections des fibrés vectoriels sur une courbe*, Bull. SMF
110 (1982), 103–125, Theorem 4.3.1 and Lemma 4.3.5, pp. 123–125
([primary PDF](https://www.numdam.org/item/10.24033/bsmf.1955.pdf)),
selects a degree-ell cover with ordinary new part when
\(\ell+1\ge(p-1)g\). This is not a theorem about every cover.

Nakajima/Zhang's geometric-generic-curve theorem controls all abelian
covers of that geometric generic curve, not all covers of an arbitrarily
fixed ordinary curve over an algebraic closure of a finite field.
See the already recorded
[proof-level prior-art comparison](BOUNDED_ABELIAN_ORDINARITY_PRIOR_ART_AND_SOLVABLE_BOUNDARY.md).
An infinite intersection of finite-level open conditions does not by
itself supply a point over \(\overline{\mathbf F}_5\).

## 2. Exact criterion for a specified cyclic tower

Put \(A=J(C^{(1)})\), where \(C^{(1)}\) is the relative Frobenius twist, and
\[
 B_C=F_{C/k*}\mathcal O_C/\mathcal O_{C^{(1)}}.
\]
Let \(D=\Theta_{B_C}\subset A\). Thus
\[
 L\in D(k)\quad\Longleftrightarrow\quad
 H^0(C^{(1)},B_C\otimes L)\ne0.
\]
Raynaud proves that D is an effective divisor numerically equivalent to
\((p-1)\Theta\), for a principal polarization \(\Theta\).

A compatible cyclic \(\mathbf Z_\ell\)-tower is equivalent to nested
cyclic subgroups
\[
 G_m\subset A[\ell^m](k),\qquad |G_m|=\ell^m,\qquad
 G_{m-1}=\ell G_m.
\]
The finite étale covers are transported from \(C^{(1)}\) to C by the
equivalence of étale sites under relative Frobenius. These are actual
covers, not merely formal character sets.

**Exact last-factor criterion.**
The last new factor of \(J(C_m)\) is ordinary if and only if
\[
 D(k)\cap(G_m\setminus G_{m-1})=\varnothing.                 \tag{2.1}
\]

Proof. The direct image of the structure sheaf of the twisted cover
decomposes into the character line bundles indexed by \(G_m\).
The old part uses \(G_{m-1}\); the complementary primitive character
summand is preserved by semilinear Frobenius, which permutes characters
by their p-th powers. The Frobenius exact sequence, projection formula,
and the canonical étale pullback of B give its Frobenius kernel as
\[
 \bigoplus_{L\in G_m\setminus G_{m-1}}
 H^0(C^{(1)},B_C\otimes L).
\]
Injective Frobenius on this finite-dimensional space is equivalent to
bijective Frobenius, hence to ordinarity of the new abelian factor.
The relative twists are retained in this formula; no identification
of the relative Frobenius with a k-linear endomorphism is required.

Write \(\Delta(C)=g(C)-f(C)\). Isogeny additivity of dimension and p-rank
gives
\[
 \Delta(C_m)-\Delta(C_{m-1})
 =\Delta\!\left(J(C_m)/\operatorname{Im}J(C_{m-1})\right)\ge0. \tag{2.2}
\]
Consequently, for a specified tower, the following are equivalent:

1. The integers \(\Delta(C_m)\) are bounded.
2. Every sufficiently late last new factor is ordinary.
3. \(D(k)\cap\bigcup_mG_m\) is a finite set.

This is a necessary and sufficient avoidance condition, not a conclusion
from ordinarity of C alone. Ordinary C says only that \(0\notin D\).

## 3. A compatible-tower consequence of the counting argument

**Proposition.** For every fixed smooth proper curve C of genus at least
two and every prime \(\ell\ne p\), Haar-almost every compatible cyclic
\(\mathbf Z_\ell\)-tower is eventually new-ordinary. Its Frobenius-nilpotent
dimension is therefore bounded. This remains true after prescribing any
finite initial cyclic tower.

This assertion is an elementary consequence proved here; it is not
attributed as the statement of Tamagawa's lemma.

Choose a symmetric principal polarization \(\Theta\) on A and the very
ample class \(H=3\Theta\). Let
\[
 K=D\cdot H^{g-1}=(p-1)3^{g-1}g!.
\]
For every integer n prime to p,
\[
 \#(D(k)\cap A[n](k))\le K n^{2g-2}.                        \tag{3.1}
\]
Indeed, the effective divisor \([n]_*D\) has numerical class
\(n^{2g-2}D\). Since [n] is étale, its multiplicity at zero is at least
the number of points of \(D\cap A[n]\), counting a point of D with at least
multiplicity one. Equivalently, use
\([n]^*[n]_*D=\sum_{a\in A[n]}t_a^*D\) and take multiplicities at zero.
Intersecting with g-1 general members of the very ample system H through
zero bounds that multiplicity by
\(([n]_*D)\cdot H^{g-1}=Kn^{2g-2}\). This also covers nonreduced D.

The number of cyclic subgroups of exact order \(\ell^m\) in
\(A[\ell^m]\cong(\mathbf Z/\ell^m)^{2g}\) is
\[
 c_m=\ell^{(2g-1)(m-1)}\frac{\ell^{2g}-1}{\ell-1}.
\]
A primitive torsion point belongs to exactly one such cyclic subgroup.
Thus the number of groups failing (2.1) is at most
\(K\ell^{m(2g-2)}\). For a uniformly chosen group the failure probability
is at most
\[
 K\,\frac{(\ell-1)\ell^{2g-1}}{\ell^{2g}-1}\,\ell^{-m}.       \tag{3.2}
\]
These probabilities are summable.

To make compatibility precise, put normalized Haar measure on the
primitive vectors of \(T_\ell A\cong\mathbf Z_\ell^{2g}\). A primitive vector
defines its compatible cyclic groups; reduction modulo \(\ell^m\) is
uniform on primitive vectors, hence uniform on the \(c_m\) groups.
The first Borel–Cantelli lemma, which needs no independence, implies
that only finitely many levels fail (2.1) almost surely. Every finite
prefix is a positive-measure cylinder, so conditioning on it preserves
the measure-zero exceptional set.

For \(p=5,g=2\), the constant K in this proof is 24. The eventual constant
\(\Delta(C_m)\) depends on the chosen tower; no uniform bound on that
constant has been proved. An ordinary base does not force the constant
to be zero. The Haar statement is about geometric towers over k; it
does not claim descent of an entire infinite tower to one fixed finite
constant field.

## 4. An actual unbounded-defect counterexample to fixed prime support

The following uses Michel Raynaud, *Revêtements des courbes en
caractéristique p > 0 et ordinarité*, Compositio 123 (2000), 73–88,
Theorem 2, Proposition 1, and the proof on pp. 85–86
([primary PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf)).
The theorem supplies, for any fixed C of genus at least two, an actual
finite étale Galois cover W/C with a finite prime-to-p solvable group G
and a representation through G having no theta divisor.

Here is a tower consequence, with all covers remaining actual.
Since kG is semisimple, some irreducible constituent \(\rho\), of dimension
r, has no theta divisor. Otherwise generic vanishing for every one of
the finitely many constituents would give generic vanishing for their
sum. For the associated bundle \(E_\rho\) on \(C^{(1)}\), semicontinuity
therefore gives
\[
 H^0(C^{(1)},B_C\otimes E_\rho\otimes L)\ne0
 \quad\hbox{for every }L\in\operatorname{Pic}^0(C^{(1)})(k). \tag{4.1}
\]
Choose a prime \(\ell\nmid p|G|\) and any compatible connected cyclic
\(\mathbf Z_\ell\)-tower \(C_m/C\). Then
\[
 W_m=W\times_C C_m
\]
is connected, smooth, proper, and étale over C, because the two Galois
extensions have relatively prime degrees. Its group over C is
\(G\times C_{\ell^m}\), and \(W_{m+1}/W_m\) is cyclic étale of degree ell.

In the regular representation of \(G\times C_{\ell^m}\), each
\(\rho\otimes\chi\) occurs with multiplicity r. All \(\ell^m\) character
line bundles are covered by (4.1). Étale pullback for B and projection
formula therefore yield
\[
 \begin{split}
 \Delta(W_m)
 &\ge\dim\ker\!\left(F:H^1(W_m,\mathcal O)\to
                         H^1(W_m,\mathcal O)\right)\\
 &=h^0(W_m^{(1)},B_{W_m})\\
 &=h^0(C^{(1)},B_C\otimes(\pi_m^{(1)})_*\mathcal O_{W_m^{(1)}})\\
 &\ge r\ell^m.                                             \tag{4.2}
 \end{split}
\]
The displayed Frobenius is semilinear; its kernel dimension agrees with
the relative-Frobenius kernel dimension used by the B sequence.

Thus EVERY fixed ordinary genus-two curve over \(\overline{\mathbf F}_5\)
admits a bounded-step prime-to-5 tower with fixed finite prime support
and unbounded Frobenius-nilpotent dimension. All total monodromies belong
to the subgroup/quotient/product/extension closure of the two fixed
groups G and \(C_\ell\).

This is not a pure pro-ell tower over C: it has the fixed initial
G-cover. Over W its tail is pro-ell, but W is nonordinary. It does not
construct a second fixed target curve or a coreless correspondence.
It disproves an inference from bounded step degrees or fixed prime
support alone, not an inference using additional two-leg geometry.

The coprimality condition \(\ell\nmid|G|\) is only a convenience. For any
fixed \(\ell\ne p\), the full fiber product has \(c_m\le|G|\) connected
components, all isomorphic over C. The preceding direct-image computation
still applies to their disjoint union. Choose compatible components V_m.
Then
\[
 \Delta(V_m)\ge r\ell^m/c_m\ge r\ell^m/|G|.
\]
The fields \(k(W)\cap k(C_m)\) stabilize inside the finite extension
\(k(W)/k(C)\). After that finite stage, \(V_{m+1}/V_m\) has degree ell.
Its total monodromy is a subgroup of \(G\times C_{\ell^m}\), as required
for the same fixed-group closure boundary. Connectedness and the actual
maps are retained; one does not treat the disconnected fiber product as
a connected cover.

In the particular case \(p=5,g=2\), Raynaud's proof permits the fixed
prime support \(\{2,3\}\): take his auxiliary cyclic degree \(m=8\),
giving genus \(g'=9\), and his Heisenberg parameter \(n=9\).
The numerical requirement is \(g'/n=1\le(g'-1)/(p-1)=2\).
The Heisenberg group is a 3-group; taking the normal closure over the
cyclic degree-eight base change embeds the resulting G in a wreath
product of that 3-group with \(C_8\). Thus G has no other prime divisors.
Taking ell equal to 2 or 3 in the preceding component argument gives
unbounded defect without enlarging that prime support. This is a direct
specialization of Raynaud's construction, not an independently audited
reproof of his Heisenberg/Brill–Noether theorem.

## 5. Exact remaining boundary

For a specified pure pro-ell tower over an ordinary genus-two curve,
the cited primary statements do not establish bounded defect.
For cyclic towers, Section 2 identifies exactly the missing
theta-avoidance condition, and Section 3 supplies a measure-one
existence statement. Neither automatically applies to a tower selected
by iterating an actual correspondence.

For nonabelian pro-ell towers, character line bundles on the fixed base
no longer exhaust the representation blocks. A bound must control the
actual new finite representations, or supply a geometric mechanism
forcing their ordinarity. Ordinarity of the base, bounded step degree,
and finite prime support do not provide that mechanism.

The bounded search did not establish or refute a universal bounded-defect
theorem for EVERY pure pro-ell tower over an ordinary genus-two curve.
No such universal theorem, and no pure pro-ell counterexample in that
precise scope, is claimed here.
