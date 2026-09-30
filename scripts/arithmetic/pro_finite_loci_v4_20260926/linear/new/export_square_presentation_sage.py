#!/usr/bin/env sage-python
"""UNEXECUTED Sage continuation. CPython syntax checked only.

Build a monic-root presentation of the COMPLETE localized square scheme, directly
from the executed global coefficient chunks. This is NOT a decision certificate.

sage -python new/export_square_presentation_sage.py --r 9 --model global/r9 --stage presentation
sage -python new/export_square_presentation_sage.py --r 9 --model global/r9 --stage groebner

No Sage version was installed or runtime-tested in this session. Memory use of
this optional stage is not bounded by the executed C++ reconstruction's usage.
"""
import argparse
import array
import json
import sys
from pathlib import Path
from functools import lru_cache
from sage.all import GF, PolynomialRing, save, load

ROOT=Path(__file__).resolve().parents[1]

def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--r',required=True,type=int)
    ap.add_argument('--model',required=True,type=Path)
    ap.add_argument('--stage',choices=('presentation','groebner'),required=True)
    ap.add_argument('--output',type=Path,default=Path('sage_generated'))
    args=ap.parse_args()
    inp=json.loads((ROOT/'data/inputs.json').read_text())
    if args.r not in inp['roots']:raise ValueError('Unknown root code')
    model=json.loads((ROOT/'data/field_model.json').read_text())
    Z=PolynomialRing(GF(5),'a')
    K=GF(5**8,'alpha',modulus=Z(model['absolute_modulus_ascending_F5']))
    alpha=K.gen()
    beta=sum((K(c)*alpha**j for j,c in enumerate(model['beta_in_alpha_ascending_F5'])),K(0))
    assert beta**2==beta+3
    @lru_cache(maxsize=390625)
    def kc(n):
        if not 0<=n<390625:raise ValueError('Invalid K code')
        r=K(0)
        for j in range(4):
            c=n%25;n//=25;r+=(K(c%5)+K(c//5)*beta)*alpha**j
        return r
    assert alpha**4+kc(7)*alpha**3+kc(6)*alpha**2+kc(2)*alpha+kc(5)==0
    args.output.mkdir(parents=True,exist_ok=True)
    stem=args.output/f'r{args.r}_monic_root'
    if args.stage=='groebner':
        ideal=load(str(stem)+'_ideal.sobj')
        raw=ideal.groebner_basis()
        save(raw,str(stem)+'_RAW_groebner.sobj')
        print('RAW result saved. No automatic certified mathematical verdict is asserted.')
        return
    A=PolynomialRing(K,names=('H','q','mu'),order='degrevlex')
    H,q,mu=A.gens()
    columns=[{} for _ in range(141)]
    for h in range(73):
        path=args.model/f'N_H_{h}.bin'
        vals=array.array('I')
        if vals.itemsize!=4:raise RuntimeError('Requires 32-bit unsigned array elements')
        with path.open('rb') as f:vals.fromfile(f,2+181*987)
        if sys.byteorder!='little':vals.byteswap()
        if list(vals[:2])!=[181,987]:raise ValueError('Incorrect coefficient chunk header')
        for j in range(181):
            for l in range(7):
                exp=(h,j,l);pos=2+j*987+l*141
                for i in range(141):
                    code=vals[pos+i]
                    if code:columns[i][exp]=kc(code)
    N=[A(d) for d in columns]
    del columns
    names=('H','q','mu','inv','ell')+tuple(f'b{i}' for i in range(1,71))
    B=PolynomialRing(K,names=names,order='degrevlex')
    hh,qq,mm,iv,ell=B.gens()[:5]
    emb=A.hom([hh,qq,mm],B)
    b=[B(1)]+list(B.gens()[5:])
    psi=json.loads((ROOT/'data'/f'psi_{args.r}.json').read_text())
    theta=sum((kc(c)*H**h*q**j for h,j,c in psi['Theta_H_q']),A(0))
    omega=H*q*mu*theta*(q-kc(psi['q_r']))*(q-kc(psi['pivot']))
    equations=[ell-emb(N[140]),iv*emb(omega)-1]
    for n in range(1,141):
        convolution=sum((b[i]*b[n-i] for i in range(max(0,n-70),min(70,n)+1)),B(0))
        equations.append(emb(N[140-n])-ell*convolution)
    assert len(B.gens())==75 and len(equations)==142
    ideal=B.ideal(equations)
    save(ideal,str(stem)+'_ideal.sobj')
    print('Complete 75-variable / 142-equation monic-root presentation saved.')
    print('This is not a finite basis, a square point, or a zero/nonzero decision.')

if __name__=='__main__':main()
