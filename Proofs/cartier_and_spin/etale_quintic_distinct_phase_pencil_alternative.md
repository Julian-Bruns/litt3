# Etale quintic distinct-phase pencil alternative: proof

Version 1. 2 October2026. [Focused whole-argument review](../../Research/audits/DISTINCT_PHASE_QUINTIC_PENCIL_AUDIT_2026_10_02.md) PASS. The argument is independent of numerical
phase certificates: the theorem states its needed phase hypotheses.
The actual etale pi and original section a are retained throughout.

## Local coefficient identity

The norm of a gives div(c5)=2D0, so |D0|=5m/2. At Q use its local
H-frame and the etale splitting to factor
F=(Z^2-s0 Z+p0)(Z^3+d1 Z^2+d2 Z+d3).
The two zero sections vanish simply, so ord(s0)=1, ord(p0)=2,
and d3 is a unit. Here c!=-1 because its order divides29. Their
ratio hypothesis gives ord(s0^2-Kp0)>=4. Also K!=0,4: these
equalities would give c=-1,1, respectively. Direct multiplication gives
c3=d3-s0 d2+p0 d1, c4=-s0 d3+p0 d2, c5=p0 d3,
and
c4^2-Kc3c5=(s0^2-Kp0)d3^2+(K-2)s0p0d3d2+p0^2(d2^2-Kd3d1).
Consequently c3 is a unit, c4 vanishes at least once and s vanishes
at least three times at every D0 point. This does not require the
three nonzero values to be distinct.

## Separating pencils

If s!=0, B=H^8(-3D0) has degree m/2 and B^2=H, since
O(2D0)=H^5. The section s gives a section b_B of B with zero
divisor DB. The quotient r=s/c5 is a global section of H^3 and
div(r)=D0+DB. Dividing it by b_B^6 gives a scalar rational function
with divisor D0-5DB and pole degree at most5m/2. There is a point
of D0 outside DB, since deg DB=m/2<|D0|. At that point the
function has a simple zero. It is therefore nonconstant and separating.

Suppose s=0. The identity c4^2=Kc3c5 and the unit property of c3
on D0 give div(c3)=2D3 and div(c4)=D0+D3, with D3 effective,
disjoint from D0 and of degree3m/2. Set L=O(D3)H^-1. Then
L^2=H, O(D3)=L^3 and O(D0)=L^5. Choose sections p,q0 with
these divisors; rescale by constants in k so that
c3=p^2, c5=q0^2, c4=kappa p q0, kappa^2=K.
If c1!=0, q0 and c1p are independent sections of L^5: the second
vanishes on the nonempty D3 and the first does not. Their common
zero divisor lies in D0 intersect div(c1), and has degree at most m.
The associated pencil therefore has degree between3m/2 and5m/2.
At some point of D0 outside div(c1), (c1p)/q0 has a simple pole;
it is separating.

## The remaining rational pullback

Now suppose s=c1=0. At each D0 point the sum of the three nonzero
values is zero. Express them as a common nonzero scalar times
1,zeta,zeta^2, for a primitive cube root zeta. Their integer
multiplicities total3. The minimal polynomial of zeta over F5 is
Z^2+Z+1, so zero sum makes all three multiplicities congruent
modulo5, and hence all equal1. Their pairwise sum is then zero.
Thus c2 vanishes at every D0 point. Since deg H^2=2m<|D0|,
c2=0 identically.

On ORIGINAL T put b=a p/q0, and on S put f=q0^3/p^5. Substitution
in the original polynomial gives
f b^5+b^2+kappa b+1=0.
Because a was primitive, k(T)=k(S)(b). This proves that the actual
pi is the degree-five pullback of the asserted R. The divisor of f
is3D0-5D3. Its zeros on D0 have order3, so f is separating.

## Wild splitting field and divisibility

R has a unique pole b=0 of order5. For its target parameter 1/f,
the derivative at b=0 has order5, since kappa!=0. Its totally
ramified root extension L0/K0 of degree5 thus has different5.
Let E/K0 be its local splitting field. Local inertia is transitive
on five roots and its wild subgroup is a normal C5. Consequently
inertia lies in the normalizer F20 of C5 in S5, and has order5d
with tame complement d dividing4. Its lower groups are I0 of
order5d, followed by C5 through some last index t>=1. Hence
delta(E/K0)=5d-1+4t. The extension E/L0 has tame degree d, so
the different tower gives
5d-1+4t=(d-1)+d*5.
Therefore d=4t, forcing d=4,t=1. Inertia is F20, with index20
and different23.

At a point of D3 of multiplicity v, the map f has local degree5v.
Etaleness of ORIGINAL pi over an algebraically closed residue field
means its completed algebra is five copies of the completed S-field.
All five R-roots therefore lie in that completed field, which contains
the full local splitting field E. Its ramification index20 must
divide5v. Every v is divisible by4. Since sum(v)=3m/2, one obtains
8|m. No assertion about inertia of an unrelated source function is used.

R has tame index3 at b=infinity above f=0; its other two points
above0 are unramified. Its only finite derivative zero is b=-kappa/2,
a simple index-two point with branch value (4-K)/(2kappa^5), nonzero
because K!=4. Its global group contains F20 and a transposition.
Conjugating this transposition by a five-cycle produces a connected
graph on the five roots, whose edge transpositions generate S5.
The order120 Galois closure has Riemann--Hurwitz contributions
80,60 and6*23=138 at its C3,C2 and F20 branches. Thus
2g-2=-240+278=38 and g=20. Base change to S may reduce the
global group and may introduce ramification in the map to this
auxiliary closure. Neither is replaced by an etale assertion.

## Actual canonical and norm consequences

The preceding proof did not use omega_S=H^16 or q. With those
additional ORIGINAL source data, the nonzero-s branch gives
omega_S=B^32. Taking the q-norm and using etaleness gives
O(32 Nm_q(DB))=Nm_q(omega_S)=omega_Y^(8m)=O(16m O).
This is the stated32-torsion divisor-class relation. It does not say
that the whole fiber of q over Nm_q(P) equals a repeated point.

For m=2,8|m is impossible. The nonzero-s pencil has divisor D0-5P
and degree5 or4, and the other pencil has degree3 through5.
These are exhibited separating pencils, not lower bounds on gonality.
Etale degree-sixteen genus-seventeen bielliptic covers exist as
one-leg constructions; low gonality alone cannot finish the common-cover
problem.

Working provenance: [uniform distinct-phase note](../../Research/experiments/oct02_reciprocal_uniform_distinct_phase_pencil.md).
For the separate actual residual-degree-five endpoint shape that can
supply these hypotheses, see [scalar-one restriction](../../Theorems/cartier_and_spin/scalar_one_self_dual_endpoint_restriction.md).
