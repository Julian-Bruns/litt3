# Proof by the three determinant divisors

Use the hypotheses in
[the statement](../../Theorems/cartier_and_spin/cyclic_determinant_section_reduction.md).
Write pi:C->P1 for the quotient. Since pi is totally ramified of
degree three at the fixed point O, a fiber over pi(O) is3O.
For every line bundle M of degree m, the divisor norm gives
\[
M\otimes\gamma^*M\otimes\gamma^{2*}M
\simeq\pi^*\operatorname{Nm}_\pi M\simeq O_C(3mO).
\]
This follows directly by summing the three conjugate divisors;
fixed points are counted with their full ramification multiplicity.

## An isotypic section space forces invariant line classes

Suppose a saturated nonnegative-degree line M in E has noninvariant
class, and put M_i=gamma^{i*}M, with the specified induced embeddings.
Their classes, hence their generic lines, are pairwise distinct.
For {i,j,k}={0,1,2}, let D_i be the effective divisor of the nonzero
wedge map M_j tensor M_k -> det E. Thus
\[
M_jM_k\simeq\det E(-D_i),\quad\deg D_i=\delta-2m,
\quad M_i(\delta O)\simeq O_C(D_i+3mO).
\]
Because m>=0, the last effective divisor gives a section s_i of
E(delta O) with zero divisor exactly D_i+3mO. Saturation of M_i
ensures that its inclusion contributes no further zeros.

Every nonzero section of an isotypic C3-space is an eigenvector.
Consequently the zero divisor of s_i is gamma-invariant. The displayed
line-bundle identification makes M_i invariant as an isomorphism class,
a contradiction. The zero section-space case gives the contradiction
already from the existence of s_i.

Now a nonzero map from a degree-zero line into E saturates to a line
M of degree m>=0. Its class is invariant by what was just proved.
The invariant degree-zero line M(-mO) still maps nontrivially into E.
Vanishing for invariant degree-zero twists therefore rules out every
such map. No semistability or reducedness of the wedge divisors is used.

## The exact norm criterion

Suppose M has degree zero and its three embedded conjugates are
distinct. The same calculation now gives M_i tensor det E=O_C(D_i).
Choose the corresponding section s=s_0 of E tensor det E. Its three
conjugates have zero divisors D_0,D_1,D_2. Their product has common
zero divisor D_0+D_1+D_2. Indeed, over any local DVR, the product of
primitive binary forms is primitive after reduction to the residue
field, so zero orders of their common scalar factors add exactly.

The wedge s wedge gamma(s) has the SAME divisor: the two section
zeros contribute D_0+D_1, and their saturated lines contribute the
remaining wedge divisor D_2. This wedge is a section of
det(E tensor det E)=(det E)^3. Division therefore produces a regular
global section G of Sym3 E and proves the identity. No local equation
or rational trivialization loses an infinity contribution.

Conversely, suppose the identity holds for nonzero s and nonzero
wedge. Write Z for the zero divisor of s as a vector-bundle section.
The norm has common zero divisor Z+gamma Z+gamma^2 Z, of degree
3 deg Z. The wedge is a nonzero section of (det E)^3, whose zero
divisor has degree3delta. Regularity of G therefore implies
deg Z>=delta. Saturating s gives a line O_C(Z) in E tensor det E,
or O_C(Z) tensor(det E)^(-1) in E. By the assumed absence of positive
lines its degree is at most zero, so deg Z<=delta. Equality follows,
giving the required degree-zero subline. The argument counts all
multiplicities and makes no separability assumption about an auxiliary
function or coefficient map.

The norm criterion concerns actual embedded lines in a bundle on C.
It does not supply a finite coefficient bundle, another endpoint map,
or an everywhere-etale common source.
