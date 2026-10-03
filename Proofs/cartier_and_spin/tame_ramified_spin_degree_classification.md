# Proof: actual stabilizers, orbifold area and divisor arithmetic

Version1. [Statement](../../Theorems/cartier_and_spin/tame_ramified_spin_degree_classification.md). [Independent whole-implication review: PASS](../../Research/audits/TAME_RAMIFIED_SPIN_DEGREE_CLASSIFICATION_AUDIT_2026_10_02.md). All fields, groups and maps are the ACTUAL ones attached to the same source. Reuse the accepted [parity and mixed-fiber theorem](actual_spin_ramified_parity_and_mixed_fibers.md), [different norm ledger](actual_spin_different_norm_residual_torsion.md), and minimal projective-kernel bound k∈{1,3}.

Let degM=δ, so d=κδ and |G|=8κδ. Since degRφ=|G| and2gT−2=16d, Hurwitz gives2gΓ−2=8δ. For H=G/K its order is8κδ/k, and its quotient B=Γ/H therefore has exact Hurwitz area
\[
2g(B)-2+\sum_b(1-1/m_b)=\frac{2g(\Gamma)-2}{|H|}=\frac{k}{\kappa}=\frac1n
\]
once the action is tame. We now verify tameness without assuming |G| prime to five.

## Actual local degrees make every inertia divide n

Over a coarse value other than the distinguished image of P, φ is étale, while q is everywhere étale. The local tower through T gives e(Y/B)=e(Γ/B). Thus each such fiber of Y→B has a uniform index m, the actual H inertia order, and m divides the degree n=[k(Y):k(B)]. The distinguished coarse fiber is treated separately below, including its unramified companion Y points.

At a branch image z of φ, the points in qP above z form one free orbit of G_z: qP itself is a free transitive G set, and equivariance identifies the stabilizer orbit exactly. Hence their number is r=|G_z|. The mixed-fiber theorem supplies r u unramified companions and κ=r(2+u), u≥1. Since K fixes z, k divides r. The faithful inertia order is t=r/k and the coarse Y→B fiber is2tP+tQ1+...+tQu. Thus n=t(2+u), and this inertia also divides n.

These account for all H inertia groups. Under5∤n, every inertia order is prime to five, so Γ→B is tame even if the group order itself is divisible by five. Also κ is even by the accepted parity theorem; since k is odd, n is even. The mixed relation gives n≥3, hence n≥4.

## The quotient is rational and its area bounds the degree

If g(B)≥2, its area is at least two, impossible since1/n≤1/4. If g(B)=1 and there is ramification, a cone contributes at least1/2, again impossible. With no ramification its area is zero, also impossible. Therefore B=P¹.

For a positive tame P¹ signature, its area is at least1/42. Here is the elementary argument. At least three cones are needed. Five or more cones give area at least1/2; four cones give either zero when all orders are two, or area at least1/6. With three orders a≤b≤c, the positive area is1−1/a−1/b−1/c. If a≥3 the minimum positive value is at least1/12. If a=2,b≥4 it is at least1/20, attained at(2,4,5). If a=2,b=3, positivity forces c≥7 and the minimum is1/42. Thus1/n≥1/42 and n≤42.

## Complete divisor-restricted signature enumeration

Every cone order divides n, with n even and5∤n. There are three or four cones, since five force n≤2. For four cones, at most one order exceeds two: two such orders would give area at least1/3 and n≤3. Write(2,2,2,m); area1/2−1/m=1/n gives n=2m/(m−2). Since m|n, m−2 divides two. Thus m=3,n=6 or m=4,n=4.

For three cones a≤b≤c, if a≥4, area≥1/4 and n≤4; divisibility then forces(4,4,4),n=4. If a=3,b≥4, area≥1/6 and n≤6; cone divisibility leaves no ordered triple with b≥4 and5∤n. If a=b=3, n=3c/(c−3), and c|n gives c−3|3. Hence c=4,n=12 or c=6,n=6.

It remains a=2. The case b=2 has nonpositive area. If b≥7 then n≤14/3<b, impossible. The case b=5 is impossible since b|n and5∤n. For b=6, area≥1/6 gives n≤6 and c≤n, so c=6,n=6. For b=4, n=4c/(c−4) and c|n give c−4|4: c=5,6,8. The first has n=20 and is excluded by5∤n; the others give n=12,8. For b=3, n=6c/(c−6) and c|n give c−6|6: c=7,8,9,12, yielding n=42,24,18,12. This is exactly the stated table.

The original degree is κ=kn. When k=1,n=4 its actual degree-four branch is independently excluded, but k=3,n=4 has κ=12 and remains within this theorem. No deletion of those rows is justified here.

Finally if κ=8, k=1. Mixed κ=r(2+u) and r an actual stabilizer order give r=1or2; r≥3 would require κ≥9. Its only allowed signature is(2,4,8). At r=2 the distinguished inertia is TWO, so the other uniform fibers of inertia four and eight complete a THREE-cone signature. A two-cone contradiction would incorrectly omit this distinguished cone.
