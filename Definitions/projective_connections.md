# Projective connections and their common curvature loci

In odd characteristic a rational projective connection is given by
potentials u''=r u in separating parameters, transforming by
r_t=(x')^2 r_x−{x,t}/2. Regular means regular in every local uniformizer.
Differences are rational quadratic differentials. A theta characteristic
realizes a regular connection as a trace-free rank-two oper; its projective
class and the following conditions do not depend on that choice.

Dormant means zero p-curvature. Nilpotent means nilpotent p-curvature;
it includes, but does not mean, dormant. An active nilpotent connection
has nonzero nilpotent p-curvature. Curvature identities, not these
definitions, establish the scalar tests in the theorem proofs.
Admissible means that its p-curvature is nowhere zero; this is not
the stronger ordinary condition in Mochizuki's nilpotent sense (etaleness of the determinant
map at the given point). The kernel/oper-line collision divisor and the
zero divisor of p-curvature can overlap in the nonadmissible case.

Following Mochizuki, write S(C) for the affine space of regular projective
connections, Q(C)=H^0(C,omega²)^F for the Frobenius twist of the quadratic
differentials, and V_C:S(C)→Q(C) for Verschiebung, the determinant of
p-curvature. The nilpotent scheme is N(C)=V_C^(-1)(0). These are the
fixed-curve fibers of his S_(g,0), Q_(g,0), V_(g,0) and N_(g,0); see
[the scalar model](../Theorems/projective_connections/nilpotent_scalar_model.md).

For actual finite etale f:Z→X and g:Z→Y, their common regular-connection
space is the intersection of the two affine pullback spaces on the SAME Z.
The common dormant/nilpotent schemes are their scheme-theoretic curvature
loci there. Reducedness of this intersection does NOT assert ordinariness
of an individual oper on Z or justify a simultaneous lift.

The following tensor formulas are in characteristic five.
For an admissible normalized quartic s with div(s)=2E, its Hasse root
class is L_s=O(E) tensor omega^(-2), with its square trivialization from s.
Here E is Hoshi's supersingular divisor. The
[Hasse–Cartier criterion](../Theorems/projective_connections/hasse_cartier_criterion.md)
uses this divisor to test ordinary status in every odd characteristic.
Its canonical double torsor is Spec(O plus L_s); a trivial class gives
the split torsor, not a connected degree-two curve. On the torsor the
tautological quadratic q satisfies q²=s and changes sign under deck action.

For L in Pic(C)[N], with N prime to5, the twisted dormant tangent space at r is
the kernel of q↦q''−r q on H^0(omega² tensor L), using the flat local
frames supplied by its etale Kummer torsor. Zero dormant tangent means
reducedness of the dormant-oper fiber at that point. This is different
from ordinariness in the nilpotent sense defined above.

The dormant tangent bundle V_r on C^(1) is ker(F_*Bol_r),
Bol_r(v)=v''−r v on quadratics. For an admissible active nilpotent r,
its nilpotent tangent bundle is E_r=pi^(1)_*V_(pi^*r+q), retaining the
FULL canonical double torsor, including its split case. The tangent-bundle
theorem proves these bundles have ranks2 and4, Euler characteristic zero,
and commute with actual etale pullback. Their defect means h^0, not the
dimension of a generic twist or the a-number of the curve.
