"""Independent partial-fraction reconstruction and certificate cell checks."""
from __future__ import annotations
from functools import lru_cache
from itertools import permutations
import struct
from pathlib import Path
from reference_field import *

MAGIC = b'RR29C001'
RECORD = struct.Struct('<I64sQ')

def read_header(path: Path) -> tuple[int, int]:
    with path.open('rb') as f:
        if f.read(8) != MAGIC:
            raise ValueError('bad magic')
        raw = f.read(8)
        if len(raw) != 8:
            raise ValueError('truncated header')
        d, count = struct.unpack('<II', raw)
    if path.stat().st_size != 16 + RECORD.size * count:
        raise ValueError('bad certificate length')
    return d, count

def read_record(path: Path, index: int) -> tuple[int, bytes, int]:
    d, count = read_header(path)
    if not 0 <= index < count:
        raise IndexError('record out of range')
    with path.open('rb') as f:
        f.seek(16 + RECORD.size * index)
        return RECORD.unpack(f.read(RECORD.size))

def pole_indices(mask: int) -> list[int]:
    return [i for i in range(29) if mask & (1 << i)]

@lru_cache(maxsize=None)
def cauchy(i: int, j: int) -> Element:
    return ZERO if i == j else inv(sub(ROOTS[i], ROOTS[j]))

def evaluation_spaces(I: list[int]) -> dict:
    d = len(I)
    M1 = [[cauchy(i, j) for j in I] + [ONE, ROOTS[i]] for i in I]
    M2 = [[cauchy(i, j) for j in I] + [ROOTS[-2*i % 29], ROOTS[-i % 29]] for i in I]
    W1, W2 = nullspace(M1), nullspace(M2)
    if len(W1) != 2 or len(W2) != 2:
        raise ArithmeticError('unexpected residue dimensions')
    D0 = ONE
    for i in I:
        D0 = mul(D0, neg(ROOTS[i]))
    E = {'first': [], 'second': [], 'lead1': [], 'lead2': [], 'constant1': [], 'constant2': []}
    for j, i in enumerate(I):
        dp = ONE
        for l in I:
            if i != l:
                dp = mul(dp, sub(ROOTS[i], ROOTS[l]))
        E['first'].append([mul(dp, W1[b][j]) for b in range(2)])
        E['second'].append([mul(mul(ROOTS[2*i % 29], dp), W2[b][j]) for b in range(2)])
    for b in range(2):
        tr, tt = ZERO, ZERO
        for j, i in enumerate(I):
            tr = add(tr, mul(W1[b][j], ROOTS[-i % 29]))
            tt = add(tt, W2[b][j])
        E['lead1'].append(W1[b][d+1])
        E['lead2'].append(add(W2[b][d+1], tt))
        E['constant1'].append(mul(D0, sub(W1[b][d], tr)))
        E['constant2'].append(mul(D0, W2[b][d]))
    E['parameter_basis1'] = W1
    E['parameter_basis2'] = W2
    return E

def det3(M: list[list[Element]]) -> Element:
    z = ZERO
    for perm in permutations(range(3)):
        term = ONE
        for i in range(3):
            term = mul(term, M[i][perm[i]])
        inversions = sum(perm[i] > perm[j] for i in range(3) for j in range(i+1, 3))
        z = add(z, neg(term) if inversions % 2 else term)
    return z

def phase_kernel(I: list[int], E: dict, phase: int) -> tuple[list[list[Element]], list[Element]]:
    if not 0 <= phase < 64:
        raise ValueError('phase index outside 0..63')
    b, c = divmod(phase, 8)
    phases = [ONE, MU[b], MU[c]]
    M = []
    for j in range(3):
        factor = mul(phases[j], ROOTS[4*I[j] % 29])
        M.append([neg(mul(factor, z)) for z in E['first'][j]] + E['second'][j])
    v = []
    for j in range(4):
        term = det3([[row[k] for k in range(4) if k != j] for row in M])
        v.append(neg(term) if j % 2 else term)
    if all(x == ZERO for x in v) or any(dot(row, v) != ZERO for row in M):
        raise ArithmeticError('cofactor rank/kernel check failed')
    return M, v

def value(pair: list[Element], v: list[Element], offset: int) -> Element:
    return add(mul(pair[0], v[offset]), mul(pair[1], v[offset+1]))

def forms(E: dict, j: int) -> tuple[list[Element], list[Element]]:
    return E['first'][j] + [ZERO, ZERO], [ZERO, ZERO] + E['second'][j]

def check_reason(reason: int, I: list[int], E: dict, v: list[Element]) -> str:
    d = len(I)
    if 0 <= reason < d:
        x, y = value(E['first'][reason], v, 0), value(E['second'][reason], v, 2)
        H = sub(power(y, 8), mul(ROOTS[3*I[reason] % 29], power(x, 8)))
        if H == ZERO:
            raise ArithmeticError('false power witness')
        return 'power'
    if 32 <= reason < 32+d:
        j = reason-32
        if value(E['first'][j], v, 0) != ZERO and value(E['second'][j], v, 2) != ZERO:
            raise ArithmeticError('false forbidden-pole-zero witness')
        return 'pole_zero'
    if 64 <= reason <= 67:
        key, offset = [('lead1',0),('lead2',2),('constant1',0),('constant2',2)][reason-64]
        if value(E[key], v, offset) != ZERO:
            raise ArithmeticError('false degree/constant witness')
        return 'degree_or_constant'
    raise ValueError('invalid witness byte')
