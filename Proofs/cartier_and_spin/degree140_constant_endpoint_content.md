# Proof: complete exclusion of higher individual endpoint content

[Statement](../../Theorems/cartier_and_spin/degree140_constant_endpoint_content.md).
The [received report](../../../litt3-computation-data/quartic_complete_partial_replies_20260927/extracted/constant/constant140_endpoint_content/REPORT.md)
contains the full source, exact arrays and useful earlier results.
This integrates the new endpoint theorem and exact exceptional
incidence presentation. The global square problem remains open;
the user subsequently stopped its Pro continuation.

## A complete local necessity, without dividing by a critical coefficient

Translate the source cubic by Z=W-L0(x) and denote its coefficients
by Acal,Bcal,Ccal,Ecal. At any endpoint use tau=t(x) as uniformizer.
The prescribed congruences give
Q-L0^5=tau^3 M with M a unit, Ccal in(tau), and
M Ecal+y^10 in(tau^2). In particular Ecal is a unit.
For the universal fixed-degree resultant set
a=3Acal,b=2Bcal,c=Ccal,d=Ecal. Its scale-quadratic leading
coefficient is (c^5-Qb b^5+Qb^2a^5)^2, with Qb=tau^3 M.
Direct expansion, valid also when a vanishes, yields
\[
D_2/\tau^5=\tau M(p)^2b(p)^{10}\pmod{\tau^2}.
\]
Thus gamma_p>=2 forces Bcal(p)=0. With b,c in(tau), the constant
coefficient is
\[
D_0=\tau^5a(p)^5d(p)^2(Ccal/\tau)(p)^5\pmod{\tau^6}.
\]
Consequently every higher-content point satisfies
\[
Bcal(p)=0,\qquad Acal(p)=0\quad\hbox{or}\quad(Ccal/t)(p)=0.
\tag{1}
\]
The change to the barred resultant and lambda=w mu multiplies
these coefficients by units at p, so it preserves this necessity.

## The six incidence algebras cover every marked point

The three roots r of t have K codes145049,211895,211959. Put
v=y(p)/w, so q=P(r)/v^3 and v!=0. The reconstructed ratio source
has form w U_i+y V_i+(y^2/w^4)Z_i(H,q,x), where Z_i is
affine-linear in H. Clearing only powers of v turns either pair
in(1) into b0(v)+b1(v)H=c0(v)+c1(v)H=0. For each of the six
choices the exact certificate gives
\[
b_1c_0-b_0c_1=c_*v^{12}g(v),\qquad
\deg g=15,\quad g(0)\ne0,\quad
\gcd(g,g')=\gcd(g,b_1)=1.
\]
Thus the ENTIRE incidence algebra is K[v]/g with
H=-b0/b1 and q=P(r)/v^3. All original ratio-open factors are
units there. These are full marked-sheet parameterizations, not
six selected ratio samples or a search for rational points.

## Local norm factorization and the actual square equation

In each degree15 algebra use the three local cubic sheets above
x=r+s. The compact norm has leading orders(5,0,0), and
\[
W(r+s,\mu)=s^5q^2\ell_0(\mu)\ell_1(\mu)\ell_2(\mu)
 \pmod{s^6}.
\tag{2}
\]
For the Ccal/t incidence the scale degrees of these factors are
(0,1,1); for the Acal incidence they are(2,1,1). All extreme
coefficients needed to make them monic are units.

Let L be the residual's nonzero leading x-coefficient and
C71=[T^71](T^140 W(T^-1)/L)^63. It is an actual necessary square
equation. The archive contains an explicit inverse of C71 in each
of the twelve linear factor algebras and the three quadratic
factor algebras from(2). The latter retain repeated roots: no
separability of a scale quadratic is assumed. All inverses are
checked by multiplication, including the defining equations.
A separate formal-root recursion through degree71 recomputes
C71; it agrees with the characteristic-five power circuit.
Hence every ell_j is a unit modulo the full square ideal I.

The following elementary lemma justifies the scheme conclusion.
In any commutative F5 algebra, if the coefficients of j(s)^2
in degrees0..4 vanish, then ([s^5]j(s)^2)^5=0. Indeed write
j=sum a_i s^i. The first equations give a0^2=a0a1=0,
a1^2=-2a0a2, a1a2=-a0a3, and
a2^2=-2a0a4-2a1a3. Thus a1^4=0 and
a2^3=2a0(a3^2-a2a4), whence a2^5=0. Taking fifth powers of
2(a0a5+a1a4+a2a3) proves the assertion.

Modulo all70 original equations W/L is exactly a polynomial
square. Applying the lemma to(2) gives
((q^2/L)ell0 ell1 ell2)^5 in I. All its factors are units
modulo I, so that quotient is zero. This excludes each complete
incidence, including nilpotents. Necessity(1) covers every
geometric higher-content point; a nonempty finite-type thickening
would have a geometric point, so the whole higher-content square
intersection is empty as well.

The individual bound gamma_p<=1 permits total endpoint orders
0,1,2,3. If the total is2 or3, the points contributing it are
distinct. The retained pole-rank theorem allows such multiple
simple content over at most one of the three roots of t.
It does not exclude that case. Common critical zeros elsewhere are
now excluded by [the subsequent theorem](degree140_common_critical_exclusion.md).

## Exact common-critical presentation, with branch points retained

Write the barred functions as g2,g3,g4. From the reconstructed
source U2=k0 P, V2=0 with k0=3794. Set z=Z2 and
\[
\begin{aligned}
A_3&=(U_3-3B_0U_2)/P,&B_3&=V_3/P,&C_3&=(Z_3-3B_0Z_2)/P,\\
A_4&=(U_4-2B_0U_3+3B_0^2U_2)/P^2,
&B_4&=(V_4-2B_0V_3)/P,
&C_4&=(Z_4-2B_0Z_3+3B_0^2Z_2)/P.
\end{aligned}
\]
Every displayed division is exact polynomial division. It does
not localize at P. With v=y/w, qv^3=P, the source identities are
\[
w^4g_2=z+q^2k_0v,\quad
(q/w)g_3=qA_3+qvB_3+v^2C_3,\quad
qg_4=q^2v^2A_4+qB_4+vC_4.
\]
Since q^2k0 is a unit, eliminate v=-z/(q^2k0). The same scheme is
\[
z^3+q^5k_0^3P=0,\quad
C_3z^2-q^3k_0B_3z+q^5k_0^2A_3=0,\quad
A_4z^2-k_0C_4z+q^3k_0^2B_4=0.
\]
The three polynomials have431,391,241 nonzero records and
(H,q,x)-degree bounds(3,15,12),(3,15,11),(2,10,12).
Only q is inverted. In particular P=0, H-coefficient drops and
all singular parameter fibers remain. Additional t!=0 selects
the common-critical component away from endpoints. No emptiness,
dimension or list of points was asserted by this presentation alone.
The subsequent common-critical theorem now determines its full
localized algebra and excludes the square intersection.

## Verification

The complete new verifier verify_endpoint.py passed:14 regenerated
output hashes, six full incidence algebras, all fifteen C71 unit
certificates, coefficient and local-jet checks, independent stored
certificate replay, and the complete1063-record presentation.
Its polynomial identities and finite algebras prove geometric claims;
the separately recorded64 fixtures are only implementation checks.
The source was retained byte-for-byte under
[the source directory](../../scripts/arithmetic/pro_quartic_complete_partials_20260927/constant/).
Run the original verifier in its extracted archive with Python and
SymPy as specified in README. The
[integration audit](../../Research/audits/QUARTIC_COMPLETE_PARTIALS_2026_09_27.md)
records the exact environment and execution scope. Earlier large
source certificates are preserved without redundant replay.
