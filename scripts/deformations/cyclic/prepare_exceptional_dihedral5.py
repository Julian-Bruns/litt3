#!/usr/bin/env sage-python
"""Supply complete actual kernel/dual bases for the exceptional D10 model."""
import argparse
import hashlib
import json
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('model');ap.add_argument('--output',required=True)
    args=ap.parse_args();source=Path(args.model)
    data=json.loads(source.read_text())
    assert data['label']=='pair_4_5' and not data['neutral'] and data['defect']==4
    ring=PolynomialRing(GF(5),'t')
    k=GF(625,'t',modulus=ring(data['field_modulus']))
    M=matrix(k,[[k(c) for c in row] for row in data['hodge_matrix']])
    assert M.rank()==11 and M[:11,:11].rank()==9 and M[11:,11:].rank()==2
    enc=lambda a:[int(a.polynomial()[i]) for i in range(4)]
    kernels=[v.apply_map(lambda a:a**125) for v in M.right_kernel().basis()]
    duals=list(M.left_kernel().basis())
    assert all(M*v.apply_map(lambda a:a**5)==0 for v in kernels)
    assert all(v*M==0 for v in duals)
    data['kernel_basis']=[[enc(a) for a in v] for v in kernels]
    data['obstruction_duals']=[[enc(a) for a in v] for v in duals]
    data['parent_model_sha256']=hashlib.sha256(source.read_bytes()).hexdigest()
    data['probe_scope']='Complete marked W3 parameter directions and W4 dual coordinates; no fourth existence or exclusion inferred.'
    Path(args.output).write_text(json.dumps(data,indent=2)+'\n')
    print('PASS exact four-dimensional kernel and dual; eigenspace defects 2+2')


if __name__=='__main__':main()
