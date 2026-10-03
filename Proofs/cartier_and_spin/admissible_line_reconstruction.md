# Proof: primitive functions and the obstruction for a fixed selection

The [source verifiers](../../scripts/arithmetic/pro_coreless_20260923/plane/certificates/verify_all.py)
check polynomial identities and local degree arithmetic; the global
arguments below are not replaced by those computations.

## Saturation and the exact function criterion

For a primitive class [g] in k(S)/k(S)^5, write it formally as
sum_{i=1}^4 a_i(t^5)[t^i]. Its order as a rational section of its
saturated line is floor(ord_t(dg)/5); the residual adjunction order
is0,1,2 or3. Distinct summands have different derivative exponents
modulo five, so no leading cancellation was suppressed.

The actual determinant section [f] wedge[f^2] has divisor
R^(1)-6H^(1). At a finite R point use primitive order3 and the
saturated basis [f],[f^2/t^5]; at infinity f has pole order7 and
the basis t^10[f],t^15[f^2] has independent reductions. Elsewhere
the primitive orders are1,2. Thus det P=O(7H^(1)) and the
section [f] of lambda has divisor-2H^(1).

At a selected point of Delta, a horizontal generator of the
degree-zero line evaluates to order2. In the local P frame with
evaluation orders2,0 this forces its fiber to equal lambda. The
contact therefore contains Delta^(1); its total degree is9n,
leaving an effective G of degree n. For an order-five line,
squaring this determinant identity gives
O_C(2G^(1))=O_C(2H^(1)) tensor A_0^3. It is automatic.

Any generic line in P other than lambda has unique normalized
generator [f^2]+c[f], with c in k(S)^5. Write c=2 beta^5 and
q=f+beta^5. Then [q]=[f], dq=df, and the line is [q^2]. If
T^(1) is the divisor of this rational section, the wedge identity
gives T=E-G-4H, E=R-Delta. Comparing
div d(q^2)=div q+2R-10H with5T+2Delta gives
div q=3E-5G-10H. This calculation uses only degree zero and the
adjunction, not Frobenius triviality. Conversely this divisor
identity and the local saturation formula recover the line, its
adjunction and contact exactly. The two torsion conditions give
precisely the admissible nontrivial order-five condition.

E and G cannot meet. At a finite point of E intersect G, q would
have pole order5g-3, not divisible by five, although f is regular.
At a point of E over infinity it would have pole order7+5g>7,
again impossible for f+beta^5. This retains actual valuations.

## The two small-pole functions

Choose a global frame of F^*A_0 and let zeta be its adjunction,
with div zeta=2Delta. The function 2df/zeta has divisor2E-10H.
Adjoining its square root z gives an etale extension of degree
at most two: all valuations are even and the residue field is
algebraically closed. On a connected component div z=E-5H.
Set u=z^3/q. Then div u=5(G-H). The class T is now H-G,
so its nontriviality is exactly u not being a fifth power.

Conversely z,u with the stated divisors and differential identity
give q=z^3/u, q-f=beta^5 over the perfect constant field, and
the preceding reconstruction applies. Div z makes5T principal,
while u non-fifth makes T nonprincipal. The primitive
g=q^2/z^5=z/u^2 represents the same embedded line. Direct
differentiation gives zeta=u dg=2df/z^2 and, for w=z/u,
zeta=dw-w dlog u. Its simple zeros E make w separable, with
pole divisor5G and degree5n. Properness makes dlog u regular.

## A regular logarithmic differential detects the exact annihilator divisor

Fix the actual source q and a nonzero a in H^0(S,O(10H)). Logarithmic
differentials have at most simple poles. At a point P the residue of
nu_a=4 da/a-dq/q is4 ord_P(a)-ord_P(q), in characteristic five.
Consequently regularity is equivalent to
\[
\operatorname{ord}_P(a)\equiv2\,\mathbf1_{P\in E}\pmod5
\quad\text{at every }P.
\]
At every finite point a is regular. Hence its order is at least two
on E and at least zero elsewhere. The divisor H is reduced because h
is etale. At a point of H the pole bound gives ord_P(a)>=-10.
The congruence therefore improves this to at least-8 on E intersect H,
and leaves at least-10 on the other points of H. These are precisely
the coefficients of2E-10H. Thus div(a)-(2E-10H) is effective. It has
degree zero and therefore vanishes. The converse follows immediately
from the same residue computation.

The proved divisor of a gives directly
\[
\operatorname{div}(aq)=5(E-G-4H)=5T.
\]
Since4=-1 in characteristic five, nu_a=-dlog(aq). If nu_a=0,
the function aq is a fifth power over the perfect constant field and
T is principal. Conversely if T is principal, comparison with a
function having divisor T makes aq a fifth power times a constant.
The constant has a fifth root in k. Hence nu_a=0 exactly when T
is principal. The global frame (aq)^(-1) of the Frobenius pullback
of O_C(T^(1)) has precisely this canonical connection form.
Finally, after z^2=a, one has4 da/a=8 dz/z=3 dz/z in
characteristic five. Therefore nu_a=dlog(z^3/q), with the same
normalization as the preceding small-pole construction. There is no
additional separable-map or source-existence assertion in this test.


## The fixed-divisor extension and its persistence

Q_D is the elementary modification selecting lambda at D.
After Frobenius its image in omega_S is omega_S(-2Delta).
Taking determinants identifies its kernel as O(19H-3Delta).
Hence the extension class lies in H^1(O(3H-Delta)), whose
degree is-5n and whose h^1 is13n.

Any degree-zero line in Q_D pulls back to a degree-zero line
mapping isomorphically to M_D. Conversely a splitting which is
horizontal descends by Cartier to such a line. The splitting is
unique because Hom(M_D,O(19H-3Delta)) has negative degree.
Its horizontality is exactly beta_D=0 in the space stated. If
M_D is trivial, the descended line is killed by Frobenius; it
is nontrivial precisely when its canonical connection on that
trivialization is nonzero. Two degree-zero lines in Q_D would
generically span it and contradict deg Q_D=-n, proving uniqueness.

A splitting of a negative-degree line extension after a finite
etale cover is unique. Pass to the actual Galois closure: its
descent data preserve that splitting, so it descends without
division by the group order. Thus pullback on the relevant H^1
is injective. Pullback cannot kill a nonzero beta_D either.
For an eventual admissible line on a refinement, uniqueness
likewise descends the degree-zero line on Q_D. Every degree-zero
line over bar(F5) is torsion. Separable pullback is injective on
the five-primary part: a function with divisor5E cannot become
a fifth power in a separable extension unless it was one already.
Remove the prime-to-five part by its etale Kummer torsor. This
proves the exact fixed-selection refinement criterion.

## Base contact and the original cubic-cover certificates

The report proves the residual-contact bound deg G>=3 on X by
interpolating B=(22,16,11,3,15,11,2,6,12,14) at cubic branch
points. For any polynomial U of degree<=4 agreeing with B at
eight branch roots, multiplication by their complementary monic
quadratic leads to a5x4 system. The left-null row
(14,6,3,10,1) has nonzero product[8] with its right side.
The only exceptional two-pole linear-system jump has two points
in one cubic fiber; it forces its x-value to[18] and then gives
the nonzero coefficient defect[20]. This exhausts all effective
degree-two pole divisors, including repeated points and infinity.
The [later trace proof](admissible_line_trace_obstruction.md)
strengthens this to deg G>=4 and supplies the current7722 count.

For completeness the returned direct cubic verification is retained
as an independent special case. For every root r of P the actual
connected etale cover t^3=x-r has model
\[
v^3=\Psi_r(t)=P(t^3+r)/t^3,\qquad (x,y)=(t^3+r,tv).
\]
The polynomial Psi_r is squarefree of degree27 and the curve has
genus25 and three infinity points. A twisted degree-zero candidate
still gives q=f+beta^5 and div q=3E-5G-10H, deg G=3.
Multiplying b=beta y by
M(t)=product_{p in G_fin}(t-t(p))^{mult_pG}, of degree<=3,
removes finite poles and gives Mb=U(t)+V(t)v with deg U<=15,
deg V<=6. At all27 v-branch points,
\[
U\equiv M B(t^3+r)\pmod{\Psi_r},
\]
including those in G because Mb vanishes there.

Put psi_r(s)=P(s+r)/s and C_r(s)=B(s+r)-[14]psi_r(s).
At P(r)=0 the leading coefficients are
\[
\psi_8=[22],\quad\psi_7=[9]+[8]r,\quad
C_8=[20]+[16]r,\quad C_7=[14]+[23]r+[14]r^2,
\quad C_6=r+[19]r^2+[16]r^3.
\]
C_8 is a unit modulo P. The t^26,t^25 coefficients force the
t,t^2 coefficients of M to vanish. The remaining2x2 system for
its constant and t^3 coefficients has determinant
[13]+[18]r+[24]r^2, also a unit modulo P. Thus M=0, impossible.
The certificate checks both Bezout identities over F25[r], covering
all geometric roots. No torsion assumption enters this proof.

All these exclusions persist for selections descending to one of
the excluded base covers: their negative-degree Q_D cannot acquire
a nonnegative line after further etale pullback. A genuinely new
selection upstairs is not a pullback of Q_D and is not excluded.
