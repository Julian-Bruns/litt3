# Proof: the extension pencil and its characteristic-free degree

[Statement](../Theorems/Thm_rank_two_extension_pencil.md).

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

## 3. Scalar Frobenius realization on the fixed curve

Now g=9 and L=O(24O). The scalar solution realization sends sections
of W(nO) to solutions in L((5n-8)O), semilinearly by Frobenius.
Thus u is represented by U in S_U, and B=H0(W(40O)) by S_40.
The determinant of two horizontal columns is

    Wh(U,T)=U delta T-T delta U.

It has zero derivative. It represents the fifth power of the determinant
section in H0(O(64O)); in particular it lies in the span of the56
monomial fifth powers m_l^5. These are linearly independent, so the
coefficients c_(j,l)(U) exist uniquely and are linear in U.

The residue pairing between P48 and H0(O(64O)) theta is perfect by
Serre duality. It is computed by Res_O(ell_i m_l theta); a possible
global sign convention has no effect on its annihilator. For an extension
coordinate vector eta the annihilator equation for the j-th determinant
section is

    sum_(i,l) eta_i c_(j,l)(U)^(1/5) S_(i,l)=0.

Taking fifth powers gives precisely Ntilde_U eta^[5]=0 with (1).
The original136-row matrix and this64-row matrix both have as kernel
the fifth power of the same extension line on the admissible locus.
This proves their equality of kernels without relying on the examples.

Entrywise Frobenius identifies the polynomial pencil in u with the
polynomial pencil in its Frobenius coordinates U, preserving polynomial
degrees. Hence the primitive kernel degree is2*24-2=46 in those coordinates.
The fixed-curve script `wronskian_serre_dual.sage` verifies all320
Wronskian expansions across five samples, the pairing rank56, and both
kernel spaces exactly. Its results are in computations/wronskian_serre_dual.json.

This theorem identifies a structured extension-space map. It does not
prove that the second Frobenius matrix R_U fails to preserve its kernel
at every admissible point; that is still the atlas obstruction to solve.

## Literature placement

The degree formula has a close predecessor in Thaddeus, Proposition5.5(iii):
the extension-space hyperplane restricts with degree d-2 on a fixed stable
bundle's section fibre, where d=2ell. His proof uses the universal bundle
and determinant of cohomology. The paper is written over C (and explicitly
expects Section5 to extend); our argument above establishes the needed
statement directly in any characteristic and identifies its matrix kernel.
[Primary source](https://arxiv.org/pdf/alg-geom/9210007), Sections5.1,5.4,5.5.
This is an adaptation of established extension-space geometry, not a claim
that degree46 itself is a newly discovered phenomenon.
