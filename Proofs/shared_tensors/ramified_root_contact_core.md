# Ramified roots amplify contact

Version3,2026-09-24.
[Statement](../../Theorems/shared_tensors/ramified_root_contact_core.md).
Use c,d0,e0,N,q,mu from the statement and put gx=g(X)-1, gy=g(Y)-1.

## 1. Use the entire root covers

The normalized d-th-root cover pi_X has tautological one-form alpha
with alpha^d=pi_X^*s_X. It may be disconnected. Every component A_i->X
has the same degree h_X dividing d, ramification index d0 above D_X,
and no other ramification. The form alpha has zero order N-1 there.
Writing R_A for the reduced inverse image of D_X gives

    g(A_i)-1=h_X*(N-1)*gx/e0,       deg R_A=2h_X*gx/e0.      (1)

Construct B_j->Y similarly, with component degree h_Y.

For each original span, equality of its tensors identifies the two
pulled-back root covers. Use this whole degree-d cover of Z. Its
components W map etale to their endpoint components A_i,B_j. Each W
is birational to its joint image: the two endpoint fields contain the
original compositum k(Z), and either tautological root generates k(W).
These images are distinct. Projection to X times Y recovers the
original jointly minimal image, and the endpoint root recovers its
upper component. Thus their union in each A_i times B_j is reduced.

Let a,b be the total original projection degrees and t=a gx=b gy.
For the reduced upper union C_ij, write a_ij,b_ij for its projection
degrees. Counting all root components gives

    sum a_ij=(d/h_X)a,       sum b_ij=(d/h_Y)b,
    a_ij*h_X*gx=b_ij*h_Y*gy.                               (2)

## 2. The amplified local contact

At a root-grid point above D_X times D_Y, choose parameters x=A0^d0,
y=B0^d0. A downstairs branch y=psi(x) lifts equivariantly as

    B0=A0*U(A0^d0),       U(x)^d0=psi(x)/x.

Both tautological forms have order N-1, so the upper slope eta=U(0)
satisfies eta^N=kappa for a fixed kappa!=0. There are at most N slopes.

For two distinct branches with the same upper slope, their downstairs
slopes agree. If their downstairs contact is I>=2, comparison of the
first changed coefficient of x^e*unit*(dx)^d gives e+dI=0 in k, hence
I>=q. The downstairs germs cannot coincide: their lifted unit root
with fixed constant U(0) is unique because p does not divide d0.
The exact upper contact is therefore

    1+d0*(I-1)>=1+mu.                                     (3)

Different slopes have contact1. For r branches at a grid point, divided
into at most N slope classes of sizes r_l, their intersection contribution
is at least

    binom(r,2)+mu*sum_l binom(r_l,2)
      >=(1+mu/N)*r²/2-(1+mu)*r/2.                         (4)

## 3. One intersection budget for all components

Put V=sum_ij a_ij*b_ij, and let S be the total number of normalized
branches above the root grids. From (1)--(2),

    S=2d*t/e0,       sum_W(g(W)-1)=(N-1)S/2.               (5)

On each product A_i times B_j, Hodge index and adjunction give
delta(C_ij)<=a_ij*b_ij+sum_(W in C_ij)(g(W)-1), as in the
[reduced-union contact proof](contact_degree_bound.md#1-global-intersection-budget).
The grid has 4h_X*h_Y*gx*gy/e0² points and its branch count is
S_ij=2a_ij*h_X*gx/e0, so S_ij²/grid=a_ij*b_ij. Summing (4) over
each grid and then over the component products yields

    (1+mu/N)V/2-(1+mu)S/2 <= sum delta(C_ij)
                           <= V+(N-1)S/2.

Thus

    (mu-N)V/(2N)<=(N+mu)S/2=d*(N+mu)*t/e0.                (6)

It remains to bound V without choosing one component above each Z.
Put h=gcd(h_X,h_Y), L=lcm(h_X,h_Y). A diagonal mu_d orbit of component
pairs has d/h elements, and there are d/L such orbits. The full
pullback of any connected Z occupies one entire orbit. If the union
uses m orbits, the number of occupied pairs is K=md/h. The common
positive ratio in (2) and Cauchy--Schwarz give

    V >= (sum a_ij)(sum b_ij)/K = d*a*b/(mL).

Substitution in (6) proves

    ab <= 2mL*N*(N+mu)*t/[e0*(mu-N)].                      (7)

Divide by t to obtain both degree bounds. One class gives the L
coefficient; m<=d/L gives the unrestricted coefficient d. This retains
all components of disconnected root covers and needs no individual
upper-component degrees.

For \(d=p+2,e=2\) and every odd \(p\ge5\), one has
\(p\nmid d(e+d)\), \(q=p-1\), and
\(d(q-2)=(p+2)(p-3)>2=e\). A reduced matched section of a spin
line to power \(p+2\) squares to exactly this shared weight-\(d\)
tensor, so the core conclusion applies in any genera. For
d=7,e=2,p=5, the values are d0=7,e0=2,N=9,q=4,mu=21. Both root
covers are connected, and (7) gives ab<=(315/2)t. For genus-two Y,
the integral total degree toward X is at most157.

## 4. The finite relation gives a core

Apply the bound to the four ordered endpoint pairs from X disjoint_union Y,
with their specified tensors. Each distinct jointly minimal preserving
image contributes a positive integral degree, so there are finitely many.
The family contains the diagonals and is closed under transpose and
normalized fiber-product composition. Etaleness and tensor equality
survive these operations and joint minimalization.

If a preserving span exists, this relation connects X and Y. The
[finite correspondence groupoid theorem](../quotient_geometry/finite_correspondence_groupoid.md)
therefore gives a common connected effective proper smooth DM curve S
with finite etale atlases from X and Y. In each original specified source
field, k(S) is a nonconstant subfield of both endpoint fields. This is
the asserted core.

The extra local input is root equivariance, which amplifies contact
by (3). Merely using the zero order of the upper one-form would lose
that gain. The argument supplies no shared tensor and gives no degree
bound when mu<=N.
