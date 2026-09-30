# Proof: genus-two étale quotients from a canonical pencil

This proves Version 1 of the
[statement](../../Theorems/quotient_geometry/genus_two_etale_pencils.md).
All curves and maps below are over the stated algebraically closed field
k of characteristic different from 2.

## The intrinsic bracket and its target value

For a rational differential frame theta write df=D(f)theta. Then

    {A theta,B theta}=(B D(A)-A D(B))theta³.

If theta is replaced by h theta, its coefficients become A/h,B/h and
the derivation becomes D/h. The two terms involving D(h) cancel, and
the remaining factor is h^-3. This proves independence of the frame.
Using a regular parameter proves regularity for regular a,b. The
chain rule proves that the bracket commutes with pullback along a
separable morphism of smooth curves.

Write F(x)=H(1,x). The squarefree binary sextic has either degree five
or degree six in this affine chart: a root at infinity, if present,
has multiplicity one. On Y, direct differentiation gives

    {dx/y,x dx/y}=-(dx)³/y²=-y (dx/y)³,

so {eta0,eta1}²=H(eta0,eta1). The two forms eta0,eta1 are a basis of
H0(Y,omega_Y) and have no common zero. This can also be checked
directly: at a finite branch point dx/y is a unit; elsewhere away
from infinity it is nonzero. In degree five, eta0 has order two at
infinity and eta1 is a unit. In degree six, eta0 has order one at
each point at infinity and eta1 is a unit. These order calculations
use 2 invertible, so remain valid in characteristic five.

If q:C→Y is finite étale, pullback identifies q*omega_Y with omega_C.
The pulled-back basis has no common zero, and bracket functoriality
gives the stated identity. This proves necessity.

## Reconstructing the actual morphism

Suppose a,b satisfy the two conditions. A nonzero regular differential
on C has a nonempty zero divisor, since its degree is 2g(C)-2>0.
Consequently a,b cannot be linearly dependent: dependence would make
them share a zero, including the case where either is zero. Thus a is
nonzero and u=b/a is a nonconstant rational function.

Let W={a,b}. If W were zero, the identity would give H(1,u)=0 in k(C).
Since k is algebraically closed and this is a nonzero polynomial, u
would belong to k, a contradiction. Thus W is nonzero. Put v=-W/a³.
Dividing the identity by a^6 gives

    v²=H(1,u).

The polynomial H(1,T) is not a square in k(T), since it is squarefree
of degree five or six. Since u is nonconstant, x↦u identifies k(x)
with k(u), and the displayed equality therefore extends to an
embedding k(Y)→k(C) taking y to v. This determines a unique
nonconstant morphism q:C→Y: a rational map between these smooth
projective curves extends at every point. It is finite.

In the rational frame used above, the quotient rule gives

    du = -W/a²,          du/v = a,          u du/v = b.

Here W/a² is a rational one-form, and the sign agrees with the
chosen bracket. Because W is nonzero, du is nonzero. The function u
is therefore separating for k(C)/k, so k(C)/k(u), and hence k(C)/k(Y),
is separable. The last two identities show that the pullbacks of
eta0 and eta1 are exactly the original forms a and b.

The differential map q*omega_Y→omega_C is a nonzero map of line
bundles. At any point of C one of eta0,eta1 is a local generator on
the target. Its image generates the ideal of this differential map;
the other image is a regular multiple of it. Therefore the common
zero divisor of a,b is precisely the different divisor. It is zero
by hypothesis. Thus the differential map is an isomorphism. A finite
morphism between smooth curves is flat, and here it is unramified,
so it is étale. This argument never divides by deg(q) and excludes
wild ramification as well as tame ramification.

The formulas for u,v prove uniqueness. Scaling a,b by c multiplies
W² by c^4 and H(a,b) by c^6. Their common value is nonzero, so the
scaled pair satisfies the identity exactly when c²=1. The change
c=-1 fixes u and negates v, as claimed.

## Keeping the other actual étale map

Given a finite locally free étale O_X-algebra A of positive rank with
connected relative spectrum C, the structural morphism f:C→X is finite étale.
The curve C is smooth, projective and connected, and

    omega_C=f*omega_X,       g(C)-1=n(g(X)-1).

By the projection formula, sections of omega_C identify with sections
of omega_X tensor A. The no-common-zero condition is exactly the
stated surjectivity of A-modules. The uniqueness of extension of
derivations over an étale algebra identifies the bracket computed
on X with that on C. The preceding construction therefore gives an
actual finite étale map q:C→Y from this same source. Riemann--Hurwitz
for q, with g(Y)=2, gives deg(q)=g(C)-1=n(g(X)-1).

Conversely, from an actual span take A=f_*O_C and the pullbacks of
the displayed canonical basis of Y. These data satisfy every
condition. Thus the two-leg formulation is an equivalence, not just
a necessary condition on abstract graded rings or Jacobians.

## Preserved special case and provenance

For Y:y²=x⁵-x in characteristic five, the sextic is
H(A,B)=AB⁵-A⁵B. The condition is simply

    {a,b}²=ab⁵-a⁵b,

together with no common zero. The identity map, with a=dx/y and
b=x dx/y, satisfies it. In the old three-generator notation
c=y(dx/y)³, its remaining brackets are {a,c}=3a⁵ and {b,c}=3b⁵;
the direct reconstruction above makes separate checks unnecessary.

The single-equation criterion was already proved in the project's
5 September author note. This revision removes its dependence on
graded Poisson reconstruction and the redundant linear-independence
hypothesis. The exact positive-rank algebra formulation and scaling
statement are explicit here. The
[original author proof](../../../litt3-computation-data/unmarked_ideas_20260915/genus_two_single_equation_original.md)
is retained as evidence, with its original contents unchanged.
The [independent audit](../../Research/audits/GENUS_TWO_ETALE_PENCILS_AUDIT_2026_09_15.md)
checks the reconstructed map and both original étale legs, including
degrees divisible by the characteristic.
