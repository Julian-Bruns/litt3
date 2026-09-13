# Etale refinement preserves the entire simultaneous deformation problem

Use the [marked deformation conventions](../../Definitions/marked_curve_deformations.md).
Let f_i:Z→C_i be any finite nonempty collection of actual finite etale
maps, and h:W→Z a connected finite etale cover. Every curve is smooth,
proper, connected, and of genus at least two. There is a natural bijection

    Def((f_i))(A) ≅ Def((f_i h))(A)

for EVERY local Artinian W(k)-algebra A with residue k. No Galois,
prime-to-p, ordinary, or core hypothesis is required. In particular, a
specified diagram lifts over W_n(k) iff its refinement does, at every n.

More generally, for every negative-degree line bundle L on Z,
H^1(Z,L)→H^1(W,h^*L) is injective. The transformation Def(Z)→Def(W)
is a monomorphism, including uniqueness of marked lift isomorphisms.

For two legs put Q=H^1(Z,T_Z)/(f^*H^1(C_1,T_C1)+g^*H^1(C_2,T_C2)).
Refinement injects Q into the corresponding quotient for W. At each
small extension, the obstruction to matching the two lifted sources
maps to its pullback under this injection. Hence a nonzero obstruction
cannot be removed by refining the specified correspondence.

In contrast, cross traces on canonical tensors are multiplied by deg h:
Tr_(gh)(fh)^*=(deg h)Tr_g f^*. Their vanishing after a p-divisible
refinement need not imply vanishing before it. For m>=2 the full trace
H^0(W,omega_W^m)→H^0(Z,omega_Z^m) is nevertheless surjective.

## The entire obstruction lives in the smaller endpoint's deformation space

For two legs, the simultaneous marked deformation functor is represented
by a complete Noetherian local W(k)-algebra R. Each projection to an
endpoint deformation functor is a closed immersion. In particular

    R ≅ W(k)[[t_1,...,t_d]]/I,
    d=dim(f^*H^1(T_X) intersect g^*H^1(T_Y))
      <= min(3g(X)-3,3g(Y)-3).

For a genus-two endpoint at most THREE parameters are needed, independently
of both map degrees and source genus. This bounds the number of parameters,
NOT the number or order of the equations defining I. Refinement preserves R.

The diagram has a simultaneous smooth proper lift, with both maps finite
etale, over a DVR finite over W(k) if and only if p is NOT nilpotent in R.
Thus intrinsic mixed-characteristic nonliftability has a finite certificate
p^e=0 in R for some e. In that case no lift to W_(e+1)(k) exists.
Existence of lifts over W_n(k) for every n, even without initially choosing
them compatibly, therefore implies a mixed-characteristic lift. A failure
over some UNRAMIFIED W_n(k) does not conversely exclude ramified lifts.

More sharply, fix a particular full marked W(k)-lift of ONE endpoint.
The deformation problem with that lift fixed has ring W(k)/(p^e), where
e is a positive integer or infinity (p^infinity means the zero ideal).
Its lifts exist uniquely at precisely the levels n<=e. They are automatically
compatible. For e=infinity they algebraize to a full actual etale span.
If d=0, the same W(k)/(p^e) description holds without fixing an endpoint lift.

This theorem neither supplies a lift nor compares DIFFERENT witnesses
between the same endpoints. In particular it does not extend the
canonical admissible W2 lift to W3 or bound e uniformly. Complete local
rings W(k)[[t_1,t_2,t_3]]/(p^e) show that a three-parameter bound alone
cannot bound e; these are abstract ring examples, not realized spans.

Version2,2026-09-09 adds the small ambient deformation ring, intrinsic
p-nilpotence criterion and fixed-lift height. Version1 rederived the
earlier116 note. Author proof; no independent audit or Lean verification.
[Proof](../../Proofs/deformations/etale_refinement_deformations.md).
