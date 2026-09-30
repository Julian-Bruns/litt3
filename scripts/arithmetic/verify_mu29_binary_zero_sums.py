#!/usr/bin/env python3
"""All subsets of mu_29 with sum zero in characteristic five.

Exact meet-in-the-middle enumeration, not a bounded field-point search.
The field modulus is independently checked by the pole18 verifier.
Every subset is represented once by its two disjoint halves; equal sums
are retained in lists so no collision can discard a witness.
"""
import argparse
import hashlib
import json
from collections import Counter
from pathlib import Path

MODULUS = [1, 2, 4, 0, 4, 4, 3, 1, 3, 4, 4, 0, 4, 2, 1]
ZERO = (0,) * 14


def powers():
    value = (1,) + (0,) * 13
    result = []
    for _ in range(29):
        result.append(value)
        value = tuple(((value[j-1] if j else 0)
                       - value[-1] * MODULUS[j]) % 5 for j in range(14))
    assert value == result[0] and len(set(result)) == 29
    assert tuple(sum(v[j] for v in result) % 5 for j in range(14)) == ZERO
    return result


def half_sums(values):
    result = [(ZERO, 0)]
    for i, value in enumerate(values):
        result += [(tuple((a+b) % 5 for a, b in zip(total, value)),
                    mask | (1 << i)) for total, mask in result]
    assert len(result) == 2 ** len(values)
    return result


def check(split):
    phase = powers()
    left, right = half_sums(phase[:split]), half_sums(phase[split:])
    table = {}
    for total, mask in left:
        table.setdefault(total, []).append(mask)
    witnesses = []
    for total, mask in right:
        opposite = tuple(-v % 5 for v in total)
        for other in table.get(opposite, []):
            witnesses.append(other | (mask << split))
    witnesses.sort()
    assert witnesses == [0, (1 << 29) - 1], witnesses
    assert pow(5, 7, 29) == 28
    return {
        'split': split, 'half_sizes': [len(left), len(right)],
        'represented_subsets': len(left) * len(right),
        'zero_sum_masks': witnesses,
        'zero_sum_cardinalities': dict(Counter(m.bit_count() for m in witnesses)),
        'status': 'PASS',
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    # Swapping the split independently partitions the same complete domain.
    checks = [check(14), check(15)]
    result = {
        'status': 'PASS', 'modulus_ascending': MODULUS,
        'scope': 'All 2^29 subsets; only the empty and full subset have sum zero.',
        'checks': checks,
        'source_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        'limitation': 'No assertion about multisets with non-binary multiplicities.',
    }
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
