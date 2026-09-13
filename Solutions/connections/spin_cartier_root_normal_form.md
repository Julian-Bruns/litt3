# Proof: spin roots, their linear equation, and functorial Cartier blocks

[Statement](../../Theorems/connections/spin_cartier_root_normal_form.md).
Author /root,2026-09-08. All roots below are tame, since ell=p+2 is
prime to p. No simultaneous Galois closure of an etale span is used.

## 1. The linear map is always onto

Write F:C->C_1 for relative Frobenius and B=B_C. The exact-differential
description supplies B as a subbundle of F_*omega_C. Hence

    H0(C_1,B L_1^(-1)) -> H0(C,omega_C L^(-p))

is injective, and its target is zero: its line-bundle degree is
(2-p)(g-1)<0. Tensoring the Frobenius sequence
0->O_(C_1)->F_*O_C->B->0 by L_1^(-1) therefore shows that

    H1(C_1,L_1^(-1)) -> H1(C,L^(-p))

is injective. Its Serre-dual map is exactly twisted Cartier
H0(C,omega_C L^p)->H0(C_1,omega_(C_1)L_1), so Cartier is surjective.
This duality can also be checked by the local residue formula defining
Cartier. No semisimplicity, ordinary Jacobian, or genericity is involved.

Both line bundles are nonspecial. Riemann-Roch gives domain dimension
(p+1)(g-1), target dimension2(g-1), and kernel dimension(p-1)(g-1).

## 2. Recovering the spin line from a tensor

Suppose div(s)=2D for a reduced D. Put m=(ell-1)/2 and
L=O(D)omega_C^(-m). The trivialization O(2D)=omega_C^ell supplied by s
gives L^2=omega_C and L^ell=O(D). The section of O(D) with divisor D
therefore gives h in H0(L^ell). Under the spin isomorphism h^2 is s,
up to a nonzero scalar that can be absorbed into the chosen isomorphism
and h. Conversely any spin line and reduced h give such a tensor h^2.
Starting with (L,h), the formula O(D)omega^(-m)=L^(ell-2m)=L recovers
the same line. Thus there is no unrecorded two-torsion ambiguity: all
spin choices are retained. Since p is odd, the set of spin lines is a
torsor for J(C)[2](k), of cardinality2^(2g).

In a local frame l of L with eta_l=l^2, write h=h_l l^ell. Then
s=h_l^2 eta_l^ell. With r=(p+1)/2 and q=(p+3)/2 one has
r*ell=1+p*q. The local coefficient in the eligible Cartier operation is
h_l^(p+1), so its image vanishes iff Cartier(h_l eta_l)=0, using the
Cartier product rule and h_l!=0 as a rational function. This is precisely
the equation defining K(C,L); the transformation of the remaining frame
is that of the target omega_(C_1)L_1. This also follows from the root
calculation in the next paragraph.

## 3. The root curve and exactness

The algebra O_C+L^(-1)+...+L^(-(ell-1)) is locally w^ell=h_l. A simple
zero of h_l gives a smooth totally ramified point of index ell. At all
other points it is finite etale. A valuation of h equal to1 also proves
the generic extension has degree ell, hence the cover is connected.

The local expressions alpha=w^2 pi^*eta_l agree on overlaps: replacing
l by c*l replaces w by c^(-1)w and eta_l by c^2 eta_l. At a branch
point w is a uniformizer, while pi^*eta_l has order ell-1. Thus alpha
has order ell+1; elsewhere it has no zero. This proves its divisor and
the genus formula. Also alpha^ell=h_l^2 pi^*eta_l^ell=pi^*s.
Because gcd(2,ell)=1, adjoining w and adjoining w^2 generate the same
field. Hence this is the canonical tensor-root cover.

Use ell=p+2 to write alpha=h_l*pi^*eta_l/w^p. Cartier gives

    Cartier_A(alpha)=w_1^(-1)*pi_1^*Cartier_C(h_l eta_l),

where w_1 is the corresponding function on A^(1). Separable pullback
on rational differentials is injective, so this vanishes exactly when
h lies in K(C,L). For a one-variable function field over a perfect
field, the kernel of rational Cartier is the space of exact rational
differentials. Thus vanishing means alpha=dH for some H in k(A).
The form alpha is already globally regular; H need not be regular.

## 4. Both etale maps, and core preservation

Suppose f:Z->X and g:Z->Y are finite etale, and f^*s_X=g^*s_Y. Their
reduced divisors agree, say E=f^*D_X=g^*D_Y. The explicit formula of
part2 identifies both pulled-back spin lines with
O_Z(E)omega_Z^(-m), and the sections with its section having divisor E.
The scalar normalizations can be chosen compatibly; their squares are
the specified common tensor. Conversely a compatible spin/section
identification gives equality of their squared tensors.

The root cover of Z with these data is the base change of each endpoint
root cover. It is connected of full degree ell over Z because E is
nonempty and reduced. Both upper maps are therefore finite etale by
base change, and both come from this SAME connected smooth projective
curve. The cyclic generators are compatible; their fixed divisors are
exactly the inverse images of the original reduced supports. The quotient
span is the original one, not a different ramified correspondence.

For the core assertion write F=k(Z), K=k(X), M=k(Y), and F',K',M'
for their root extensions. Both tensors give the SAME F'. Full degree
ell over F implies F and K' are linearly disjoint over K, and F and M'
are linearly disjoint over M. If K intersect M=k and a belongs to
K' intersect M' inside F', its monic minimal polynomial over F is, by
these two disjointness assertions, also its minimal polynomial over K
and over M. Its coefficients therefore belong to k. Algebraic closedness
gives a in k. Conversely a nonconstant element of K intersect M remains
in K' intersect M'. This proves equivalence of corelessness.

## 5. All Cartier blocks on the base curve

Finite duality for the finite flat map pi and the displayed root algebra
give pi_*omega_A=omega_C + sum_(i=1)^(ell-1) omega_C L^i. Concretely
the i-th space is represented by a_l*eta_l/w^i. This description is
regular at the branch point: its order is at least ell-1-i>=0. Away
from the branch locus it is the usual character decomposition, and thus
it determines the whole decomposition. Riemann-Roch gives dimension
(i+1)(g-1) for i>0; the invariant space has dimension g.

Let i' and n be as in the statement. The inequalities1<=i,i'<=p+1
show p*i'-i>=-1. It is divisible by ell, hence n>=0; also n<=p-1.
Since w^ell=h_l,

    a_l*eta_l/w^i = a_l*h_l^n*eta_l/w^(p*i').

Apply Cartier and its product rule. The numerator represents a section
of omega_C L^(p*i')=omega_C F^*(L_1^i'), which proves exactly the stated
twisted block formula. For i=p, one has i'=1,n=0, so part1 applies.
The formulas are intrinsic despite being written in frames; both finite
duality and twisted Cartier commute with etale base change. In a shared
root span the blocks therefore commute with BOTH pulled-back sections.

For p=5 the six triples(i,i',n) are obtained by multiplication by3
modulo7. Their table in the statement follows immediately. Three blocks
have larger domain than target: i=3,5,6, with excess dimensions
(g-1),4(g-1),2(g-1). Add the invariant Cartier kernel of dimension a(C)
to get a(A)>=a(C)+7(g-1).

On the Cartier-bijective part, the six nontrivial character spaces have
equal dimension b because multiplication by3 is one six-cycle modulo7.
The smallest ambient character space has dimension2(g-1). The invariant
bijective part has dimension f_5(C). Thus f_5(A)=f_5(C)+6b with the
stated bounds. This is the elementary eigenspace bound, not a new general
p-rank theorem: compare Bouw, *Quotients of tame fundamental groups of
affine curves*, Lemma3.8 and Corollary3.10
([primary preprint](https://dspace.library.uu.nl/bitstream/handle/1874/2445/961.pdf?isAllowed=y&sequence=1)).

## 6. What this does and does not accomplish

For a fixed curve, this replaces the entire weight(p+2)/double-zero
root search by finitely many spin lines and linear kernels of known
dimension. The zero divisor must still be reduced. No assertion that
every such kernel has a reduced section is needed for completeness.

Under an etale map of degree N, genus-minus-one and all the nontrivial
character dimensions multiply by N. The three forced kernel dimensions
do too. For the actual genus9/genus2 pair, degrees d and8d respectively
give the SAME source genus-minus-one8d and identical ambient bounds.
Consequently the dimension inequalities alone do not contradict the two
legs. Nor does either separately constructed endpoint section identify
their spin lines and sections on an unknown common source. The remaining
condition is an actual common nonzero vector in the two pulled-back
Cartier kernels, with the common spin identification retained. No claim
of a Litt3 counterexample or a proof of the new Pro assertion follows.
