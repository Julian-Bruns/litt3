# Proof: full conductor-two gluing removes the fifth-power correction

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_degree_one_twenty_wild_spin_carrier_exclusion.md). The whole-profile implication passed [fresh independent review](../../Research/audits/CANONICAL_DEGREE_ONE_TWENTY_WILD_EXCLUSION_AUDIT_2026_10_03.md). Both original endpoint maps remain onT; the auxiliary étale endpoint double cover below supplies functions and a necessary obstruction, not a replacement source.

## Retain the accepted five genuine Cartier survivors

Use the independently accepted [degree120 Cartier reduction](canonical_degree_one_twenty_wild_cartier_reduction.md). It excludes the distinguished-wild position and every Weierstrass origin exceptP=t. The remaining distinguished positions are ordinary or tame-six. The invariant functions satisfy
\[
H^2=FG,\quad\beta=G^3/F^{20},\quad
F=(z-a)^2E_1(z),\quad E_1=z-w,\quad\Phi=E_1J_4,
\quad a=1/(4-t).
\]
Herew is a branch root, a is nonbranch, E1J4 is squarefree of degree FIVE, and the three wild points are W:z=w and the two hyperelliptically conjugate points z=a. Multiplicative constants are absorbed in the generators. The same accepted proof gives the ACTUAL connected étale double coverY' with
\[
r^2=E_1,\quad s^2=J_4,\quad y=rs,\quad
U=(z-a)r,\quad V=H/U,\quad V^2=G,
\quad dV=cU^7\sigma,\quad c\ne0,\quad\sigma=dz/y.
\]
OrdinaryP gives exact pole orders H23,F6,G40,V20. Distinguished tame-six gives H21,F6,G36,V18. Every function is regular away from the points overP except for those stated poles; V is regular at the zeros ofU because H vanishes simply there.

## The complete bounded fifth-power correction

The biquadratic cover has r ands as its two independent square-root sectors. V changes sign under(r,s)↦(−r,−s), the étale deck action overY. Thus
\[
V=rA(z)+sB(z).
\]
The other involutions preserve the points overP, so extracting these two sectors leaves functions regular away fromP. A andB are consequently POLYNOMIALS: a finite pole at a branch root would give a pole even after multiplication by r ors. The pole bounds give
\[
\deg A\le9,\quad\deg B\le8
\]
in the ordinary case, and bounds8,7 in the tame case.

The exact right side cU⁷σ lies in the s-sector, namely
\[
c(z-a)^7E_1^3\,dz/s.
\]
The r-sector of dV therefore vanishes. Its polynomial equation is
\[
2E_1A'+A=0.
\]
Expand in powers ofE1. The only allowed exponents are2 moduloFIVE. With the stated degree bound this gives
\[
A=E_1^2Q(z)^5,\quad\deg Q\le1,
\qquad V=(rQ)^5+sB.
\]
This retains, rather than prematurely removes, the full possible fifth-power correction.

## Actual conductor-two extensions have a pure quadratic AS class

At every wild point ofY the completed field is the SAME actual Γ/B completed extension. Indeed q:T→Y is étale, and φ:T→Γ is also étale there because its different is preciselyqP. Choose a source point over each wild point and identify its two completed fields through these actual maps. All Γ/B wild completions are isomorphic over the fixed β-base by the actual Galois actionG. No simultaneous Galois closure of the endpoint maps is presumed.

Its inertia has order40, wild groupC5 and tame quotientC8. The maximal tame subextension is obtained by ψ=β^(1/8). The different tower gives12 for the C5 extension overk((ψ^-1)), so its AS conductor is TWO. A reduced AS representative is
\[
W^5-W=L\psi^2+M\psi,\quad L\ne0.
\]
The regular part has been removed by Hensel over the algebraically closed residue field. A tame generator sendsψ toζ8ψ and acts on the AS character by a scalar inF5*. Comparing the unique reduced leading term requires that scalar to equalζ8². The linear term would instead requireζ8, which differs fromζ8². No AS coboundary can remove a pole of order ONE or TWO belowFIVE. Hence necessarily
\[
M=0.
\]
The intrinsic invariant of this extension over the original β-base is L⁴. Changing the AS generator scalesL byF5*, and changing the eighth rootψ scalesL byζ8^-2; both preserveL⁴. Conversely these are exactly the possible scalings. Equal actual completions therefore have equalL⁴.

## Two explicit local constraints from this pure AS class

At a wild point ofY', U is a uniformizer andV is a unit. Write
\[
\sigma=(f_0+f_1U+\cdots)dU,\quad f_0\ne0,
\quad
V=V_0+V_5U^5+V_8U^8+V_9U^9+\cdots.
\]
The absence of the other terms below degreeTEN follows from dV=cU⁷σ. In particular
\[
V_8=2cf_0,\qquad V_9=4cf_1.
\]
Choose locally ψ=V^(3/4)/U⁵, an eighth root ofβ=V⁶/U⁴⁰. Its expansion through degreeFOUR is
\[
\psi=\alpha U^{-5}+p_0+\gamma U^3+\delta U^4+\cdots,
\quad
\alpha=V_0^{3/4},\quad
p_0=2\alpha V_5/V_0,\quad
\gamma=2\alpha V_8/V_0,\quad
\delta=2\alpha V_9/V_0.
\]
The pure AS generator W has pole TWO and expansionλU^-2+μU^-1+regular. Comparing its four negative coefficients withLψ² gives
\[
\lambda^5=L\alpha^2,\quad\mu^5=2L\alpha p_0,
\quad-\lambda=2L\alpha\gamma,\quad-\mu=2L\alpha\delta.
\]
Eliminatingλ,μ proves exactly
\[
L^4=-\frac1{2\alpha^3\gamma^5}
=\frac1{2c^5V_0f_0^5},
\qquad V_0f_1^5=2V_5f_0^5.
\]
The first expression must have the SAME value at all actual wild completions. The second is the missing-linear-term condition, not merely a ramification-exponent constraint. Every denominator is nonzero because the local different and unitV give c,V0,f0 nonzero.

## Comparing the hyperelliptic pair forces Q=0

Choose the two points z=a onY' with the SAME nonzero value ofr and opposite values ofs. Their U coordinate is the same. Under this conjugationσ changes sign, so bothf0 andf1 change sign. In
\[
V=(rQ)^5+sB,
\]
the first term is unchanged and the second changes sign. Equality of V0f0⁵ at those two points therefore forces(rQ(a))⁵=0, hence Q(a)=0.

Since degQ≤1, write Q=q(z−a). Then the correction is EXACTLYq⁵U⁵. At the paired points V0 now changes sign; the U⁵ coefficients ofV are q⁵ plus opposite coefficients fromsB. The products V0f1⁵ are the same at the pair, whereas the products V5f0⁵ differ by2q⁵f0⁵. The missing-linear-term equation from the preceding section therefore forcesq=0. Consequently
\[
V=sB,\quad H=(z-a)yB\text{ is anti-invariant},
\quad G=J_4B^2\text{ is invariant}.
\]
This uses the FULL same completed extension and its tame character, rather than the weaker Cartier gate whose five generic survivors were correctly retained.

## The exact odd invariant ring and ordinary parity

The genuine canonical class is K=7Dw−Dt with40Dw=6Dt. Its section degree formula is
\[
d_j=\lfloor7j/40\rfloor-\lceil j/6\rceil.
\]
Every odd-weight invariant section has at leastONE zero at each branch divisor: its residual coefficients7j modulo40 and−j modulo6 are odd and nonzero. Dividing by the weight23 generatorH therefore leaves an even-weight regular invariant section.

For an even weightj<120, choose b∈{0,1,2} so that j=6a+40b with integral a. The formula givesd_j=floor(a/20), so the space is ZERO ifa<0 and ONE-dimensional otherwise; its basis is F^aG^b. Thus every odd coefficient below120 is a constant multiple of
\[
H F^aG^b,\quad b\le2,\quad6a+40b\le96.
\]
This is complete without a new numerical enumeration. In the ordinary case its pole order is the weight23+6a+40b. Those weights are all distinct below120, since the first duplicate of weights6and40 occurs at120. Applying the hyperelliptic involution to primitive characteristic evaluation and subtracting forces every such odd coefficient to vanish. The polynomial is EVEN, contrary to the accepted actual carrier minus/tangent obstruction.

## The tame case and the only possible coefficient collision

In the distinguished-tame case F is a cubic polynomial andG a polynomial of exact degree18. The actual function-field extension k(z)/k(F) has degree THREE. If G is not in k(F), then it generates that prime-degree extension, so1,G,G² are linearly independent overk(F). Applying the hyperelliptic involution to characteristic evaluation givesH times a polynomial inF,G with G-degree at mostTWO. This independence forces every odd coefficient to vanish, and again the actual primitive polynomial is impossibly EVEN.

It remains to rule out G∈k(F). SinceG has no finite poles, it would be a polynomial inF. Then H²=FG∈k(F), while H is not in k(F) because it is anti-invariant and nonzero. Therefore C=k(F,H) is an actual quadratic extension ofk(F), and [k(Y):C]=THREE. It is separating. Hurwitz gives genusC≤ONE. The functionF has its only pole atP, so its unique pole point onC has onlyP above it, with ramification indexTHREE. If genusC0, a coordinate with a simple pole there pulls back to a function with sole pole3P, contradicting the Weierstrass gap THREE. If genusC1, this is an actual separating degree-three elliptic map fromY, excluded by the accepted [MAIN low-degree elliptic-map theorem](../quotient_geometry/main_small_elliptic_map_exclusion.md) or [BACKUP simplicity](../curve_arithmetic/backup_curve_arithmetic.md).

Thus G∉k(F), completing the tame parity contradiction. Both possible distinguished positions are excluded; the accepted gate reduction covered every other antecedent. The ENTIRE canonical profile(120,40,6,47) is impossible on BOTH endpoints, with both original finite étale maps and their same source retained.
