# Pole shortening and endpoint-jet bounds for Klein-four comparisons

Version2, 25 September2026. Let k be the algebraic closure of F5 and
use the fixed P,A and F25 convention of the [fixed curve](../../Definitions/fixed_pair.md).
Let S be smooth proper connected, L=k(S), with separating t,u,v,
epsilon in k*, and
\[
[L:k(t)]=4,\quad\operatorname{Gal}(L/k(t))=V_4,\quad
L=k(t,u)=k(t,v)=k(u,v),\quad\deg u=\deg v=n.
\]
Require the actual endpoint identities
\[
A(v)=\epsilon^4t^{-13}A(u),\qquad
(dv/du)^3P(u)^2=\epsilon^{-17}t^{48}P(v)^2,
\]
the noncube condition P(u) not in L*3, and the endpoint ramification
conditions: u,v unramified away from P-roots and infinity, with every
index above those values equal to1 or3. These are the actual quartic
comparison hypotheses, not a presumed Galois closure of arbitrary maps.

Write D0,Dinf for the reduced degree-four parameter end fibers, and
\[
(u)_\infty=D+3D_{\rm inf},\quad
(v)_\infty=D+3D_0,\quad\deg D=n-12.
\]
Let s count parameter fibers containing simple common poles, j1,j2
those containing one/two triple common poles, j=j1+j2, and E3 the
reduced divisor of all triple common poles. Then s+j<=29 and
s+3j<=n-12. Under these hypotheses:

1. The function w=v-epsilon*t^4*u is separating and primitive over
   k(t), and its pole divisor is exactly3D0+7Dinf+E3.
2. All three nontrivial V4-character components of w are nonzero.
   Equivalently, its trace to every quadratic intermediate field is
   nonrational over k(t). This conclusion has no upper bound on n.
3. Put g=g(S). Universally g<=min(n+8,27+2j)<=85, so t has at most88
   branch values. Each quadratic quotient separately satisfies
   g_i+1<=10+j-q_i, where q_i counts triple-pole parameter fibers
   whose inertia is the kernel of its character.
4. The connected cubic cover defined by y^3=P(u) has exactly
   R3=8n-3g+3 branch points. In the requested range14..182 this is at
   least74.

The returned pole/character argument gave g<=100. Version1 improved
this to90 using two-jets and distinct unordered pair sums. Version2
uses the first logarithmic variation of equal-label branches to force
all four endpoint labels to coincide if a character were missing.
A nonzero quadratic term in their common local differential equation
then contradicts that missing character. Four exact finite-field
values distinguish the116 variation constants. This is a local
differential proof of a full character exclusion, not a search for curves.

For14<=n<=182, the full marked tuple has a model over some F_(25^d)
with d<=29(n!)^36*3^(4(8n+1)^2)<=3^8524160. This is a theoretical
finite bound on full models, not a feasible enumeration or a bound
on an arbitrary unmarked common cover.

No complete V4 exclusion or actual model is supplied. D4,S4 and
unrestricted unmarked spans remain outside these conclusions.

[Proof and evidence](../../Proofs/cartier_and_spin/klein_four_pole_shortening.md).
