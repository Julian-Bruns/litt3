"""Exact permutation routines; Python standard library only."""
import collections

def cycles(p):
    seen = set()
    result = []
    for x in range(len(p)):
        if x in seen:
            continue
        c = []
        y = x
        while y not in seen:
            seen.add(y)
            c.append(y)
            y = p[y]
        assert y == x
        result.append(c)
    return result


def labelled_generators(t):
    a = [row[0] for row in t]
    b = [row[1] for row in t]
    # Functional composition ba: x |-> b(a(x)).
    c = [b[a[x]] for x in range(len(t))]
    return a, b, c


def rooted_key(t, root):
    """BFS-normalized table, preserving the generator and branch labels."""
    relabel = {root: 0}
    queue = [root]
    result = []
    for x in queue:
        for g in range(3):
            y = t[x][g]
            if y not in relabel:
                relabel[y] = len(queue)
                queue.append(y)
            result.append(relabel[y])
    assert len(queue) == len(t), 'nontransitive table'
    return tuple(result)


def commuting_permutations(t):
    """All centralizer elements, each determined by the image of 0."""
    n = len(t)
    answer = []
    for image0 in range(n):
        p = [-1]*n
        p[0] = image0
        queue = [0]
        good = True
        for x in queue:
            for g in range(3):
                y = t[x][g]
                z = t[p[x]][g]
                if p[y] < 0:
                    p[y] = z
                    queue.append(y)
                elif p[y] != z:
                    good = False
                    break
            if not good:
                break
        if good:
            assert len(queue) == n and sorted(p) == list(range(n))
            assert all(p[t[x][g]] == t[p[x]][g]
                       for x in range(n) for g in range(3))
            answer.append(p)
    return answer


def join_pair(t, partition, j):
    """Smallest invariant equivalence coarsening partition and identifying 0,j."""
    parent = list(partition)

    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x

    pending = [(0, j)]
    for x, y in pending:
        x, y = find(x), find(y)
        if x == y:
            continue
        if x > y:
            x, y = y, x
        parent[y] = x
        pending.extend((t[x][g], t[y][g]) for g in range(3))
    result = tuple(find(x) for x in range(len(t)))
    # Independently check invariance of the resulting equivalence relation.
    for x in range(len(t)):
        for g in range(3):
            assert result[t[x][g]] == result[t[result[x]][g]]
    return result


def invariant_partitions(t):
    discrete = tuple(range(len(t)))
    result = [discrete]
    seen = {discrete}
    for partition in result:
        for j in range(len(t)):
            if partition[j] != j or partition[j] == partition[0]:
                continue
            new = join_pair(t, partition, j)
            if new not in seen:
                seen.add(new)
                result.append(new)
    return result


def quotient_profile(t, partition):
    representatives = sorted(set(partition))
    labels = {b: i for i, b in enumerate(representatives)}
    sizes = collections.Counter(partition)
    assert len(set(sizes.values())) == 1
    qt = [[labels[partition[t[b][g]]] for g in range(3)]
          for b in representatives]
    cyc = [cycles(p) for p in labelled_generators(qt)]
    genus_numerator = 2+len(qt)-sum(map(len, cyc))
    assert genus_numerator >= 0 and genus_numerator % 2 == 0
    signature = []
    for e, branch_cycles in zip((2, 3, 7), cyc):
        for orbit in branch_cycles:
            ell = len(orbit)
            assert e % ell == 0
            if ell < e:
                signature.append(e//ell)
    return dict(genus=genus_numerator//2,
                signature=sorted(signature),
                source_degree=len(t)//len(qt),
                target_degree=len(qt),
                quotient_cycle_lengths=[sorted(map(len, cs)) for cs in cyc],
                partition=list(partition))


