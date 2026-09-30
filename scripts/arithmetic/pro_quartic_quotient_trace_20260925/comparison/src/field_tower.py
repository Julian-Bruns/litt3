"""Independent Python arithmetic for E=F_25[alpha,zeta], degrees 4 and 7.

An E element is a length-28 tuple of F_25 codes: index 7*i+j is the
coefficient of alpha^i*zeta^j.  No floating point or external packages.
"""
from pathlib import Path
import json
from ff25 import add, mul, neg

ROOT = Path(__file__).resolve().parents[1]
FIELDS = json.loads((ROOT/'data/field_data.json').read_text())
AM = FIELDS['alpha_modulus'][:-1]
ZM = FIELDS['zeta_modulus'][:-1]
ADD = [[add(a,b) for b in range(25)] for a in range(25)]
MUL = [[mul(a,b) for b in range(25)] for a in range(25)]
NEG = [neg(a) for a in range(25)]
ZERO = (0,)*28
ONE = (1,)+(0,)*27

def scalar(a):
    if not 0 <= a < 25:
        raise ValueError('F_25 code must be in 0..24')
    return (a,)+(0,)*27

def eadd(a,b):
    return tuple(ADD[x][y] for x,y in zip(a,b))

def eneg(a):
    return tuple(NEG[x] for x in a)

def esub(a,b):
    return eadd(a,eneg(b))

def emul(a,b):
    w = [[0]*13 for _ in range(7)]
    for i in range(4):
        for j in range(7):
            x = a[7*i+j]
            if not x:
                continue
            for h in range(4):
                for k in range(7):
                    y = b[7*h+k]
                    if y:
                        w[i+h][j+k] = ADD[w[i+h][j+k]][MUL[x][y]]
    for i in range(6,3,-1):
        for j in range(13):
            x = w[i][j]
            if x:
                for h in range(4):
                    w[i-4+h][j] = ADD[w[i-4+h][j]][MUL[x][NEG[AM[h]]]]
    for j in range(12,6,-1):
        for i in range(4):
            x = w[i][j]
            if x:
                for k in range(7):
                    w[i][j-7+k] = ADD[w[i][j-7+k]][MUL[x][NEG[ZM[k]]]]
    return tuple(w[i][j] for i in range(4) for j in range(7))

def epow(a,n):
    if n < 0:
        return epow(einv(a),-n)
    out = ONE
    while n:
        if n & 1:
            out = emul(out,a)
        a = emul(a,a)
        n //= 2
    return out

def einv(a):
    if a == ZERO:
        raise ZeroDivisionError('zero in E')
    return epow(a,25**28-2)

def ediv(a,b):
    return emul(a,einv(b))

def from_k0(a):
    out = [0]*28
    for i,x in enumerate(a):
        out[7*i] = x
    return tuple(out)

ZETA = (0,1)+(0,)*26
ZPOW = [ONE]
for _ in range(28):
    ZPOW.append(emul(ZPOW[-1],ZETA))

ENDPOINTS = json.loads((ROOT/'data/endpoint_data.json').read_text())
C_LABELS = [emul(from_k0(ENDPOINTS['C'][i]), ZPOW[5*j % 29]) for i in range(4) for j in range(29)]
M_LABELS = [emul(from_k0(ENDPOINTS['M'][i]), ZPOW[8*j % 29]) for i in range(4) for j in range(29)]

def endpoint_sum(labels, values):
    if len(labels) != 4 or any(not isinstance(i,int) or not 0 <= i < 116 for i in labels):
        raise ValueError('exactly four labels in 0..115 are required; repetitions are allowed')
    out = ZERO
    for i in labels:
        out = eadd(out,values[i])
    return out
