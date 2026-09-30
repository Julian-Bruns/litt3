# Proof: integral quotient lattices, extension, and connection

This is a local continuation of the returned contact-lifting result.
The [Sage verifier](../../scripts/arithmetic/new_line_quotient_extension.py)
checks the polynomial identities and residue row; the integral
bundle identification is proved here. The
[data](../../../litt3-computation-data/finite_coefficients_contacts_20260923/new_line_quotient_extension.json)
and [output](../../../litt3-computation-data/finite_coefficients_contacts_20260923/new_line_quotient_output.txt)
are retained separately. No independent-agent audit is claimed.

Let theta=dx/y^2 and A=(1,21,14,22,13), so the actual lambda
has adjunction A^2 theta. Normalize the polynomial primitive by
\[
Q=(0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24),
\qquad Q'=P A^2.
\]
Then f=Q/y^5 has df=A^2 theta and represents the generic lambda
line in k(X)/k(X)^5. Its positive plane is span([f],[f^2]), and
lambda-perp is span([f],[f^2],[f^3]). These follow directly from
the Cartier pairing and the canonical second-line formula.

Choose the unique polynomial N of degree below10 with N^5=Q mod P.
The exact row in the statement satisfies
\[
Q-N^5=P^2T,\qquad P T'+(P'/3)T=A^2.
\]
Thus g=yT is an affine-regular primitive and
f-g=(N/y)^5. Write c=N1(x1)/y1 on C; its pullback is (N/y)^5.
If a1=A^(1)(x1), use the rational quotient vectors
\[
l=[f^2]/a1,\qquad r=[f^3]/a1,\qquad
r_{\rm aff}=r-3c\,l.
\]
Here classes and coefficients are interpreted in the relative
generic fiber. Subtracting a Frobenius-constant primitive leaves
[f^2] unchanged modulo lambda and changes [f^3] by -3c[f^2].

We check the full lattices, not only their generic fibers. At a
finite point away from A=0 the affine primitive g, after removing
its constant term, is a parameter, since dg is a unit. Hence the
classes of g^2,g^3 give a regular basis of the quotient. This
includes the cubic branch points: theta and A are units there.
At a simple root of A, normalize the local primitive to t^3.
For s=t^5, lambda-perp/lambda has regular basis
[t^6]/s=[t] and [t^9]/s=[t^4]. The single zero of a1 on C
removes exactly this common factor s. Therefore l,r_aff form an
affine frame, also at all roots of A. A regular constant shift in
the primitive changes this frame by a regular triangular matrix.

At infinity t=x^3/y is a parameter and f has order -7.
The primitive t^10 f has order3; t^10 is a Frobenius constant.
The same local computation gives quotient basis
t^15[f^2], t^25[f^3]. Since A^5 has order -60 on X,
l and r have respective divisor orders9 and7 on C. Removing
higher Frobenius-constant terms in the order-three primitive
only makes a regular triangular change of this local basis.
Thus the affine frame and the infinity frame identify the actual
extension as r=r_aff+3c l. This proves the stated class in H1(O(2O)).

For its Serre pairing, the seven printed differentials form a
basis of H0(omega_C(-2O)). Pairing with the first five reduces to
the residue at infinity of 3N1 x1^i dx1/P^(1). The degree-three
map to the x1-line multiplies its residue by3. Thus it is -9
times the x1^-1 coefficient of N1 x1^i/P^(1). The final two
residues vanish by cubic character. The exact nonzero row proves
nonsplitting.

There is an explicit splitting after relative Frobenius. The
pulled-back transition is 3(f-g). On the infinity chart f has
pole order7, allowed in O(10O), and g is regular on the affine
chart. Hence the quotient lift
\[
r_{\rm split}=r-3f\,l=r_{\rm aff}-3g\,l
\]
is global in the pulled-back extension. This proves
F_X^*V_lambda=O(45O)+O(35O) and F_X^*epsilon_X=0.
As a second check, its Serre dual space H0(omega_X(-10O)) is
spanned by theta,x theta,x^2 theta; all residue pairings with
3(N/y)^5 vanish by their nontrivial cubic character.

The rational frames l,r pulled back from C are horizontal.
Differentiating the explicit splitting gives
nabla r_split=-3 df l, while nabla l=0. The coefficient is
regular as a section of omega_X(10O), since
div(df)+10O=2R_X. This specifies the actual nonsplit connection
on the split underlying bundle. Frobenius splitting is therefore
not a common-map descent argument or a proof that an individual
contact section lifts.
