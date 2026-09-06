# Canonical uniqueness of shared dormant oper–line data

Date: 2026-09-05. Root's strengthened theorem, independently checked by
/root/tango_line_class_and_uniqueness_check on the same date: PASS.
[Audit record](audits/TANGO_LINE_CLASS_AND_UNIQUENESS_CHECK_2026_09_05.md);
open only to investigate a doubt. This replaces the weaker fixed-oper
statement formerly in this file, retaining its proof ingredients.

## Theorem

Let k=Fbar5 and let X <-f- Z -g-> Y be an actual finite etale span
of smooth connected curves with k(X) intersection k(Y)=k inside k(Z).
Suppose nonzero rational weight-d pluriforms, d>0 prime to five, satisfy

    f*s_X=g*s_Y=s,       C_n(s_C^r)=0,

where 1<=r<=4, rd=5n+1.

There is at most ONE compatible pair of regular dormant PGL2-opers
equipped with horizontal Borel reductions, up to isomorphism preserving
these data. Each candidate includes an oper isomorphism between its
two pullbacks on Z, and the horizontal Borels must agree under it.
The opers are NOT fixed before counting. No transversality, genus
congruence, or holomorphicity assumption is required.

More precisely, any such pair equals the meromorphic pair determined
by the shared s:

    s_C=a(dt)^d,       ell_s=a'/(da),
    Q_s=ell_s'-ell_s^2/2,       H_s=[1:-ell_s/2].

Thus it exists exactly when Q_s extends to regular endpoint opers;
H_s then extends horizontally by saturation. This asserts uniqueness
of simultaneously preserved data, not absence of such data.

## Proof

A dormant projective oper with a horizontal Borel has, in a separating
parameter t, normalized companion equation v''+(Q/2)v=0. Its trace-zero
rank-two connection is dormant: projective zero p-curvature makes the
lift's p-curvature scalar, and trivial determinant makes its trace zero.
Since 2 is invertible, that scalar vanishes. Cartier descent supplies
a nonzero rational horizontal vector (v,v') on the given generic line.
Put ell=-2v'/v. The equation gives Q=ell'-ell^2/2.

These are intrinsic projective coefficients, without choosing compatible
global theta characteristics. Under t=t(z), the rational projective
jet matrix is [1,0;-t''/(2t'),t']; hence

    ell_z=t'ell_t+t''/t'.

Consequently the difference of two such affine coefficients times dt
is an intrinsic rational one-form. The same holds when comparing with
ell_s, since ell_s has this transformation law and equals
-2(a^j)'/a^j for 2dj=-1 modulo five. For a candidate compatible pair set

    delta_C=(ell_C-ell_s,C)dt.

Compatibility makes delta_X and delta_Y actually shared on Z, and

    delta_C=-2 dlog(v/a^j),       C(delta_C)=delta_C.

If delta is nonzero, delta_C^d/s_C is a shared rational function.
Corelessness forces s_C=c delta_C^d with the same c in k*. Therefore

    C_n(s_C^r)=c^(r/5) delta_C^n C(delta_C)
             =c^(r/5) delta_C^(n+1) != 0,

a contradiction. Thus ell=ell_s, and both Q and the generic horizontal
line are determined.

For completeness, normalization introduces no extra isomorphism choices.
Over a field the oper Borel torsor is split; the nonzero second
fundamental map allows companion normalization. A projective gauge
preserving its oper line is lower triangular; preserving the
upper-right entry 1 forces equal diagonal entries, and preserving
the zero diagonals forces its remaining parameter zero. Thus an
oper automorphism is identity. The same normalization works in local
regular frames because the second fundamental map is a unit.
Equality of Q therefore gives local regular isomorphisms, unique
and hence gluing globally. Horizontal reductions agree by saturation.
Conversely, regular Q_s and its natural H_s supply the required data
by the [equation theorem](EXPLICIT_SECOND_ORDER_EQUATION_FOR_CARTIER_ZERO_PLURIFORMS.md).
This proves the statement.

## Interpretation

The equation has two independent rational solutions on each endpoint.
Only one resulting oper–line structure can be preserved by BOTH actual
maps in the coreless Cartier-zero branch. Fifth-power freedom on a
single curve has not been confused with simultaneous compatibility.

The more general comparison used above is also useful: two distinct
compatible dormant oper–line structures produce a common nonzero
Cartier-fixed rational one-form. If a common holomorphic s exists,
the identity s=c delta^d forces that one-form to be holomorphic.
No numerical cover degree is excluded by this theorem.
