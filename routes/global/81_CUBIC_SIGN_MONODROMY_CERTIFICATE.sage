"""Exact finite-group check for Theorem 81.3.

Run: sage routes/global/81_CUBIC_SIGN_MONODROMY_CERTIFICATE.sage
The proof in the theorem file is independent of this enumeration.
"""

S = SymmetricGroup(6)
beta = S("(1,2,3)(4,5,6)")
signed = S.subgroup([beta, S("(1,2)(4,5)"), S("(1,4)")])
assert signed.order() == 48
selection = frozenset([1, 2, 3])
groups = [H for H in signed.subgroups() if beta in H]
assert len(groups) == 10

def cyclic_action_is_free(h):
    return all(
        all((h**a)(i) != i for i in range(1, 7))
        for a in range(1, h.order())
    )

four_choice = []
rows = []
for H in groups:
    H0 = H.subgroup([
        h for h in H
        if frozenset(h(i) for i in selection) == selection
    ])
    j = H.order() // H0.order()
    assert j in (1, 2, 4, 8)
    assert H0.order() in (3, 6)
    free_orders = sorted(set(
        h.order() for h in H
        if h.order() > 1 and cyclic_action_is_free(h)
    ))
    rows.append((H.order(), H.structure_description(), j, free_orders))
    if j == 4:
        assert H.order() in (12, 24)
        assert free_orders == [3]
        three_subgroups = {
            frozenset(H.subgroup([h]))
            for h in H if h.order() == 3
        }
        conjugates = {
            frozenset(H.subgroup([h * beta * h**(-1)])) for h in H
        }
        assert three_subgroups == conjugates
        four_choice.append((H.order(), H.structure_description()))

assert sorted(four_choice) == [(12, "A4"), (24, "S4")]
for row in sorted(rows):
    print(row)
print("PASS: cubic sign degrees, four-choice groups, and inertia checks")
