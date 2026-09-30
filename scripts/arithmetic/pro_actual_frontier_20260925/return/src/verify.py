#!/usr/bin/env python3
"""Exact verification of the archived results; not a global existence solver.

Default verifies saved certificates and representative full-system evaluations.
--full also regenerates every tensor, the bounded search, and all point data
from the input formulas in a temporary directory and compares the results.
"""
from pathlib import Path
import argparse,itertools,json,shutil,subprocess,sys,tempfile,time
from math import comb
import numpy as np
from exact import *
from point_test import combine_tensor,test_fixed
from make_certificates import determinant
from stability import verify_certificate,load_sections
from global_generation import verify as verify_generation
from extension_fields import Field,dot_field,kernel_field
from fixed_scheme import test as test_extension,complete_matrix,evaluation_matrix
ROOT=Path(__file__).resolve().parents[1]

def say(s):print(s,flush=True)
def readj(p):return json.loads((ROOT/p).read_text())

def field_checks():
    for a in range(25):
        assert fpow(a,25)==a and ADD[a,NEG[a]]==0
        if a:assert MUL[a,INV[a]]==1
        for b in range(25):
            assert MUL[a,b]==MUL[b,a] and ADD[a,b]==ADD[b,a]
            for c in range(25):
                assert MUL[a,ADD[b,c]]==ADD[MUL[a,b],MUL[a,c]]
                assert MUL[MUL[a,b],c]==MUL[a,MUL[b,c]]
                assert ADD[ADD[a,b],c]==ADD[a,ADD[b,c]]
    assert fpow(14,3)==LP.from_terms([(i,0,int(c)) for i,c in enumerate(P)]).eval(5,14)
    beta=5;assert MUL[beta,beta]==ADD[beta,3]
    F=Field([20,0,1]);assert F.q==625 and F.mul(25,25)==5 and F.pow(25,25)==100
    # A nontrivial extension and its conjugation are tested, not assumed.
    for a in range(625):
        assert F.pow(a,625)==a
        if a:assert F.mul(a,F.inv(a))==1
    say('PASS field axioms, evaluation point, and F625 Frobenius/arithmetic')

def tensor_checks():
    D=np.load(ROOT/'data/tensors.npz');V=np.load(ROOT/'data/fixed_tensors.npz')
    shapes={'T':(19,80,35),'Q':(19,43,16),'REC':(19,235,35),'RAW':(19,315,35),'CT':(315,235),'RT':(235,315),'CTc':(80,315),'CQ':(159,116),'RQ':(116,159),'CQc':(43,159)}
    for name,shape in shapes.items():assert D[name].shape==shape and np.max(D[name])<25
    for name,shape in {'TOP':(19,19,43,35),'EVTOP':(19,19,2,35),'EVS':(19,2,16),'EVPHI':(19,4,35),'AF':(2,35),'NU':(19,35),'SEVAL':(16,)}.items():
        assert V[name].shape==shape and np.max(V[name])<25
    assert np.array_equal(matmul(D['RT'],D['CT']),np.eye(235,dtype=np.uint8))
    assert not matmul(D['CTc'],D['CT']).any()
    assert np.array_equal(matmul(D['RQ'],D['CQ']),np.eye(116,dtype=np.uint8))
    assert not matmul(D['CQc'],D['CQ']).any()
    for j in range(19):
        assert np.array_equal(matmul(D['CTc'],D['RAW'][j]),D['T'][j])
        assert np.array_equal(NEG[matmul(D['RT'],D['RAW'][j])],D['REC'][j])
    say('PASS tensor dimensions, exact constant eliminations, all nineteen raw residual/recovery identities')

def section_checks():
    ss=load_sections(); assert len(ss)==19
    for a,b in ss:
        assert all(i>=0 for i,j,c in a.terms()+b.terms())
        assert all(3*i+10*j<=23 for i,j,c in b.terms())
        assert all(3*i+10*j<=12 for i,j,c in (a-e*b).terms())
    pair=np.array([[(u*a if i<6 else u*b).coeff(-1,2) for a,b in ss] for i,u in enumerate(XIB)],dtype=np.uint8)
    assert np.array_equal(pair,np.eye(19,dtype=np.uint8))
    assert verify_generation(readj('certificates/global_generation.json'))
    certs=readj('certificates/stability.json');assert len(certs)==21
    for i,c in enumerate(certs):
        assert verify_certificate(c)
        unit=all(c['Hermite_basis'][r] is not None and c['Hermite_basis'][r][r]==[1] for r in range(3))
        assert unit==c['finite_minor_ideal_is_unit']
        iw=c['infinity_witness'];assert (iw is not None)==c['infinity_rank_two']
        if iw:
            a,b=[c['infinity_matrix'][r] for r in iw['rows']]
            assert int(ADD[MUL[a[0],b[1]],NEG[MUL[a[1],b[0]]]])==iw['determinant']!=0
        assert c['geometric_stable']==(i<17)
    say('PASS Serre-dual section bases, global generation, and all 21 geometric stability certificates')

def candidate_checks():
    D=np.load(ROOT/'data/tensors.npz');cands=readj('data/bounded_candidates.json');certs=readj('certificates/candidate_minors.json')
    stab=readj('certificates/stability.json');assert len(cands)==len(certs)==16
    for i,(r,c) in enumerate(zip(cands,certs)):
        assert r['xi']==c['xi']==stab[i]['xi'];assert any(c['xi'][:13])
        T=combine_tensor(c['xi'],D['T']);Q=combine_tensor(c['xi'],D['Q'])
        assert len(c['T_rows'])==35 and len(c['Q_rows'])==16
        assert determinant(T[c['T_rows'],:])==c['T_determinant']!=0
        assert determinant(Q[c['Q_rows'],:])==c['Q_determinant']!=0
        assert r['rank_T']==35 and r['rank_Q']==16 and r['hom_dimension']==0 and not r['invertible_morphism']
    say('PASS 16 explicit geometrically stable candidates: rank(T)=35, rank(Q)=16, hence no fixed-target Hom')

def lpmatmul(A,B):
    return [[sum((A[i][k]*B[k][j] for k in range(len(B))),ZERO) for j in range(len(B[0]))] for i in range(len(A))]

def regression_checks():
    r=readj('certificates/regression_point.json');xi=r['xi'];hs=[[[LP.from_terms(ts) for ts in row] for row in h] for h in r['H_basis']]
    assert r['hom_dimension']==len(hs)==4 and not r['invertible_morphism']
    u,v=uv(xi);U=u**25;V=v**25;one=LP.term()
    G=[[one,-u,-v],[ZERO,one,-e],[ZERO,ZERO,one]]
    GI=[[one,U,V+U*E],[ZERO,one,E],[ZERO,ZERO,one]]
    bounds=[[24,124,-151],[20,120,-155],[31,131,-144]]
    for H in hs:
        assert all(i>=0 for row in H for p in row for i,j,c in p.terms())
        HV=lpmatmul(lpmatmul(G,H),GI)
        for i in range(3):
            for j in range(3):assert all(3*a+10*b<=bounds[i][j] for a,b,c in HV[i][j].terms())
    # Test the entire determinant cubic, including all mixed coefficients, in
    # the Laurent coordinate ring, independently of evaluation at P_*.
    dp={}
    for perm in itertools.permutations(range(3)):
        sign=4 if sum(perm[i]>perm[j] for i in range(3) for j in range(i+1,3))%2 else 1
        for inds in itertools.product(range(len(hs)),repeat=3):
            p=LP.term(c=sign)
            for row in range(3):p=p*hs[inds[row]][row][perm[row]]
            key=tuple(sorted(inds));dp[key]=dp.get(key,ZERO)+p
    assert all(p==ZERO for p in dp.values()) and len(dp)==20
    fresh=test_fixed(xi,True)
    assert json.loads(json.dumps(fresh))==r
    say('PASS regression: all four global matrices integral at every point; all 20 coefficients of their determinant cubic vanish')

def extension_checks():
    saved=readj('certificates/extension_field_checks.json')
    for r in saved:assert test_extension(r['xi'],r['modulus'])==r
    # Non-F25 projective rescaling: this also tests the bundle weights used
    # in the theoretical cardinality/residue-degree bound.
    F=Field([20,0,1]);lam=25
    xi=[1,25]+[0]*17;lx=[F.mul(lam,c) for c in xi]
    C=complete_matrix(xi,F);CL=complete_matrix(lx,F)
    weights=[F.pow(F.inv(lam),25)]*35+[F.pow(F.inv(lam),24)]*16
    for i in range(123):
        rowweight=1 if i<80 else lam
        for j in range(51):assert F.mul(CL[i][j],weights[j])==F.mul(rowweight,C[i][j])
    A=evaluation_matrix(xi,F);AL=evaluation_matrix(lx,F)
    hweights=[F.pow(F.inv(lam),24),lam,lam,F.pow(F.inv(lam),25),1,1,F.pow(F.inv(lam),25),1,1]
    for i in range(9):
        for j in range(51):assert F.mul(AL[i][j],weights[j])==F.mul(hweights[i],A[i][j])
    say('PASS full 123x51 system over F25 and F625; Frobenius and projective covariance beyond the base field')

def bound_checks():
    B=sum(comb(34+i,i)*comb(33-i,18-i)*26**i*25**(18-i) for i in range(19))
    s=[1]+[0]*18
    for a in [26]*35+[25]*16:
        s=[sum(s[j]*a**(i-j) for j in range(i+1)) for i in range(19)]
    assert s[18]==B==int(readj('certificates/degree_bound.json')['bound'])
    say('PASS cardinality bound integer, checked by two independent coefficient expansions: '+str(B))

def full_rebuild():
    with tempfile.TemporaryDirectory(prefix='second-return-verify-') as td:
        t=Path(td);shutil.copytree(ROOT/'src',t/'src',ignore=shutil.ignore_patterns('__pycache__','*.pyc','*.nbc','*.nbi'))
        for sub in ['data','logs','certificates']:(t/sub).mkdir()
        commands=[['build.py'],['small.py'],['build_fixed.py','--stop','9'],['build_fixed.py','--start','9','--stop','19'],['scan_incidence.py'],['point_test.py'],['stability.py'],['global_generation.py'],['fixed_scheme.py'],['make_certificates.py']]
        for args in commands:
            say('REBUILD: '+' '.join(args));subprocess.run([sys.executable,str(t/'src'/args[0]),*args[1:]],cwd=t,check=True)
        for name in ['tensors.npz','fixed_tensors.npz','small.npz','serre_pairing.npz']:
            with np.load(t/'data'/name) as a,np.load(ROOT/'data'/name) as b:
                assert set(a.files)==set(b.files)
                for key in a.files:assert np.array_equal(a[key],b[key]),(name,key)
        for path in ['data/bounded_candidates.json','data/dual_sections.json','data/small_sections.json','data/tensor_format.json','certificates/regression_point.json','certificates/stability.json','certificates/global_generation.json','certificates/extension_field_checks.json','certificates/candidate_minors.json','certificates/degree_bound.json']:
            assert json.loads((t/path).read_text())==readj(path),path
    say('PASS full from-formulas rebuild, complete bounded-search rerun, and exact comparison of all arrays/point certificates')

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--full',action='store_true');args=ap.parse_args()
    start=time.monotonic();say('STATUS OF EXISTENCE QUESTION: UNRESOLVED. Verification does not decide it.')
    field_checks();tensor_checks();section_checks();candidate_checks();regression_checks();extension_checks();bound_checks()
    if args.full:full_rebuild()
    say('ALL REQUESTED CHECKS PASSED; elapsed %.2f seconds'%(time.monotonic()-start))
if __name__=='__main__':main()
