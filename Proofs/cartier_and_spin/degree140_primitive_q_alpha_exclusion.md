# Exact resultant certificate at q=alpha

[Statement](../../Theorems/cartier_and_spin/degree140_primitive_q_alpha_exclusion.md).
The input is the accepted original ratio source in the
[primitive archive](../../../litt3-computation-data/september29_replies/primitive140_continuation_record/primitive140/).
The source recipe was reused; its prior certificate chain was not rerun.
The new [whole-fibre driver](../../scripts/arithmetic/primitive140_fibre_backend_20260929.py)
constructs the exact q=<25> residual and necessary normalized tails.
It clears only the original H and Psi units. The first three tails
have mu-degrees47,47,48.

The original Psi has unique root H=<191580> on this fibre. Write
p=H-<191580>. For
\[
A_1=\operatorname{Res}_{\mu}(C73,C71),\qquad
A_2=\operatorname{Res}_{\mu}(C73,C72),
\]
the Sylvester-matrix degree and valuation assignments give
\[
\deg A_1\le31829,\quad H^{1854}p^{6804}\mid A_1,
\qquad
\deg A_2\le32060,\quad H^{1914}p^{6699}\mid A_2.
\]
These bounds come from minimum-weight perfect matchings of the
Sylvester support, using negative coefficient degrees for the upper
degree bounds. The code checks primal-dual equality and every dual
inequality. At p it computes the exact coefficient valuations by
synthetic division. Thus the quotient resultants B1,B2 are polynomials
of degrees at most23171 and23447.

The existing exact field DFT evaluates these quotients at all24414
points of a multiplicative coset avoiding H=0 and p=0. Since24414
exceeds both degree bounds, inverse interpolation determines the
entire polynomials over K. Every evaluation uses the fixed-degree
Sylvester resultant, with both-leading-degree drops retained. It does
not replace the polynomial by the resultant of its specialized degree
without the appropriate leading factors.

The resulting degrees attain the bounds. Seven additional nodes per
resultant independently check evaluation/interpolation conventions.
Separately729 small fixed-degree cases, covering all degree-drop
patterns through degree6, agree with literal Sylvester determinants.
Finally the saved exact identity is
\[
U(H)B_1(H)+V(H)B_2(H)=1.
\]
It is checked by full polynomial multiplication, not only evaluation.
Both B_i belong to the localized ideal(C71,C72,C73), since their
removed factors are original units. Therefore that ideal is the unit
ideal over K[H,mu,1/(H*Psi)], hence over every geometric extension and
over the further original open conditions.

The [native source](../../scripts/arithmetic/primitive140_resultant_fibre_20260929.cpp)
and the [exact resultants, Bezout multipliers, inputs and receipts](../../../litt3-computation-data/conceptual_continuation_20260929/primitive_q25/)
are retained. The previous direct Singular computation was interrupted
after the resultant certificate finished; it supplied no claimed result.

This is one entire new geometric ratio fibre. It is not a decision of
the varying-q family or of any unrestricted common-cover question.
