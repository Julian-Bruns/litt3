# The full coordinate group realizes the entire Cartier filtration

Version2,3 October2026. The later all-height Cartier duality
identifies the broader structure of this older model: EVERY simple
factor has the same primitive-character alternating pairing.
 This is a representation-theoretic model,
NOT a construction of a curve or of a common cover.

Let k be an algebraically closed field of ODD characteristic p,
q=p^r, A_r=k[t]/(t^q), and B_r=A_r/k. Let
\[
G_r=\operatorname{Aut}_{k\text{-alg}}(A_r)
\]
be the FULL affine group scheme, including its nonreduced directions.
Its coordinate ring is
\[
k[a_0,a_1,a_1^{-1},a_2,\ldots,a_{q-1}]/(a_0^q),
\qquad t\longmapsto\sum_{i=0}^{q-1}a_it^i.
\]

The COMPLETE subrepresentation lattice of B_r is
\[
0=P_0\subset P_1\subset\cdots\subset P_r=B_r,
\qquad
P_j=k[t^{p^{r-j}}]/k,
\qquad \dim P_j=p^j-1.
\]
Every quotient P_j/P_{j-1} is simple, of dimension
(p-1)p^{j-1}. Every adjacent two-factor sequence is nonsplit.
Thus this actual algebra representation already has the same full
lattice and adjacent-extension pattern as the common higher Cartier
bundle in the no-clump case.

There is also a precise character calculation:
\[
X^*(G_r)=\mathbf Z\chi_r,
\qquad \chi_r=a_1^{p^r},
\qquad \det B_r=\chi_r^{(p^r-1)/2}.
\]
In particular the primitive character chi_r has NO pth root in
X^*(G_r). Restriction to the Frobenius subalgebra gives faithfully
flat maps G_{r+1}->G_r with chi_r pulling back to chi_{r+1}.
The character group of their inverse limit is still Z, with this
primitive generator. Retaining EVERY Frobenius height therefore
does not force that generator to become p-divisible in this model.

For EVERY 1<=j<=r, put u=t^(p^(r-j)). On P_j/P_(j-1),
\[
\langle\bar f,\bar g\rangle_j
=[u^{p^j-1}]\bigl(f\,dg/du\bigr)
\]
is a perfect alternating pairing with similitude character chi_r.
The pairings commute with the restriction tower. Thus the model
retains ALL Cartier-layer pairings, as well as multiplication,
infinitesimal translations, ranks and nonsplit adjacent extensions.
A single universal coefficient identity proves the full covariance;
no bounded coaction or symbolic-matrix computation is needed.

The nonreduced directions are essential. The reduced group fixes
the t-adic flag. At height one the FULL group acts irreducibly on
the rank-(p-1) quotient even though its reduced subgroup is solvable.
One cannot infer a common subline from the reduced group alone.

This result identifies a limitation of the abstract algebra route:
the complete filtration and all its pairings, or their Frobenius tower,
are not by themselves an abstract contradiction or a source of the
missing canonical pth root. A proof for the selected curves must
also use their actual global sections and the two field embeddings.
No no-clump bi-etale span is produced here.

[Proof](../../Proofs/cartier_and_spin/truncated_coordinate_algebra_model.md).
