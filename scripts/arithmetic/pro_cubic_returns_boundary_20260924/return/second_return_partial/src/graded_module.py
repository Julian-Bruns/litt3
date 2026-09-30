"""Exact projective full-column-rank certificates over F_25.

The parameters in this module are FORMAL INDETERMINATES, not sampled
F_25-valued points. See REPORT.md for the homogeneous-module argument.
All coefficient arrays contain the codes a+5b for a+b*beta.
"""
from __future__ import annotations
from functools import lru_cache
from pathlib import Path
import itertools
import sys
import numpy as np
from numba import njit

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'vendor/full_return_inputs/src'))
import compute as arithmetic
ADD, MUL, NEG, INV = arithmetic.ADD, arithmetic.MUL, arithmetic.NEG, arithmetic.INV

@lru_cache(maxsize=None)
def monomials(n: int, degree: int) -> tuple[tuple[int, ...], ...]:
    """Ascending lexicographic exponent tuples, with fixed total degree."""
    if n < 1 or degree < 0:
        raise ValueError('Positive variable count and nonnegative degree required')
    if n == 1:
        return ((degree,),)
    return tuple((i,) + tail for i in range(degree + 1)
                 for tail in monomials(n - 1, degree - i))

def macaulay(tensor: np.ndarray, degree: int) -> np.ndarray:
    """Rows are z^a times rows of sum(z_i*tensor[i]), |a|=degree-1.

    Row order: monomial-major, then original matrix row.
    Column order: monomial-major, then original matrix column.
    """
    if tensor.ndim != 3 or degree < 1:
        raise ValueError('Need a 3-dimensional tensor and degree >= 1')
    n, r, s = tensor.shape
    old = monomials(n, degree - 1)
    new = monomials(n, degree)
    lookup = {m: i for i, m in enumerate(new)}
    out = np.zeros((len(old)*r, len(new)*s), dtype=np.uint8)
    for k, m in enumerate(old):
        for j in range(n):
            target = list(m)
            target[j] += 1
            ell = lookup[tuple(target)]
            block = out[k*r:(k+1)*r, ell*s:(ell+1)*s]
            out[k*r:(k+1)*r, ell*s:(ell+1)*s] = ADD[block, tensor[j]]
    return out

@njit(cache=True)
def pivot_witness(A):
    """A nonzero square minor: original rows, columns, and determinant.

    Row order is the order in which ORIGINAL rows are selected as pivots.
    Therefore no permutation sign is needed in the reported determinant.
    """
    M = A.copy()
    nr, nc = M.shape
    row_ids = np.arange(nr)
    pcols = np.zeros(min(nr, nc), dtype=np.int64)
    rank = 0
    determinant = 1
    for col in range(nc):
        p = rank
        while p < nr and M[p, col] == 0:
            p += 1
        if p == nr:
            continue
        if p != rank:
            row_ids[rank], row_ids[p] = row_ids[p], row_ids[rank]
            for j in range(nc):
                M[rank,j], M[p,j] = M[p,j], M[rank,j]
        pivot = M[rank,col]
        determinant = MUL[determinant,pivot]
        inverse = INV[pivot]
        for j in range(col,nc):
            M[rank,j] = MUL[inverse,M[rank,j]]
        for i in range(rank+1,nr):
            if M[i,col] != 0:
                a = NEG[M[i,col]]
                for j in range(col,nc):
                    M[i,j] = ADD[M[i,j],MUL[a,M[rank,j]]]
        pcols[rank] = col
        rank += 1
        if rank == nr:
            break
    return row_ids[:rank].copy(), pcols[:rank].copy(), int(determinant)

@njit(cache=True)
def determinant(A):
    """Independent square Gaussian determinant, allowing row swaps."""
    if A.shape[0] != A.shape[1]:
        raise ValueError('Square matrix required')
    M = A.copy()
    n = M.shape[0]
    result = 1
    for col in range(n):
        p = col
        while p < n and M[p,col] == 0:
            p += 1
        if p == n:
            return 0
        if p != col:
            for j in range(col,n):
                M[p,j], M[col,j] = M[col,j], M[p,j]
            result = NEG[result]
        pivot = M[col,col]
        result = MUL[result,pivot]
        inv = INV[pivot]
        for i in range(col+1,n):
            if M[i,col] != 0:
                a = NEG[MUL[M[i,col],inv]]
                for j in range(col+1,n):
                    M[i,j] = ADD[M[i,j],MUL[a,M[col,j]]]
                M[i,col] = 0
    return int(result)

def normal_form(M: np.ndarray) -> tuple[np.ndarray, np.ndarray, np.ndarray]:
    """Return the quotient map V_d -> V_d / row(M), as a right matrix."""
    R, pivots = arithmetic.rref(M)
    mask = np.ones(M.shape[1], dtype=bool)
    mask[pivots] = False
    free = np.flatnonzero(mask)
    N = np.zeros((M.shape[1],len(free)), dtype=np.uint8)
    N[free,np.arange(len(free))] = 1
    N[pivots] = NEG[R[:len(pivots)][:,free]]
    return N, pivots, free

def relation_count(n: int, degree: int, s: int) -> int:
    return n*(n-1)//2 * len(monomials(n,degree-1)) * s

def commutator_relations(N: np.ndarray, n: int, degree: int,
                         s: int, indices: np.ndarray) -> np.ndarray:
    """Selected multiplication-commutativity relations in (M_d)^n.

    Enumeration: pair (i,j), i<j; degree-(d-1) monomial m;
    module component c. Each row has blocks i=N[x_j*m,c] and
    j=-N[x_i*m,c]. The indices identify actual algebraic identities.
    """
    new = monomials(n,degree)
    old = monomials(n,degree-1)
    lookup = {m:i for i,m in enumerate(new)}
    pairs = tuple(itertools.combinations(range(n),2))
    h = N.shape[1]
    if N.shape[0] != len(new)*s:
        raise ValueError('Normal-form dimensions do not match the module')
    out = np.zeros((len(indices),n*h),dtype=np.uint8)
    total = relation_count(n,degree,s)
    for k, raw in enumerate(indices):
        ix = int(raw)
        if ix < 0 or ix >= total:
            raise ValueError('Invalid relation index')
        component = ix % s
        ix //= s
        m_index = ix % len(old)
        pair_index = ix // len(old)
        i,j = pairs[pair_index]
        m = list(old[m_index])
        m[j] += 1
        at_j = lookup[tuple(m)]*s + component
        m[j] -= 1
        m[i] += 1
        at_i = lookup[tuple(m)]*s + component
        out[k,i*h:(i+1)*h] = N[at_j]
        out[k,j*h:(j+1)*h] = NEG[N[at_i]]
    return out

def field_self_test() -> None:
    """Check the field tables by pair arithmetic, independently of their use."""
    for a in range(25):
        a0,a1 = a%5,a//5
        for b in range(25):
            b0,b1 = b%5,b//5
            assert int(ADD[a,b]) == (a0+b0)%5 + 5*((a1+b1)%5)
            expected = (a0*b0+3*a1*b1)%5 + 5*((a0*b1+a1*b0+a1*b1)%5)
            assert int(MUL[a,b]) == expected
        assert int(ADD[a,NEG[a]]) == 0
        if a:
            assert int(MUL[a,INV[a]]) == 1
    # Check nonzero-minor bookkeeping on independently generated small arrays.
    rng = np.random.default_rng(9024)
    for nr,nc in ((3,5),(7,4),(6,6)):
        for _ in range(10):
            A = rng.integers(0,25,size=(nr,nc),dtype=np.uint8)
            rows,cols,det = pivot_witness(A)
            assert len(rows) == len(arithmetic.rref(A)[1])
            assert determinant(A[np.ix_(rows,cols)]) == det != 0
