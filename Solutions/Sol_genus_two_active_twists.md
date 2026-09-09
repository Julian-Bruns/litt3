# Proof: tiny Cartier blocks, including the unavoidable bad doubles

[Statement](../Theorems/Thm_genus_two_active_twists.md).
Author /root,2026-09-09. Not independently audited.

## 1. The twist block is the actual nilpotent tangent operator

For an active normalized quartic s, the induced infinitesimal Verschiebung
has, up to a nonzero constant, the kernel of t↦C_1(s t) on regular quadratic
differentials. This follows from the square-Hasse/Cartier formula in
Mochizuki II2.11–2.13 and Definition3.1, as explained and source-checked in
[the inverse-character note](../routes/global/ORDINARY_INDIGENOUS_INVERSE_CHARACTER_CARTIER_CRITERION.md).
It commutes with actual etale pullback.

On the connected etale double Y_R with kappa²=R, the anti-invariant
quadratic space is exactly

    kappa eta²,  u kappa eta²,  (v/kappa) eta².             (1)

Here deg R is1 or2. To check completeness and regularity, let the second
involution change v to-v while fixing kappa. Each of its two eigenspaces
in the anti-kappa quadratic space consists respectively of rational
multiples over k(u) of kappa eta² and (v/kappa)eta². At every finite
branch point a pole in that rational coefficient would lower the order
by at least2, whereas the displayed factors have order0 or1. At other
finite points no pole is allowed either. Thus the coefficients must be
polynomials. At infinity their orders are4-deg R and deg R-1, giving
polynomial degree at most1 and0, respectively. This proves (1), including
the case in which infinity belongs to the two-torsion branch pair.

Write s=A eta^4. For the first two basis vectors the scalar coefficient
of the input six-tensor is A u^j kappa/v^6. Extract the fifth power
(kappa/v²)^5: the remaining polynomial is A S²u^j. For the third vector
extract (1/(kappa v))^5: the remaining polynomial is A R². Their degrees
are at most13 and8, respectively. Cartier therefore gives exactly the
stated2x2 and1x1 blocks, preserving the two characters. This derives the
test from the actual double, not from an unrelated bundle.

## 2. The exact finite certificate

Use [genus_two_active_critical_quartics](../Theorems/Thm_genus_two_active_critical_quartics.md).
There are fifteen four-branch data c0 S0 eta^4, sixty fiber data
K(h)R0(u)(u-h)² eta^4, and ten split data from unordered pairs of the
five dormant connections. No other active data exist in the stated family.

The certificate specializes t to a root of

    t^13+4t²+3t+3

and verifies this polynomial irreducible overF5. For each of the sixty
fiber data it works in the ENTIRE reduced algebra k[h]/(J), of dimension4,
rather than selecting rational roots. It checks the original quartic
Cartier identity for every datum. All fifteen twisted determinants are
units in every such algebra. It also checks all fifteen four-branch data:
exactly the ten entries in the table fail, with zero scalar block and
invertible2x2 block.

For the ten split data the dormant quintic factors into degrees1,2,2
at this specialization. The certificate splits it in the degree-two
extension, verifies there are five distinct roots, forms ALL ten unordered
pairs, checks their quartic Cartier identities, and checks all150 twists.
All those determinants are nonzero. Thus it checks all1275 nontrivial
twists of the85 active data, not a sample of the geometric points.

The ten zero scalar entries are verified IDENTICALLY overF5[t] in the
same program. For example R0=u-t gives A=(t+1)²G(u), where
G=u(u-1)(u-2)(u-3), and the twist R=u(u-3) has

    [u^4] A R²=(t+1)² [u^4]G(u)[u(u-3)]²=0.

Accordingly (v/kappa)eta² is a nonzero twisted tangent vector. These
are actual bad etale doubles in our family, not artifacts of a finite
sample or of discarded normalization equations.

The full exact certificate ran in about0.5seconds (excluding Sage startup).
It uses no atlas search, large coefficient field from the oper census,
or presumed correspondence.

## 3. Why the specialization proves the high-degree statement

The coefficient matrices are polynomial in the family parameter. The
following explicit bounds ensure that a nonzero polynomial detected by
the specialization cannot vanish at our much higher-degree parameter.

For a four-branch datum A=c0 S0, its coefficients have t-degree at most3.
The product of the2x2 determinant and scalar block has degree at most15;
the2x2 determinant alone has degree at most10. Its specialization proves
nonvanishing of each determinant asserted nonzero in the theorem. The ten
zero scalar identities were checked symbolically.

For a fiber datum retain h as an indeterminate, before reducing modulo J.
Its A has h-degree at most5 and t-degree at most3. The product determinant
therefore has h-degree at most15 and t-degree at most15. The polynomial
J has h-degree4, t-degree at most1, and constant nonzero leading coefficient.
Its resultant with this determinant has t-degree at most

    15*1+4*15=75.

The exact quotient-algebra unit check makes this a NONZERO polynomial.
Thus it excludes bad determinants at every geometric h over every
parameter of degree greater than75, not only at our chosen specialization.

For completeness the split pairs admit an equally bounded norm without
choosing coefficients in a splitting field. Divide the half-difference
of their numerator polynomials by lambda-mu, and call the resulting
quadratic in u Q. From the universal dormant quintic formula its constant
term is

    3[2(lambda²+lambda*mu+mu²)+2F_4(lambda+mu)+3F_4²+F_3],

its u coefficient is3(lambda+mu+3F_4), and its u² coefficient is3.
Replace A=(lambda-mu)² Q² by Q² for the nonvanishing test; the removed
factor is a unit on distinct pairs. The twist determinant D(lambda,mu)
then has t-degree at most18 and degree at most12 in each root variable.

Make the dormant quintic monic, calling it psi. Its coefficients have
t-degree at most3. The polynomial

    P_lambda(mu)=(psi(mu)-psi(lambda))/(mu-lambda)

is monic of mu-degree4, with lambda-degree at most4 and t-degree at most3.
The inner resultant Res_mu(P_lambda,D) has t-degree at most108 and
lambda-degree at most96. Its resultant with psi(lambda) has t-degree
at most

    96*3+5*108=828.

At the checked specialization both resultants are nonzero, because ALL
ordered distinct dormant pairs passed. Hence this is a nonzero polynomial.
The dormant discriminant is already nonzero at every smooth family member.
Parameters of degree greater than828 therefore avoid every bad split
determinant. This establishes the table, with precisely the stated uniform
bound. No bound on the degree of a witnessing etale cover enters.

## 4. From the table to actual unbounded covers

Let E_r be the functorial tangent bundle on Y^(1) in
[ordinary_source_partner_finiteness](../Theorems/Thm_ordinary_source_partner_finiteness.md).
Its L-twisted sections are the just-computed tangent kernels; on an actual
etale cover its pulled-back sections test ordinary status there.

First take a Galois cover q:W→Y with normal5-group P and elementary
abelian2-quotient A2. The intermediate cover T=W/P→Y decomposes its
function algebra into the degree-zero two-torsion character lines H.
Projection formula gives

    H0(T^(1),E_r|T^(1)) = direct-sum_(L in H) H0(Y^(1),E_r tensor L).

The trivial summand vanishes because r is ordinary. Thus T is ordinary
exactly when H contains none of the table's bad classes.

For W→T, the regular representation of P in characteristic5 has a
filtration with trivial factors. Galois descent gives a filtration of
its pushed-forward structure sheaf with factors O_T. Tensoring by E_r
shows that vanishing downstairs implies vanishing upstairs. Conversely,
any nonzero section downstairs pulls back injectively. This proves the
claimed equivalence for Galois q, without division by its degree.

For a non-Galois intermediate cover, ordinary status on W descends by
section injectivity. If the intermediate cover itself trivializes a bad
line, it dominates the corresponding bad double, so nonordinariness
persists. A bad line on the Galois closure alone supplies no converse.

Finally apply ordinary-source partner finiteness to the ACTUAL common
source whenever the sufficient criterion holds. This retains both maps
and gives finiteness for that monodromy subclass. It says nothing about
general simple factors or the remaining nonordinary joint sources.
