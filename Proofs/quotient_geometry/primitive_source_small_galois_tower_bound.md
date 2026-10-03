# Proof: base change the upper Galois step, or the single lower normal closure

Version1,3 October2026. Independent whole review: [PASS](../../Research/audits/ACTUAL_SPIN_CUBIC_TOWER_AUDIT_2026_10_03.md). See the [statement](../../Theorems/quotient_geometry/primitive_source_small_galois_tower_bound.md).

Put U=ΓB. Base change of the actual Galois extension E/B shows T=UE is Galois over U with group a subgroup of Gal(E/B). Thus d=[T:U] divides ℓ. The actual degree tower gives κ=d[U:Γ], so d also divides κ. Meanwhile [U:Γ]≤[B:F]=m, by the field-component degree bound for base change of B/F. It follows that κ≤gcd(κ,ℓ)m. No target quotient degree has been divided without a corresponding actual field tower.

For the prime-to-p assertion let N0/F be the actual normal closure of B/F. Its group embeds in Sm, hence has order prime to p when m<p. Over N0 each conjugate of E/B becomes a Galois extension whose group is a subgroup of the original group of order ℓ. Their finite compositum N has a Galois group over N0 embedding in a product of such prime-to-p groups. Thus N/F is Galois of order prime to p and contains the normal closure of E/F. This constructs only the normal closure of ONE explicitly specified finite tower; it does not supply a common completion of unrelated maps.

After base change, NΓ/Γ is still Galois, with group a subgroup of Gal(N/F). The actual field T=ΓE lies in NΓ. Its degree divides [NΓ:Γ], and is therefore prime to p. This argument allows reducible base changes: one uses the specified field component in the common overfield, rather than asserting connectedness of the entire fiber product.
