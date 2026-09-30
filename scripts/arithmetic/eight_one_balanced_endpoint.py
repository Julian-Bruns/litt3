#!/usr/bin/env python3
"""Exact half-turn endpoint test opposite a balanced eight-label endpoint.

This script is only an endpoint coefficient test. It does not construct a
curve. All 435 balanced phase pairs and 189225 ordered half-turn pairs are
retained. The first two trace equations provide the tested conditions.
"""
import argparse,itertools,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing

def main():
    ap=argparse.ArgumentParser();ap.add_argument('output');args=ap.parse_args()
    started=time.monotonic()
    F=GF(5);R=PolynomialRing(F,'z')
    K=GF(5**14,'z',modulus=R([1,2,4,0,4,4,3,1,3,4,4,0,4,2,1]));z=K.gen()
    beta=K([1,1,0,0,4,3,3,1,1,3,1,2,1,1]);assert beta**2==beta+3 and z**29==1
    code=lambda n:K(n%5)+(n//5)*beta
    enc=lambda a:sum(int(a.polynomial()[i])*5**i for i in range(14))
    eta=code(22);c0=code(20);e0=code(8);u0=code(12);v0=K(4)
    # Fixed root Fourier identities used by the structural reduction.
    PB=PolynomialRing(F,'b');bb=PB.gen()
    B=GF(25,'b',modulus=bb*bb-bb-3);bb=B.gen()
    dec=lambda n:B(n%5)+(n//5)*bb
    PE=PolynomialRing(B,'a');aa=PE.gen()
    EE=B.extension(PE([dec(n) for n in [5,2,6,7,1]]),'a');aa=EE.gen()
    roots=[aa**(25**i) for i in range(4)];PX=PolynomialRing(EE,'x')
    rows={'c':[22,7,9,23],'e':[1,3,8,15],
          'u':[20,12,13,8],'v':[21,21,20,2]}
    fourier={name:[sum((EE(2)**(-ell*i)*PX([dec(n) for n in row])(roots[i])
                        for i in range(4)),EE(0))/4 for ell in range(4)]
             for name,row in rows.items()}
    assert all(fourier['c'][ell] and fourier['u'][ell] for ell in (1,2,3))
    assert fourier['e'][3]==fourier['v'][3]==0
    assert fourier['e'][1] and fourier['e'][2] and fourier['v'][1] and fourier['v'][2]
    assert fourier['e'][2]/fourier['c'][2]==dec(12)
    kk=-fourier['c'][2]*fourier['v'][1]/(fourier['c'][1]*fourier['v'][2])
    assert kk==dec(11) and kk**7!=1
    packet_tests=0
    for v in itertools.product(range(3),repeat=4):
        ff=[sum(v[i]*pow(2,ell*i,5) for i in range(4))%5 for ell in range(4)]
        if (ff[1]==ff[2]==0) or (ff[2]==ff[3]==0):
            assert len(set(v))==1
        if ff[1]==ff[3]==0:assert v[0]==v[2] and v[1]==v[3]
        packet_tests+=1
    pairs=list(itertools.combinations_with_replacement(range(29),2))
    ph=[z**j for j in range(29)]
    sums={r:[ph[r*i%29]+ph[r*j%29] for i,j in pairs] for r in (4,5,8,17)}
    targets={};free=[];boundary=[]
    for idx,p in enumerate(pairs):
        C0=4*c0*sums[5][idx];E0=4*e0*sums[8][idx]
        U0=4*u0*sums[17][idx];V0=4*v0*sums[4][idx]
        X=(U0/eta)**(5**10);Y=(-V0/eta)**(5**6)
        assert X**625==U0/eta and Y**(5**8)==-V0/eta
        aa=E0-eta*X**(5**7);bb=C0-eta*Y
        if not aa or not bb:
            boundary.append({'pair':p,'a':enc(aa),'b':enc(bb)})
            continue
        targets.setdefault(bb/aa,[]).append((idx,aa,bb,X,Y))
    ratio_hits=0;old_hits=[];visited=0
    for i,p in enumerate(pairs):
        for j,q in enumerate(pairs):
            visited+=1
            if i==j:continue # both endpoints balanced: separately excluded
            c1=2*(sums[5][i]-sums[5][j]);e1=2*code(12)*(sums[8][i]-sums[8][j])
            assert c1
            ratio=e1/c1
            if ratio not in targets:continue
            for k,aa,bb,X,Y in targets[ratio]:
                ratio_hits+=1
                c=2*c0*(sums[5][i]+sums[5][j])
                e=2*e0*(sums[8][i]+sums[8][j])
                if aa*(e-eta*X)!=bb*(c-eta*Y**(5**7)):continue
                old_hits.append({'balanced':pairs[k],'even_pair':p,'odd_pair':q,
                                 'epsilon0':enc((c-eta*Y**(5**7))/aa),
                                 'epsilon_tau':enc(c1/aa),'X':enc(X),'Y':enc(Y)})
    result={'status':'COMPLETE_NECESSARY_TWO_TRACE_TEST',
            'balanced_pairs':len(pairs),'halfturn_endpoints':visited,
            'target_classes':len(targets),'boundary':boundary,
            'ratio_hits':ratio_hits,'old_equation_hits':old_hits,
            'fourier_norm_constant':11,'small_packet_tests':packet_tests,
            'seconds':time.monotonic()-started}
    Path(args.output).write_text(json.dumps(result,indent=2)+'\n')
    print({k:v for k,v in result.items() if k!='old_equation_hits'},flush=True)
    print('old equation hits',len(old_hits),flush=True)

if __name__=='__main__':main()
