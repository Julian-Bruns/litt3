#!/usr/bin/env python3
"""Independent exact checks and complete temporary regeneration of the archive.
No search over parameter points is performed. All rank tests are on constant
coefficient/certificate matrices, proving the stated geometric module claims.
"""
from __future__ import annotations
import argparse, hashlib, json, os, platform, shutil, subprocess, sys, tempfile, time
from pathlib import Path
import numpy as np
import numba
from algebra import ADD,MUL,NEG,INV,P,P_CODES,e,UV,one,add,sub,mul,plus,powp,L,forbidden,vec,matpol,mm,rref,kernel
from macaulay import rank_fast,macaulay_tensor
ROOT=Path(__file__).resolve().parents[1]

def check(value: bool, label: str) -> None:
    if not value:
        raise AssertionError(label)
    print('PASS:',label,flush=True)

def load(name: str) -> dict[str,np.ndarray]:
    with np.load(ROOT/'data'/name) as z:
        return {k:z[k].copy() for k in z.files}

def trim(a):
    a=list(a)
    while a and not a[-1]: a.pop()
    return a

def rem(a,b):
    a,b=trim(a),trim(b)
    if not b: raise ZeroDivisionError('zero polynomial')
    while len(a)>=len(b):
        shift=len(a)-len(b); c=int(MUL[a[-1],INV[b[-1]]])
        for i,v in enumerate(b): a[i+shift]=int(ADD[a[i+shift],NEG[MUL[c,v]]])
        a=trim(a)
    return a

def pgcd(a,b):
    a,b=trim(a),trim(b)
    while b:a,b=b,rem(a,b)
    return [int(MUL[c,INV[a[-1]]]) for c in a] if a else []

def slow_mul(a,b):
    """Independent dictionary convolution, as opposed to NumPy convolution."""
    out={}
    def ins(i,j,c):
        old=out.get((i,j),0);new=int(ADD[old,c])
        if new:out[(i,j)]=new
        else:out.pop((i,j),None)
    for (i,j),c in a.items():
        for (h,k),d in b.items():
            cd=int(MUL[c,d]);y=j+k
            if y<3:ins(i+h,y,cd)
            else:
                for (t,_),v in P.items():ins(i+h+t,y-3,int(MUL[cd,v]))
    return out

def check_manifest():
    mf=ROOT/'SHA256SUMS'
    if not mf.exists():
        print('INFO: SHA256SUMS not yet installed during packaging; mathematical checks continue.',flush=True)
        return
    count=0
    for line in mf.read_text().splitlines():
        digest,rel=line.split('  ',1);p=ROOT/rel
        if not p.is_file() or hashlib.sha256(p.read_bytes()).hexdigest()!=digest:
            raise AssertionError('manifest mismatch: '+rel)
        count+=1
    check(True,f'SHA-256 manifest, {count} files')

def main(regenerate: bool=True):
    start=time.time()
    print('UTC',time.strftime('%Y-%m-%dT%H:%M:%SZ',time.gmtime()),flush=True)
    print('Python',platform.python_version(),'NumPy',np.__version__,'Numba',numba.__version__,flush=True)
    check_manifest()
    check(int(MUL[5,5])==8,'beta^2=beta+3')
    for a in range(25):
        for b in range(25):
            for c in range(25):
                assert MUL[a,ADD[b,c]]==ADD[MUL[a,b],MUL[a,c]]
                assert MUL[MUL[a,b],c]==MUL[a,MUL[b,c]]
    check(all(MUL[a,INV[a]]==1 for a in range(1,25)),'finite-field laws and all inverses')
    monoms=[{(i,j):c} for i in [-2,0,2] for j in range(3) for c in [1,5,17]]
    for a in monoms:
        for b in monoms:assert mul(a,b)==slow_mul(a,b)
    assert mul(e,e)==slow_mul(e,e)
    check(True,'independent Laurent multiplication checks')
    # The p^2 power of F_25 coefficients is the identity, but never of xi symbols.
    E=powp(e,25);p16=one
    for _ in range(16):p16=slow_mul(p16,P)
    Ef={}
    for (i,j),c in e.items():
        Ef=add(Ef,slow_mul({(25*i,2):c},p16))
    check(E==Ef,'e^25 by independent characteristic-five Frobenius formula')
    for u,v in UV:
        for p in (u,v):
            if not p:continue
            (i,j),c=next(iter(p.items()));q,r=divmod(25*j,3);pq=one
            for _ in range(q):pq=slow_mul(pq,P)
            assert powp(p,25)==slow_mul({(25*i,r):c},pq)
    check(True,'all nineteen monomial Frobenius rules')
    derivative=[int(MUL[i%5,P_CODES[i]]) for i in range(1,len(P_CODES))]
    check(pgcd(P_CODES,derivative)==[1],'P is squarefree')

    D=load('matrices.npz')
    for suffix,n,m in [('c',235,315),('q',116,159)]:
        A=D['A'+suffix];Pc=D['P'+suffix];Rc=D['R'+suffix]
        assert A.shape==(m,n)
        assert np.array_equal(mm(Rc,A),np.eye(n,dtype=np.uint8))
        assert not mm(Pc,A).any()
        assert len(rref(Pc)[1])==m-n
    check(True,'constant eliminations: ranks 235 and 116; annihilator and recovery identities')
    check(D['T'].shape==(19,80,35) and D['Q'].shape==(19,43,16),'T and Q tensor dimensions')

    Wd=load('line_incidence.npz');W=Wd['W'];S=Wd['S']
    AW=np.stack([vec(mul(E,{ij:1}),forbidden(-124)) for ij in L(151)],axis=1)
    check(np.array_equal(AW,Wd['A']) and len(rref(AW)[1])==132,'W section matrix: 132x143, rank132')
    check(not mm(AW,W).any() and len(rref(W)[1])==11,'eleven exact independent W sections')
    _,piv=rref(AW);free=[j for j in range(len(L(151))) if j not in piv]
    expected=[(47,0),(48,0),(49,0),(50,0)]+[(i,1) for i in range(41,48)]
    check([L(151)[i] for i in free]==expected,'eleven high free b coordinates')
    check(not W[[i for i,ij in enumerate(L(151)) if ij[1]==2],:].any(),'no character-two component in W')

    pos=json.loads((ROOT/'data'/'positive_line.json').read_text())
    a0={(i,0):v for i,v in enumerate(pos['A']) if v};b0={(i,1):v for i,v in enumerate(pos['B']) if v}
    resid=sub(a0,mul(E,b0))
    assert not vec(resid,forbidden(-133)).any()
    assert -max(3*i+10*j for i,j in resid)==135
    assert -max(3*i+10*j for i,j in b0)==-142 and b0[(44,1)]==1
    assert pgcd(pos['A'],pos['B'])==[1] and pgcd(pos['A'],P_CODES)==[1]
    check(True,'s_* has no finite or infinite zero in F^2K(-8O)')
    for twist,dim in [(-8,1),(-9,0)]:
        X=np.stack([vec(mul(E,{ij:1}),forbidden(twist-125)) for ij in L(150+twist)],axis=1)
        assert X.shape[1]-len(rref(X)[1])==dim
    check(True,'h0(F^2K(-8O))=1 and h0(F^2K(-9O))=0')

    Fd=load('filtration_matrices.npz');C=Fd['C'];Spos=Fd['Spos']
    for j in range(4):
        assert np.array_equal(mm(W,C[:,j:j+1])[:,0],vec(mul(b0,{(j,0):1}),L(151)))
    for j in range(19):assert np.array_equal(Spos[j],mm(S[j],C))
    for j in [0,6,7]:assert not Spos[j,:7].any() and not Spos[j,18:].any()
    for j in [1,2,3,4,5,8,9,10,11,12]:assert not Spos[j,:18].any()
    for j in range(13,19):assert not Spos[j,7:].any()
    check(True,'fixed-line section embedding and all separating zero blocks')
    for name,degree,size in [('A',2,(30,44)),('B',8,(1650,1680))]:
        M=macaulay_tensor(Fd[name],degree); cert=load('macaulay_'+name+'.npz')
        assert M.shape==size and int(cert['degree'])==degree
        pivots=cert['pivots']; minor=M[:,pivots]
        rank,_=rank_fast(minor,ADD,MUL,NEG,INV)
        check(rank==size[0],f'global {name} module certificate: degree{degree}, nonzero {rank}x{rank} minor')

    Md=load('modification_model.npz');J=Md['J'];cols=[]
    fpairs=[]
    for k in range(11):
        b=matpol(W[:,k],L(151));a=plus(mul(E,b));delta=sub(mul(a0,b),mul(b0,a))
        assert all(i>=0 and 3*i+10*j<=18 for i,j in delta)
        cols.append(vec(delta,L(18)))
    assert np.array_equal(J,np.stack(cols,axis=1))
    assert len(rref(J)[1])==7 and not mm(J,C).any()
    expectedV=np.array([[1,0,0,0,17,2,1],[0,1,0,0,22,21,22],[0,0,1,0,13,18,23],[0,0,0,1,16,1,15]],dtype=np.uint8)
    assert np.array_equal(Md['polynomial_basis'],expectedV)
    assert not mm(Md['polynomial_constraints'],J[:7]).any()
    check(True,'the exact rank-seven degree-18 subsystem and its three polynomial relations')

    # Independent, universal coefficient verification of all relative cofactors.
    Cd=load('cofactors.npz');B=Cd['B'];rec=Cd['recovery']
    free_basis=[('f',ij) for ij in L(31)]+[('alpha',ij) for ij in L(20)]
    coeff=np.zeros((11,35,235),dtype=np.uint8)
    for i,(kind,ij) in enumerate(free_basis):
        f={ij:1} if kind=='f' else {};a=plus(mul(e,f)) if kind=='f' else {ij:1};p=sub(a,mul(e,f))
        for h,mon in enumerate(L(131)):coeff[:,i,h]=vec(mul(p,{mon:1}),expected)
        for h,mon in enumerate(L(120)):coeff[:,i,123+h]=NEG[vec(mul(f,{mon:1}),expected)]
    for l in range(11):
        for j in range(19):assert np.array_equal(B[l,j],mm(coeff[l],rec[j]))
    check(True,'all 11x19x35x35 cofactor coefficients, independently and symbolically')
    Gd=load('global_coupling.npz');G=J[[0,1,2,3,7,8,9],:]
    assert np.array_equal(Gd['G'],G)
    for j in range(19):assert np.array_equal(Gd['D'][:,j].reshape(7,1225),mm(G,B[:,j].reshape(11,1225)))
    check(True,'all seven relative cofactor polynomials')

    portable=json.loads((ROOT/'data'/'portable_arrays.json').read_text())
    for filename,arrays in portable.items():
        X=load(filename)
        for key,obj in arrays.items():
            value=np.array(obj['data'],dtype=obj['dtype']).reshape(obj['shape'])
            assert np.array_equal(value,X[key])
    check(True,'software-independent JSON agrees with every stored array')

    if regenerate:
        scripts=['reconstruct.py','line_incidence.py','cofactors.py','filtration.py','macaulay.py','modification_model.py','global_coupling.py','export_json.py','explore_projective_period.py']
        with tempfile.TemporaryDirectory(prefix='return19_verify_') as tmp:
            target=Path(tmp)
            shutil.copytree(ROOT/'src',target/'src',ignore=shutil.ignore_patterns('__pycache__'))
            (target/'data').mkdir()
            env=os.environ.copy();env['OPENBLAS_NUM_THREADS']='1'
            for script in scripts:
                result=subprocess.run([sys.executable,str(target/'src'/script)],capture_output=True,text=True,env=env,timeout=180)
                if result.returncode:
                    raise RuntimeError(script+' failed:\n'+result.stdout+'\n'+result.stderr)
                if script=='explore_projective_period.py':
                    assert 'matrix (291, 259) kernel 0' in result.stdout
                print('REGENERATED:',script,flush=True)
            for stored in sorted((ROOT/'data').glob('*.npz')):
                generated=target/'data'/stored.name
                assert generated.is_file(),stored.name
                with np.load(stored) as a,np.load(generated) as b:
                    assert set(a.files)==set(b.files)
                    for key in a.files:assert np.array_equal(a[key],b[key]),(stored.name,key)
            for filename in ['positive_line.json','macaulay_results.json','modification_model.json','portable_arrays.json']:
                assert json.loads((ROOT/'data'/filename).read_text())==json.loads((target/'data'/filename).read_text()),filename
        check(True,'complete independent temporary regeneration matches all archived arrays and certificates')
    print('ALL REQUESTED CHECKS PASSED; seconds=',round(time.time()-start,3),flush=True)
    print('STATUS: partial global structural results; stable-return emptiness NOT decided.',flush=True)

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--quick',action='store_true',help='skip the complete temporary regeneration, but verify all stored certificates')
    args=parser.parse_args()
    main(regenerate=not args.quick)
