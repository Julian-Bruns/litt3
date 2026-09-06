# Proof record: Parameterized contact bounds and reduced-union atlas bounds

Canonical statement: [`contact_degree_bound`](../Theorems/Thm_contact_degree_bound.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Contact counting at a shared zero divisor: a parameterized degree bound

Author: /root, 2026-09-06. Status: independently audited PASS;
[audit record](../routes/global/audits/SHARED_SIMPLE_FORM_CONTACT_DEGREE_BOUND_AUDIT_2026_09_06.md).
Removal of Jacobian orthogonality independently audited PASS by
/root/contact_root_extension_audit, 2026-09-06;
[extension audit](../routes/global/audits/ETALE_ROOT_REDUCTION_OF_THE_CONTACT_BOUND_AUDIT_2026_09_06.md).
This retains both actual etale maps and allows arbitrarily many branches
and arbitrarily high contacts at every joint-image singularity.

## Theorem

Let k be algebraically closed of characteristic p>0. Let X <-f- Z -g-> Y
be finite etale maps of smooth connected projective curves of genus >=2,
with k(Z)=k(X)k(Y). Set

    a=deg(f), b=deg(g), sX=g(X)-1, sY=g(Y)-1, t=a*sX=b*sY.

Suppose there are nonzero regular weight-d tensors s_X,s_Y whose actual
differential pullbacks agree, and whose zero divisors are e D_X,e D_Y,
where D_X,D_Y are nonempty reduced divisors and e,d are positive integers.
Assume p does not divide d(e+d). Define m to be the least integer >=2
such that e+d*m=0 modulo p, and put n=e+d. Thus 2<=m<=p.

Then

    ((m-1-n)/(2n))*a*b <= (1+m*d/e)*t.                 (1)

If m>n+1, this gives the uniform bounds

    b <= 2*sX*n*(e+m*d)/(e*(m-1-n)),
    a <= 2*sY*n*(e+m*d)/(e*(m-1-n)).                 (2)

There is no dependence on branch count, contact orders, or monodromy.

In characteristic five, for a shared one-form with only simple zeros,
e=d=1, n=2, m=4. Consequently

    b <= 20*(g(X)-1),    a <= 20*(g(Y)-1).           (3)

Neither exactness nor Cartier fixedness is required for (3). In particular,
it applies to the Cartier-nonzero degree-one branch of a coreless span
if its primitive form has simple zeros. For genera 9 and 25 it gives
b<=160 in this specified branch, NOT in arbitrary common covers.

## Proof

Write C for the joint image in X times Y, with normalization Z. Each
formal branch is a smooth graph over both endpoint coordinates. The
total delta invariant satisfies

    delta(C)=C^2/2+t <= a*b+t.                       (4)

Indeed, for the fiber classes FX,FY, the class C-b FX-a FY is orthogonal
to both fibers and hence to the ample class FX+FY. Hodge index gives
C^2<=2ab. Adjunction and etale Riemann--Hurwitz then give (4).
No assumption on Hom(JX,JY) is needed. At each singularity delta is the
sum of the pairwise branch intersection multiplicities: all individual
branches are smooth.

The common pullback divisor gives the same reduced set

    S=f^(-1)(D_X)=g^(-1)(D_Y).

Put u=deg D_X=2d*sX/e and v=deg D_Y=2d*sY/e. Then

    |S|=a*u=b*v=2d*t/e,
    |S|^2/(u*v)=a*b.                                (5)

Fix P in D_X, Q in D_Y, and choose local parameters x,y at them. Write

    s_X=x^e A(x)(dx)^d, s_Y=y^e B(y)(dy)^d,
    A(0) B(0) != 0.

Every branch y=h_i(x) above (P,Q) obeys

    h_i(x)^e B(h_i(x)) h_i'(x)^d = x^e A(x).         (6)

Its nonzero slope lambda_i=h_i'(0) therefore satisfies

    lambda_i^(e+d)=A(0)/B(0).                       (7)

There are at most n=e+d distinct slopes. Distinct slopes have contact
one. If two different branches have the same slope and contact q>=2,
compose one branch with the inverse of the other. The resulting formal
automorphism h(x)=x+c*x^q+O(x^(q+1)), c!=0, preserves a tensor of the
form x^e U(x)(dx)^d, U(0)!=0. Expanding its pullback, the first possible
change, in relative degree q-1, has coefficient

    (e+d*q)*c.

Indeed the unit ratio U(h(x))/U(x) starts in degree at least q; the
x^e term contributes e*c and the derivative term contributes d*q*c.
The equality of tensors forces e+d*q=0 modulo p, and hence q>=m.
Formal composition preserves the branch contact order, justifying its
use in this calculation.

Let r_PQ be the number of branches at (P,Q), and let r_PQ,lambda be
their numbers in the slope classes (including empty classes up to n
if desired). The local contribution is at least

    binom(r_PQ,2)+(m-1)*sum_lambda binom(r_PQ,lambda,2)
    >= (1/2)*((1+(m-1)/n)*r_PQ^2 - m*r_PQ).         (8)

The last step is Cauchy--Schwarz: the sum of the squares of at most
n class sizes is at least r_PQ^2/n. This inequality also holds for
zero or one branch. Summing over the u*v possible pairs gives

    delta(C) >= (1/2)*(1+(m-1)/n)*|S|^2/(u*v)
                - (m/2)*|S|.

Contributions outside this grid are nonnegative and may be discarded.
Using (4)--(5) and rearranging proves (1). If its left coefficient is
positive, divide by t and use a*b/t=b/sX=a/sY to obtain (2). Substitution
gives (3). QED.

## Reduced unions and arbitrary orbifold atlases

The same inequality holds for a finite REDUCED union of distinct joint
images whose normalized components are etale over both endpoints and
preserve the same two tensors. Replace a,b,t by

    A=sum a_i, B=sum b_i, T=sum(g(Z_i)-1)=A*sX=B*sY.

Indeed, if there are c components, the normalization genus formula gives

    delta(D)=p_a(D)-sum_i g(Z_i)+c-1=D^2/2+T<=AB+T.

The common zero set on the disjoint normalization has size 2dT/e.
The local count includes intersections BETWEEN distinct components;
all branches are still smooth etale graphs. Thus (5)--(8) in the proof
hold unchanged with the total degrees. This is the general reducible
argument used in the previously audited root/contact extension.

In particular, let p>=5 and let C -> S be a representable finite etale
atlas of degree n of a smooth proper effective DM curve. If a rational
one-form on its coarse curve B pulls back to a regular one-form on C
with only simple zeros, then

    n <= (4p/(p-4))(g(C)-1).                              (9)

To apply the union statement, take D=(C x_B C)_red. Its normalization
is C x_S C: the latter is finite over D, normal and etale over both
C factors, and generically identical to D because S is effective.
Both projection degrees of D are n. Every normalized component
preserves the pulled-back form, so the reducible inequality with
e=d=1, m=p-1, n_local=2 gives (9). Wild stabilizers and p-divisible
atlas degrees are allowed. No hypothesis on a second curve appears.

This parameterized atlas corollary was previously written inside
Section1 of the genus-nine all-quotients theorem. Keeping the general
argument here avoids making structural results depend on that
curve-specific theorem or on its later core consequences.

## Exact limitation for higher weights in characteristic five

The coefficient in (1) is positive only if m>e+d+1. Since m<=5, one
needs e+d<=3. The cases (e,d)=(1,2),(2,1) give m=2,3 respectively and
fail this strict inequality. Thus among positive e,d in characteristic
five, this particular bound is effective ONLY for e=d=1. Raising the
tensor to a power does not improve it. The inequality itself is valid
in every allowed weight, but is then only a necessary condition with
nonpositive left coefficient. No higher-weight exclusion is claimed.

This explains precisely which part of the contact budget must improve
to treat the unbounded-weight branch: the available slope classes and
the first allowed same-slope contact leave too much room. A generic
assertion that large tangencies alone supply a contradiction is false.
