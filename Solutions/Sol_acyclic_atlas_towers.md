# Proof: cyclic torsion lines avoiding the section locus

[Statement](../Theorems/Thm_acyclic_atlas_towers.md).
The construction uses no countable-union avoidance. It chooses an
actual finite cyclic cover for each sufficiently large prime.

## A general genus-two bundle lemma

Let B be ANY vector bundle on a genus-two curve C with H0(C,B)=0.
In the abelian surface J=Pic0(C) its bad locus

    Z={L:H0(C,B tensor L)!=0}

is proper and closed by semicontinuity and misses the origin. Choose
an effective ample divisor D containing Z and a very ample divisor H
on J. Set c=D.H. For every prime ell different from the characteristic,

    #(D intersect J[ell](k)) <= c ell^2.                    (1)

Indeed multiplication by ell is etale. The multiplicity of [ell]_*D
at0 is the sum of the multiplicities of D at all ell-torsion points,
and bounds their number. A general member of |H| through0 bounds this
multiplicity by its intersection with [ell]_*D. The projection formula
and [ell]^*H numerically equivalent to ell^2 H give (1).

The group J[ell](k)=F_ell^4 has ell^3+ell^2+ell+1 one-dimensional
subspaces. Every nonzero torsion point lies on exactly one such line.
For sufficiently large ell, (1) shows that some line has all its
nonzero points outside D. Choose a generator L of this line. The
cyclic etale cover pi associated with L has degree ell and is connected
because L has exact order ell. Its character decomposition gives

    H0(C_ell,pi^*B)=direct_sum_(i=0)^(ell-1) H0(C,B tensor L^i)=0.

The zero character vanishes by hypothesis; all others avoid Z. This
proves the lemma with no special equation for C or B.

## Apply to an actual atlas and retain stability

Take B=V from the genuine Hermitian quotient. Its acyclicity was proved
using the free clock-and-shift group. Composing pi with its actual atlas
gives an actual representable finite etale atlas of C_ell. Pullback
preserves the Frobenius form, determinant and distinguished section;
its normalized quotient is pi^*V. Riemann--Hurwitz gives genus ell+1.

For completeness its required stability does not follow from the false
general assertion that every stable bundle stays stable under etale
pullback. Write V=W theta, where theta^2=omega and W is the dormant
rank-two descent. Pulling back the oper supplies an oper with line
theta_ell=pi^*theta of degree ell and nonzero second fundamental map.
If A were a line subbundle of pi^*W of nonnegative degree, its
horizontal Frobenius pullback could not lie in the oper line: equality
generically would make that line horizontal. Its projection to the
quotient theta_ell^-1 is therefore nonzero, giving

    5 deg A <= -ell <0,

a contradiction. Hence pi^*W, and thus pi^*V, is stable. The canonical
nonsplit extension is also retained: trace composed with pullback on
H1(omega) is multiplication by ell, which is nonzero in characteristic5.
The pulled-back extension can consequently be identified with the
chosen normalized one. These arguments use ell!=5.

Finally ell>=5 implies the p-jet hypothesis of
`cartier_jet_tensor_surjectivity`. Its intrinsic tensor therefore has
full output rank12ell. The same family has H0(pi^*V)=0 by the lemma.
All statements concern actual covers, not just compatible slopes or
formal ramification profiles.
