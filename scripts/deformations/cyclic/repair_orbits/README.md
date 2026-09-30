# Fourth obstruction on the second cyclic-cover orbit

21 September2026. These sources adapt the previously audited selected
cyclic-five engine to a coefficient field of arbitrary degree. The
new execution uses degree20. The original source is preserved at
`../../../../../litt3-computation-data/cyclic5-w4-returned-20260911-JsDjLw/cyclic5_fourth_certificate/scripts/`.
Its mathematical construction is described in
[the old proof](../../../../Proofs/deformations/cyclic_descent/cyclic_five_fourth_obstruction.md).
The new scope is [all six covers](../../../../Proofs/deformations/cyclic_descent/all_cyclic_five_fourth_obstructions.md).

Run from the repository root, with Python3, NumPy, gmpy2 and Sage:

```sh
sage scripts/deformations/cyclic/probe_rational_repair_hodge.sage \
  --cover-orbit nonrational --precision 160 \
  --output ../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_repair_hodge.json

python3 scripts/deformations/cyclic/repair_orbits/compute_fourth.py \
  --input ../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_repair_hodge.json \
  --precision 1200 \
  --output ../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_fourth_p1200_v2.json

python3 scripts/deformations/cyclic/repair_orbits/compute_fourth.py \
  --input ../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_repair_hodge.json \
  --precision 1500 --frobenius-variant 1 \
  --output ../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_fourth_p1500_variant1.json

sage scripts/deformations/cyclic/repair_orbits/check_receipt.sage \
  --input ../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_repair_hodge.json \
  --receipt ../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_fourth_p1200_v2.json \
  --compare ../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_fourth_p1500_variant1.json \
  --output ../litt3-computation-data/bt_obstruction_transport_20260921/nonrational_fourth_independent_check.json
```

The degree-four embedded parameter is Hensel lifted independently of
the chosen degree20 field generator. Witt Frobenius is Hensel lifted;
it is not coefficientwise fifth power modulo625. The actual infinity
algebra is `s^5-chi*s`, with its nonsplit branch Frobenius retained.

Changing the polynomial coordinate system of the coefficient ring
changes coefficientwise lifts of the first curve digit. The new
engine computes the actual primary right side, proves its difference
from the characteristic-five reference is a base Hodge-map image,
and solves for the corresponding third-reference correction. This
is recorded as `primary_reference_adjustment`; no earlier marking
is altered. An initial run without this correction failed its full
15-coordinate primary compatibility check; that failed log is kept
outside the repository. The correction is verified independently
by `check_receipt.sage` before any fourth value is used.

Both successful runs verify the actual full preceding jet and Hodge
compatibility, fourth cohomology, independent trace residue, Riccati
formula, full higher horizontality, and coefficient/branch Frobenius.
The separate Sage check verifies the primary matrix, reference change,
trace contraction, arithmetic conjugates and nonzero norm. It does
not reimplement the mixed-characteristic Laurent engine. Whole-plane
constancy comes from the existing theorem, not from these sample runs.

The primary replay first reproduced every old rational matrix and
repair vector. The generalized degree-four integral baseline also
reproduced the old complete fourth result. No original certificate
was overwritten. Numerical JSON and logs remain outside the workspace.
