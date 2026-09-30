"""Intrinsic degree-four endpoint reconstruction; no endpoint search.

All coefficient integers in ROWS are F25 bracket codes, not F5 scalars.
The reference arithmetic is the original field tower in src/exact_fields.py.
The returned trace rows are coefficients in theta=c-hat_2, theta^4=[20].
"""
from __future__ import annotations
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2] / 'src'))
from exact_fields import K, F25, code, embed, zeta, encode

ROWS = {'C': [20,1,7,19], 'E': [8,1,15,0],
        'U': [12,18,8,6], 'V': [4,17,2,0]}
# entry = (power-sum index, literal fifth-Frobenius exponent)
TABLE = {'C': [(4,6),(1,1),(6,2),(7,3)],
         'E': [(8,0),(17,3),(2,9),None],
         'U': [(8,11),(17,0),(2,6),(3,2)],
         'V': [(4,0),(1,9),(6,10),None]}
PHASE_EXP = {'C':5, 'E':8, 'U':17, 'V':4}

def constant(n: int):
    return embed(code(n), K)

def newton_coefficients(first):
    """Return e_0,...,e_4 from p_1,...,p_4, over any given field."""
    if len(first) != 4:
        raise ValueError('Exactly four power sums are required')
    field = first[0].field
    es = [field.one]
    for k in range(1,5):
        total = field.zero
        for j in range(1,k+1):
            term = es[k-j]*first[j-1]
            total += term if j%2 else -term
        es.append(total / field(k))
    return es

def power_sums(first, stop=119):
    if stop < 4:
        raise ValueError('stop must be at least four')
    field=first[0].field
    e=newton_coefficients(first)
    out=[field(4), *first]
    for n in range(5,stop+1):
        out.append(e[1]*out[n-1]-e[2]*out[n-2]
                   +e[3]*out[n-3]-e[4]*out[n-4])
    return out

def quartic_row(first):
    e=newton_coefficients(first)
    return [e[4],-e[3],e[2],-e[1],e[0]]

def reconstruct_first(C,U):
    return [(C[1]/constant(1)).frob(13),
            (U[2]/constant(8)).frob(8),
            (U[3]/constant(6)).frob(12),
            (C[0]/constant(20)).frob(8)]

def traces_from_first(first):
    p=power_sums(first,17)
    out={}
    for name,row in TABLE.items():
        out[name]=[K.zero if spec is None else
                   constant(ROWS[name][j])*p[spec[0]].frob(spec[1])
                   for j,spec in enumerate(row)]
    return out

def grid_residuals(first):
    p=power_sums(first,119)
    return [p[116+j]-p[j] for j in range(4)]

def compatibility_residuals(C,U):
    first=reconstruct_first(C,U)
    p=power_sums(first,17)
    return [C[2]-constant(7)*p[6].frob(2),
            C[3]-constant(19)*p[7].frob(3),
            U[0]-constant(12)*p[8].frob(11),
            U[1]-constant(18)*p[17]]

def direct_traces(labels):
    if len(labels)!=4 or any(not(0<=i<4 and 0<=j<29) for i,j in labels):
        raise ValueError('Four labels in Z/4 x Z/29 are required')
    out={}
    for name,row in ROWS.items():
        m=PHASE_EXP[name]
        out[name]=[constant(row[k])*sum((K(pow(2,i*k,5))*zeta**((m*j)%29)
                   for i,j in labels),K.zero) for k in range(4)]
    return out

def direct_first(labels):
    roots=[K(pow(2,i,5))*zeta**j for i,j in labels]
    return [sum((z**n for z in roots),K.zero) for n in range(1,5)]

def decode_roots_from_quartic(first):
    """116 exact evaluations, only to decode a supplied quartic (not a pair search)."""
    coeff=quartic_row(first)
    out=[]
    for i in range(4):
        for j in range(29):
            root=K(pow(2,i,5))*zeta**j
            while len(coeff)>1:
                # Divide ascending coeff by X-root, retaining the remainder.
                q=[K.zero]*(len(coeff)-1)
                q[-1]=coeff[-1]
                for k in range(len(q)-2,-1,-1):
                    q[k]=coeff[k+1]+root*q[k+1]
                remainder=coeff[0]+root*q[0]
                if remainder:
                    break
                out.append((i,j));coeff=q
    if len(coeff)!=1 or len(out)!=4:
        raise ValueError('Quartic does not have four roots, with multiplicity, in mu_116')
    return sorted(out)
