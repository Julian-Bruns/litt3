# Higher-cover genus bounds at comparison pole degree six

Version 5, 24 September 2026. Use the fixed curve, tensor and actual
comparison hypotheses of
[the comparison normal form](new_line_comparison_normal_form.md).
Suppose the two distinct embedded X-fields jointly generate k(T).
Let n be their common covering degree and assume the comparison
function s has pole degree six. Let S be the simultaneous cyclic
cubic quotient, so k(S)=k(x_1,x_2), and let g=g(S).

There is a monic polynomial D(s), supported on
\(s^{29}=\kappa^{18}\), with each exponent at most two, such that
\[
x_1=\frac{a+bw}{D},\qquad
x_2=\frac{c+dw}{s^3D},\qquad w^2=B(s).
\]
Here B is monic squarefree of degree2g+2, B(0) is nonzero,
\(\deg a,\deg c\le r+3\) and
\(\deg b,\deg d\le r+2-g\), where r=deg D. Both b and d are nonzero.
D can be chosen minimally among polynomial denominators clearing
both functions away from zero and infinity. For that choice,
\[
g\le r,\qquad
r\le\min\left(n-6,\left\lfloor\frac{n+23}{2}\right\rfloor,58\right).
\]
In particular the earlier bound g<=n-4 sharpens to
\[
g(S)\le\min\left(n-6,\left\lfloor\frac{n+23}{2}\right\rfloor\right).
\]
There is a further restriction. Normalize the common-pole values to
mu29 and write epsilon for the nonzero comparison scalar. If t is
the number of distinct roots of D and u=r-t, then
\[
D_{\rm red}\mid d-\varepsilon s^7b.
\]
This polynomial is ALWAYS nonzero. Otherwise x_2=epsilon*s^4*x_1+R(s)
would give the same leading coefficient for s^3*x_2 on both zero
branches, hence the same simple root of the full quartic equation for
x_1. The two embeddings of k(S)=k(s,x_1) would coincide, impossible.
Consequently
\[
g\le u+9\le9+\lfloor(n-6)/3\rfloor\le38.
\]
Thus g<=38 uniformly on the entire branch n<=93. If all minimal
common-pole denominators are simple, g<=9. The exact affine-ratio
alternative is excluded. These bounds alone do not exclude the other
models; subsequent restrictions are linked below.

In the simple-denominator subcase one also has n<=64 and
\[
D\mid c-\varepsilon s^7a,\qquad
x_2=\varepsilon s^4x_1+\frac{p_0(s)+p_1(s)w}{s^3},
\quad \deg p_0\le10,\quad 0\ne p_1,\quad\deg p_1\le9-g.
\]
This clears every finite common pole from the residual comparison.
The pole bound is independent of n and of the number of common-pole
values. Ramified quadratic fibers and single-sheet poles are included.

At covering degree seven the original genus bound leaves only zero
and one; both are now excluded by
[degree-seven recognition](degree_seven_new_line_recognition.md).
The later [squarefree exclusion](squarefree_common_pole_exclusion.md)
eliminates that entire subcase. The
[degree-55 reduction](pole_six_degree_fifty_five.md) now confines the
full branch to one arithmetic pole pattern and genus3--16. The subsequent
[complete exclusion](pole_six_complete_exclusion.md) eliminates that pattern
and the whole pole-six branch. Recognition through degree eight follows.

These are necessary conditions for the same two actual etale maps.
These bounds do not construct such a comparison. Higher comparison pole
degrees remain open; pole six is now excluded.

[Minimal-denominator proof](../../Proofs/cartier_and_spin/new_line_degree_six_genus_bound.md),
[common-pole polynomial and strengthened bound](../../Proofs/cartier_and_spin/pole_degree_six_contact_polynomial.md).
