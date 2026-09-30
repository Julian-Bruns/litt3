# Actual etale scales satisfy three quadratic traces

Version1,30 September2026. Retain the primitive degree140 family and
all chart hypotheses of the
[actual derivative trace theorem](degree140_actual_split_derivative_traces.md).
Write the critical equation as
\[
3aW^2+2bW+c=0,\qquad
\eta=(3b-aW)/2,\qquad d=b^2+2ac=\eta^2.
\]
The regular affine source coefficients a,b,c are the primitive-coordinate
coefficients g2,g3,g4. Let delta0 be dual to omega0=dx/(3y^2).
For every affine regular f on X with pole order at most p at O, put
\[
U_f(\ell)=\operatorname{Tr}_{k(C)/k(\Lambda)}
            \left(f\,\frac{\delta_0\Lambda}{\eta}\right).
\]
Then U_f is a POLYNOMIAL and
\[
\deg U_f\le
\max\left(2,\left\lfloor\frac{5+p}{4}\right\rfloor,
               \left\lfloor\frac{8+p}{7}\right\rfloor\right).
\]
For every nonzero scale lambda giving an ACTUAL everywhere-etale
degree-ten source, U_f(lambda)=0. In particular the three traces
\[
U_1(\lambda)=U_x(\lambda)=U_{x^2}(\lambda)=0
\]
are necessary equations of degree at most TWO.

The functions inside these traces need not be regular on an actual
fibre. At higher critical collisions the assertion concerns their
paired trace, with its actual residue cancellation. It does not follow
by applying the trace to a presumed nilpotent regular function.

No nonzero leading coefficient, absence of common roots, or global
parameter exclusion is asserted here. The unmarked common-cover
problem remains unresolved.

[Proof](../../Proofs/cartier_and_spin/degree140_inverse_discriminant_quadratic_traces.md).
