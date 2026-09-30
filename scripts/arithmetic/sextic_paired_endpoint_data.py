#!/usr/bin/env python3
"""Small exact inputs for the F625 paired-endpoint comparison."""
import argparse,json,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).parent/'pro_mixed_quintic_20260927/src'))
from exact import F,Extension
from mixed_phase_data import make_data,cpp_array

def main():
    p=argparse.ArgumentParser();p.add_argument('header',type=Path);p.add_argument('json',type=Path);a=p.parse_args()
    _,d=make_data();E=Extension([5,2,6,7,1]);a2=tuple(d['normalized_root_character_components']['f0'][2]);assert E.mul(a2,a2)==E.embed(9)
    pairs=[]
    for name in ['c','e','f0','f1']:
        vv=[tuple(z) for z in d['root_values'][name]];rr=[]
        for i in [0,1]:
            w=E.add(vv[i],vv[i+2]);coef=F.div(w[1],a2[1]);const=F.sub(w[0],F.mul(coef,a2[0]))
            assert w==E.add(E.embed(const),E.mul(E.embed(coef),a2))
            rr.append([const,coef])
        pairs.append(rr)
    text='#pragma once\n'
    for name,value in [('add25',[[F.add(i,j) for j in range(25)] for i in range(25)]),('mul25',[[F.mul(i,j) for j in range(25)] for i in range(25)]),('neg25',[F.neg(i) for i in range(25)]),('inv25',[0]+[F.inv(i) for i in range(1,25)]),('frob25',[F.pow(i,5) for i in range(25)]),('phase',d['phase_vectors_F25']),('pair_values',pairs)]:text+=cpp_array(name,value)
    a.header.parent.mkdir(parents=True,exist_ok=True);a.header.write_text(text)
    a.json.write_text(json.dumps(dict(basis='1,a2 with a2^2=[9]',a2=list(a2),pairs=pairs,order=['c','e','f0','f1']),indent=2)+'\n')
    print('PAIR DATA',pairs)

if __name__=='__main__':main()
