#!/usr/bin/env python3
"""Read-only certificate verification by default; Python standard library only."""
import sys
sys.dont_write_bytecode=True
import argparse
import itertools
import json
import platform
import time
from pathlib import Path

ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'src'))
from finite_fields import (ADD,NEG,MUL,add,sub,mul,inv,div,pow25,Extension,
    padd,psub,pmul,pscale,pdivmod,pgcd,pderivative,ppowmod,peval,
    determinant,resultant)
from trace_profiles import (F,DATA,ZETA,ZPOW,Q,conjugate,norm,make_record,
    generate_bounded_records,family_moments)

WRITE=False

def certificate(name,data):
    path=ROOT/'certificates'/name
    data=json.loads(json.dumps(data))
    if WRITE:path.write_text(json.dumps(data,indent=2)+'\n')
    stored=json.loads(path.read_text())
    assert stored==data, f'Certificate mismatch: {name}'

def verify_fields_and_endpoints():
    for x in range(25):
        assert ADD[x][NEG[x]]==0
        assert pow25(x,25)==x
        if x:assert MUL[x][inv(x)]==1
        for y in range(25):
            for z in range(25):
                assert MUL[x][MUL[y][z]]==MUL[MUL[x][y]][z]
                assert MUL[x][ADD[y][z]]==ADD[MUL[x][y]][MUL[x][z]]
    P,A=DATA['P'],DATA['A']
    assert pgcd(P,pderivative(P))==[1]
    assert pgcd(A,pderivative(A))==[1]
    assert pgcd(P,A)==[1]
    assert pscale(A,inv(A[-1]))==DATA['K0_modulus']
    kmod=DATA['K0_modulus'];fmod=DATA['F_modulus']
    assert ppowmod([0,1],25**4,kmod)==[0,1]
    assert pgcd(psub(ppowmod([0,1],25**2,kmod),[0,1]),kmod)==[1]
    assert ppowmod([0,1],29,fmod)==[1] and peval(fmod,1)!=0
    assert next(i for i in range(1,29) if pow(25,i,29)==1)==7
    assert next(i for i in range(1,29) if pow(5,i,29)==1)==14
    assert pow(5,7,29)==28
    assert F.pow(ZETA,29)==F.one and conjugate(ZETA)==ZPOW[28]
    orbit2={2*pow(5,i,29)%29 for i in range(14)}
    orbit6={6*pow(5,i,29)%29 for i in range(14)}
    assert len(orbit2)==len(orbit6)==14 and orbit2.isdisjoint(orbit6)
    assert orbit2|orbit6==set(range(1,29))
    assert div(DATA['C_sum'],DATA['a'])==13
    assert div(DATA['M_sum'],DATA['a'])==4
    assert sub(13,pow25(13,5))==23 and pow25(23,2)==2
    assert add(13,pow25(13,5))==3 and pow25(13,6)==3
    K=Extension(kmod);alpha=K.gen
    C=[tuple(x) for x in DATA['C_rows']];M=[tuple(x) for x in DATA['M_rows']]
    assert determinant(C)==2 and determinant(M)==0
    assert any(determinant([[M[i][j] for j in jj] for i in ii])
               for ii in itertools.combinations(range(4),3)
               for jj in itertools.combinations(range(4),3))
    assert tuple(__import__('functools').reduce(add,(r[j] for r in C),0) for j in range(4))==(5,0,0,0)
    assert tuple(__import__('functools').reduce(add,(r[j] for r in M),0) for j in range(4))==(22,0,0,0)
    roots=[K.pow(alpha,25**i) for i in range(4)]
    assert len(set(roots))==4 and all(K.eval(A,r)==K.zero for r in roots)
    result=[]
    for i,ai in enumerate(roots):
        assert K.pow(C[i],25)==C[(i+1)%4] and K.pow(M[i],25)==M[(i+1)%4]
        pa=K.eval(P,ai);da=K.eval(pderivative(A),ai)
        dda=K.eval(pderivative(pderivative(A)),ai)
        b29=K.scale(K.mul(K.pow(da,3),K.pow(pa,2)),div(3,pow25(A[4],3)))
        b=K.pow(b29,pow(29,-1,25**4-1))
        assert K.pow(b,29)==b29
        lam=K.div(K.scale(K.pow(b,4),A[4]),da)
        c1=K.mul(K.mul(b,lam),K.add(K.div(K.eval(pderivative(P),ai),pa),K.div(dda,K.scale(da,4))))
        mu=K.sub(K.scale(K.div(K.mul(lam,c1),b),4),K.div(K.mul(dda,K.pow(lam,2)),K.scale(da,2)))
        assert c1==C[i] and mu==M[i]
        result.append({'i':i,'alpha_i':ai,'b_i':b,'lambda_i':lam,'C_i':c1,'M_i':mu})
    certificate('endpoint_reconstruction.json',result)
    print('  F25/F/K0 exact presentations, polynomial gcds, all endpoint constants: PASS')

def verify_profiles():
    witness=make_record(F.const(2),0)
    assert witness['n']==42
    d=witness['d_0_to_28']
    assert [j for j,x in enumerate(d) if x]==[0,1,2,3,7,11,14,16,17,19,20,21,23,24,25]
    assert set(d)=={0,2}
    certificate('degree_42_trace_witness.json',witness)
    records=generate_bounded_records()
    certificate('bounded_trace_records.json',records)
    assert len(records)==105
    assert len({tuple(r['d_0_to_28']) for r in records})==105
    assert 5*(Q*Q-Q-2)==30517187490
    print('  Degree-42 witness and 105 bounded records: PASS')
    print('  Family cardinality integer arithmetic: 30517187490 (proved, not enumerated)')

def verify_auxiliary_cover():
    N=DATA['auxiliary_t_numerator_F5'];D=DATA['auxiliary_t_denominator_F5']
    H=psub(pmul(pderivative(N),D),pmul(N,pderivative(D)))
    B=DATA['auxiliary_branch_polynomial_F5']
    assert H==DATA['auxiliary_critical_polynomial_F5']
    assert pgcd(N,D)==[1]
    for p in [N,D,psub(N,D),H,B]:assert pgcd(p,pderivative(p))==[1]
    assert pgcd(H,N)==[1] and pgcd(H,D)==[1]
    assert len(psub(N,D))==4 # t-1 has order one at z=infinity.
    evals=[]
    for T in range(7):
        lhs=resultant(H,psub(N,pscale(D,T)));rhs=peval(B,T)
        assert lhs==rhs
        evals.append({'T_F25_code':T,'resultant':lhs,'B_at_T':rhs})
    assert peval(B,0)!=0 and peval(B,1)!=0
    certificate('auxiliary_quartic_cover.json',{
        'N':N,'Q':D,'H':H,'branch_polynomial':B,'seven_resultant_checks':evals,
        'scope':'An auxiliary S_aux,t,D_aux realization only; no functions u,v,r are supplied.'})
    print('  Auxiliary quartic cover: gcds, squarefreeness, 7 exact resultant evaluations: PASS')

def verify_linearization():
    from trace_linearization import affine_matrix,rref,check_moments
    fixed=DATA['fixed_end_labels_infinity']
    tests=[(fixed,fixed), ([(0,0)]*4,[(0,0)]*4),
           ([(0,0),(1,1),(2,2),(3,3)],[(0,4),(1,5),(2,6),(3,7)]),
           ([(0,0),(0,1),(1,2),(3,5)],[(1,0),(1,7),(2,11),(3,18)])]
    out=[]
    for ii,(i,z) in enumerate(tests):
        matrix=affine_matrix(i,z);rr=rref(matrix)
        assert rr['rank']==[2,3,3,5][ii]
        assert rr['inconsistent']==[False,True,True,True][ii]
        if ii==0:
            for eps in [F.const(2),F.add(ZPOW[1],F.one)]:
                X,Y=family_moments(eps);check_moments(matrix,X,Y)
        out.append({'infinity':i,'zero':z,'matrix':matrix,**rr})
    certificate('linearization_examples.json',out)
    print('  Four bounded endpoint-pair linearizations, ranks 2/3/3/5: PASS')
    print('  No exhaustive endpoint-pair search was executed.')

def verify_local_experiment():
    from formal_jets import run_experiment
    r=run_experiment()
    assert r['K_F25']==19
    assert [t['allowed'] for t in r['trials']]==[[22],[2],list(range(25))]
    assert all(x==0 for x in r['full_truncated_residual'][:5])
    certificate('local_jet_example.json',r)
    print('  Bounded jets at c=1, epsilon=2, truncation 10: PASS')
    print('  Only the stated initial coefficient constraints are asserted; no full solution.')

def verify_genus_arithmetic():
    mu=[0,0,4,1,3,9,8]
    assert 3*42-21-15*mu[2]==45
    assert 3*184-21-27*mu[6]-2*mu[5]==297
    assert 3*183-21-27*mu[6]-mu[4]-mu[5]==300
    assert 3*183-21-26*mu[6]-3*mu[5]==293
    assert (56-6+1)//2==25 and (55-6+1)//2==25
    print('  Necessary genus-bound arithmetic: PASS (not existence/exclusion tests)')

def main():
    global WRITE
    if not __debug__:raise RuntimeError("Run without -O or -OO; assertions must be enabled.")
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--write-certificates',action='store_true',help='Regenerate exact JSON evidence before comparing it.')
    args=p.parse_args();WRITE=args.write_certificates
    print('Quartic quotient partial-results verification')
    print('Python:',sys.version.replace('\n',' '))
    print('Platform:',platform.platform())
    print('Certificate mode:','regenerate and compare' if WRITE else 'read-only compare')
    start=time.perf_counter()
    for fn in [verify_fields_and_endpoints,verify_profiles,verify_auxiliary_cover,
               verify_linearization,verify_local_experiment,verify_genus_arithmetic]:
        fn()
    print('ALL EXECUTED CHECKS PASSED')
    print('Actual simultaneous-quotient existence: UNRESOLVED')
    print('Elapsed seconds: %.3f'%(time.perf_counter()-start))

if __name__=='__main__':main()
