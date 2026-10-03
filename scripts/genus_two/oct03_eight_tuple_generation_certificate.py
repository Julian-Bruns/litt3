#!/usr/bin/env python3
"""Find/check a small exact transvection-star certificate for SL8(F5)."""
import argparse
import itertools
import json
import math
import time
from pathlib import Path

import numpy as np
from oct03_eight_tuple_block_ansatz import mul, power, rref, nil_ranks


def fast_power(a, n):
    out = np.eye(len(a), dtype=np.int64)
    while n:
        if n & 1:
            out = mul(out, a)
        a = mul(a, a)
        n >>= 1
    return out


def word_matrix(word, generators):
    out = np.eye(8, dtype=np.int64)
    for letter in word:
        out = mul(out, generators[letter])
    return out


def rank(a):
    return len(rref(a)[1])


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--input', required=True)
    parser.add_argument('--output', required=True)
    parser.add_argument('--seconds', type=float, default=15)
    args = parser.parse_args()
    started = time.monotonic()
    candidate = json.loads(Path(args.input).read_text())['tuples'][0]
    a = np.array(candidate['A'], dtype=np.int64)
    b = np.array(candidate['B'], dtype=np.int64)
    i8 = np.eye(8, dtype=np.int64)
    generators = {'A': a, 'B': b, 'a': power(a, 4), 'b': power(b, 4)}
    assert np.array_equal(power(a, 5), i8) and np.array_equal(power(b, 5), i8)
    assert nil_ranks(a) == nil_ranks(b) == [6, 4, 2, 1, 0]
    assert np.array_equal(power(mul(a, b), 2), 3*i8)
    exponent = math.lcm(*(5**i - 1 for i in range(1, 9)))
    result = {'field': 5, 'transvection_power': exponent, 'transvection_word': None,
              'A': a.tolist(), 'B': b.tolist(), 'star_words': [], 'basis_words': [],
              'tested_power_words': 0, 'tested_orbit_words': 0, 'complete': False}
    transvection = None
    for length in range(1, 7):
        for letters in itertools.product('ABab', repeat=length):
            if any(x.swapcase() == y for x, y in zip(letters, letters[1:])):
                continue
            if time.monotonic() - started >= args.seconds:
                break
            word = ''.join(letters)
            matrix = word_matrix(word, generators)
            t = fast_power(matrix, exponent)
            result['tested_power_words'] += 1
            if rank((t-i8) % 5) != 1 or not np.array_equal(power(t, 5), i8):
                continue
            transvection = t
            result['transvection_word'] = word
            result['transvection'] = t.tolist()
            break
        if transvection is not None or time.monotonic() - started >= args.seconds:
            break
    if transvection is not None:
        delta = (transvection-i8) % 5
        column = next(j for j in range(8) if np.any(delta[:, j]))
        v = delta[:, column]
        row = next(i for i in range(8) if v[i])
        phi = delta[row] * pow(int(v[row]), -1, 5) % 5
        assert np.array_equal(np.outer(v, phi) % 5, delta)
        assert int(phi @ v % 5) == 0
        result['v'] = v.tolist()
        result['phi'] = phi.tolist()
        star_rows = []
        basis_columns = []
        # Words are built on the left here; the saved strings retain literal product order.
        queue = [(v, phi, '')]
        head = 0
        while head < len(queue) and time.monotonic()-started < args.seconds:
            gv, gphi, word = queue[head]
            head += 1
            result['tested_orbit_words'] += 1
            if rank(np.array(basis_columns + [gv]).T) > len(basis_columns):
                basis_columns.append(gv)
                result['basis_words'].append(word)
            pairing = int(phi @ gv % 5)
            if int(gphi @ v % 5) == 0 and pairing:
                if rank(np.array(star_rows + [gphi])) > len(star_rows):
                    star_rows.append(gphi)
                    result['star_words'].append({'word': word, 'pairing': pairing,
                                                 'row': gphi.tolist()})
            if len(star_rows) == 7 and len(basis_columns) == 8:
                result['complete'] = True
                break
            if len(word) >= 9:
                continue
            for letter in 'ABab':
                if word and letter.swapcase() == word[0]:
                    continue
                queue.append((generators[letter] @ gv % 5,
                              gphi @ generators[letter.swapcase()] % 5,
                              letter + word))
        result['star_row_rank'] = rank(np.array(star_rows)) if star_rows else 0
        result['orbit_basis_rank'] = rank(np.array(basis_columns).T) if basis_columns else 0
        # Verify every commutator matrix independently of the rank-one formula.
        for item in result['star_words']:
            g = word_matrix(item['word'], generators)
            invg = word_matrix(''.join(x.swapcase() for x in item['word'][::-1]), generators)
            u = mul(mul(g, transvection), invg)
            commutator = mul(mul(mul(transvection, u), power(transvection, 4)), power(u, 4))
            expected = (i8 + item['pairing'] * np.outer(v, np.array(item['row']))) % 5
            assert np.array_equal(commutator, expected)
    result['elapsed_seconds'] = time.monotonic()-started
    target = Path(args.output)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items()
                      if k not in ('A', 'B', 'transvection', 'v', 'phi')}))


if __name__ == '__main__':
    main()
