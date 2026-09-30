# Abelian Raynaud components force small elliptic quotients

Version1, 16 September2026. Independently audited.

Let C be a smooth projective connected curve of genus G at least
two over an algebraically closed field of characteristic p>0.
Write J=J(C^(1)), let Theta be its principal polarization, and
let D=Theta_(B_C) be its actual Raynaud divisor.

Suppose an irreducible component of D is a translate A+x of an
abelian subvariety. Necessarily dim A=G-1. Let mu be its scheme
multiplicity and delta its generic Raynaud cohomology dimension.
The quotient q:J->E=J/A induces an actual map h:C^(1)->E of
degree e, and
\[
2\le\delta\le\mu,\qquad 2\le e,\qquad \mu e\le p-1.
\tag{1}
\]
In particular e<p, so h is separable. No ordinariness or
Neron--Severi rank hypothesis is imposed.

If equality mu e=p-1 holds in (1), it is impossible: symmetry
would make q(x) a nonzero two-torsion point, removing this
component would preserve the Dirac property, and the residual
divisor would have degree zero on the complementary elliptic
curve despite being ample. Thus the sharper bound is
\[
\boxed{\mu e<p-1.}
\tag{2}
\]
Consequently, in characteristics two, three and five, the
Raynaud divisor of EVERY such curve has no abelian component.
Equivalently, for every abelian divisor A in J and every x in J,
\[
\boxed{\operatorname{generic}_{L\in A+x}
 h^0(C^{(1)},B_C\otimes L)=0.}
\tag{3}
\]
For p=7, the only possibility left by (2) is e=2 and
delta=mu=2. This is a necessary condition, not existence.

The characteristic-three conclusion is already in Tong's
Theorem4.1.3.4; this proof obtains it from the general numerical
bound. The characteristic-five conclusion removes the genus
restriction from the earlier low-genus argument.

For either candidate common-cover pair, (3) applies to every
possible smooth source and every further finite etale cover.
It concerns abelian DIVISORS in the source Jacobian. The actual
mixed inherited abelian subvariety has higher codimension in
general; it is not excluded by (3).

[Proof](../../../Proofs/jacobians/theta_divisors/raynaud_abelian_components.md).
