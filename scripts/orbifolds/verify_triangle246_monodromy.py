#!/usr/bin/env python3
"""Exact finite certificate for the genus-two (2,4,6), degree-24 obstruction.

Pure Python 3; no packages, floating point, databases, or external files.
Run: python3 degree24_certificate.py

It enumerates ALL transitive pairs (a,b), up to simultaneous conjugation,
with cycle types a=2^12, b=4^6, ba=6^4; verifies deck groups; and verifies
all intermediate-cover permutation facts used in the accompanying proof.
Permutation composition mul(p,q) means p after q. Cycle types of ba and
(ab)^(-1) agree; either convention gives the same fiber data.
"""
from collections import Counter
import argparse
import contextlib
import io
import json
from pathlib import Path
import subprocess
import time

N = 24
B = tuple(4*(i//4) + (i+1)%4 for i in range(N))
ID = tuple(range(N))


def mul(p, q):
    return tuple(p[q[i]] for i in range(len(p)))


def inv(p):
    r = [0]*len(p)
    for i, x in enumerate(p):
        r[x] = i
    return tuple(r)


def cycles(p):
    seen = set()
    out = []
    for i in range(len(p)):
        if i in seen:
            continue
        t = []
        j = i
        while j not in seen:
            seen.add(j)
            t.append(j)
            j = p[j]
        out.append(tuple(t))
    return out


def rooted_code(a, root):
    """Unique labels for a connected pair, given its distinguished dart."""
    old = []
    labels = {}

    def add_vertex(r):
        for _ in range(4):
            labels[r] = len(old)
            old.append(r)
            r = B[r]

    add_vertex(root)
    i = 0
    ans = []
    while i < len(old):
        r = a[old[i]]
        if r not in labels:
            add_vertex(r)
        ans.append(labels[r])
        i += 1
    assert len(old) == N
    return tuple(ans)


def enumerate_pairs():
    """Build a fixed-point-free involution, with first-encounter vertex labels."""
    a = [-1]*N
    c = [-1]*N                 # partial permutation B*a
    answers = set()
    nodes = 0
    leaves = 0

    def valid_partial():
        # A partial permutation consists of paths and cycles. A path with
        # six edges cannot extend to a six-cycle. A closed cycle must have
        # exactly six edges. All other partial components remain admissible.
        for i in range(N):
            if c[i] == -1:
                continue
            j = i
            length = 0
            while True:
                j = c[j]
                if j == -1:
                    break
                length += 1
                if j == i:
                    if length != 6:
                        return False
                    break
                if length >= 6:
                    return False
        return True

    def dfs(used):
        nonlocal nodes, leaves
        nodes += 1
        i = next((i for i in range(N) if a[i] == -1), N)
        if i == N:
            leaves += 1
            answers.add(min(rooted_code(a, r) for r in range(N)))
            return
        # Do not start a disconnected component.
        if i >= used:
            return
        options = [j for j in range(i+1, used) if a[j] == -1]
        if used < N:
            options.append(used)  # first dart of the next undiscovered vertex
        for j in options:
            a[i], a[j] = j, i
            c[i], c[j] = B[j], B[i]
            if valid_partial():
                dfs(used+4 if j == used else used)
            a[i] = a[j] = c[i] = c[j] = -1

    dfs(4)
    return sorted(answers), nodes, leaves


def centralizer(a):
    """A commuting permutation is uniquely determined by the image of dart 0."""
    result = []
    for root in range(N):
        d = {0: root}
        todo = [0]
        valid = True
        while todo and valid:
            i = todo.pop()
            for p in (a, B):
                j, v = p[i], p[d[i]]
                if j in d:
                    if d[j] != v:
                        valid = False
                        break
                else:
                    d[j] = v
                    todo.append(j)
        if valid:
            assert len(d) == N
            h = tuple(d[i] for i in range(N))
            assert sorted(h) == list(range(N))
            assert mul(h, a) == mul(a, h)
            assert mul(h, B) == mul(B, h)
            result.append(h)
    return result


def quotient(generators, blocks):
    """Induced permutations on a supplied invariant partition."""
    labs = {}
    for x in blocks:
        if x not in labs:
            labs[x] = len(labs)
    blocks = tuple(labs[x] for x in blocks)
    reps = [blocks.index(i) for i in range(len(labs))]
    result = []
    for p in generators:
        q = tuple(blocks[p[i]] for i in reps)
        assert all(blocks[p[i]] == q[blocks[i]] for i in range(len(p)))
        result.append(q)
    return tuple(result), blocks


def forced_partition(generators, j):
    """Smallest invariant equivalence relation containing 0~j."""
    n = len(generators[0])
    parent = list(range(n))

    def root(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x

    def union(x, y):
        x, y = root(x), root(y)
        if x == y:
            return False
        parent[y] = x
        return True

    union(0, j)
    changed = True
    while changed:
        changed = False
        for x in range(n):
            for y in range(x):
                if root(x) == root(y):
                    for p in generators:
                        changed |= union(p[x], p[y])
    labs = {}
    out = []
    for x in range(n):
        r = root(x)
        if r not in labs:
            labs[r] = len(labs)
        out.append(labs[r])
    return tuple(out)


def elliptic_factor_certificate(a, h):
    # Quotient C by its deck involution, which has six fixed points.
    pairs = [min(i, h[i]) for i in range(N)]
    (aa, bb), _ = quotient((a, B), pairs)
    assert len(aa) == 12
    partitions = {forced_partition((aa, bb), j) for j in range(1, 12)}
    partitions = [p for p in partitions if sorted(Counter(p).values()) == [4,4,4]]
    assert len(partitions) == 1
    (aq, bq), blocks = quotient((aa, bb), partitions[0])
    cc, cq = mul(bb, aa), mul(bq, aq)

    def profiles(p, q):
        result = []
        for t in cycles(q):
            inner = []
            for u in cycles(p):
                if blocks[u[0]] in t:
                    assert len(u) % len(t) == 0
                    inner.append(len(u)//len(t))
            result.append((len(t), tuple(sorted(inner))))
        return tuple(sorted(result))

    actual = tuple(profiles(p,q) for p,q in ((aa,aq),(bb,bq),(cc,cq)))
    expected = (
        ((1,(1,1,2)), (2,(1,1,1,1))),
        ((1,(4,)), (2,(1,1,2))),
        ((3,(1,1,2)),),
    )
    assert actual == expected
    return aa, bb, blocks, actual


def generated_group(generators):
    n = len(generators[0])
    one = tuple(range(n))
    found = {one}
    todo = [one]
    while todo:
        p = todo.pop()
        for q in generators:
            r = mul(p, q)
            if r not in found:
                found.add(r)
                todo.append(r)
    return found


def a5_certificate(a):
    # The degree-two intermediate cover is branched at 1 and infinity:
    # a preserves its two blocks and B swaps them.
    color = {0: 0}
    todo = [0]
    while todo:
        i = todo.pop()
        for p, flip in ((a,0),(B,1)):
            j, v = p[i], color[i]^flip
            if j in color:
                assert color[j] == v
            else:
                color[j] = v
                todo.append(j)
    block = tuple(i for i in range(N) if color[i] == 0)
    assert len(block) == 12
    labels = {i:j for j,i in enumerate(block)}
    # These are all four branch fibers of the ACTUAL degree-12 inner
    # map. They let the proof reuse our stronger integral 2223 theorem.
    def restricted_type(p, subset):
        lab = {i:j for j,i in enumerate(subset)}
        return sorted(map(len, cycles(tuple(lab[p[i]] for i in subset))))
    for value in (0, 1):
        subset = tuple(i for i in range(N) if color[i] == value)
        assert restricted_type(a, subset) == [2]*6
    assert restricted_type(mul(B,B), block) == [2]*6
    c = mul(B,a)
    assert restricted_type(mul(c,c), block) == [3]*4
    kernel_generators = (a, mul(B,B), mul(mul(B,a),inv(B)))
    gens = tuple(tuple(labels[p[i]] for i in block) for p in kernel_generators)
    G = generated_group(gens)
    assert len(G) == 60
    one = tuple(range(12))
    involutions = [p for p in G if p != one and mul(p,p) == one]
    assert len(involutions) == 15
    klein = {
        frozenset((one,p,q,mul(p,q)))
        for p in involutions for q in involutions
        if p != q and mul(p,q) == mul(q,p)
    }
    assert len(klein) == 5
    klein = sorted(klein, key=lambda H: tuple(sorted(H)))
    index = {H:i for i,H in enumerate(klein)}
    action = set()
    for p in G:
        pi = inv(p)
        q = tuple(index[frozenset(mul(mul(p,x),pi) for x in H)] for H in klein)
        inversions = sum(q[i] > q[j] for i in range(5) for j in range(i+1,5))
        assert inversions % 2 == 0
        action.add(q)
    # A faithful action of a group of order 60 by even permutations on five
    # objects explicitly identifies it with A_5. No group database is used.
    assert len(action) == 60
    return block, gens


def main(native=None):
    start = time.monotonic()
    representatives, nodes, leaves = enumerate_pairs()
    assert len(representatives) == 40
    assert leaves == 339
    if native:
        independent = json.loads(subprocess.check_output([native], text=True))
        assert independent['rooted'] == leaves
        assert [tuple(p) for p in independent['representatives']] == representatives
        print('UNPRUNED native cross-check: every representative agrees; '
              f"nodes={independent['nodes']}, completed={independent['completed']}, "
              f"seconds={independent['seconds']}")
    counts = Counter()
    rows = []
    extra = []
    for number, a in enumerate(representatives, 1):
        assert sorted(a) == list(range(N))
        assert all(a[a[i]] == i and a[i] != i for i in range(N))
        assert sorted(map(len,cycles(mul(B,a)))) == [6]*4
        assert rooted_code(a,0) == a
        deck = centralizer(a)
        assert deck[0] == ID
        profile = None
        if len(deck) > 2:
            category = 'extra automorphisms'
        elif len(deck) == 1:
            category = 'one-class Frobenius obstruction'
        else:
            h = deck[1]
            profile = tuple(sum(set(h[i] for i in t) == set(t) for t in cycles(p))
                            for p in (a,B,mul(B,a)))
            if sum(profile) == 2:
                category = 'nonhyperelliptic involution'
            elif profile == (4,0,2):
                category = 'two-class Frobenius obstruction'
            elif profile == (2,2,2):
                category = 'degree-four elliptic quotient'
                data = elliptic_factor_certificate(a,h)
                extra.append((number, category, data))
            elif profile == (4,2,0):
                category = 'A5 and real multiplication by sqrt(5)'
                data = a5_certificate(a)
                extra.append((number, category, data))
            else:
                raise AssertionError(('unexpected profile', number, profile))
        counts[category] += 1
        rows.append((number, len(deck), profile, category, a))
    expected = {
        'extra automorphisms': 23,
        'nonhyperelliptic involution': 6,
        'one-class Frobenius obstruction': 1,
        'two-class Frobenius obstruction': 2,
        'degree-four elliptic quotient': 4,
        'A5 and real multiplication by sqrt(5)': 4,
    }
    assert dict(counts) == expected
    assert sum(N//row[1] for row in rows) == leaves
    print('Exact enumeration and all assertions PASSED.')
    print('Search nodes:', nodes)
    print('Rooted representatives:', leaves)
    print('Unrooted representatives:', len(representatives))
    print('\nSUMMARY')
    for label, count in expected.items():
        print(f'{count:2d}  {label}')
    print('\nALL 40 REPRESENTATIVES (zero-based permutation arrays)')
    print('The fixed second generator is B =', B)
    for number, order, profile, label, a in rows:
        print(f'{number:2d} deck={order:2d} fixed={profile}  {label}')
        print('   a =', a)
    print('\nADDITIONAL INTERMEDIATE-COVER CERTIFICATES')
    for number, label, data in extra:
        print(number, label)
        if label.startswith('A5'):
            block, gens = data
            print('   index-two block:', block)
            print('   restricted Schreier generators:', gens)
            print('   verified faithful even action on five Klein four subgroups')
            print('   all FOUR inner fibers verified: 2^6,2^6,2^6,3^4')
        else:
            aa, bb, blocks, profile = data
            print('   hyperelliptic quotient generators:', aa, bb)
            print('   invariant partition into three four-element blocks:', blocks)
            print('   outer-length / inner-fiber profiles:', profile)
    print('\nPASS: the finite certificate is complete.')
    print(f'seconds={time.monotonic()-start:.6f}')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--native', help='Optional independent unpruned C++ executable')
    parser.add_argument('--receipt', type=Path, help='Save this computation transcript')
    args = parser.parse_args()
    if args.receipt:
        buffer = io.StringIO()
        with contextlib.redirect_stdout(buffer):
            main(args.native)
        transcript = buffer.getvalue()
        args.receipt.write_text(transcript)
        print(transcript, end='')
    else:
        main(args.native)
