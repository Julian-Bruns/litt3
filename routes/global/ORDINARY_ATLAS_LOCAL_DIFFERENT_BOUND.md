# Cartier bounds on wild inertia from a possibly non-Galois étale atlas

**Status:** independently audited **PASS**, 2026-09-05.
Auditor: `/root/x_elliptic_quotient_maps`. No breaking objections; the
non-Galois local chart argument, Cartier bounds, and stated consequences
were checked. The common-orbifold existence assumption remains essential.
[Audit record](audits/ORDINARY_ATLAS_AND_WEAK_TWO_POINT_AUDIT.md).

This is a parameterized necessary condition, not a construction of a common
orbifold. It preserves the actual étale atlas and does not assume its coarse
map is Galois. The fixed pair is still the pair in file 76.

## 1. Statement

Let k be algebraically closed of odd characteristic p. Let S be a smooth
proper effective Deligne--Mumford orbifold curve with coarse curve P1.
Suppose a smooth projective connected curve C admits a representable finite
étale map to S. Let q:C -> P1 be its coarse map.

At the i-th stacky point, let I_i be the inertia group, e_i its order, and
d_i the different exponent of its action on the completed local disc.
Set

\[
 \alpha_i=d_i/e_i,\qquad h_i=\lfloor\alpha_i\rfloor,
 \qquad w=\#\{i:p\mid e_i\}.
\]

Write f_C for the p-rank of C and a_C for the dimension of the kernel of
Cartier on H0(C,omega_C). Then

\[
 \boxed{\quad f_C\ge\max(w-1,0),\qquad
 g(C)-f_C\ge\sum_i\max(h_i-1,0).\quad}                 \tag{1}
\]

There is also the sharper one-step bound

\[
 \boxed{\quad
 a_C\ge\sum_{h_i\ge1}
 \left(h_i-1-\left\lfloor\frac{h_i-1}{p}\right\rfloor\right).
 \quad}                                               \tag{2}
\]

In particular, if C is ordinary, every local inertia type satisfies

\[
                         d_i<2e_i.                    \tag{3}
\]

These are inequalities for every actual atlas C of S. For a common
orbifold of two curves they apply separately to both curves, with the
same local numbers e_i,d_i. The degrees of the two atlases may differ.

## 2. Why the local data are uniform without a Galois hypothesis

The completed local stack at a stacky point is the quotient of a formal
smooth disc by its faithful finite inertia group. Pulling an étale atlas
back to that chart gives, at each point over it, an isomorphism of completed
smooth discs. Thus every point of C over the i-th branch point has coarse
ramification index e_i and different exponent d_i. Away from the stacky
points, q is étale. In particular q is separable.

For a rational differential eta on P1 and a point P of C over the i-th
branch point, the local different formula is

\[
       \operatorname{ord}_P(q^*\eta)
         =e_i\operatorname{ord}_{q(P)}(\eta)+d_i.       \tag{4}
\]

Consequently every differential with pole order at most h_i at that branch
point, and no poles elsewhere, pulls back to a holomorphic differential
on C. The pullback is injective because q is separable.

For tame inertia, d_i=e_i-1 and h_i=0. For wild inertia, put
|I_i|=mP with P a positive power of p and m prime to p. The first two lower
ramification groups have orders mP and P. Hence

\[
 d_i\ge(mP-1)+(P-1)=e_i+P-2>e_i,
\]

so h_i>=1. Thus h_i>=1 holds precisely at the wild points.

## 3. The entire rational differential space and its Cartier action

Put D=\sum_i h_i s_i on P1, omitting the terms h_i=0. Formula (4) gives
a Cartier-compatible injection

\[
 V=H^0(\mathbf P^1,\omega_{\mathbf P^1}(D))
           \hookrightarrow H^0(C,\omega_C).           \tag{5}
\]

If w=0, V=0 and all assertions follow. Suppose w>=1 and choose the
coordinate on P1 so that one of these w points is infinity.

The space V is the direct sum of the following explicit spaces:

* logarithmic differentials dt/(t-a), one for each of the w-1 finite
  marked points; their poles at infinity are simple;
* differentials (t-a)^(-j)dt with 2<=j<=h_i at each finite marked point;
* differentials t^(j-2)dt with 2<=j<=h_infinity at infinity.

This follows either by partial fractions or by counting the independent
principal parts: the total dimension is
(w-1)+\sum_i(h_i-1)=\deg D-1, as required by Riemann--Roch.

Cartier fixes the displayed logarithmic differentials and acts bijectively
semilinearly on their span. On the other displayed basis vectors it is
nilpotent. Indeed, in a local coordinate u, Cartier kills u^a du unless
a is congruent to -1 modulo p, in which case it sends it to
u^((a+1)/p-1)du. A higher-order pole therefore either disappears or has
its pole order minus one divided by p; after finitely many iterations it
disappears. The same calculation in u=1/t handles infinity. These two
spans are Cartier-stable.

Thus V has Cartier-bijective part of dimension w-1 and Cartier-nilpotent
part of dimension \sum_i(h_i-1). On H0(C,omega_C), the corresponding
dimensions are f_C and g(C)-f_C. The injection (5) proves (1).

The one-step kernel in the higher-pole span has one basis vector for every
1<=b<=h_i-1 not divisible by p: at a finite point it is a nonzero scalar
multiple of d((t-a)^(-b)), and at infinity of d(t^b). Its dimension is
the right side of (2). This proves (2).

For an ordinary curve, Cartier has zero nilpotent part; (1) implies h_i<=1
for every i, proving (3).

There is a shorter proof of (3) alone. If d_i>=2e_i, choose t with its sole
simple pole at s_i. Then q*dt=d(t\circ q) is nonzero, exact, and globally
holomorphic by (4). Cartier kills it, contradicting ordinarity.

## 4. Consequences independent of the atlas degree

### No one-point hyperbolic orbifold with an ordinary atlas

An ordinary curve of genus at least two cannot be an étale atlas of a
rational-coarse orbifold with exactly one stacky point. Indeed, étale
Riemann--Hurwitz gives

\[
 2g(C)-2=\deg(q)\left(-2+\frac d e\right)>0,
\]

whereas (3) makes the right side negative. This excludes arbitrary wild
inertia, not just a p-group, and arbitrary atlas degree.

### Pure p-group inertia must be weakly ramified

If I_i=P is a p-group, its lower ramification filtration has G0=G1=P,
and

\[
 d_i=2(|P|-1)+T_i,\qquad
 T_i=\sum_{j\ge2}(|G_j|-1).
\]

Equation (3) says T_i<2. Every nonzero summand is at least p-1>=2,
so T_i=0. Therefore G2=1. This conclusion is local; it does not say that
the global monodromy of the coarse cover is a p-group.

### Scope for the fixed pair

For the fixed X and Y, g(X)=9, f_X=6, and Y is ordinary of genus25.
If they have a common effective orbifold with rational coarse curve,
then (3) applies at every inertia point, the one-point case is impossible,
and every pure 5-group inertia is weakly ramified. Also w<=7 from X.

Nothing here proves that an arbitrary common étale cover admits a finite
common orbifold. Coreless correspondences remain a separate possibility.
Mixed inertia with a nontrivial tame quotient is not asserted to be weakly
ramified: (3) bounds its full different ratio, which is a weaker condition.
