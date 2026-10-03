# Proof: the intrinsic extension pencil and the full atlas criterion

[Statement](../../Theorems/atlases/rank_two_extension_pencil.md).

## 1. The extension class and its annihilator

For nowhere-zero u the exact sequence in the definition gives, since
H0(W L^-1)=0 by stability and negative slope,

    0 -> k --eta_u--> H1(L^-2) --u--> H1(W L^-1).

Thus its kernel is the nonzero line k eta_u. Serre duality identifies
the transpose map with determinant multiplication M_u:B->H, up to the
irrelevant fixed overall sign of the determinant convention. Its kernel
is u H0(omega). Riemann--Roch and stability give the stated dimensions.
This proves the rank formula without any semisimplicity or characteristic
assumption.

For a general nonzero u with zero divisor D, any w with det(u,w)=0 is
a rational multiple u h. Regularity at points where u vanishes allows
precisely the poles of D for the differential h. Therefore

    ker M_u = u H0(omega(D)).

If D=0 this space has dimension g. If D>0 it has dimension g+deg D-1,
by Riemann--Roch and H0(O(-D))=0. In particular deg D=1 does not lower
the rank. Every length-two divisor imposes four independent conditions
on H0(W L): H1(W L(-D))=0 because its Serre dual has stable negative
slope2g-ell<0. The incidence variety over Sym^2 C therefore has image
of codimension at least2. Outside that image the pencil has generic rank.

## 2. Degree of the primitive kernel

On P=P(A) outside the codimension-two rank-drop locus, multiplication
by the universal u gives an exact complex of vector bundles

    0 -> H0(omega) tensor O_P(-1) -> B tensor O_P
      -> H tensor O_P(1) -> Q -> 0,                         (2)

where Q is a line bundle. Determinants give

    Q = O_P(dim H-g)=O_P(2ell-1)

on this open subset. Dualizing and twisting by O_P(1), the kernel
line of the transposed matrix N_u has class O_P(-(2ell-2)).

Line bundles and morphisms between locally free sheaves extend uniquely
across codimension at least2 on the smooth projective space, with the
extension of the line bundle given by its reflexive hull. Consequently
the kernel inclusion extends to a nonzero polynomial vector

    O_P(-(2ell-2)) -> E tensor O_P.

Its entries cannot have a common divisor: any such divisor meets the
generic-rank open subset, where it would make a line-subbundle inclusion
vanish. Hence the vector is primitive, has exactly the stated homogeneous
degree, and is unique up to a scalar. This proves existence without
expanding gigantic maximal minors or assuming a particular pivot stays
nonzero. On the generic-rank locus the inclusion is nonvanishing.

Equivalently, primitive specialization can be checked algebraically.
Locally where a rank-(dim E-1) minor is a unit, the kernel has a generator
v with a unit coordinate. Any polynomial kernel vector is h v there.
If a primitive vector vanished at this point, h would be a nonunit;
in the regular local ring it would have a height-one divisor dividing
all entries, hence a common global polynomial factor. This is impossible.

## 3. Scalar realization and the whole tensor comparison

For g=9,L=O(24O), horizontal sections of W(nO) are represented
Frobenius-semilinearly by scalar solutions in L((5n-8)O).
Thus H0(W40) is S_40 and has dimension64 by stability and
Riemann--Roch. The horizontal determinant is the Wronskian.
It represents the fifth power of a section of O(64O);
its expansion in the56 monomial fifth powers is unique.
The residue matrix S pairs P48 with H0(O64)theta and is
invertible by Serre duality. Its annihilator equations become
N_U eta^[5]=0 after taking fifth powers. This also proves
linearity in U. Coefficient Frobenius preserves the primitive
degree2*24-2=46.

The later [Bol projection](dormant_differential_projection.md) uses
the intrinsic inclusion W(-24O)->F_*O(-128O). Its quotient embeds
in F_*O(-96O), which has no global sections, so its H1 map is
a fixed injection from dimension64 to dimension136.
The cup product has scalar representative U eta^5.
Consequently the principal-part tensor is J_0 N_U for that ONE
fixed injection, before kernels or decomposable points are taken.
A k-linear injection splits and stays injective over every
coefficient algebra. The64-row pencil therefore replaces the136-row
pencil on every stratum, including all coupled tensor restrictions.

For an admissible U, the general extension argument gives a
one-dimensional kernel and rank55. Admissible sections form a dense
open: W24 is globally generated and a zero at a given point imposes
two conditions while the curve has dimension one.
Thus all56-column minors vanish identically and rank N_U<=55
everywhere. No rank-one claim is made on invalid directions.

## 4. Elimination of the complement, without losing infinity

The [direct Wronskian criterion](direct_wronskian_atlas.md) is reused.
Normalize its actual extension representative to eta=rho48(eta).
Subtracting an affine h in L17 changes T by U h^5 and leaves both
Wronskian and residual unchanged. A local change t48g changes the
residual only by valuation-at-least48 terms, by that criterion's
local gauge calculation. Hence
\[
T=-\operatorname{aff}(U\eta^5),\qquad
\operatorname{val}_O\operatorname{rem}(U\eta^5)\ge128.
\]
The whole tensor comparison makes the latter condition exactly
N_U eta^[5]=0, and substitution gives the displayed R_U.
This proves necessity with the original quotient direction.

Conversely let U have pole111 or112 and N_U eta^[5]=0.
The fixed injection gives the principal-part condition, so the
same T and V=rem(U eta^5) satisfy T in L197 and val V>=128.
The rational U eta^5 is horizontal, whence
(delta^2-P)T=(delta^2-P)V. The left side is affine; the right
side has valuation at least94, so both are zero.
Thus T belongs to S_T.

Wh(U,T)=Wh(U,V) is affine and has valuation at least128-pole(U)-17.
On the112 chart its possible pole has coefficient
(128+112)*3=0; on the111 chart there is no possible pole.
It is therefore constant. If it is1, the direct criterion's
regular determinant-one basis and gluing apply, even when val V=128.
The last equation R_U eta^[5]=eta is exactly its remaining test.
Every operation is fixed linear reduction, multiplication by U
or a fifth power, so the claimed polynomial degrees follow.

The Wronskian functional is nonzero on the admissible kernel line.
Indeed if it vanished, T/U=h^5. Since U and delta U have no common
finite zero, h is affine, with pole at most17. The bound on V gives
val(eta+h)>=ceil((128+pole U)/5)=48.
The unique P48 representative of that class is eta=0.
The functional is thus injective on the already known nonzero
one-dimensional kernel; normalize its value to1.

## 5. The smaller projective Frobenius test

Choose the normalized eta and put e=eta^[5], spanning ker N_U.
The direct criterion's observations are R_Ue and eta.
The equation N_U^[1/5] R_Ue=0 is equivalent to
N_U(R_Ue)^[5]=0, hence to proportionality of R_Ue and eta.
Requiring nonzero output gives precisely the direct theorem's
three-scale criterion. The first64-row block already has rank55,
so the stacked128-row matrix has rank55 or56.
With U=sum u_i^5 U_i its fifth-root block is sum u_i N_(U_i)^[1/5]
and R_U=sum u_i^5 R_(U_i), giving degrees5 and6.

The stronger later gradient theorem is an application downstream,
not an input to this proof. All actual directions and both charts
remain; neither a generic minor nor a sampled kernel replaces them.

## Evidence, literature and scope

The old five-direction principal-part/dual-pencil comparisons are
superseded by the intrinsic whole tensor identity. Their original
receipts and sources remain externally in
[the provenance archive](../../../litt3-computation-data/archive_cleanup_20260930/wronskian_tensor_before_hindsight/).
Necessary fixed-oper coordinates and residue constructors for the
remaining exact tensor certificates are in
[the shared section context](../../scripts/atlases/wronskian_section_context.sage).
It contains no obsolete sample-comparison algorithm.

The degree formula has a close complex-characteristic predecessor:
[Thaddeus, Proposition5.5(iii)](https://arxiv.org/pdf/alg-geom/9210007)
restricts the extension hyperplane with degree d-2 on a fixed
stable bundle's section fiber, d=2ell. The direct determinant
argument above retains every characteristic and generic-rank stratum.
It does not claim this degree is new, exclude an atlas, or solve
either unmarked common-cover problem.
