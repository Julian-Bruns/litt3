# Proof: horizontal tensor solutions and Frobenius descent

Canonical [statement](../Theorems/Thm_dormant_horizontal_tensor_tower.md).

Write G=G_2(theta), with its dormant connection and oper quotient
G -> theta^-1. A local horizontal section projects to a scalar solution
of u''=r u. Its jet (u,u') recovers that section; the second fundamental
map is an isomorphism. This is the usual scalar description of a
rank-two oper, not an additional assumption about solutions.

Twist G and its connection by the canonical Frobenius connection on
F_C^*(theta^(1+2n) tensor tau^2). Its quotient line becomes

    theta^-1 tensor theta^(5+10n) tensor tau
      = omega^(2+5n) tensor tau.

Its horizontal descent is
W tensor theta^(1+2n) tensor tau^2 = V tensor omega^n.
Projection identifies horizontal sections with the asserted scalar
kernel. This identification is 5-semilinear on k-scalars. The local
operator glues because the weight 2+5n differs from -1/2 by a
multiple of five: the extra transition factor is a fifth power and
its derivatives vanish. The torsion line has its canonical horizontal
local frames, since its order is prime to five.

Stability of V, of degree 2g-2, follows from
F_C^*V=K_C^vee tensor omega^2 tensor tau as proved in the semilinear-lift
record. For n>=1, Serre duality gives

    H^1(V tensor omega^n)=H^0(V^vee tensor omega^(1-n))^vee=0

by negative slope. Riemann--Roch therefore gives 4n(g-1).
For every point P, the dual bundle for H^1(V omega^n(-P)) has slope
1-(2n-1)(g-1), which is negative, except for n=1,g=2 where it is zero.
In that case it is stable of rank two, so it still has no section:
a section would supply a degree-zero subline after saturation.
Thus evaluation is surjective at every P. Since the bundle has rank
two on a curve, the incidence of sections vanishing somewhere has
dimension at most h^0-1; a general section is nowhere zero.

At a point, the scalar value and its first derivative are the two
coordinates of the horizontal jet. They vanish together precisely
when the Frobenius pullback of the descended section vanishes there.
Faithful flatness of Frobenius detects this fiberwise vanishing. Thus
absence of a common zero is exactly that every zero of the scalar
tensor is simple. The tensor is not identically zero unless the
horizontal section vanishes, by the oper jet isomorphism.

For the asserted marking correspondence, rank-two duality and
det V=omega tensor tau give Hom(V,omega^2 tensor tau)=V tensor omega.
A morphism is surjective exactly when the corresponding section is
nowhere zero, so the weight-seven assertion follows.

Finally linearize r''-3r^2=0 in characteristic five. Its variation is
(delta r)''-r delta r=0, with delta r in H^0(omega^2). This is precisely
the n=0 kernel (tau=O for the tangent-space assertion). Twisting by
nontrivial tau gives the analogous horizontal space but not a tangent
to the original untwisted oper scheme. All constructions commute
with etale pullback of the specified data.
