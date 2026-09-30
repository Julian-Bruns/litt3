# Proof: integral Prym quotients and double-layer norms

[Statement](../../../Theorems/jacobians/isogeny_sieves/fixed_x_prym_smoothness.md).
22September2026. Independent follow-up derivation and focused integration
check, using the audited [one-form theorem](../../cartier_and_spin/two_form_map_descent.md).
The general smooth-joint-norm criterion already appears in
[saturated divisor relations](../../shared_tensors/saturated_divisor_relations.md);
the new input is unconditional one-form recognition for the actual X-map.

## The scheme kernel and the Prym

The norm r=pi_* is surjective, since r pi^*=[deg pi]. Its cotangent
map is the injective pullback of regular forms by the separable map pi.
Thus r is smooth, its scheme kernel is smooth, and its identity
component P_pi is an abelian variety. In invariant cotangent spaces,
\[
\operatorname{Ann}(\operatorname{Lie}P_\pi)
=\pi^*H^0(W,\omega_W).
\]
Consequently the cotangent kernel of q=h_*|P_pi consists exactly of
those omega on X for which h^*omega belongs to this pulled-back space.
If h does not descend, one-form recognition makes that kernel zero.
The differential of q is surjective; the image is all of J(X) and
translations make q smooth everywhere. A descended map gives q=0.
Conversely q=0 puts the entire nonzero nine-space in the intersection,
and one-form recognition descends the actual map.

No rational projector is reduced modulo five. In particular, smoothness
of r justifies use of its scheme kernel and its Lie annihilator; a
reduced identity component of a non-smooth kernel would not suffice.

## Integral congruences and normal layers

For any v and m as in the statement, [m]h_*-v pi_* restricts to [m]q
on P_pi. In the non-descending case its differential is therefore
surjective. An identity(2) would instead make the differential of this
restriction zero, a contradiction. After descent h_*=(h0)_*pi_* is an
actual integral factorization. This tests the distinguished map class,
not saturation of every class in the ambient Hom lattice.

For the normal-layer assertion, let H=Gal(T/Z). Joint minimality says
k(Z)=k(X)k(Y) inside k(T), and H has trivial core in G because T is
the original Y-leg's Galois closure. If h descended through T/N, N
would fix both original fields pointwise and hence lie in H. A normal
subgroup of G contained in H is trivial. Every nontrivial normal N
therefore satisfies the non-descending alternative, proving the claim.
It does not imply that every successive quotient in a normal tower
adds a different J(X)-factor: the same factor can occur in several Pryms.

## The cross norm for any actual involution quotient

Let sigma be an involution of T and pi its quotient, possibly ramified.
A nonzero omega killed by
Tr_pi h^* would give (h sigma)^*omega=-h^*omega. These two actual
X-maps share a nonzero regular form, so one-form recognition gives
h sigma=alpha h for an automorphism alpha of X. Its square is one.
The established Aut(X)=C3 forces alpha=1, contrary to 2omega!=0.
Thus the trace is injective. It is the cotangent map of h_*pi^*, so
that norm is smooth and surjective. Cartier commutes with both trace
and pullback, giving the asserted injection on Cartier kernels.
The use of one-form recognition is legitimate even for a ramified pi:
it is applied to the two etale maps h and h sigma.

If sigma has a fixed point, an invariant nonzero h^*omega would instead
give h sigma=alpha h with alpha^2=1, hence h sigma=h. A nonidentity
deck transformation of the etale h cannot fix a point. Thus no such
invariant form exists. The annihilator calculation for the smooth norm
pi_* now proves smoothness of h_* on its Prym as well. Each smooth
surjection injects the exact three-space and the ordinary six-space
of J(X) into the corresponding invariant-form spaces.

In a tower of doubles the next input is a traced nine-space, not the
canonical space of an actual map to X. A relation between sums of
pullbacks does not meet the hypothesis of one-form recognition.
Hence no all-two-group induction is asserted here.

## A relative second-Cartier-kernel obstruction

Assume now that both maps are etale, h_*pi^*=0, and 5 divides
d=deg h. Put A=J(X), P=P_pi, and i:P->J(T). Taking adjoints of the
zero norm gives pi_*h^*=0. The actual homomorphism h^*:A->J(T)
therefore factors through a homomorphism v:A->P: its connected image
lies in the identity component of the smooth kernel. Write q=h_*|P.
The zero cross norm prevents h from descending, so q is smooth by
the first part of the proof. Integrally qv=[d].

On invariant one-forms put alpha=q^* and beta=v^*. Both commute with
Cartier; alpha is injective and beta alpha=0. Let V be the nilpotent
Cartier summand of H^0(A,Omega_A^1), and M the nilpotent summand on P.
For the fixed X, dim V=3 and C(V)=0. We claim that beta:M->V is
surjective, a stronger statement than the existence of the first map.

Curve pullback H^1(X,O_X)->H^1(T,O_T) is injective on its nilpotent
Frobenius summand by the
[finite-map Frobenius argument](../etale_frobenius_degree_gap.md).
Serre duality gives
\[
\langle Fz,\eta\rangle=\langle z,C\eta\rangle^5,\qquad
\langle h^*z,\eta\rangle_T
=\langle z,\operatorname{Tr}_h\eta\rangle_X.
\]
The Fitting decompositions are orthogonal: a nilpotent vector pairs
trivially with the bijective summand on the other side, by iterating
the first identity. Thus trace is surjective on the nilpotent Cartier
summands. Identifying curve forms with invariant Jacobian forms,
\[
\operatorname{Tr}_h=v^*i^*=\beta i^*.
\]
Since i^* commutes with Cartier, a nilpotent trace preimage gives a
preimage in M. This proves the claim. It does not assert surjectivity
of trace on the full space of regular forms.

We have obtained
\[
V\xrightarrow{\alpha}M\xrightarrow{\beta}V,\qquad
\alpha\text{ injective},\quad\beta\text{ surjective},\quad
\beta\alpha=0,\quad C(V)=0,\quad\dim V=3.
\]
Let b=dim ker C_M and let l be the number of nilpotent Cartier blocks
of length at least two. The kernel of beta on ker C_M contains
alpha(V), so its rank there is at most b-3. The map beta kills C_M M.
Modulo that image, at most l further top vectors are required beyond
ker C_M. Hence 3=rank beta is at most b-3+l. We conclude
\[
\dim\ker C_M\ge3,\qquad
\dim\ker C_M^2=b+l\ge6.
\]
Over the perfect ground field the same block calculation applies to
the inverse-semilinear Cartier operator. Its stable rank on invariant
forms of an abelian variety is the p-rank, so dim M=dim P-f_5(P).
This proves (4), including all t>=2 by monotonicity.
