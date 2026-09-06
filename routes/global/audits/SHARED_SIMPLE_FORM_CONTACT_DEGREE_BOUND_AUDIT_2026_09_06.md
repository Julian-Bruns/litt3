# Shared simple-form contact degree bound: independent proof audit

Verdict: **PASS**. Auditor: `/root/shared_form_contact_bound_audit`.
Date: 2026-09-06.

Scope: the theorem and proof in
[CLUMP_CONTACT_ENERGY_AND_A_UNIFORM_COVER_DEGREE_BOUND.md](../../../Solutions/Sol_contact_degree_bound.md),
including its parameterized inequality and its characteristic-five,
weight-one, simple-zero specialization. This is a direct proof audit,
not an independent existence claim for spans satisfying the hypotheses.

## Checks

1. Joint minimality identifies Z with the normalization of the integral
   joint image C. Etaleness makes every completed branch a smooth graph
   over x and y. Distinct normalization branches have distinct graph
   series; their intersection multiplicity is ord(h_i-h_j). Consequently
   local delta is the sum of all unordered pairwise contacts, including
   every branch at a multiple point; there are no omitted individual
   branch defects.
2. If h_1 and h_2 have equal slope, H=h_1^(-1) composed with h_2
   preserves the source tensor because h_1^*s_Y=h_2^*s_Y=s_X.
   Composition with an invertible formal series preserves ord(h_1-h_2).
   For H=x+c*x^q+O(x^(q+1)), the relative coefficient in degree q-1
   is (e+d*q)c: U(H)/U(x)=1+O(x^q). This calculation does not divide
   by q or e. Thus e+d*q=0 modulo p and q>=m. The exclusion
   p not dividing d(e+d) makes m well defined with 2<=m<=p and
   allows at most n=e+d slopes.
3. The lower local bound is
   ((1+(m-1)/n)*r^2-m*r)/2. It follows by separating pairs with
   distinct slopes from pairs with equal slope, then applying
   sum(r_lambda^2)>=r^2/n. Negative lower bounds at empty or singleton
   grid cells cause no problem. The reduced common zero set has
   N=a*u=b*v=2*d*t/e distinct points, and every such point supplies
   exactly one branch in the u-by-v grid. Hence sum(r_PQ)=N and
   sum(r_PQ^2)>=N^2/(u*v)=a*b. Self-intersections and arbitrarily
   many branches are fully included.
4. Independently checking file100's substitution: Hom(JX,JY)=0 gives
   C^2=2*a*b and K.C=2*a*sX+2*b*sY=4*t. Adjunction gives
   p_a(C)=1+a*b+2*t; etale Riemann--Hurwitz gives g(Z)=1+t.
   Therefore delta(C)=a*b+t. Combining this with the grid bound gives
   exactly ((m-1-n)/(2*n))*a*b <= (1+m*d/e)*t.
   All degrees and counts here are integers or real inequalities,
   not field elements: p-divisible a or b creates no exception.
5. In characteristic five with e=d=1, n=2 and m=4, the inequality
   is a*b/4<=5*t. Thus b<=20*sX and a<=20*sY. For positive e,d,
   positivity requires n<=3; the other permitted possibilities
   (e,d)=(1,2),(2,1) have m=2,3 and fail positivity. The stated
   higher-weight limitation is correct.

## Edge cases and nonbreaking limitations

A local attempt to improve the contact estimate fails sharply: in
characteristic five, let c be nonzero and take the unique formal square
root H=x*sqrt(1+c*x^3) with leading term x. Then H^2=x^2+c*x^5,
so H*H'=x and H preserves x dx, while ord(H-x)=4. Thus the first
allowed equal-slope contact really occurs. Higher contacts also satisfy
the lower bound and do not undermine the count. No counterexample to
the theorem was found.

The hypotheses of joint minimality, Hom(JX,JY)=0, actual tensor equality,
and uniform zero multiplicity remain essential to this proof. In
particular the bound is not asserted for arbitrary common covers,
arbitrary zero patterns, or arbitrary weights. The application sentence
about a primitive form is conditional on it satisfying the theorem's
stated descent and simple-zero hypotheses; this audit does not establish
those hypotheses for another branch of the project.
