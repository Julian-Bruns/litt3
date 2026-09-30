#!/usr/bin/env python3
"""Compare exact relative normalization with direct differentiation."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import sys


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--engine-dir',type=Path,required=True)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    assert not args.output.resolve().is_relative_to(Path(__file__).resolve().parents[3])
    os.environ['LITT3_REFERENCE_MODULUS']='15625'
    os.environ['LITT3_REFERENCE_PRECISION']='256'
    sys.path.insert(0,str(args.engine_dir.resolve()))
    import witt_cubic as w
    import batch_witt as b
    from fourth_engine import Engine
    checks=[]
    for module in (w,b):
        S=module.Ser;z=module.Z;t=S(w.T)
        eng=Engine.__new__(Engine)
        eng.Ser=S;eng.mu=S(1);eng.checks=[];eng.frame_certificates={};eng.frame_ancestors={}
        P=1+t*z+z*z;q=2+(t*t+1)*z+3*z*z
        I=[[S(1),1+z],[S(0),S(1)]]
        # This explicitly unipotent frame has determinant exactly1.
        eng.frame_certificates[id(I)]=(I,15625)
        for di in (S(1),1+z):
            ii=eng.mi(I,3125)
            oper=[[S(0),S(-1)],[-P,S(0)]]
            old=eng.mm(eng.mm(I,oper),ii)
            old=[[x/di for x in row] for row in old]
            correction=eng.mm([[x.deriv() for x in row] for row in I],ii)
            old=eng.madd(old,eng.scalar(S(-1),correction))
            for nonzero_connection in (False,True):
                C=[[1+z,t+z*z],[2+t*z,-1-z]] if nonzero_connection else [[S(0)]*2 for _ in range(2)]
                C=[[S(x) for x in row] for row in C]
                change=eng.mm(eng.mm(I,C),ii)
                change=[[x/di for x in row] for row in change]
                for weight,modulus in ((25,125),(25,625),(25,3125),(625,3125)):
                    new=eng.madd(old,eng.scalar(weight,change))
                    actual=eng.corrected_connection(I,q,di,old,new,P,weight,modulus)
                    h=[I[j][1]+weight*q*I[j][0] for j in range(2)]
                    direct=eng.normalize_line(h,di,new,modulus,2 if weight==25 else 4)
                    for i in range(2):
                        for j in range(2):eng.zero(actual[i][j]-direct[i][j],modulus,30,'exact versus direct normalization')
                    eng.zero(actual[0][0]*actual[1][1]-actual[0][1]*actual[1][0]-1,modulus,30,'actual determinant')
                    for lower in (5,25,125,625,3125):
                        if lower>modulus:continue
                        reduced=eng.mmod(actual,lower)
                        for i in range(2):
                            for j in range(2):eng.zero(reduced[i][j]-direct[i][j],lower,30,'constructed lower frame image')
                    checks.append({'module':module.__name__,'variable_derivation':di is not None and di.valuation==0 and di.end>1,
                                   'connection_changes':nonzero_connection,'weight':weight,'modulus':modulus})
        # A shorter high-weight Laurent tail must not destroy the EXACT
        # lower image of I. This checks the known failure mode explicitly.
        di=S(1);P=S(0);old=[[S(0),S(-1)],[S(0),S(0)]]
        identity=[[S(1),S(0)],[S(0),S(1)]]
        eng.frame_certificates[id(identity)]=(identity,15625)
        short_q=(z**-80).cut(140)
        out=eng.corrected_connection(identity,short_q,di,old,old,P,25,3125)
        lower=eng.mmod(out,25)
        assert min(x.prec for row in lower for x in row)>min(x.prec for row in out for x in row)
        for i in range(2):
            for j in range(2):eng.zero(lower[i][j]-identity[i][j],25,100,'known lower image retains its range')
    sources={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in
             [Path(__file__),args.engine_dir/'fourth_engine.py',args.engine_dir/'witt_cubic.py',args.engine_dir/'batch_witt.py']}
    args.output.write_text(json.dumps({'status':'PASS','cases':checks,'source_sha256':sources},indent=2)+'\n')
    print('PASS:',len(checks),'relative graph/connection cases, four entries each')


if __name__=='__main__':main()
