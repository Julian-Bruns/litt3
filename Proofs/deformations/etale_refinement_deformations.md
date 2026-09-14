# Negative cohomology and the simultaneous deformation ring

[Statement](../../Theorems/deformations/etale_refinement_deformations.md).
All deformation functors retain the specified special-fiber markings.

## 1. Etale pullback on negative cohomology

For finite etale h:W->Z, the bundle Q_h=h_*O_W/O_Z becomes trivial
on a finite etale Galois cover trivializing h: it is the quotient of
a permutation representation by its constant subspace. For deg L<0,
pullback to that cover shows H0(Z,L tensor Q_h)=0. The exact sequence

    0->L->h_*h^*L->L tensor Q_h->0

therefore makes H1(Z,L)->H1(W,h^*L) injective. In particular this
applies to L=T_Z, with h^*T_Z=T_W.

Across a small extension with kernel I, differences of curve lifts lie
in H1(T) tensor I, and their marked automorphisms in H0(T) tensor I=0.
Induction on the Artinian base now shows that Def(Z)->Def(W) is a
monomorphism: an isomorphism upstairs kills the downstairs difference
by the injection above, and uniqueness identifies the lifted isomorphism.

Finite etale covers lift uniquely over nilpotent thickenings by
[Stacks, Lemma58.8.3](https://stacks.math.columbia.edu/tag/0BQB).
Thus Def((f_i)) is the fiber product of the endpoint functors Def(C_i)
over Def(Z). Replacing Def(Z) by Def(W) leaves this fiber product
unchanged because the intervening map is a monomorphism. This proves
refinement invariance for every finite nonempty collection of legs.

For two legs write a=h^*:H1(T_Z)->H1(T_W). The refined endpoint
subspace is exactly a(f^*H1(T_X)+g^*H1(T_Y)). Hence a also injects the
quotient obstruction spaces. An obstruction is the difference of the
two separately lifted sources modulo endpoint deformation directions;
pullback takes this difference to its refined counterpart.

Transitivity of trace and the projection formula give
Tr_(gh)(fh)^*=(deg h)Tr_g f^*. For m>=2, duality identifies the dual
of the full m-canonical trace with the injective H1 pullback for
omega_Z^(1-m). Thus that full trace is surjective even when p divides
deg h.

## 2. A closed intersection of endpoint deformation spaces

For a smooth proper genus>=2 curve C, the groups H0(T_C)=H2(T_C)=0
give the universal ring

    R_C=W(k)[[t_1,...,t_(3g(C)-3)]].

The map R_Z->R_C induced by a specified etale cover is surjective:
its relative cotangent map is surjective by Section1, and complete
Nakayama (successive approximation together with p) gives surjectivity
of the ring map. Write I_X,I_Y for the two kernels. Then

    R=R_X completed-tensor_(R_Z) R_Y=R_Z/(I_X+I_Y).

In particular both endpoint projections are closed immersions.
Its tangent space is the intersection of the two endpoint tangent
spaces in H1(T_Z). Lifting a basis of its d-dimensional relative
cotangent space gives R=W(k)[[t_1,...,t_d]]/I. Refinement preserves
this ring because it preserves its represented functor.

## 3. Mixed-characteristic points and the exact fixed-endpoint height

We use the following consequence of Cohen normalization. For any
complete Noetherian local W(k)-algebra R with residue k,

    p is not nilpotent in R
      iff R has a local W(k)-map to a finite DVR extension of W(k).   (1)

Only the forward implication needs proof. Choose a prime P avoiding p,
put B=R/P and Lambda=W(k). Applying
[Stacks, Lemma10.160.11, CaseII](https://stacks.math.columbia.edu/tag/032D)
with this coefficient ring gives a finite inclusion
R0=Lambda[[X1,...,Xd]] into B. By lying over, choose a prime Q of B
over (X1,...,Xd). Then B/Q is a finite torsion-free Lambda-algebra
and a domain. Its normalization is a complete DVR finite over Lambda,
with residue k, and receives the desired map from R. Finiteness and
the DVR assertion follow from
[Stacks, Lemma33.41.2](https://stacks.math.columbia.edu/tag/0C44)
for the complete one-dimensional Nagata domain B/Q.

Compatible curve deformations over that DVR algebraize using their
ample relative canonical bundles and
[Stacks, Lemma99.14.11](https://stacks.math.columbia.edu/tag/0D4T).
Formal full faithfulness algebraizes the map graphs and their shared
source identifications. Smoothness and finite etaleness extend from the
formal completion to the whole proper curves. Thus (1) is precisely
the stated existence criterion for an actual simultaneous DVR lift.

If p^e=0 in R, a W_(e+1)(k)-point is impossible. Consequently points
over every W_n imply (1), even if the given points were not chosen
compatibly. The converse unramified assertion fails: W(k)[[t]]/(t²-p)
has a ramified DVR point but no W2 point with t=0 on the special fiber.

Finally fix a full endpoint lift R_X->W(k). Its diagram functor has ring

    R completed-tensor_(R_X) W(k)=W(k)/J,

since R_X->R is surjective. The ideal J is (p^e) or zero. This quotient
has a unique W(k)-map to W_n exactly when n<=e, so these lifts are
automatically compatible. For J=0 they algebraize as above. When d=0,
R itself is a quotient of W(k), giving the same conclusion without
fixing an endpoint. None of these arguments bounds e as the span varies.
