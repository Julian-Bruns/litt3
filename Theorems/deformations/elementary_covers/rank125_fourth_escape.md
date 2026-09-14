# A genuine rank125 fourth-lift escape and its eight-dimensional fibre

Version1,2026-09-14. Fixed cubic parameter and original marked cover.
This proves W4 existence and a relative W5 reduction, not a W5 lift
or exclusion, a full-tower theorem, or a common-cover theorem.

Use the actual maximal C5^3 cover of the genus-three curve, scalar
Schur coordinates and canonical ordinary-Y reference specified in
[the quadratic-channel proof](../../../Proofs/deformations/elementary_covers/fourth_hodge_quadratic_channel.md).
Thus k0=F5[t]/(t3+t+1), k is its algebraic closure,
R=k[s1,s2,s3]/(s_i5), J=(s1,s2,s3), K=Ann(f), dimK=43.
The scalar H is AFTER coefficient Frobenius in the original scaled
logarithmic deck generators. Retain the actual flat periodicity line,
preceding filtered object, graded maps and source marking throughout.
Write K_d=K intersect J^d and Z4 for the geometric-point locus of H
whose actual X3(H)=X3^0+n(H) admits a compatible fourth extension.

Field codes [m] mean m0+m1*t+m2*t2 for m=m0+5m1+25m2. There exists
an actual completed H* in K, odd in s, such that

    H* in Z4,
    ((H*)5_014,(H*)5_104,(H*)5_113,(H*)5_203)=(0,[101],[14],0).

In particular H* has NONZERO degree-five part. The previously proved
[15-dimensional locus](rank125_fourth_exclusion.md) S15=Z4 intersect K6
is therefore a PROPER subset of Z4. The two particular excluded
positive/reflected high-jet families in that theorem remain excluded.

The construction is explicit RELATIVE TO THE ACTUAL REFERENCE: two
fixed degree-five comparison coefficients determine an odd seed, and
a universally invertible four-by-four relative repair kills whatever
actual terminal obstruction remains. Those reference coefficients
are not chosen to suit the construction. This is not a numerical
coefficient list of the canonical-reference H* over k0.

There is a stronger exact local statement. Define Q(H,V) by symmetric
bilinear polarization, with Q(H,H)=Q(H), in the actual scalar
normalization. Let C denote the first integral product carry in the
original odd logarithms, s_i5/5=-c_i*s_i, c=(3,1,2). On K9,

    L_H*(V)=2 Q(H*,V)-[C(q2 V9)] in R/(f)

is the COMPLETE relative fourth obstruction, is k-linear, and has
rank8 for every value of the actual reference coefficients. Since
dimK9=16,

    Z4 intersect(H*+K9)=H*+ker L_H*

is an eight-dimensional affine scalar family. Every point has the
same nonzero H5 (indeed the same scalar modulo J9) and admits genuine
terminal source and whole regular Hodge repairs. This is an equality
of geometric-point loci; no reducedness assertion about the original
Frobenius-parameter scheme is made.

There is also an exact RELATIVE fifth statement. Put
A4(V)=E4(V)-Q(V). Fix any H in Z4 and any compatible fourth origin
above X3(H). Translating its fourth curve digit by the actual n(V),
V in K, changes its fifth obstruction by

    R_H(V)=A4(V)+2 Q(H,V).

The coordinates V already include the same coefficient-Frobenius
transport as H; no additional Frobenius is applied in this formula.
R_H is additive, not presumed k-linear on the whole K. Its restriction
to K9 is precisely L_H above. Consequently the known eight-dimensional
linear image removes eight fifth-obstruction coordinates on the escape
family. This computes a relative response, not the absolute remaining
fifth obstruction.

There is a sharper result on the odd part F_odd of the escape fibre,
which is a nonempty four-dimensional affine scalar family. Use the
increasing-degree/lex target normal form in R/(f). For every H in F_odd,
the GEOMETRIC relative image on the22-dimensional odd source is exactly

    R_H(K_odd)={E odd: E001=E010=E100=E030+[45]E021=0}.

It is an18-dimensional k-linear subspace even though the whole map
R_H need not be k-linear. Its four separating values are independent
of ALL43 fourth-digit choices. Choosing a tame-invariant fourth origin
makes its absolute fifth class C5(H) odd. Therefore a compatible fifth
extension exists over H if and only if

    theta5(H)=(C5_001,C5_010,C5_100,C5_030+[45]C5_021)=0.

The scalar constant/trace channel is already zero for every fourth
choice over this odd family. These results evaluate the RELATIVE image
and remove that constant channel; they do not evaluate the four
absolute functions theta5. Their geometric common zero set remains
open. Neither a fifth lift on this family nor its nonexistence has been
proved. The rank125 X6-to-given-X3 bootstrap and the unmarked common-cover
problem remain open.

[Proof, reconstruction and independent audits](../../../Proofs/deformations/elementary_covers/rank125_fourth_escape.md).
