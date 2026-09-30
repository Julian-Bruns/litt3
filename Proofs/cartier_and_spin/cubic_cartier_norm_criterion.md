# Proof of the open-family norm criterion

This is a family in which the general
[primitive trace-jet criterion](primitive_trace_jet_criterion.md) can be
checked by two small endpoint determinants.

The local argument of
[the fixed-endpoint norm proof](uniform_admissible_norm.md) uses no
arithmetic property of its coefficients except the two stated matrix
conditions. Here are the points needed to transport it to varying
coefficients; in particular coefficient Frobenius must not be omitted.

The smooth curve X has genus nine, with ord_O(x)=-3 and ord_O(y)=-10.
The exactness and degrees give df=A^2 theta and pole order seven for f.
It has cubic character zeta, so f=t^-7 times a unit in k[[t^3]],
where t=x^3/y. Thus every actual logarithmic norm in the statement
has no constant dt coefficient, by precisely the selected/unselected
valuation argument. This uses unramified local trace as a sum and never divides
by the degree. Its poles are simple and supported on R.

On W=H0(omega_X(R)), Cartier interchanges U and V and preserves
the rational character space {H(x)dx/A:deg H<=3}. If omega is
Cartier-fixed, its V-coordinate v satisfies v^[25]=Tv. The absence
of its constant infinity coefficient is lv=0. Induction gives
l_i v=0 with l_(i+1)=l_i^[25]T. The first condition kills v; the
fixed-point equation then kills its U-coordinate. Therefore
omega=H(x)dx/A with deg H<=3.

At each finite root alpha of A, the selected q-germs have the
same cubic and quartic terms because their differences are fifth
powers. The logarithmic norm has constant coefficient equal to
one quarter of its residue times P'/P+A''/A'. Unselected germs
contribute neither residue nor constant coefficient. Expressing
this in terms of H gives
4PA'H'-3PA''H-P'A'H=0 modulo A. The second condition kills H.
Hence the logarithmic norm vanishes and the norm is a fifth power.

Finally the hypotheses genuinely define an open subfamily. If D_1
and D_2 denote the matrices of the two Cartier character maps, their
entries are fifth roots of polynomial coefficient expressions.
Since B=D_1 D_2^[1/5],
\[
T=B^{[25]}=D_1^{[25]}D_2^{[5]}
\]
has polynomial entries in the coefficients of P and A. Every row
l_i and its determinant therefore has polynomial entries too. The
second determinant is regular after inverting the leading coefficient
of A. Exactness of PA^2 is the vanishing of its coefficients in
degrees congruent to four modulo five. Squarefreeness and coprimality
are open conditions. The fixed endpoint has the two nonzero
determinants [18] and [21], as reconstructed by
[the exact verifier](../../scripts/arithmetic/verify_uniform_admissible_norm.py).
Thus the open set is nonempty. No irreducibility or density assertion
about other components of the parameter locus is needed.
