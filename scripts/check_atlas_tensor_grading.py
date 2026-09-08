#!/usr/bin/env python3
"""Check a diagonal Kummer descent on EVERY native rooted N/R coefficient.

Find weights w_i,n_r in F3 with grade(N_rih)+w_i+w_h=n_r and
grade(R_rih)+w_i+w_h=2w_r. Then v_i,b_i have the SAME weight w_i.
This is an exact coefficient test, not a generic-rank or atlas exclusion.
"""
import argparse,json,struct,time
from pathlib import Path
from atlas_native_tensor_input import sha


class GradingUnavailable(ValueError):
    """These exact coordinates do not admit the tested diagonal grading."""


class Equations:
    def __init__(self):self.pivots={}
    def add(self,terms,rhs):
        row={i:c%3 for i,c in terms.items() if c%3};rhs%=3
        while row:
            i=min(row);a=row[i]
            if i not in self.pivots:
                inverse=1 if a==1 else 2
                self.pivots[i]=({j:c*inverse%3 for j,c in row.items()},rhs*inverse%3);return
            old,b=self.pivots[i];rhs=(rhs-a*b)%3
            for j,c in old.items():
                value=(row.get(j,0)-a*c)%3
                if value:row[j]=value
                else:row.pop(j,None)
        if rhs:raise GradingUnavailable('No diagonal Kummer grading in these original coordinates')
    def solution(self,size):
        x=[0]*size
        for i,(row,b) in sorted(self.pivots.items(),reverse=True):
            x[i]=(b-sum(c*x[j] for j,c in row.items() if j!=i))%3
        return x


def grading(tensor):
    started=time.monotonic();tensor=Path(tensor)
    header=json.loads((tensor.parent/'native-original-input.json').read_text())
    assert header['source_sha256']==sha(tensor) and header['all_native_fifth_roots_verified']
    model=header['field_model'];degree=int(model['degree_F5'])
    if degree%3 or any(c and i%3 for i,c in enumerate(model['modulus'])):
        raise GradingUnavailable('Native field is not presented by f(t^3)')
    equations=Equations();equations.add({0:1},0);grades=[];nonzero=0
    for direction,b in enumerate(header['root_blocks']):
        assert b['direction']==direction and sha(b['binary'])==b['binary_sha256']
        with Path(b['binary']).open('rb') as stream:
            assert struct.unpack('<QI',stream.read(12))==(0x41544c524f4f5431,degree)
            for kind,count in [('N',64),('R',32)]:
                assert struct.unpack('<II',stream.read(8))==(count,32)
                for r in range(count):
                    for h in range(32):
                        length=struct.unpack('<I',stream.read(4))[0];cs=stream.read(length)
                        assert len(cs)==length and length<=degree and all(c<5 for c in cs)
                        support={i%3 for i,c in enumerate(cs) if c}
                        if len(support)>1:raise GradingUnavailable('Mixed cubic character in a native coefficient')
                        if not support:grades.append(3);continue
                        g=next(iter(support));grades.append(g);nonzero+=1
                        terms={}
                        for i,c in [(direction,1),(h,1),(r,-2)] if kind=='R' else [(direction,1),(h,1),(32+r,-1)]:
                            terms[i]=terms.get(i,0)+c
                        equations.add(terms,-g)
    x=equations.solution(96);checked=0
    for i in range(32):
        for r in range(96):
            for h in range(32):
                g=grades[(i*96+r)*32+h]
                if g==3:continue
                rhs=x[r+32] if r<64 else 2*x[r-64]
                assert (g+x[i]+x[h]-rhs)%3==0;checked+=1
    assert checked==nonzero
    return dict(source_sha256=header['source_sha256'],degree_F5=degree,descended_degree_F5=degree//3,
        original_coefficient_count=len(grades),nonzero_coefficient_checks=checked,
        all_original_N_and_R_character_identities_verified=True,weights_v_and_beta=x[:32],weights_N=x[32:],
        grading_constraint_rank=len(equations.pivots),seconds=time.monotonic()-started,
        chart_formula='a_i=w_i-w_j; Nprime=t^(w_i+w_h-n_r)N; Rprime=t^(w_i+w_h-2w_r)R; '
        'graph lambda^(3*a_r)*(sprime_r)^5-b_r; norm w*sum(lambda^a_i*v_i*sprime_i)-1',
        scope='Exact coefficient descent test only; no chart solve, rank claim or atlas exclusion')


if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--tensor',type=Path,required=True)
    ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
    result=grading(args.tensor);temporary=args.output.with_suffix('.tmp')
    temporary.write_text(json.dumps(result,indent=2)+'\n');temporary.replace(args.output)
    print(json.dumps(result),flush=True)
