# Tango line classes and uniqueness across dormant oper choices

Date: 2026-09-05. Author: `/root/tango_line_class_and_uniqueness_check`.
Verdict: **source contradiction confirmed; stronger uniqueness theorem passes**.
This report does not edit the audited notes.

## 1. Actual correction to the primary-source screen

[Wakabayashi, Remark 5.1.3](https://arxiv.org/html/1709.04241#S5.SS1),
following Definition 5.1.1, explicitly says that the underlying
line-bundle isomorphism class determines a Tango structure on a proper
smooth geometrically connected curve. The stated setting has genus
greater than one. Consequently the sentence “Equality merely of abstract
line-bundle classes would be insufficient” in
[the transverse screen](../TRANSVERSE_DORMANT_MIURA_TANGO_PRIMARY_SOURCE_SCREEN.md)
is false for its two actual Tango pullbacks on proper Z.

The precise replacement is: **the two embedded Tango lines agree if and
only if their underlying line bundles on Z^(1) are isomorphic**.
Here both lines must already be Tango structures. Equality of their
Frobenius pullbacks with omega_Z alone does not imply equality of their
classes on Z^(1).

Independent verification: identify the two source line bundles M.
Adjunction identifies Hom(M,F_*omega_Z) with Hom(F^*M,omega_Z).
Since F^*M is isomorphic to omega_Z, the latter is H^0(Z,O_Z)=k.
Two nonzero embeddings therefore differ by a scalar and have the same
image. This proof explains the role of properness and the full Tango
condition; it does not extend the assertion to arbitrary subsheaves on
an open curve. The rational affine relation and the absence of a core
conclusion in the screen remain valid.

## 2. Stronger theorem, with exact quantifiers

Let k=Fbar_5 and let X <-f- Z -g-> Y be an actual finite etale span of
smooth connected curves, coreless in the sense that the actual endpoint
function fields intersect in k inside k(Z). Suppose nonzero rational
weight-d forms satisfy f^*s_X=g^*s_Y=s, where d>0 and 5 does not divide d.
Choose 1<=r<=4 with rd=1 modulo 5, put n=(rd-1)/5, and assume
C_n(s_X^r)=0.

Then there is **at most one compatible pair of endpoint regular dormant
PGL2-opers equipped with horizontal Borel reductions**, up to oper
isomorphisms preserving those reductions. Each candidate includes an
isomorphism of its two pullbacks preserving connection and oper Borel,
and the horizontal Borels must agree under that isomorphism. One does
not fix the underlying opers before counting. No everywhere-transverse
condition on the horizontal Borel is needed.

Proof. A candidate on a curve C intrinsically determines a rational
affine coefficient ell_C,t in a separating parameter t, with

    ell_C,z = t' ell_C,t + t''/t',
    Q_C,t = ell_C,t' - ell_C,t^2/2.

For two candidates, even with different projective connections Q_1,Q_2,
the difference delta_C=(ell_1,C,t-ell_2,C,t)dt is therefore an intrinsic
rational one-form. Compatibility separately for each candidate implies
f^*delta_X=g^*delta_Y. In the dormant normalized companion presentation,
ell_i=-2v_i'/v_i for nonzero rational horizontal solutions v_i, so

    delta_C = -2 dlog(v_1/v_2),    C(delta_C)=delta_C.

If delta is nonzero, corelessness applied to delta_C^d/s_C gives
s_C=c delta_C^d with the same c in k^* on both endpoints. Thus

    C_n(s_C^r) = c^(r/5) delta_C^n C(delta_C)
               = c^(r/5) delta_C^(n+1) != 0,

contrary to the hypothesis. Hence delta=0. Equality of ell forces
equality of Q by the displayed Riccati equation and identifies the
horizontal generic lines [1:-ell/2]. This proves the claim, subject to
the normalization and extension checks immediately below.

## 3. Normalization and isomorphism checks

A PGL2-oper with its oper Borel is split over K=k(C): a torsor for the
split Borel over a field is trivial (successive G_m and G_a torsors).
The nonzero second fundamental map allows a rational projective gauge
to normalized companion form

    nabla_partial = partial - [0,1; -Q/2,0].

Subtracting half the trace chooses the unique trace-free lift of the
projective connection in this frame. Projective dormancy makes its
p-curvature scalar; trivial determinant makes that scalar have trace
zero. Since 2 is invertible, the rank-two lift is dormant. A stable
generic line then has a nonzero rational horizontal vector by Cartier
descent over K/K^5. Its coordinates are (v,v'), with v nonzero.

Coordinate changes require no rational square root of dt. The projective
jet transformation is represented over K by

    [1,0; -t''/(2t'),t'],

which yields exactly the affine law above. It is independent of Q, so
the comparison of different opers introduces no extra matching choice.

For a fixed coordinate and oper Borel, normalized companion form has
no residual projective gauge: a lower-triangular gauge preserving that
Borel first has equal diagonal entries from the upper-right entry 1,
and then zero lower-left gauge parameter from the diagonal entries 0.
Thus an oper automorphism is identity generically and everywhere.
On a regular oper, the same normalization works in local regular
frames and an etale parameter: the second fundamental map is a unit.
Consequently equality of Q gives a regular local oper isomorphism;
uniqueness glues these, and the horizontal reductions agree globally
because they agree generically. There is no hidden multiplicity from
theta characteristics, scalar lifts, or chosen pullback isomorphisms.

This supersedes the fixed-oper quantifier in
[the earlier uniqueness note](../SHARED_HORIZONTAL_BOREL_UNIQUENESS_IN_CARTIER_ZERO_BRANCH.md).
It proves uniqueness, not nonexistence and not a core theorem.

In fact any existing candidate equals the explicit s-defined pair:
write s_C=a(dt)^d and choose j with 2dj=-1 modulo 5. Its meromorphic
affine coefficient ell_s=a'/(da)=-2 dlog(a^j)/dt has the same
transformation law. Comparing ell with ell_s gives the identical
Cartier-fixed-difference contradiction. Therefore ell=ell_s,
Q=Q_s, and H=H_s. This comparison remains valid before knowing that
Q_s extends regularly.

## 4. Finite Tango pool and etale injection

These optional deductions also pass for geometric points. For a fixed
smooth proper connected C, the possible Tango classes M satisfy
F_C^*M=omega_C. If one exists, the classes of all such Frobenius roots
form a torsor under ker(F_C^*:Pic(C^(1))(k)->Pic(C)(k)). Its cardinality
is 5^f(C): after the bijective scalar Frobenius twist on geometric
points, this is the usual fifth-power root problem in the Picard group,
whose differences are Pic(C)[5](k). There is at most one Tango embedding
per class by section 1. Hence the Tango pool has size at most 5^f(C).
This is a bound on distinct structures over k, not on a moduli scheme's
length or tangent dimension.

For finite etale h:D->C, pullback injects this pool. Indeed, two root
classes with equal pullbacks differ by a 5-torsion line bundle L killed
by h^(1)*. Pass to a connected finite etale Galois cover dominating
h^(1). A trivialization of the pullback of L has descent datum a
character of its finite Galois group into k^*, since all global units
on the proper connected cover are constants. If L^5 is trivial, the
character has fifth power 1, hence is trivial in characteristic five.
Thus L is trivial. This excludes 5-torsion geometric points in the
etale Picard pullback kernel; it makes no reducedness assertion about
that kernel as a group scheme.
