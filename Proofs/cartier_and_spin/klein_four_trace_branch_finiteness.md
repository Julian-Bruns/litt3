# Proof: absolute branch support

[Statement](../../Theorems/cartier_and_spin/klein_four_trace_branch_finiteness.md).
The complete incoming proof is in Appendices A–D of
[the retained report](../../../litt3-computation-data/finite_loci_v4_replies_20260926/extracted/v4/klein_four_structural_v5/REPORT.md).
The following records the substantive arguments and their scope.

## Actual traces

At a common-pole value c set lambda_c=epsilon c^4. The simple-pole
coefficient of u is eta c(lambda_c^-1-1). At a triple pole choose
t=c+s^2 and write u=a s^-3+b s^-2+... . The actual differential identity
gives b=4 eta c(lambda_c^-1-1). Averaging the two inertia conjugates
therefore contributes exactly the pole weight3 divided by4 times the
same simple-pole coefficient. Thus, for all allowed weights, the trace
principal parts are
\[
R_c=\frac{\eta m_c}{4}(\epsilon^{-1}c^{-3}-c),
\qquad S_c=\epsilon c^4R_c.
\]
Regular companion points contribute zero. No division by lambda_c-1 is
made. With bars denoting averages of the four supplied endpoint jets,
\[
u_0=\bar\alpha_0+\sum R_c/c+
(\bar a_0+\sum R_c/c^2)t+
\epsilon^{-1}\bar c_\infty t^2+
\epsilon^{-1}\bar B_\infty t^3+\sum R_c/(t-c),
\]
\[
v_0=\bar\alpha_\infty+
(\bar a_\infty-\sum S_c)/t+
\epsilon\bar c_0/t^2+\epsilon\bar B_0/t^3+\sum S_c/(t-c).
\]
Comparison with the known second jets, with M_j=sum m_c c^j, gives
\[
\epsilon(E_0-\eta M_{-2})=C_\infty-\eta M_{-6},\qquad
\epsilon(C_0-\eta M_6)=E_\infty-\eta M_2.
\]

All endpoint labels are in F_(5^56): the four roots of A and canonical
29th roots lie in F_(5^8), while mu29 lies in F_(5^14). The four canonical
c-label conjugates form a normal basis over F25, determinant[2], and
their sum divided by eta is kappa=[17], not in F5. If both coefficients
of epsilon above vanished, both endpoint c-sums would lie in F_(5^14).
Normal-basis independence and the absence of a nonzero relation on at
most four cyclotomic nodes force each endpoint to have one label of
each type with one common phase. The relation M_-6=M_6^(5^7) would then
give kappa^5/kappa in mu29 intersect F25*, hence kappa^5=kappa, a
contradiction. At least one equation therefore determines epsilon over
F_(5^56). The displayed formulas then determine the traces there too.

## Nonzero stationary eliminant

At a non-pole branch point of t, the V4 inertia has order2. Differentiating
the value identity at that point and using the differential identity gives
\[
A(v)=\epsilon^4t^{-13}A(u),\qquad
K(u)=\epsilon^{-29}t^{87}K(v).
\]
If du vanishes there, the actual endpoint profile gives P(u)=0; the
differentiated identity then gives A'(v)=0 or P(v)=0. Thus both K-values
vanish and the same equation still holds. This boundary uses the actual
ramification hypothesis and would fail for an arbitrary formal solution.

The norm R0 has73 terms, weight4i+29j<=116 on B^iC^j, top terms
C^4-[16]^4 ell^-29 B^29. Hence R is polynomial of Z-degree116,
t-degree at most377, with top Z-coefficient[16]^4(1-t^29).
At t=0 its roots are three times the116 endpoint B-labels.

No sum of two endpoint B-labels equals a sum of four. The canonical
B-conjugates have normal-basis determinant[23], reducing this assertion
to short cyclotomic relations. The only extra case is a signed relation
of two positive and four negative29th roots. In Z[T]/(T^29-1) let f be
its signed count polynomial. The product f(T)f(T^2) reduces modulo5 to
Phi29: Frobenius covers the quadratic-residue roots, and2 covers the
other coset. Its integer coefficient sum is4 and its negative mass at
most16. Since all29 coefficients are1 modulo5, their negative mass is
at least(4/5)(29-4)=20, a contradiction. Repetitions and cancellations
are retained.

Now W(0)/E(0)=3 sum B_0. A common root of the two fixed-degree resultant
inputs at0 would express that sum as three times two endpoint labels.
The preceding separation proves Delta(0)!=0. At any actual branch value
c outside E, the two points of its fiber have v-values summing to2v0(c).
Their scaled values c^3v/epsilon are roots of R(c,Z), so Delta(c)=0.
This implication includes leading-coefficient drops at c^29=1. Together
with squarefreeness and coprimality of the inertia polynomials, it proves
D1D2D3 divides E Delta.

The two resultant coefficient-degree bounds are377 and377+116(e+3).
Their degree116 homogeneities give the stated bound. Every root of
E Delta has degree<=N over F_(5^56), proving the absolute field bound.
Assigning each root to none or one of three inertia labels leaves only
finitely many parameter curves; no such assignment is asserted admissible.

## Finiteness of the actual functions

Fix such a curve S and one allowed pole divisor of u. A separating u
with the prescribed tame profile has exactly g(S)+n-1 ramification
points, each of index3, mapping to the fixed eleven branch values.
The corresponding marked incidence schemes are of finite type.
Every tangent variation is du(xi) for a global vector field xi on S:
the allowed variation at a movable index3 point vanishes to order2,
precisely the image of du. At the four fixed order3 poles over parameter
infinity it must vanish one order further, so xi vanishes at all four.
The degree of T_S(-four points) is negative even in genus0. Thus every
tangent space is zero and the incidence schemes have finitely many points.
Apply the same argument to v. Fixed-curve uniqueness in degrees86/87,
followed by quadratic splitting of the marked fibers and the final cubic
constant, gives the asserted high-degree descent bounds.

Abstract bounded-degree finiteness also follows from finite generation
of the endpoint fundamental group and fixed-source rigidity. The new
feature here is the explicit, nonzero constraint on the unknown branch
support and its usable coefficient description.

## Verification

The incoming source computes the norm determinant and checks R0(A,K)=0,
both normal-basis determinants, the endpoint field, and short-sum arithmetic.
The local replay of `src/verify_branch.py` passed every retained check.
The large Delta is specified by an exact circuit; it has not been
expanded or factored. The proofs above do not claim otherwise.
See [the integration audit](../../Research/audits/FINITE_LOCI_V4_REPLIES_2026_09_26.md).
