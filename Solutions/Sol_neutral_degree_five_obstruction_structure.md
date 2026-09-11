# Proof: canonical defect polarization, neutral trace and regular lattices

[Statement](../Theorems/Thm_neutral_degree_five_obstruction_structure.md).
Returned Pro partial result, integrated by /root2026-09-11. Focused
audit /root/audit_n5_returned_partial PASS2026-09-10. The original(N5)
request remains unresolved; the supplied exact checks certify local
and finite algebra only.

## 1. The actual bundle, not a replacement defect model

The established higher Hodge first variation is induced by inverse
Cartier on the maximal Higgs field and projection to the normal line.
This is [LSYZ, Theorem6.2](https://arxiv.org/html/1404.0538v2#S6.Thm2).
The normal line is T_S; the actual flat periodicity twist cancels only
in this Hom line. Normal projection of the horizontal p-curvature
therefore gives j_r:T_(S^(1))→F_*T_S inducing psi_S.

In an oper coordinate z put D_r(v)=v'''−4rv'−2r'v. A horizontal
trace-zero adjoint matrix [[a,b],[c,−a]] satisfies

                 a=−c'/2, b=rc−c''/2, D_r(c)=0.

Every such section commutes with p-curvature. Active admissibility makes
its nilpotent centralizer a line, identified by p-curvature with
F*T_(S^(1)). Thus ker(F_*D_r)=im(j_r). At a zero of its lower entry c,
nilpotence gives a=0, hence c'=0; nonzero p-curvature then gives b≠0
and c''≠0. The zero has order2<5. This makes its coordinate vector in
F_*T primitive. Consequently A:=coker(j_r) is locally free of rank4.

Define beta(u,v)=Car(u D_r(v) dz). The identity

 uD_r(v)+vD_r(u)=(uv''−u'v'+u''v−4ruv)'

and Cartier's vanishing on exact forms make beta alternating. Its
matrix on the Frobenius fiber with basis1,z,z²,z³,z⁴ is

    [ 0, −2r4, r3, −r2, 2r1 ]
    [ 2r4, 0, −2r2, r1, −r0 ]
    [ −r3, 2r2, 0, −2r0, 0 ]
    [ r2, −r1, 2r0, 0, −1 ]
    [ −2r1, r0, 0, 1, 0 ].

Here r=sum r_i z^i modulo z^5. Its five signed maximal Pfaffians are
twice the coefficients of c=r²+3r''. Admissibility makes that vector
primitive, as above. Hence beta has rank4 everywhere and descends to a
perfect omega_(S^(1))-valued alternating form on A.

To identify A with the EXISTING canonical-double E_r, rather than
merely identify dimensions, use Frobenius duality:

       (F_*T_S)^dual tensor omega_(S^(1))≅F_*omega_S².

The dual of j_r is v↦Car(c v dz); A^dual tensor omega is its kernel.
In the scalar conventions of the library,

       s=(r''−3r²)/3,             c=−s.

This minus sign is a convention conversion, not a new coefficient
correction. The [canonical-double factorization](Sol_etale_double_dormant_pairs.md),
Section2, gives dDelta_r(v)=D^4(sv). Its kernel is exactly the kernel of
Car(sv dz), hence is the canonical E_r, including the split-double
case. The preceding perfect form identifies A with that kernel.
All these maps commute with actual etale pullback and relative
Frobenius, so the induced pairing on E_r is etale-natural.

The degree of F_*T is2(g−1). Subtracting deg(T_(S^(1)))=−2(g−1)
gives deg E_r=4(g−1). Negative tangent bundles have no sections; the
exact sequence gives H0(E_r)=K_S and H1(E_r)=O_S. Polarized Serre
duality identifies O_S with K_S^dual. It pairs two different spaces;
it does not imply evenness of arbitrary d_S.

## 2. The neutral trace and the relative obstruction

Etale base change gives E_(r_T)=h^(1)*E_(r_C). Pullback of sections is
injective. Equal defect makes it surjective as well. Every upper
section is consequently h*s for a lower section s, and

                         Tr_h(h*s)=5s=0.

Serre duality, using the natural polarization, identifies pullback on
H1(E) with the dual of this trace. Therefore h*:O_C→O_T is zero.
The same calculation at neutral degree prime to5 gives an isomorphism,
which is the distinction used by the earlier prime-to-five descent.

Pullback on H1(T) is injective for each individual finite etale map.
Indeed pass to its individual Galois closure and use Cartan–Leray with
H0 of the upper tangent line zero. This requires no simultaneous
Galois closure for a correspondence. The snake sequence for the
quotient Hodge map is now

 0→K_C→K_T→K_Q→O_C→O_T→O_Q→0.

Its first nonzero map is an isomorphism; its map O_C→O_T is zero.
Thus K_Q≅O_C and O_Q≅O_T, both of dimension d.

For a compatible previous descended tuple, the usual next Hodge
obstruction class pulls back by this zero map. The upper primary
equation therefore has a repair even when the lower class is nonzero.
If a compatible lower next lift exists, differences of compatible
upper next lifts lie in K_T=h*K_C, and descend uniquely. This is only
a one-step statement: an arbitrary repaired upper lift has not been
shown to continue through a full tower.

## 3. The actual individual-closure lattices

Let q:Z→C be the individual Galois closure, with G⊂S5 and point
stabilizer H, |H| prime to5. Put N=3g(C)−3 and M=H1(Z,T_Z).
For every subgroup K⊂G, the Cartan–Leray spectral sequence has only
the q=1 row, since H0(Z,T_Z)=0. The quotient is a curve, so
H^i(K,M)=0 for i>0. Restriction to the cyclic Sylow five-subgroup
is free; induction and its prime-to-five index make M projective
over k[G].

For a simple k[G]-module S, equivariant Serre duality and descent give

     Hom_G(M,S)≅H0(C,omega_C² tensor E_S),

where E_S is its finite-etale-trivialized associated bundle. Its
degree is zero. The dual H1 vanishes: a section of T_C tensor E_S^dual
pulls back injectively to a direct sum of negative tangent lines on Z.
Riemann–Roch gives dimension N dim S. These are exactly the
multiplicities of projective covers in k[G]^N. Hence M≅k[G]^N.

Choose any smooth proper lower W-reference and lift the actual etale
cover. Tangent cohomology is W-free and commutes with reduction.
Lifting the images of a regular module basis gives a W[G]-linear
surjection W[G]^N→H1(Z_W,T_(Z_W/W)); equal W-ranks make it an
isomorphism. Reduction gives the statement at every finite Witt level.

On a pulled-back two-affine cover the negative Cech complex is

              0→C0 --delta→ C1 →H1→0.

Projectivity supplies an integral G-linear section of its last map.
The inverse of delta on boundaries is G-linear because delta is
injective. Relative Frobenius twists retain their own coefficient
transport. None of this chooses a compatible lower periodic extension.

## 4. Why these results do not decide N5

The exact regular norm test survives the new lattice condition. For
Lambda=W[S5], H=S4 and e_H=N_H/24, the summand Lambda e_H is the
five-letter permutation lattice. The integral equivariant operator

                 L=I−R_(e_H)+(1/24)R_(N_G)

is the all-ones norm J on that summand and the identity on its
complement. Modulo5 it has kernel U (augmentation of dimension4) and
cokernel P/k1≅U^dual. It is self-adjoint for the regular coefficient
pairing. The nonconstant H-fixed vector N_G−5N_H is killed integrally;
its25multiple is G-fixed through W3 but not W4. Coefficient Frobenius
does not change this conclusion.

Thus regularity and the cohomological duality alone do not exclude a
primitive surviving mode. No actual oper, Cartier-polarized complex or
compatible full tower realizing this operator has been constructed.
The missing datum is its actual higher divided normal residual and
coupling to other blocks. The old cyclic odd-defect growth theorem is
stronger than the returned cyclic-evenness observation and is retained.

The [supplied finite verification](../scripts/verify_neutral_degree_five_structure.py)
replays Bol skew-adjointness, all five
Pfaffians, regular S5/H invariant dimensions and the integral mode in
less than one second under SagePython. It is not geometric existence
evidence. [Scoped audit](../Research/audits/N5_RETURNED_PARTIAL_AUDIT_2026_09_10.md):
PASS,2026-09-10, /root/audit_n5_returned_partial; no(N5) verdict.
