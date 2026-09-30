# Different endpoints cannot force the same actual scale

The statement is [here](../../Theorems/cartier_and_spin/degree140_root9_single_actual_content.md).
Use the established [endpoint-content structure](degree140_root9_endpoint_content_structure.md)
and [actual local scale](root9_content_etale_scale.md). The marked
cubic-branch content is excluded already. Each remaining content point
is simple, has B nonzero, and occupies the unique sheet over its endpoint.

## The comparison is on the actual normalized family

At a root b_i of t, let Z_i be the sheet coordinate, so
q=P(b_i)/Z_i^3. Let J_i(H,Z_i)=0 be the established degree(12,90)
content equation. The endpoint expansions of the translated source have
\[
Phi=W^5+mT^3+m_1T^4+\cdots,\quad
S=g_0W^3+g_1W^2+g_2W+g_3.
\]
Put A=3g0(0), B=2g1(0), D0=g3(0), C1=[T]g2,
C2=[T2]g2, B1=2[T]g1 and kappa=[T]g3/D0. The last ratio
is a constant, checked as an exact polynomial identity. Let ell_j be
the coefficients of T^(5+j) in Phi(0,T)g3+E(T), j=0,1,
and let V0 be the scale coefficient V(0). Actual local splitting gives
\[
mu=N_i/D_i,\qquad D_i=V0*m^2*B^3,
\]
where
\[
N_i=-((ell1-kappa*ell0)B^3-(mC2+m1C1)C1B^2
+(3mB1+3m1B+3kappa*mB)C1^2B-2mA*C1^3).
\]
Every denominator in this formula is nonzero on an actual candidate;
the B=0 cases were separately excluded. Nonzero scale also requires
N_i nonzero. These are necessary conditions on actual splitting, not
conditions inferred merely from parity of a cubic norm.

For two distinct endpoints b_i,b_j, their coordinates obey
Z_j=c*Z_i, where c^3=P(b_j)/P(b_i). The three cube roots c
belong to K and are all retained. There are three unordered endpoint
pairs and hence nine charts. On each, necessary equations are
\[
J_i(H,Z)=J_j(H,cZ)=0,\qquad
N_i(H,Z)D_j(H,cZ)-N_j(H,cZ)D_i(H,Z)=0.
\]
They retain the same H,q and actual normalized scale. The necessary
open is H*Z*D_i*D_j*N_i nonzero. The equality then also makes
N_j nonzero. Only powers of H and Z are removed from polynomial rows.

## Complete algebraic calculation

The [new source](../../scripts/arithmetic/root9_two_endpoint_actual_scales_20260929.sage)
constructs all nine comparisons from the accepted local source jets.
In each chart the three equation bidegrees are(12,90),(12,90),(14,108).
Sage/Singular computes their complete two-variable Groebner basis.
Adding one inverse for the displayed necessary unit gives Groebner
basis[1] in EVERY chart. This is a geometric ideal calculation, not a
finite-field point search, and imposes no reducedness assumption.

The exact original rows, intermediate bases, localized equations,
final bases and execution logs are retained in the
[evidence directory](../../../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_content/two_endpoint_actual/).
The first three optional transformation-matrix calculations were stopped
after their complete Groebner computations; those large multiplier
matrices are not claimed as retained certificates. The completed exact
algorithms and bases are reproducible with the script's --case option.
The remaining six charts completed with the same exact basis[1].
Earlier source and boundary certificates were used as established inputs,
not replayed in full.

Thus two different endpoints cannot both support content in an actual
cover. Together with the existing one-sheet-per-endpoint and marked-
branch exclusions, at most one content point remains globally.
