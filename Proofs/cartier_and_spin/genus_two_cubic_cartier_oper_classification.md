# Proof: complete coefficient algebra and rigidity of the bounded horizontal pencil

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/genus_two_cubic_cartier_oper_classification.md). Pending independent review. Use the exact dormant equation proved in [the quadratic-bound theorem](genus_two_log_dormant_oper_quadratic_bound.md). The coefficient classification below is direct algebra, not a fusion count, endpoint census or numerical replay.

## The restricted derivative and the complete four-coefficient equation

For ∂=y d/dz, direct differentiation of z gives
\[
\partial^5=H\partial,\qquad
H=\frac{(\Phi'')^2}{4}+2\Phi'\Phi'''+\frac{\Phi\Phi''''}{2}
=2qz^5+2qu+2rt+s^2.
\]
Write E=C(z)+vy, C=az²+bz+c. Its dormant equation separates into
\[
\Phi C''+\tfrac12\Phi'C'-3C^2-3v^2\Phi-2H=0,
\qquad v(\Phi''/2-C)=0.
\]
If v≠0, the odd equation forces C=qz²+3rz+s, and the leading z⁵ coefficient of the even equation forces v²=q. The entire remaining even equation then vanishes IDENTICALLY for every Φ: no endpoint restriction remains. Thus q≠0 gives precisely the two stated nonpolynomial coefficients, and q=0 gives none with v≠0.

If v=0, the leading coefficient gives a=2q. The surviving equations in b,c are
\[
3q(s+c)+4br+2b^2=0,\quad qt+b(s-c)=0,
\quad c^2=bt+2rt+s^2.
\]
For q≠0 the first determines c=(b²+2rb+4qs)/q, and the second gives the stated monic cubic P(b). The third is redundant, by the EXACT polynomial identity
\[
(b^2+2rb+4qs)^2-q^2(bt+2rt+s^2)
=(b+2r)(b^3+2rb^2+3qsb-q^2t).
\]
This proves the complete polynomial classification. For q=0 the first equation is b(4r−3b)=0. If b=0, the third gives c²=2rt+s². The only other case has r≠0,b=3r,c=s; its third equation is automatic. This gives the complete q=0 list.

The new source [verify_genus_two_log_oper_coefficients.py](../../scripts/genus_two/verify_genus_two_log_oper_coefficients.py) checks the restricted-derivative formula, universal nonpolynomial even identity and cubic redundancy by direct sparse polynomial multiplication over F5. It was executed on3 October2026 and all THREE assertions passed. It has no dependencies, performs no Gröbner computation, and replays no endpoint arithmetic. The preceding derivation supplies the remaining coefficient comparisons.

## A genuine bounded horizontal pencil for each coefficient

Let S={f∈L(7P):∂²f=Ef}, and assume it contains the indicated F1 with simple finite zeros and pole5or7. For fi∈S put di=∂fi. Every di is regular off P and has pole≤10P. The Wronskian fij=fi dj−fj di has zero derivative, hence fij=Kij⁵ for an actual Kij∈k(Y). It is regular off P and has pole≤17P, so Kij∈L(3P)=⟨1,z⟩.

If all solution columns (fi,di) span only ONE line over k(Y)⁵, every fi/F1 is a fifth power U⁵. A finite pole of U would create a pole of fi because F1's finite zeros are simple. Thus U is regular off P. The bound fi∈L(7P) and poleF1=5or7 makes U's pole order at P at mostZERO. Hence U is constant, giving dimS=1 in this case.

Otherwise choose F1,F2 with K12≠0. For any Fj∈S, Cramer's rule gives
\[
F_j=(K_{j2}/K_{12})^5F_1+(K_{1j}/K_{12})^5F_2.
\]
If K12 is nonconstant, every Kij in the two-dimensional space⟨1,z⟩ has the form aK12+b with constants a,b. Therefore Fj is a constant combination of F1,F2 plus (b1F1+b2F2)/K12⁵. Regularity of Fj at the zero divisor of K12 forces that numerator to vanish on FIVE times this degree-TWO divisor, counting multiplicities even if it is a branch fiber. A nonzero function in L(7P) cannot have TEN zeros. Thus the numerator is zero and Fj is a constant combination of F1,F2.

If K12 is constant, the same formula instead writes Fj as a constant combination plus z⁵(b1F1+b2F2). Since both Fj and the first term have pole≤7P, the latter factor would require b1F1+b2F2 to have zero order at leastTHREE at P. It is regular off P, so a nonzero such function would be globally regular with a zero, impossible. Again Fj is a constant combination. This handles the constant-Wronskian case separately rather than using a nonexistent finite zero divisor.

Thus dimS≤2. The argument bounds a genuine k-linear horizontal pencil, even though the full rational horizontal module has rank TWO over k(Y)⁵. It neither replaces an actual étale map with a horizontal solution nor decides which pencil members satisfy the remaining full large-wild global incidence.
