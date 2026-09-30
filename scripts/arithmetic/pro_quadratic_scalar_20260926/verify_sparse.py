#!/usr/bin/env python3
"""Independent complete endpoint classification by sparse polynomial remainders.

Unlike endpoint_scan.cpp, this verifier never multiplies two elements of K.
It expands the determinant into the 16 ordered pairs of four label occurrences,
using precomputed diagonal and unordered-pair contributions. Thus repeated
labels retain their exact multiplicities. All arithmetic is exact over F_25.

Run: python src/verify_sparse.py
"""
from itertools import combinations_with_replacement
from pathlib import Path
import hashlib
import json
import time
import argparse


def plus(a, b):
    a1, a0 = divmod(a, 5)
    b1, b0 = divmod(b, 5)
    return (a0+b0) % 5 + 5*((a1+b1) % 5)


def times(a, b):
    a1, a0 = divmod(a, 5)
    b1, b0 = divmod(b, 5)
    # Raw convolution, then beta^2 = beta + 3.
    constant = a0*b0 + 3*a1*b1
    linear = a0*b1 + a1*b0 + a1*b1
    return constant % 5 + 5*(linear % 5)


def minus(a):
    a1, a0 = divmod(a, 5)
    return (-a0) % 5 + 5*((-a1) % 5)


A = tuple(tuple(plus(a,b) for b in range(25)) for a in range(25))
T = tuple(tuple(times(a,b) for b in range(25)) for a in range(25))
N = tuple(minus(a) for a in range(25))
ZERO = (0,)*7
ONE = (1,)+(0,)*6
MOD = (4,22,7,20,21,7,24)


def add(a,b): return tuple(A[x][y] for x,y in zip(a,b))
def scale(a,c): return tuple(T[x][c] for x in a)


def shift(a):
    """Multiply by Z, reducing only Z^7 by the stated monic polynomial."""
    lead = a[-1]
    r = [0]+list(a[:-1])
    return tuple(A[x][N[T[lead][m]]] for x,m in zip(r,MOD))


def expected_normalized_zeros():
    # The distinguished occurrence (0,0) is label code 0.
    # Invariant endpoints: its mate is (2,0)=58, plus any opposite pair.
    answer = set()
    for i in (0,1):
        for j in range(29):
            answer.add(tuple(sorted((0,58,29*i+j,29*(i+2)+j))))
    assert len(answer) == 58
    # Single-character zeros: the four normalized triple/single patterns.
    answer.update({(0,0,0,29), (0,87,87,87),
                   (0,0,0,87), (0,29,29,29)})
    assert len(answer) == 62
    return answer


def run(record=False, stream_path=None):
    start = time.perf_counter()
    roots = [ONE]
    for _ in range(29): roots.append(shift(roots[-1]))
    assert roots[29] == ONE
    assert all(v != ONE for v in roots[1:29])
    assert len(set(roots[:29])) == 29

    p, q = 5, 17  # C_3 F_2, C_2 F_3, in F_25 code notation.
    two = (1,2,4,3)
    three = (1,3,4,2)
    labels = [(i,j) for i in range(4) for j in range(29)]
    diagonal = [scale(roots[22*j % 29], A[p][N[q]]) for i,j in labels]
    pair = [[ZERO]*116 for _ in range(116)]
    for a,(i,j) in enumerate(labels):
        for b,(k,l) in enumerate(labels):
            # Ordered occurrence pair (a,b), plus ordered pair (b,a).
            coef_ab = A[T[p][T[three[i]][two[k]]]][N[T[q][T[two[i]][three[k]]]]]
            coef_ba = A[T[p][T[three[k]][two[i]]]][N[T[q][T[two[k]][three[i]]]]]
            pair[a][b] = add(scale(roots[(5*j+17*l) % 29],coef_ab),
                             scale(roots[(5*l+17*j) % 29],coef_ba))
            assert pair[a][b] == pair[b][a] or b > a
    single = [add(diagonal[a], pair[0][a]) for a in range(116)]
    expected = expected_normalized_zeros()
    zeros = []
    digest = hashlib.sha256()
    raw = bytearray() if stream_path is not None else None
    count = 0
    for a in range(116):
        base = add(diagonal[0],single[a])
        for b in range(a,116):
            base2 = add(add(base,single[b]),pair[a][b])
            for c in range(b,116):
                remainder = add(add(add(base2,single[c]),pair[a][c]),pair[b][c])
                key = (0,a,b,c)
                actual_zero = remainder == ZERO
                assert actual_zero == (key in expected), (key,remainder)
                if actual_zero: zeros.append(key)
                encoded = bytes(remainder)
                digest.update(encoded)
                if raw is not None: raw.extend(encoded)
                count += 1
    assert count == 266916
    assert set(zeros) == expected
    if raw is not None:
        assert len(raw) == 266916*7
        Path(stream_path).write_bytes(raw)
    result = {
        'method':'independent sparse ordered-pair expansion, reduced modulo f7',
        'total_normalized_multisets':count,
        'determinant_zero':len(zeros),
        'invariant_zeros':58,
        'single_character_zeros':4,
        'nondegenerate_zeros':0,
        'all_zero_multisets':[list(t) for t in zeros],
        'ordered_remainder_stream_sha256':digest.hexdigest(),
        'stream_convention':'a=0..115, b=a..115, c=b..115; append seven ascending F25 codes, one byte each'
    }
    root = Path(__file__).resolve().parent.parent
    path = root/'evidence'/'sparse_classification.json'
    path.parent.mkdir(exist_ok=True)
    if record:
        path.write_text(json.dumps(result,indent=2)+'\n')
    else:
        assert json.loads(path.read_text()) == result
    print('PASS: all 266916 normalized multisets classified exactly.')
    print('Zeros: 58 invariant, 4 single-character; 0 nondegenerate.')
    print('Remainder stream SHA-256:',digest.hexdigest())
    print('Elapsed seconds:',round(time.perf_counter()-start,3))
    print('PASS: saved classification certificate matches regeneration.')
    return result

if __name__ == '__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--record',action='store_true',help='regenerate the compact classification certificate')
    parser.add_argument('--stream',help='also write the complete 1.87 MB remainder stream for direct byte comparison')
    args=parser.parse_args()
    run(args.record,args.stream)
