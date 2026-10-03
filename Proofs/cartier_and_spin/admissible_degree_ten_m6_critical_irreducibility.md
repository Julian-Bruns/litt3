# Constant source-row certificates exclude every rational m6 critical root

Version1,1 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m6_critical_irreducibility.md).
Use the necessary source coefficient kernel in
[the support reduction](admissible_degree_ten_eleven_reduction.md),
the actual infinity profile in
[the profile theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md),
and the complement-gap and finite-itinerary conclusions in
[critical coprimality](admissible_degree_ten_m6_critical_coprimality.md).
The new coefficient calculation received an independent quotient-ring
check and a focused review of its source, frame and membership implication.

## Eighteen root families with two free shifts

If $c\in K$ is a root of $D$, critical coprimality gives
\[
\delta_3=kq,\quad q=([13],[18],[24]),\quad k\ne0,
\quad\operatorname{pole}c=5,
\quad\operatorname{pole}\delta_2=11,
\quad\operatorname{pole}\delta_1=16.
\]
The critical scale $k$ is distinct from the source remainder $\kappa$.
Put $J=[22]+[15]x$ and $a=Z/y$. The simple unramified roots of
$q$ are $x_1=[12],x_2=[16]$. The finite root $c_f=c+a$ has exactly
three simple poles above them, with distributions $(1,2)$ or $(2,1)$.
The preceding theorem proves this using Gauss content and the unequal
two-fiber cube products.

Choose the orientation so fiber $i$ has the single pole $(x_i,Y_i)$
of $c_f$, while fiber $j$ has its single regular point $(x_j,Y_j)$.
Thus $Y_i^3=P(x_i)$ and $Y_j^3=P(x_j)$. Put $\gamma=J(x_i)Y_i$.
Let $p_0$ be the unique linear interpolant with
\[
p_0(x_i)=J(x_i)Y_i^2,\qquad
p_0(x_j)=-J(x_j)Y_j^2-\gamma Y_j.
\]
Every remaining root is exactly
\[
c_f=(Jy^2+p_0+\gamma y)/q+r_0+r_1x,\qquad r_0,r_1\in k.
\]
The cubic polynomial component of its affine numerator has the two
displayed values, so differs from $p_0$ by $q(r_0+r_1x)$.
There are eighteen discrete choices, two orientations and three
choices on each fiber. The
[two-parameter note](../../Research/experiments/oct01_nonzero_source/M6_RATIONAL_ROOT_TWO_PARAMETER_MODEL.md)
records this derivation. No actual source is inferred from the parameters.

## Seven necessary source columns

Fix first the projected support omitting $\alpha$, a root of $A$.
Its cached coefficient field is $K_0=\mathbf F_{25}(\alpha)$,
with $\beta^2=\beta+3$ and monic quartic of ascending coefficients
$([5],[2],[6],[7],1)$ for $\alpha$. Codes are those of the support
certificate: $[a+5b]=a+b\beta$, and four base25 digits give the
coefficients of $1,\alpha,\alpha^2,\alpha^3$.

The source $S$ has thirteen homogeneous columns before Newton
restrictions; its first scalar is the source remainder $\kappa$.
The five independent $v$ columns do not occur in $D=S'$.
Impose the $(10,6)$ Newton rows and the sharpened necessary bound
$\operatorname{pole}\delta_{2,s}\le11$. The translation is
\[
y\delta_{2,s}=y\delta_{2,f}+3Z\delta_3,
\]
so this is a linear bound21 on an affine numerator. The combined
matrix has rank6 on thirteen columns, leaving SEVEN homogeneous
columns. In the retained basis its $\kappa$ functional is
$(1,0,0,0,0,0,0)$. Every retained $\delta_3$ is a scalar multiple
of $q$, as checked directly. No leading scalar is divided, and
zero-leading columns are retained. Every actual source belongs to
this necessary space; extra tuples only strengthen the exclusion.

The [input producer](../../scripts/oct01_nonzero_source/m6_rational_root_source_input.py)
retains the row matrix, its kernel, every finite $D$ column and the
$\kappa$ functional in
[the input certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/m6_rational_root_source_input.json).
Its executed calculation took0.059 seconds on one core.

## Literal bivariate equations and constant witnesses

For a root family put $n=Jy^2+p_0+\gamma y+q(r_0+r_1x)$.
For every finite critical column $D_{f,h}$ form the EXACT polynomial
\[
q^3D_{f,h}(n/q)=\sum_{j=0}^3[T^j]D_{f,h}\,n^j q^{3-j}
\]
in $k[r_0,r_1,x,y]/(y^3-P)$. Collect each $x$ coefficient in
each of the three cubic characters. This gives31 rows on seven
homogeneous source columns, each of total degree at most3 in the
TWO root shifts. The full polynomial rows are evaluated at the
actual shifts; their shift coefficients are never imposed separately.

For EVERY case the exact certificate supplies eighteen nonzero
CONSTANT row weights with
\[
\sum_{\ell=1}^{31}w_\ell M_{\ell,*}=(1,0,0,0,0,0,0)
\quad\text{in }k[r_0,r_1]^7.
\]
If $D(c)=0$, all the complete row equations evaluate to zero on
the actual source vector. The displayed combination gives
$\kappa=0$, contradicting the required nonzero source remainder.
This identity holds over the full polynomial ring. There are no
shift denominators, exceptional shift values, auxiliary determinant
units or leading-content localizations. Sampled rank plays no role
in the exclusion.

The coefficient calculation uses a cubic extension of $K_0$ with
$Y_1^3=[6]$, and cube roots of1 for $Y_2$. Frobenius $25^4$
fixes $K_0$ and the cube roots of1, and cycles the three $Y_1$.
Thus six computed cases, two orientations times three $Y_2$ values,
cover all eighteen choices. Frobenius over $\mathbf F_{25}$ also
transports the omitted $A$ root to the other three support choices.
It transports the whole coefficient identity and source kernel;
it imposes no invariance assumption on unknown geometric scalars.

The [matrix producer](../../scripts/oct01_nonzero_source/m6_rational_root_source_matrix.sage)
and [membership producer](../../scripts/oct01_nonzero_source/m6_rational_root_source_membership.sage)
retain the matrices and combinations for cases0 through5 under
`m6_rational_root_source_case_N.sobj` and
`m6_rational_root_source_membership_case_N.sobj` in
[the external data directory](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/).
The [matrix summary](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/m6_rational_root_source_matrix_summary.json)
and [membership summary](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/m6_rational_root_source_membership_summary.json)
record all cases. Matrix construction took1.86 seconds and all six
degree-zero identities took3.84 seconds. The bounded higher-degree
search was unnecessary: every first degree-zero test succeeded.

## Independent check and conclusion

The [independent verifier](../../scripts/oct01_nonzero_source/verify_m6_rational_root_source.sage)
uses a quotient-ring representation instead of the producer's
three-character multiplication routine. It reconstructs every cleared
$D_f(c_f)$ column and checks ALL collected rows. It then checks all
seven target components in every case and the stored source-kernel
identities and rank. Its
[executed result](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/m6_rational_root_source_verification.json)
is PASS in5.08 seconds. The independent focused review additionally
checked the finite/short bound, $\kappa$ normalization, complete
coefficient collection and Frobenius coverage.

Run the input producer with `python3`, then the matrix and membership
producers with `sage --cases 0,1,2,3,4,5`, and the verifier with
`sage`; all accept `--work` set to the sibling
`litt3-computation-data/oct01_local_continuation/nonzero` directory.
Executed calculations used one core and Sage10.9.

Therefore $D$ has no rational root. A reducible cubic over a field
has a rational linear factor, so $D$ is irreducible. An irreducible
cubic in characteristic five is separable. This proves the critical
irreducibility claim; sources with irreducible critical cubic and
the full actual-source existence problem remain unresolved.
