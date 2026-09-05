"""Exact certificate for Proposition 26.2a; requires only Python 3."""


def cycle(sequence, degree):
    permutation = list(range(degree))
    for source, target in zip(sequence, sequence[1:] + sequence[:1]):
        permutation[source] = target
    return tuple(permutation)


def compose(left, right):
    return tuple(left[right[i]] for i in range(len(left)))


def cycle_lengths(permutation):
    unseen = set(range(len(permutation)))
    lengths = []
    while unseen:
        point = min(unseen)
        length = 0
        while point in unseen:
            unseen.remove(point)
            length += 1
            point = permutation[point]
        lengths.append(length)
    return sorted(lengths, reverse=True)


def conjugate_by_transposition(permutation, first, second):
    swap = list(range(len(permutation)))
    swap[first], swap[second] = second, first
    return tuple(swap[permutation[swap[i]]] for i in range(len(permutation)))


def delete_fixed_letter(permutation, letter):
    assert permutation[letter] == letter
    return tuple(
        image - (image > letter)
        for point, image in enumerate(permutation)
        if point != letter
    )


def verify(permutation_a, permutation_b, m):
    target = [31] + [1] * m
    permutation_ab = compose(permutation_a, permutation_b)
    assert cycle_lengths(permutation_a) == target
    assert cycle_lengths(permutation_b) == target
    # Inversion does not change cycle lengths, so this checks c=(ab)^-1.
    assert cycle_lengths(permutation_ab) == target
    assert not any(
        permutation_a[i] == i == permutation_b[i]
        for i in range(31 + m)
    )


core = list(range(16))
x_only = list(range(16, 31))
y_only = list(range(31, 46))
a = cycle(core + x_only, 46)
b = cycle(list(reversed(core)) + y_only, 46)
verify(a, b, 15)

for m in range(15, 0, -1):
    removed = 0 if m % 2 else m
    a = delete_fixed_letter(conjugate_by_transposition(a, removed, 31), removed)
    b = delete_fixed_letter(conjugate_by_transposition(b, removed, 16), removed)
    verify(a, b, m - 1)

print("verified transitive (31,1^m)^3 triples for every 0 <= m <= 15")
