# Proof: negative cohomology separates marked lifts

[Statement](../Theorems/Thm_etale_refinement_deformations.md).
Author /root, rechecked2026-09-09; incorporates the2026-09-05 proof.

For finite etale h:W→Z, the quotient Q_h=h_*O_W/O_Z is locally free
and becomes trivial after a finite etale Galois cover of Z trivializing
h. This is descent of a permutation representation, not semisimplicity.
If deg L<0, a section of L⊗Q_h pulls back to a tuple of sections of
negative line bundles and is zero. Thus H^0(Z,L⊗Q_h)=0. Tensoring
0→O_Z→h_*O_W→Q_h→0 with L and using projection formula proves
the claimed injection on H^1. In particular h^*T_Z=T_W gives an
injection a_h:H^1(Z,T_Z)→H^1(W,T_W).

We recall the elementary marked deformation argument. Across a small
extension A→A_0 with kernel I killed by the maximal ideal, differences
between two lifts of a fixed smooth curve lie in H^1(T)⊗I; differences
between marked isomorphisms lie in H^0(T)⊗I. One obtains this directly
by choosing local smooth lifts: their transition differences are
derivations, forming a Cech1-cocycle, with changes of identifications
giving coboundaries. For genus>=2, H^0(T)=0, so marked isomorphisms
are unique. Lifting a fixed etale cover pulls back those derivations.

Induct on the length of A. If two marked Z-lifts induce isomorphic
W-lifts, their reductions over A_0 are uniquely isomorphic by induction.
Their difference δ in H^1(Z,T_Z)⊗I maps to zero under a_h. Injectivity
makes δ=0. The resulting Z-isomorphism induces the given W-isomorphism
by uniqueness. Hence Def(Z)→Def(W) is a monomorphism over every A.

Finite etale covers lift uniquely through a nilpotent thickening.
Therefore Def((f_i)) is the fiber product of the Def(C_i) over Def(Z),
with maps induced by lifting the specified covers. Replacing the middle
functor Def(Z) by Def(W) leaves this fiber product unchanged because
Def(Z)→Def(W) is a monomorphism. This proves the simultaneous statement
and its compatibility under base change. This concerns actual marked
maps, not merely equal abstract source isomorphism classes.

For two legs the refined denominator in H^1(W,T_W) is exactly a_h
of the original denominator. Thus a_h induces the asserted quotient
injection. Choosing separate endpoint lifts across a small extension,
their source difference pulls back to the refined difference. Modulo
the endpoint deformation directions this is precisely functoriality
of the obstruction class. An obstruction already nonzero cannot vanish
after refinement. This argument applies at every fixed lower-order
diagram; no choice of a canonical higher lift is assumed.

Finally transitivity and projection formula give
Tr_(gh)(fh)^*=(deg h)Tr_g f^*. For m>=2, Serre duality identifies the
dual of the full m-canonical trace with the injective pullback on
H^1(omega_Z^(1-m)). This line has negative degree, proving surjectivity.
For m=1 that negative-degree argument is unavailable.

## The small formal ambient space and the lifting height

For a smooth proper curve C of genus>=2 the marked deformation functor
has universal ring R_C=W(k)[[t_1,...,t_(3g(C)-3)]]. Indeed the local
Cech construction above has automorphisms H^0(T_C)=0, tangent space
H^1(T_C), and obstructions H^2(T_C)=0. Riemann--Roch gives the displayed
tangent dimension. Equivalently use an etale chart of the smooth moduli
stack of curves, completed with the prescribed special-fiber marking.
The markings remove automorphisms of C not inducing the identity.

Lifting f:X<-Z induces R_Z→R_X. Its map of relative cotangent spaces is
surjective, by the negative-cohomology injection already proved. This
implies the ring map is surjective: select in R_Z lifts of a relative
cotangent basis of R_X; together with p their images topologically
generate the maximal ideal of R_X. Successive approximation in powers
of that ideal, followed by completeness, gives surjectivity. The same
argument applies to R_Z→R_Y. Write their kernels I_X,I_Y. The marked
fiber product therefore has ring

    R=R_X completed-tensor_(R_Z) R_Y=R_Z/(I_X+I_Y).

It is a quotient of BOTH endpoint rings. Its relative tangent space is
exactly the intersection of their injected tangent spaces in H^1(T_Z).
Choosing d lifts of a relative cotangent basis gives the asserted
presentation over W(k). This also proves the closed-immersion claim,
not just a dimension estimate. The functorial refinement isomorphism
already proved identifies the representing rings.

Here is the commutative-algebra argument for the intrinsic criterion;
we include it to avoid an unjustified compactness assertion about
unbounded finite-field points. A map R→O to a mixed-characteristic DVR
obviously precludes p-nilpotence. Conversely, suppose p is not nilpotent.
Choose a prime P of R avoiding p and set B=R/P, a complete local domain
of dimension D>=1. Complete p to a system of parameters p,x_2,...,x_D
of B. Some prime Q minimal over (x_2,...,x_D) avoids p: otherwise that
ideal would have maximal-ideal radical, contrary to the height theorem
for an ideal generated by D-1 elements. The complete domain B/Q has
dimension one, since p is a parameter there and is nonzero.

Put B_1=B/Q. Its p-adic and maximal-ideal topologies agree, and B_1/p
is finite-dimensional over k. Lift a k-basis of B_1/p and use successive
p-adic approximation: these lifts generate B_1 as a W(k)-module.
Thus B_1 is a finite torsion-free W(k)-algebra. The integral closure O
of W(k) in Frac(B_1) is finite and is a complete DVR (choose a local
factor if necessary), with residue k. It contains B_1 and gives
R→O. This is the elementary one-dimensional curve-selection step;
finiteness of normalization uses that complete DVRs are excellent.
See [Stacks, normalization in dimension one](https://stacks.math.columbia.edu/tag/0C44)
and [complete local rings and excellence](https://stacks.math.columbia.edu/tag/0BGJ).

The induced compatible formal curves over O algebraize: use their
compatible ample relative canonical bundles in
[Stacks, formal effectiveness](https://stacks.math.columbia.edu/tag/0D4T).
Smoothness holds everywhere because the non-smooth locus is closed in a
proper scheme over a local base and misses the special fiber. The fixed
finite etale covers of either endpoint lift over O by proper henselian
invariance of finite etale covers. Their source identifications agree
at every infinitesimal level; formal existence/full faithfulness
algebraizes these identifications. Hence the resulting BOTH maps are
finite etale on the SAME smooth proper source. Alternatively algebraize
the graphs of the compatible formal maps.

If no such lift exists, p is nilpotent in R, so p^e=0 for some finite e.
A W_(e+1)(k)-point is then impossible, since p^e is nonzero in that
ring. Conversely, points over all W_n force p to be nonnilpotent and
the preceding construction gives a possibly ramified DVR lift. No
compatibility of the initially chosen points was needed for this
implication. Do not reverse the unramified test: the abstract ring
W(k)[[t]]/(t^2-p) has a ramified DVR point but no W_2(k)-point reducing
t to zero.

Finally fix a full lift of X, a continuous map R_X→W(k). The constrained
diagram functor has ring R completed-tensor_(R_X) W(k). Since R_X→R is
surjective, this is a quotient W(k)/J. Every proper ideal J of W(k) is
(p^e) or zero. There is precisely one W(k)-algebra map from this quotient
to W_n(k) when n<=e, and none otherwise. Uniqueness forces all these
marked diagram lifts to be compatible; if e=infinity, algebraize as
above. When d=0, R itself is a quotient of W(k), giving the last claim.

None of this bounds the ideal I or its p-nilpotence exponent as the
specified cover varies. Nor does it show that a canonical W2 point
extends even one further step. Refinement invariance, bounded ambient
dimension, and the missing higher-level existence are distinct facts.
