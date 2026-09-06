# Pluricanonical realizations jointly detect actual bi-etale cycles

Date: 2026-09-05. Status: author proof, not independently audited. This is
a faithful realization result for characteristic-p coefficient cycles,
not an obstruction to the existence of a common etale cover and not a
solution of Litt3.

## 1. Coefficients and the realization

Let k be algebraically closed of characteristic p>0. All curves below
are smooth, projective, connected, and of genus at least two. Let E_k(X,Y)
be the free k-vector space on the distinct joint-minimal bi-etale images
in X times Y. Its composition is the integral actual-cycle composition
of Sections 1-2 of
[the refinement-block construction](BIETALE_REFINEMENT_BLOCKS_AND_POSITIVE_CORRESPONDENCE_CATEGORY.md),
with its nonnegative integer structure constants mapped to k. In
particular a connected span factoring through its joint-minimal
normalization with degree e represents e times that basis image, with e
read in k. This is not the complex positive-trace category of that note.

Write omega_X for the canonical line bundle. For a finite etale map
h:U -> V, its differential gives a canonical isomorphism

    D_h: h^* omega_V -> omega_U.

For every integer m>=0, put L_X=omega_X^{tensor m}. For a span
Gamma=(X <-f C ->g Y), define

    T_m(Gamma): H^0(X,L_X) -> H^0(Y,L_Y)
    T_m(Gamma) = Tr_g o (D_g^{tensor m})^{-1}
                       o D_f^{tensor m} o f^*.

Here Tr_g on g^*L_Y is the ordinary finite-flat trace on g_*O_C
tensored with L_Y, followed by global sections. This is an unnormalized
trace: there is no division by deg(g).

## 2. Functoriality, including degrees divisible by p

**Proposition 1.** Each T_m is a k-linear functor on E_k, with object
assignment X |-> H^0(X,omega_X^{tensor m}).

**Proof.** The identities needed are base change of trace, transitivity
of trace, the projection formula, and compatibility of differential
pullback isomorphisms with composition. They hold for arbitrary finite
etale maps. One can check the trace identities after an etale faithfully
flat base change splitting each relevant finite etale cover: trace then
is summation over a finite set, base change preserves this sum, and
transitivity says an iterated sum is the sum over pairs. This argument
does not assume that the number of summands is invertible in k.

Explicitly, for composable spans

    X <-f C ->g Y,       Y <-h D ->j Z,

put W=C times_Y D, with projections a:W->C and b:W->D. Base change for
the square gives h^*Tr_g=Tr_b a^*, with the pulled-back line bundles
understood. Differential compatibility and the projection formula move
the line-bundle identifications through this equality. Transitivity
Tr_j Tr_b=Tr_{j b} then gives

    T_m(D) T_m(C) = T_m(X <-f a W ->j b Z).

For a disconnected W, trace adds the contributions of its components.
If a connected component has joint-minimal normalization M and the
refinement map q:W_0->M has degree e, the two differential pullbacks
through q cancel in the comparison of endpoint bundles. Projection
formula and transitivity reduce its operator to that of M times
Tr_q(1)=e. Thus

    T_m(W_0)=e T_m(M).

This is exactly the minimalization multiplicity defining E_k. The
diagonal acts as identity, which proves the proposition. In particular,
an entire refinement of degree divisible by p acts by zero, exactly as
its represented cycle does in E_k. QED.

## 3. A finite-support independence bound

**Theorem 2.** Fix distinct joint-minimal correspondences
Gamma_1,...,Gamma_r from X to Y, with normalizations C_i and right degrees
b_i=deg(C_i/Y). Put N=sum_i b_i. If

    (m-1)(2g(X)-2) > N,                                  (1)

then T_m(Gamma_1),...,T_m(Gamma_r) are linearly independent over k.
Consequently the family of all T_m is jointly faithful on every Hom
space of E_k. One sufficient explicit choice is

    m = floor(N/(2g(X)-2)) + 2.

**Proof.** Take a geometric generic point y of Y, with field
Omega=an algebraic closure of k(Y). Each finite etale map C_i->Y has
exactly b_i distinct Omega-points above y. Their images in X_Omega are
distinct, both within a single i and across different i.

Here is the geometric justification for the latter assertion. The
normalization C_i->Gamma_i is an isomorphism over a dense open of the
integral image Gamma_i; its exceptional set has finitely many points.
Different integral image curves Gamma_i,Gamma_j in X times Y intersect
in finitely many points. All these exceptional or intersection points
project into a finite subset of Y, so a geometric generic y avoids
them. Equal X-coordinates over this y would mean equal points of
X times Y, contradicting one of these two facts. Denote the resulting
N distinct points of X_Omega by x_{i,t}, for 1<=t<=b_i.

Evaluate the output T_m(Gamma_i)(s) at y. Splitting the etale fiber turns
the trace into the sum over its geometric points. Thus

    T_m(Gamma_i)(s)(y)
        = sum_{t=1}^{b_i} lambda_{i,t}(s(x_{i,t})),          (2)

where lambda_{i,t} is an isomorphism from the fiber of L_X at x_{i,t}
to the fiber of L_Y at y, induced by the two etale differential maps.
Every lambda_{i,t} is nonzero. After choices of fiber bases, these are
nonzero scalar weights.

Let A=sum_{i,t} x_{i,t}, a reduced effective divisor of degree N on
X_Omega. Condition (1) is precisely

    deg(L_X(-A)) = m(2g(X)-2)-N > 2g(X)-2.

Serre duality makes H^1(X_Omega,L_X(-A)) vanish: its dual line bundle
has degree (1-m)(2g(X)-2)+N<0. The divisor exact sequence consequently
makes the evaluation map surjective:

    H^0(X_Omega,L_X) -> direct_sum_{i,t} (L_X)_{x_{i,t}}.

Now suppose sum_i c_i T_m(Gamma_i)=0 with c_i in k. Extend scalars to
Omega; global sections commute with this field extension. The relation
therefore vanishes on every section over Omega. Choose such a section
whose value at any one prescribed x_{i,t} is nonzero and whose values
at all other N-1 points are zero. Equation (2) forces
c_i lambda_{i,t}=0, hence c_i=0. Doing this for every i proves linear
independence. Every cycle has finite support, so a nonzero cycle is
detected for every m satisfying (1) for its support. QED.

There are no derivatives or jets in (2). Distinct points suffice, and
the tensor power of an invertible differential comparison remains
invertible even when p divides m. Although a sum of equal values can
vanish when p divides b_i, the interpolation argument prescribes the
individual values independently. Hence divisibility of b_i by p is
not an obstruction either.

## 4. Quantitative rank growth for each fixed nonzero cycle

**Corollary 3.** Let alpha=sum_i c_i Gamma_i be nonzero, with each
c_i nonzero and the Gamma_i distinct. Put N=sum_i b_i. For any positive
integer r such that

    (m-1)(2g(X)-2) > Nr,

one has rank_k T_m(alpha)>=r. In particular

    rank_k T_m(alpha)
      >= max(0, floor(((m-1)(2g(X)-2)-1)/N)).              (3)

Thus the ranks grow at least linearly with m for each fixed nonzero
cycle alpha; the stated slope and threshold depend on its support.

**Proof.** Choose distinct points y_1,...,y_r of Y such that all Nr
points of X lying under the C_i-fibers over these y-values are distinct.
These choices exist even over k itself. First avoid the finite bad set
from the proof of Theorem 2. Inductively, if S is the finite set of
previously selected X-points, also avoid the finite sets
g_i(f_i^{-1}(S)) and the previously chosen y-values. The remaining open
of Y has k-points because k is algebraically closed and infinite.

The same divisor argument as before makes evaluation of H^0(X,L_X)
onto the Nr input fibers surjective. Evaluating T_m(alpha) at the r
output points gives r linear functionals on those input fibers. Their
supports are disjoint, one block of N fibers per output point, and
each functional has a nonzero coefficient c_i lambda_{i,t}. Therefore
the map from the direct sum of the Nr input fibers onto the direct
sum of the r output fibers is surjective. Its composition with input
evaluation is exactly output evaluation following T_m(alpha), so
T_m(alpha) has rank at least r. The largest nonnegative integer r
satisfying the strict inequality gives (3). QED.

The same argument can be made after an algebraically closed field
extension, since the rank of a linear map is invariant under field
extension. No degree-uniform rank or faithfulness statement follows:
N varies with the cycle being tested.

## 5. Bounded-degree polynomial detection

**Corollary 4.** Let P be the cycle of a finite bi-etale self-span of X
whose right degree is d (allowing a disconnected source and counting
all its components). Let n>=0 and

    B_n = sum_{j=0}^n d^j.

For every m satisfying (m-1)(2g(X)-2)>B_n and every polynomial
q(t) in k[t] of degree at most n,

    q(T_m(P))=0  if and only if  q(P)=0 in E_k(X,X).       (4)

**Proof.** Before reducing coefficients modulo p, the actual cycle
of P^j is effective and has total right degree d^j, including
minimalization multiplicities. Every basis image occurring with positive
multiplicity has positive right degree, so the sum of the right degrees
of its distinct basis images is at most d^j. Consequently the union of
the supports of 1,P,...,P^n has summed right degree at most B_n. Passing
to k can only remove support. Theorem 2 makes T_m injective on the span
of that union. Functoriality gives (4). QED.

The same statement holds for any effective integral self-cycle P when
d denotes its total right degree, including multiplicities. The
statement does not assert that q(P) is nonzero for every nonzero
polynomial q: a cycle relation may already exist. It says that this
single weight introduces no additional polynomial relation through
degree n.

## 6. Scope and limits

- All coefficients in the realization are in k. An integral relation
  is tested only after reduction modulo p. A nonzero integral cycle
  divisible by p cannot be recovered this way. There is no implication
  for arbitrary complex-coefficient relations in the positive-trace
  category, nor a comparison homomorphism from that category to E_k.
- The bound depends on the finite support and its right degrees. No
  fixed weight is shown faithful on an entire infinite-dimensional Hom
  space. Indeed a fixed H^0-to-H^0 operator space is finite-dimensional.
- This construction uses actual etale differential geometry and
  distinguishes every characteristic-p actual cycle in some weight.
  It does not show that a seed correspondence cannot exist, bound its
  generated supports, or force a cycle polynomial to be nonzero.
- No positivity or adjointness assertion for T_m is made. Faithfulness
  of the family over k and positivity of the separate complex diagonal
  trace are distinct results with different coefficient fields.
