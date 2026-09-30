#!/usr/bin/env python3
"""Check the residual subsystem against the full Hom tensor and chart inputs.

This uses coded F25 elimination, without a CAS. Ideal membership is
checked only if an explicit multiplier identity is present. A saved
unit Groebner basis alone is recorded as an executed CAS conclusion,
not misreported as an elementary identity verification.
"""
import argparse
import hashlib
import json
from pathlib import Path
import numpy as np
import pro_quadratic_twist_vanishing as q
from verify_k_shifted_norm_identities import add_term


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('residual', type=Path)
    ap.add_argument('pencils', type=Path)
    ap.add_argument('prepared', type=Path)
    ap.add_argument('checked', type=Path)
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    residual = np.load(args.residual, allow_pickle=False)
    H, J = residual['H'], residual['J']
    T = np.load(args.pencils, allow_pickle=False)['T']
    indices = list(range(11,19))+list(range(23,30))
    whole = [[int(T[v,r,u]) for v in range(16) for u in indices]
             for r in range(80)]
    split = [[int(H[r,u,v]) for v in range(10) for u in range(15)]+[0]*90
             for r in range(30)]
    split += [[0]*150+[int(J[r,u,v]) for v in range(6) for u in range(15)]
              for r in range(23)]
    rr, pp = q.rref(whole)
    ss, qq = q.rref(split)
    assert len(pp) == len(qq) == 53 and rr[:53] == ss[:53]
    data = json.loads(args.prepared.read_text())
    cert = json.loads(args.checked.read_text())
    assert data['input_sha256'] == hashlib.sha256(args.residual.read_bytes()).hexdigest()
    assert cert['input_sha256'] == hashlib.sha256(args.prepared.read_bytes()).hexdigest()
    j, d = data['source_stratum'], data['polynomial_degree']
    names = cert['variables']
    assert names == [f'b{i}' for i in range(j+1,10)]+[f'p{i}' for i in range(d)]+[f'c{i}' for i in range(7)]+['a']
    n = len(names)
    def variable(name):
        e = [0]*n; e[names.index(name)] = 1; return tuple(e)
    zero = (0,)*n
    source = [None if i<j else zero if i==j else variable(f'b{i}') for i in range(10)]
    mapping = [variable(f'p{i}') if i<d else zero if i==d else None for i in range(8)]
    mapping += [variable(f'c{i}') for i in range(7)]
    equations = []
    for r in range(30):
        f = {}
        for u, eu in enumerate(mapping):
            if eu is None: continue
            for v, ev in enumerate(source):
                if ev is None: continue
                code = int(H[r,u,v]); e = [a+b for a,b in zip(eu,ev)]
                add_term(f,tuple(e),code%5)
                e[-1] += 1; add_term(f,tuple(e),code//5)
        if f: equations.append(f)
    relation = {}
    for power,c in ((2,1),(1,4),(0,2)):
        e = [0]*n; e[-1] = power; add_term(relation,tuple(e),c)
    equations.append(relation)
    assert equations == [{tuple(e):c for e,c in f} for f in cert['equations']]
    receipt = {'status':'PASS', 'source_stratum':j,'polynomial_degree':d,
               'full_Hom_restriction_rank':53,
               'scope':'Residual H,J row space equals the complete restricted Hom row space; every prime-field chart equation independently reconstructed.',
               'recorded_CAS_unit_ideal': cert.get('empty'),
               'explicit_identity_verified':False}
    if 'multipliers' in cert:
        assert len(cert['multipliers']) == len(equations)
        total = {}
        for f,h in zip(equations,cert['multipliers']):
            for e,c in h:
                for ee,cc in f.items():
                    add_term(total,tuple(a+b for a,b in zip(e,ee)),c*cc)
        assert total == {zero:1}
        receipt['explicit_identity_verified'] = True
        receipt['witness_terms'] = cert['witness_terms']
    receipt['input_hashes'] = {p.name:hashlib.sha256(p.read_bytes()).hexdigest()
                              for p in (args.residual,args.pencils,args.prepared,args.checked)}
    args.output.write_text(json.dumps(receipt,indent=2)+'\n')
    print('PASS full-rank53 provenance and chart',j,d,
          'identity',receipt['explicit_identity_verified'],flush=True)


if __name__ == '__main__':
    main()
