# Proof: Bol sections, their theta equations, and Frobenius orbits

[Statement](../../Theorems/projective_connections/backup_dormant_theta_divisors.md).
The explicit equation and smoothness proof came from the third focused
Pro response. The mutual incidence, orbit restrictions and unbounded
torsion consequences below were obtained locally from those equations.
Original source and exact data are retained in the external
[theta package](../../../litt3-computation-data/focused_pro_returns_20260916/theta_package/dormant_theta_divisors/).
The actual stable bundles, their étale functoriality and tangent-space
identification come from the
[Bol complex](dormant_bol_complex.md) and
[tangent-bundle theorem](tangent_bundle_cyclic_refinements.md).

## Four sections and the determinant

Put \(\eta=du/v\), \(H=2u^3+Tu^2+Wu+V\). The actual potential is
\[
r_T=2(F'/F)^2-F''/F+H/F.
\]
Direct substitution gives
\[
(h/F)''-r_T(h/F)=(Fh''-2F'h'-Hh)/F^2.
\]
Consequently \((p+vq)\eta^2\) is horizontal precisely when
\[
\mathscr L(p)=Fp''-2F'p'-Hp=0,\qquad
\mathscr M(q)=Fq''-F'q'+(3F''-H)q=0.
\]
Stability gives \(H^1(\mathcal V_T(2O))=0\); Riemann--Roch then
gives four sections. Projection formula identifies them with these
horizontal quadratics of pole bound \(\omega_Y^2(10O)\). They have
\(\deg p\le7,\deg q\le4\).

Solving these two polynomial systems gives two even sections \(p_0,p_1\),
normalized by \(p_0\) monic of degree four, \(p_1\) monic of degree
seven and with zero degree-four coefficient, and two odd sections
\[
q_0=u^2+2Tu+W,\quad
q_1=u^4+(2a_4-T)u^3+
 [3(2a_4-T)W-2a_2]u-a_1.
\]
The package contains the full even coefficients and reconstructs them
from the displayed systems. Exact multiplication verifies
\[
p_0p_1'-p_0'p_1=3F^2,\qquad
q_0q_1'-q_0'q_1=2F.
\tag{2}
\]
Define \(N_{ij}\) by
\[
N_{ij}(u^5)=2F(p_iq_j'-p_i'q_j)+F'p_iq_j.
\tag{3}
\]
Only powers divisible by five occur. The replacement \(u^5\mapsto x\)
fixes all of K. With
\[
B(x,y)=-N_{00}(x)N_{11}(y)+N_{01}(x)N_{10}(y)
       +N_{10}(x)N_{01}(y)-N_{11}(x)N_{00}(y),
\]
the exact polynomial identity is
\[
B(x,y)=\mathcal F(x,y)+(x-y)^2(A_0+A_1(x+y)+A_2xy).
\tag{4}
\]
The three coefficient rows in the statement are obtained from the
coefficients of \(x^2,x^3,x^3y\) in B, respectively. Independent
Sage arithmetic also checks (2)--(3) in an absolute finite field.

For the dense chart \(L=\mathcal O(P_1+P_2-2O)\), let \(R_i\) be the
hyperelliptic conjugate of \(P_i\). The sequence
\[
0\to\mathcal V_T\otimes L\to\mathcal V_T(2O)
\to\mathcal V_T(2O)|_{R_1}\oplus\mathcal V_T(2O)|_{R_2}\to0
\]
presents its determinant section as a four-by-four evaluation
determinant. Pull back in both point variables by relative Frobenius.
The jet coordinates of the four sections are \((h/F,(h/F)')\),
where \(h=(p_0,p_1,vq_0,vq_1)\). The determinant change from
\((h,h')\) to these coordinates is \(F^{-2}\) at each point.
The two even/odd minors of the former matrix are \(3F^2,2F^2\);
its mixed minors are \(N_{ij}(u^5)/(2v)\). Laplace expansion gives
\[
D=2+\frac{B(x_1,x_2)}{4y_1y_2}
 =-\frac{(x_1-x_2)^2}{y_1y_2}
  (A_0+A_1\kappa_2+A_2\kappa_3+\kappa_4).
\tag{5}
\]
The prefactor is a unit on the chosen chart. Faithful flatness of
relative Frobenius descends this equality of determinant schemes.

## Smoothness and global equality

Set \(s=\kappa_2,p=\kappa_3\) on \(\kappa_1=1\), and put
\[
\ell=A_0+A_1s+A_2p,\quad \Delta=s^2-4p,\quad
P=c_1s+2c_2p+c_3sp+2c_4p^2+sp^2.
\]
Here \(c_0=0,c_5=1\). Write
\[
K_0=c_1^2-2c_1c_3p-4c_1c_4sp-4c_1s^2p
 +(2c_1-4c_2c_4+c_3^2)p^2-4c_2sp^2-2c_3p^3+p^4.
\]
The Kummer equation is
\(\Delta\kappa_4^2-2P\kappa_4+K_0=0\); the plane section is the
homogenization of \(Q=\Delta\ell^2+2P\ell+K_0\).
The original exact certificate supplies and verifies polynomials with
\[
U_0Q+U_1Q_s+U_2Q_p=1.
\tag{6}
\]
Their degrees are 5,6,6 and term counts 18,22,24. For the degree-four
and degree-three homogeneous parts, evaluated at s=1, it also supplies
\(V_0q_4+V_1q_4'+V_2q_3=1\). The remaining infinity point is excluded
by \(Q^{\mathrm h}(0,1,0)=1\). These multiplication certificates,
replayed locally, prove geometric smoothness of the plane quartic.

It avoids the Kummer nodes; its pullback through the quotient by
inversion is therefore a smooth étale double cover. This is an ample
divisor of class \(2\Theta\). A disconnected smooth ample divisor on
an abelian surface would have disjoint components of positive
self-intersection, contradicting Hodge index. Thus the pullback is
geometrically connected and irreducible, and adjunction gives genus five.
The excluded coordinate loci have images of degree at most two or
unions of lines, so do not contain the plane quartic. Hence (5) holds
at the generic point of this irreducible divisor. It occurs with
multiplicity one in the actual determinant divisor. Both have class
\(2\Theta\); an effective residual divisor would have zero intersection
with an ample theta class, so it is zero.

If a fiber of the actual square cohomology matrix had corank at
least two, all first derivatives of its determinant would vanish.
Smoothness of the determinant divisor therefore gives precisely
the section dimensions (1) at every point.

## Mutual intersections and their fields

The local source
[check_backup_dormant_theta.py](../../scripts/genus_two/check_backup_dormant_theta.py)
constructs the field \(\mathbf F_{5^{15}}\) independently of the
returned arithmetic and forms the five plane rows
\((A_0^{125^j},A_1^{125^j},A_2^{125^j},1)\).
Every four rows have rank four. For each of the ten triples the
unique common projective point lies off the Kummer quartic. For each
pair, restriction to its intersection line is an irreducible quartic
over K, with nonzero discriminant. All ten pairs were evaluated; their
exact factor degrees and checks are in
[the incidence record](../../../litt3-computation-data/focused_pro_returns_20260916/theta_incidence.json).
Thus the pairwise intersections on the Kummer surface are four reduced
points and no point lies on three planes. Étale pullback gives eight
transverse points for each pair on the Jacobian, with no repetitions
between pairs.

The same computation checks that each Kummer point lifts already
over the quartic residue extension of K. To see the checked square
class, write a Mumford representative
\((x^2-sx+p,b_1x+b_0)\). The Kummer formula gives
\[
b_1^2=\kappa_4+c_2+c_3s+c_4s^2+s^3-sp.
\tag{7}
\]
This is nonzero and a square in every tested quartic residue field.
Reduction of \(\overline F\) modulo \(x^2-sx+p\) then determines
\(2b_1b_0\), so both lifts are defined over that field. Every lift
has degree four over K since its image does. Frobenius over \(k_0\)
permutes the five theta divisors cyclically. An unordered pair has
orbit length five, and a point determines its pair since there are no
triple intersections. Every one of the eighty points consequently
has degree twenty over \(k_0\), giving four orbits.

## The exact five-primary obstruction at the pair intersections

The pairs have two orbits under their five-cycle: representatives
\(\{0,1\}\) and \(\{0,2\}\). For each representative solve the two
linear theta equations for p and \(\kappa_4\) in terms of s, then
substitute into the Kummer quartic. This gives the irreducible
quartic described above. Its four roots lift to four line classes
and their inverses over \(\mathbf F_{125^{20}}\).

The [finite-field probe](../../scripts/genus_two/theta_exception/torsion_pair_probe.py)
records one actual Mumford divisor D for each of these two pair
types, including the field modulus, embedded \(\alpha,T\), curve,
divisor, and its five-primary multiple. The
[independent verifier](../../scripts/genus_two/theta_exception/verify_torsion_pairs.py)
uses Sage's native Jacobian group, rather than the probe's Cantor
implementation. It checks the actual curve equation, both theta
equations and four distinct Kummer conjugates over the degree-five
field. Their two signs exhaust the eight pair-intersection points.
Its completed checks are
\[
N D=0,\qquad 125D_5=0,\qquad 25D_5\ne0,\qquad
D_5=(N/5^6)D,
\tag{8}
\]
where
\[
N=\operatorname{Res}_X(P(X),X^{20}-1)
 =\#J(C)(\mathbf F_{125^{20}}),\qquad v_5(N)=6.
\]
The two exact records are preserved in
[the external certificate](../../../litt3-computation-data/theta_exception_20260916/torsion_pair_probe.json).
Conjugation and inversion preserve orders. Thus (8) certifies
five-primary order125 for all eighty points, not merely the two
chosen representatives.

A degree-zero line bundle trivialized by a finite étale cover has
prime-to-five order. Indeed, pass to the actual Galois closure of
that one cover; descent of a trivial line is a character into
\(k^*\), whose finite image has prime-to-five order. Conversely
every prime-to-five torsion line has a cyclic étale trivialization.
Equation (8) therefore excludes tame torsion from every pair
intersection.

Now let E have finite étale monodromy and only one-dimensional
simple constituents. Its associated filtration has tame character
lines as quotients. If a test \(H^0(V_i\otimes E)\) is nonzero,
at least one of those character quotients passes that test; this
follows by induction from the cohomology exact sequence. Each
character can pass at most one test, by (8). Passing all five
requires at least five composition factors, hence rank at least
five. This does not assume the representation is semisimple.
The [simultaneous cyclic-refinement theorem](../jacobians/ordinary_covers/prime_avoiding_section_growth.md)
supplies one tame character on each theta curve with pairwise
coprime orders. Their direct sum attains rank five and is
trivialized by a single connected cyclic étale cover.

The same theorem yields simultaneous unbounded section growth:
each smooth connected theta curve of genus five and ample class
\(2\Theta\) generates the whole Jacobian up to translation.
Containment in a translate of a proper positive-dimensional
abelian subvariety would identify it with an elliptic curve.
Apply the theorem to all five actual Bol bundles on \(Y^{(1)}\),
then pull back the character covers by relative Frobenius to Y.
Étale compatibility of the actual Bol bundles identifies the
five growing section spaces with the five growing dormant tangent
spaces. This disproves preservation of at least one rigid
dormant connection on every étale cover.

## Arithmetic exclusion of whole torsion families

If \(L\) is fixed by \(\operatorname{Frob}_{125}^r\), with \(5\nmid r\),
and lies on one theta divisor, Frobenius forces it onto all five.
The empty triple intersections contradict this. This proves the
field-of-definition restriction without any torsion assumption.

Let \(\ell\ne5\), and suppose Frobenius on \(J[\ell]\) has order d
prime to five. Its order on \(J[\ell^a]\) divides
\(d\ell^{a-1}\): the kernel of reduction of general linear groups
is an \(\ell\)-group, of exponent dividing \(\ell^{a-1}\).
Thus every such torsion line is defined over an extension of degree
prime to five. The same holds for mixed torsion at any finite set
of these primes.

For \(\ell=2\), all Weierstrass points are rational, so d=1.
For \(\ell=3\), the known
[Weil polynomial](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md)
is
\[
P(X)=X^4-8X^3+182X^2-1000X+15625.
\]
Modulo three it is \((X^2+2X+2)^2\), which divides \(X^{24}-1\).
Cayley--Hamilton gives \(d\mid24\). The coefficient Frobenius twist
C has the same Weil polynomial and rational branch set. This proves
vanishing on all \(\{2,3\}\)-primary torsion, without extending the
old finite torsion searches.

A prime-to-five abelian cover of C decomposes into its character
lines. If its degree is supported on 2,3, all of their twisted section
spaces vanish. Further five-group covers preserve zero sections:
a nonzero representation of a finite five-group in characteristic
five has nonzero invariants, which would descend to a section below.
For an abelian group supported on 2,3,5 first quotient by its
five-primary subgroup. The same argument applies to an extension
of that abelian group by any five-group. Relative Frobenius transports
these actual covers and the Bol bundles between C and Y.
