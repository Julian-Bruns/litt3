# Connecting-class generation and a common quotient at equality

**Status: author proof. 2026-09-05. Not independently audited.**

This note strengthens the actual connecting-class argument in file 101.
Its coefficient sections have no base points. More substantially, equality
in both degree bounds forces the integral joint image to be an entire fiber
product over a common projective line. Thus the equality case has a
nonconstant core, not merely a numerical constraint.

The structural statements below hold over any algebraically closed field.
The differential origin of the descended unit is not needed in their
proofs. In the application to file 101, the same joint image and the same
normalization retain both finite etale maps throughout.

## 1. The coefficient spaces globally generate

Let X and Y be smooth projective connected curves. Let Gamma be an
integral effective divisor in S = X x Y, with both projections nonconstant,
and suppose

\[
                  \mathcal O_S(\Gamma)=A\boxtimes B.
\]

In particular, deg A and deg B are positive. Let P on X and Q on Y be
line bundles of positive degree, and suppose there is a trivialization

\[
 t:\mathcal O_\Gamma\xrightarrow{\sim}
                         (P\boxtimes Q^{-1})|_\Gamma.
                                                        \tag{103.1}
\]

Write L_X = P A^{-1} and L_Y = Q B^{-1}. The restriction sequence gives
an injective connecting map on global sections, since
H^0(S,P boxtimes Q^{-1}) = 0. In particular,

\[
 \delta_X(t)\in H^0(X,L_X)\otimes
                     H^1(Y,Q^{-1}B^{-1})              \tag{103.2}
\]

is nonzero. The other Kunneth summand vanishes because
H^0(Y,Q^{-1}B^{-1}) = 0. Let U_X be the image of the contraction map

\[
 H^1(Y,Q^{-1}B^{-1})^*\longrightarrow H^0(X,L_X)
\]

defined by this tensor. Define U_Y analogously using t^{-1}, interchanging
the two factors.

### Theorem 103.1

The evaluation maps

\[
 U_X\otimes\mathcal O_X\twoheadrightarrow L_X,
 \qquad U_Y\otimes\mathcal O_Y\twoheadrightarrow L_Y
                                                        \tag{103.3}
\]

are surjective.

#### Proof

Fix a closed point x in X, and put D_x = Gamma cap ({x} x Y), with its
scheme structure. Gamma has no vertical component, so its defining
section restricts to a nonzero section of A_x tensor B on Y. Consequently
D_x is a nonempty effective Cartier divisor of degree deg B. It can be
nonreduced. Restricting the divisor sequence to the fiber is nevertheless
exact:

\[
 0\longrightarrow (L_X)_x\otimes Q^{-1}B^{-1}
 \longrightarrow P_x\otimes Q^{-1}
 \longrightarrow (P\boxtimes Q^{-1})|_{D_x}
 \longrightarrow0.                                    \tag{103.4}
\]

Equivalently, exactness follows because the finite morphism Gamma -> X
is flat: its finite module is torsion-free over the local discrete
valuation ring of the smooth curve X.

The restriction t_x remains a trivialization on the entire finite scheme
D_x. In particular it is a nonzero global section, including when D_x
is nonreduced. Since H^0(Y,P_x tensor Q^{-1}) = 0, the connecting map
for (103.4) is injective. Its value on t_x is therefore nonzero.

Naturality of the restriction connecting maps, together with the Kunneth
identification (103.2), identifies that fiber connecting class with

\[
 (\operatorname{ev}_x\otimes1)\delta_X(t)
 \in (L_X)_x\otimes H^1(Y,Q^{-1}B^{-1}).                 \tag{103.5}
\]

Thus the coefficient sections in U_X do not all vanish at x. This holds
for every closed point, so Nakayama's lemma gives the first surjection in
(103.3). Applying the same argument to t^{-1}, with X and Y interchanged,
gives the second. \(\square\)

This is a statement about the coefficient span of the specified class,
not just the complete linear series of L_X or L_Y. No reduction of a
fiber to its support is used.

## 2. A general equality theorem for a split divisor

### Theorem 103.2

Let A and B have positive degree on X and Y, and let Gamma be an integral
effective divisor in |A boxtimes B| with both projections nonconstant.
The following are equivalent:

1. (A boxtimes B^{-1})|_Gamma is trivial.
2. There are basepoint-free pairs
   a_0,a_1 in H^0(X,A) and b_0,b_1 in H^0(Y,B) such that, after multiplying
   a defining section by a nonzero constant,

\[
                  F(x,y)=a_0(x)b_0(y)+a_1(x)b_1(y)
                                                        \tag{103.6}
\]

   defines Gamma scheme-theoretically.
3. There are nonconstant morphisms

\[
 h_X:X\to\mathbf P^1,\qquad h_Y:Y\to\mathbf P^1,
 \qquad h_X^*\mathcal O(1)=A,
        \quad h_Y^*\mathcal O(1)=B,
                                                        \tag{103.7}
\]

   whose full scheme-theoretic fiber product is Gamma in X x Y.

Consequently, if Z normalizes Gamma, then k(X) cap k(Y) in k(Z)
contains the nonconstant rational subfield obtained by pulling back
k(P^1). The degrees of the displayed maps are deg A and deg B.

#### Proof of 1 implies 2

Put M = A boxtimes B^{-1}, and choose a nowhere-vanishing section t of
M|_Gamma. The exact sequence

\[
 0\longrightarrow\mathcal O_X\boxtimes B^{-2}
 \xrightarrow{\ F\ }A\boxtimes B^{-1}
 \longrightarrow M|_\Gamma\longrightarrow0            \tag{103.8}
\]

has H^0(S,M) = 0. Its connecting class is therefore nonzero and, by
Kunneth, has the form

\[
                \delta(t)=1\otimes\eta,
                \qquad \eta\in H^1(Y,B^{-2}).          \tag{103.9}
\]

Choose the rank-two extension on Y

\[
             0\longrightarrow B^{-1}
               \longrightarrow E\xrightarrow{\pi}B
               \longrightarrow0                      \tag{103.10}
\]

with extension class -eta. The sign is chosen for the Cech convention
used below; changing that convention only changes a final section by -1.
The image of delta(t) in H^1(S,M) is zero. Hence the obstruction to
lifting F through A boxtimes E is zero, and there is a section

\[
 s\in H^0(S,A\boxtimes E),\qquad (1\boxtimes\pi)(s)=F.
                                                        \tag{103.11}
\]

We check the crucial point: s is nowhere zero. Locally choose splittings
sigma_i of (103.10), and write

\[
                    s=\sigma_i(F)+q_i,
                    \qquad q_i\in A\boxtimes B^{-1}.
\]

On overlaps,

\[
                  q_j-q_i=-(\sigma_j-\sigma_i)(F).
\]

Since F vanishes on Gamma, the q_i restrict to a global section t' of
M|_Gamma. Dividing the displayed differences by F computes its connecting
class in (103.8): with the chosen extension sign it is eta. Thus
delta(t') = delta(t). The connecting map is injective because H^0(S,M)=0,
so t'=t. With the opposite sign convention one obtains t'=-t, which has
the same nowhere-vanishing property.

Away from Gamma, the quotient F of s is nonzero. On Gamma, the component
of s in A boxtimes B^{-1} is the unit t. Therefore s has no zero anywhere
on S, including over singular points of Gamma.

Now det E = O_Y. By Kunneth, s lies in H^0(X,A) tensor H^0(Y,E). For
any y in Y, its restriction s_y is a nowhere-zero section of A tensor
the two-dimensional vector space E_y. If the evaluation image
H^0(Y,E) -> E_y had dimension at most one, s_y would be a single section
of A times a fixed vector. Every nonzero section of the positive-degree
line bundle A vanishes somewhere, a contradiction. Hence that evaluation
map has rank two.

Choose two global sections of E independent at one point y. Their wedge
is a global section of det E = O_Y that is nonzero at y, and therefore a
nonzero constant. They trivialize E on all of Y. Under this trivialization
s is a pair (a_0,a_1) of sections of A with no common zero, and pi is a
pair (b_0,b_1) of sections of B with no common zero. Equation (103.11)
becomes (103.6). This proves 2.

#### The remaining implications

From 2 take

\[
               h_X=[a_0:a_1],\qquad h_Y=[-b_1:b_0].
\]

Their pairs are basepoint-free and their pullbacks of O(1) are A and B.
Positive degree makes both maps nonconstant. The diagonal equation on
P^1 x P^1 pulls back to (103.6), so the full scheme-theoretic fiber
product is exactly Gamma. This proves 3.

Conversely, on such a fiber product the pullbacks of A and B are both
the pullback of O_{P^1}(1) by the common composite. They are isomorphic,
which proves 1. The common rational subfield assertion follows by passing
to the normalization. \(\square\)

## 3. Application to the equality case of file 101

Keep the setup of file 101: g(X),g(Y) >= 2, s_X=g(X)-1,
s_Y=g(Y)-1, Hom(J(X),J(Y))=0, and Gamma is the primitive integral joint
image with normalization Z and both maps f:Z -> X, g:Z -> Y finite etale.
Write d_X=deg f and d_Y=deg g, so s_X d_X=s_Y d_Y and
O_S(Gamma)=A boxtimes B with deg A=d_Y, deg B=d_X.

Suppose n is positive and M^n|_Gamma is trivial for
M=omega_X boxtimes omega_Y^{-1}. Apply Theorem 103.1 to
P=omega_X^n and Q=omega_Y^n. If

\[
                          d_Y=2ns_X,                   \tag{103.12}
\]

then the etale degree relation also gives d_X=2ns_Y. Both L_X and L_Y
have degree zero and are generated by their connecting-class coefficient
spaces, so

\[
                        A\simeq\omega_X^n,
                        \qquad B\simeq\omega_Y^n.      \tag{103.13}
\]

Theorem 103.2 now produces nonconstant maps h_X,h_Y to P^1 whose full
fiber product is Gamma, with

\[
 \deg h_X=d_Y=2ns_X,\qquad
 \deg h_Y=d_X=2ns_Y,\qquad h_X\circ f=h_Y\circ g.       \tag{103.14}
\]

In particular the core k(X) cap k(Y) in k(Z) is nonconstant.

These quotient maps are separable. Indeed, in positive characteristic,
if a=h_X^*(u) were a p-th power in k(X), its pullback would have zero
differential in k(Z). Since k(Z)/k(Y) is separable, the common function
b=h_Y^*(u) would then have zero differential in k(Y), hence b=v^p there.
Writing also a=w^p, on a product of dense affine open sets the defining
equation of the fiber product would be

\[
                          a-b=(w-v)^p.
\]

This makes the divisor nonreduced at its generic point, contradicting
the integrality of Gamma. The same argument applies with X and Y
interchanged. In characteristic zero separability is automatic.

Only the numerical relation and this last separability observation use
the original etale hypotheses after the split divisor and descended unit
have been supplied. Theorems 103.1 and 103.2 themselves apply to any
trivialization; they do not distinguish the differential trivialization
tau^n from another unit. In file 101 every trivialization pulls back to
a constant multiple of tau^n, so this distinction causes no loss in the
equality application.

## 4. Boundary

The coefficient spaces globally generate in every degree range. The
rank-two bundle used in Theorem 103.2 has determinant O_Y specifically
at equality; its trivialization is the step producing the separated
two-term equation and the common projective line.

No implication from M^n|_Gamma trivial to a nonconstant core has been
proved here when both L_X and L_Y have positive degree. Thus this note
settles the equality case and supplies the exact basepoint-free coefficient
spaces for further work, but does not exclude arbitrary larger gluing
orders or solve the full common-cover problem.
