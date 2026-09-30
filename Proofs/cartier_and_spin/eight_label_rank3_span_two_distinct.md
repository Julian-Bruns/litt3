# Proof: genuine-pair classification and the norm filter

[Statement](../../Theorems/cartier_and_spin/eight_label_rank3_span_two_distinct.md).
The full accepted proof, complete finite-domain records and implementation
are sections9--23 of the
[incoming report](../../../litt3-computation-data/september29_evening_replies/rank3/REPORT.md).
Its final93 computation chunks and430 necessary-row survivors are retained.
No old scan or verifier was replayed locally.

Three distinct pair polynomials are affinely collinear over F5 exactly
when they are {2T^a,T^a+T^b,2T^b}. Thus a repeated span-two endpoint
has three distinct, noncollinear pairs. With four distinct pairs, the
unique phase-character relation places the endpoint in one of the five
families classified in section19: three linked families, midpoint
families, or chains. There are5,700,240 four-distinct endpoints and
496,162,044 full-support span-two endpoints in total. The accepted complete
fourteen jobs cover every distinct-pair family against every span-two
partner, after the proved symmetries. All430 necessary-row survivors
have rank four. The coverage is exact by the classification, rather
than inference from a finite sample of phase values.

For the two-candidate theorem, the third lower row of the stacked
matrix forces the displayed equation. Set u=aA,v=bB, and use conjugation
bar over H=F_(5^7), where bar(xi)=xi^{-1}. Membership in mu29 implies
\[
N(u)+t\operatorname{Tr}(u\bar v)+t^2(N(v)-1)=0.
\]
If a is nonzero, its constant coefficient is nonzero because A is
nonzero by full support; a quadratic has at most two roots t in F5*.
If a=0, even rotations give v and odd rotations give-v. Both cannot
belong to the odd-order group mu29. This proves the bound even on the
identically-zero norm-polynomial boundary. For each t the eighth-power
map on mu29 is bijective, so the phase translation is unique.

The report separately proves an exact nine-equation linear scalar-graph
criterion and unique actual-moment completion. Those conditions remain
essential after the stacked rank has dropped; none is assumed from the
necessary row equation or from a relaxed choice of row constants.
