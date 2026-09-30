"""Explicitly BOUNDED F25 incidence search; no geometric emptiness conclusion."""
from pathlib import Path
import itertools,time,json
import numpy as np
from exact import *
from point_test import test_fixed
ROOT=Path(__file__).resolve().parents[1]
B=np.load(ROOT/'data'/'small.npz')['B']
@njit(cache=True)
def scan_vectors(ws,B):
    indices=np.empty(ws.shape[0],dtype=np.int64);num=0
    for n in range(ws.shape[0]):
        m=np.zeros((32,19),dtype=np.uint8)
        for j in range(11):
            if ws[n,j]:
                for i in range(19):
                    for r in range(32):m[r,i]=ADD[m[r,i],MUL[ws[n,j],B[i,r,j]]]
        _,p=rref(m)
        if len(p)<19:indices[num]=n;num+=1
    return indices[:num]
def projective_vectors(n):
    for lead in range(n):
        for tail in itertools.product(range(25),repeat=n-lead-1):yield (0,)*lead+(1,)+tail

def main():
    start=time.monotonic();log=[];out=[];seen=set();count=0
    def say(s):
        print(s,flush=True);log.append(s);(ROOT/'logs'/'incidence_scan.log').write_text('\n'.join(log)+'\n')
    for a in range(8):
        support=list(range(a,a+4));ws=np.zeros((16276,11),dtype=np.uint8)
        for i,w in enumerate(projective_vectors(4)):ws[i,support]=w
        indices=scan_vectors(ws,B);count+=len(ws)
        say(f'support {support}: scanned {len(ws)} w in P3(F25); rank-deficient source matrices {len(indices)}')
        for n in indices:
            w=ws[n];m=np.column_stack([matmul(B[i],w[:,None])[:,0] for i in range(19)]);ks=kernel(m)
            if ks.shape[1]>3:
                say(f'kernel dimension {ks.shape[1]} >3: source enumeration deliberately skipped');continue
            for c in projective_vectors(ks.shape[1]):
                xi=matmul(ks,np.array(c,dtype=np.uint8)[:,None])[:,0]
                lead=np.nonzero(xi)[0][0];xi=MUL[INV[xi[lead]],xi];key=tuple(xi.tolist())
                if key in seen:continue
                seen.add(key)
                if not xi[:13].any():continue
                r=test_fixed(xi);out.append(r)
                if r['rank_T']<35:say(f'candidate T {r["rank_T"]}, Q {r["rank_Q"]}, Hom {r["hom_dimension"]}, invertible {r["invertible_morphism"]}: {xi.tolist()}')
                if r['invertible_morphism']:
                    (ROOT/'certificates'/'potential_return.json').write_text(json.dumps(test_fixed(xi,True),indent=2));say('potential return found; stability requires verification');return
        (ROOT/'data'/'bounded_candidates.json').write_text(json.dumps(out,indent=2)+'\n')
        say(f'cumulative unique sources {len(seen)}, tested outside pure-v {len(out)}, elapsed {time.monotonic()-start:.2f}s')
    say(f'BOUNDED SEARCH FINISHED: {count} incidence vectors (with repeats), {len(seen)} unique sources, {len(out)} outside pure-v. No geometric emptiness conclusion.')
if __name__=='__main__':main()
