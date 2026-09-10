# The simple defect on an explicit etale double has cubic local length

Version1,2026-09-10. Author proof and exact symbolic verification;
not independently audited or Lean-verified.

Let k be algebraically closed of characteristic5 and t^5-t!=0. Put

    G=u(u-1)(u-2)(u-3), F=G(u-t), Y:v²=F,
    A=(t+1)²G, a=A/F², r=3a''/a+(a'/a)².

This is the ordinary active admissible connection on Y associated with
the four-branch quartic A(du/v)^4. Let C be the smooth projective curve
with function field k(u,v,kappa), kappa²=u(u-3), and pull r back to C.
The map C→Y is connected finite etale of degree2 and g(C)=3.
Write gamma=v/kappa and phi=gamma/F*(du)^2.

The completed local ring of the fixed-curve nilpotent connection scheme
N(C) at this r is

                         k[[z]]/(z³).

In particular, the known one-dimensional tangent defect is an exact
length-THREE nonreduced point, not merely a first-order observation.
An explicit second-order deformation realizing its tangent is

    r_z=r+z*gamma/F+z²*(u-t)/((t+1)F).

For E(R)=R''-3R² and N(R)=-(E')²-3E(E''+3RE), its obstruction is

    N(r_z)=3(t+1)z³*(gamma/F)^5 + O(z^4).

The coefficient is a unit for every stated t. The two other anti-invariant
directions and all three invariant directions have invertible linear
blocks; their formal elimination is included in the proof.

There is also a transverse family check: replacing the branch point3
by c, with F_c=u(u-1)(u-2)(u-c)(u-t), R_c=u(u-c), and the normalized
four-branch connection defined by A_c=[u^4](F_c*(u-t))*F_c/(u-t), the
coefficient of phi_c^5 in the linearized N-equation is

    -(c+2)c²*(-2t²+tc-2t-c+1).

Its c-derivative at c=3 is3(t+1)², again nonzero. Thus this defect has
an explicit nonzero transverse unfolding, not a family in which every
direction is accidentally singular.

This is a characteristic-five FIXED-CURVE nilpotent germ. Its cubic
coefficient is not asserted to equal a higher-Witt obstruction, or to
exclude a common span. It supplies the local model for computing that
new arithmetic invariant.

[Proof](../Solutions/Sol_bad_double_cubic_defect.md) ·
[Exact symbolic script](../scripts/bad_double_nilpotent_local.sage).
