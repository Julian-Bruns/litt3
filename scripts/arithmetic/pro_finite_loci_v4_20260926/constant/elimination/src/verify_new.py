#!/usr/bin/env python3
"""Independent checks of the retained compact reconstruction and exact exclusion.
The auxiliary Delta exclusion is not a decision of the original square scheme.
"""
from pathlib import Path
from array import array
import gzip,hashlib,importlib.util,json,sys
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('legacy',ROOT/'continuation/src/verify_continuation.py')
v=importlib.util.module_from_spec(spec);spec.loader.exec_module(v);f=v.f
EVD=ROOT/'elimination/evidence'

def load(name):return json.loads((EVD/name).read_text())
def add(a,b):
    o=a.copy()
    for e,c in b.items():
        val=f.add(o.get(e,0),c)
        if val:o[e]=val
        else:o.pop(e,None)
    return o

def mul(a,b):
    o={}
    for (i,j),c in a.items():
        for (k,l),d in b.items():
            e=(i+k,j+l);val=f.add(o.get(e,0),f.mul(c,d))
            if val:o[e]=val
            else:o.pop(e,None)
    return o

def scale(a,c):return {e:f.mul(v,c) for e,v in a.items() if v and c}
def eval2(p,H,q):
    val=0
    for (i,j),c in p.items():val=f.add(val,f.mul(c,f.mul(f.pw(H,i),f.pw(q,j))))
    return val

def check_delta(chart):
    d=load('critical_delta.json')
    dhat=[[{(h,q):c for h,q,r,s,c in p} for p in row] for row in d['Dhat']]
    for j in range(3):
        for x,poly in enumerate(dhat[j]):
            for (h,q),c in poly.items():
                assert 0<=h<=2 and 0<=q<=10 and x<=10-3*j and 0<c<f.N
    eps=359499
    assert dhat[2][4]=={(0,3):f.mul(4,f.pw(eps,2))}
    # These are all nodes required by the proven H<=2, q<=10 degree bounds.
    for H in (0,1,2):
        for iq in range(11):
            w=f.pw(25,iq);q=f.pw(w,3);G=f.evaluate_chart(chart,f.div(H,w),w)
            delta=f.cdy(f.ca(f.cscale(f.cprod(G[1],G[1]),4),f.cscale(f.cprod(G[0],G[2]),3)),6)
            assert f.pole(delta)==32
            for j in range(3):
                sc=f.mul(f.pw(q,3),f.pw(w,j-2))
                assert f.sc(delta[j],sc)==f.trim([eval2(p,H,q) for p in dhat[j]])
    assert len({f.pw(25,3*i) for i in range(11)})==11
    print('Independent full Delta interpolation grid, support and exact pole 32: PASS',flush=True)
    # Independently multiply the three coefficient polynomials.
    equations=[{} for _ in range(21)]
    for x,p in enumerate(dhat[1]):
        for y,r in enumerate(dhat[1]):equations[x+y]=add(equations[x+y],mul(p,r))
    for x,p in enumerate(dhat[0]):
        for y,r in enumerate(dhat[2]):equations[x+y]=add(equations[x+y],scale(mul(p,r),1)) # -4=1 in F5
    recorded=[{(h,q):c for h,q,r,s,c in p} for p in d['rank_equations']]
    assert equations==recorded
    cert=load('critical_exclusion.json');total={}
    for i in (12,13,14):
        c={(h,q):a for h,q,a in cert['multipliers']['c'+str(i)]}
        total=add(total,mul(c,equations[i]))
    assert total=={(0,4):1}
    print('Independently expanded q^4 Bezout certificate (78 multiplier terms): PASS',flush=True)

def compact_data():
    hashes={d['path']:d for d in load('compact_hashes.json')['files']}
    path=EVD/'compact.jsonl.gz'
    assert path.stat().st_size==hashes[path.name]['bytes']
    assert hashlib.sha256(path.read_bytes()).hexdigest()==hashes[path.name]['sha256']
    dense=array('I',[0])*335439;seen=set();terms=[];h=hashlib.sha256();nbytes=0
    stats=[dict(j=j,terms=0,H_degree=0,q_degree=0,mu_degree=0,x_degree=0) for j in range(3)]
    with gzip.open(path,'rb') as stream:
        for line in stream:
            h.update(line);nbytes+=len(line)
            j,m,H,q,x,c=json.loads(line)
            assert 0<=j<3 and 0<=m<3 and 0<=H<13 and 0<=q<61 and 0<=x<47 and 0<c<f.N
            assert H+m<=12 and H+(5*m+j)//3<=q<=60-3*H-(4-j+10*m)//3
            assert x<=46-3*j
            pos=((((j*3+m)*13+H)*47+x)*61+q)
            assert pos not in seen;seen.add(pos);dense[pos]=c;terms.append((j,m,H,q,x,c))
            s=stats[j];s['terms']+=1
            for key,val in [('H_degree',H),('q_degree',q),('mu_degree',m),('x_degree',x)]:s[key]=max(s[key],val)
    assert h.hexdigest()==hashes['compact.jsonl']['sha256'] and nbytes==hashes['compact.jsonl']['bytes']
    if sys.byteorder!='little':dense.byteswap()
    assert dense.itemsize==4 and hashlib.sha256(dense.tobytes()).hexdigest()==hashes['compact.bin']['sha256']
    summary=load('compact_summary.json');assert summary['components']==stats and len(terms)==summary['terms']==89481
    print('All 89,481 compact terms: uniqueness, bounds, counts, binary and text hashes: PASS',flush=True)
    return terms

def eval_compact(terms,H,q,mu,x):
    ps=[[f.pw(a,i) for i in range(n)] for a,n in [(mu,3),(H,13),(q,61),(x,47)]]
    E=[0,0,0]
    for j,m,i,k,l,c in terms:
        c=f.mul(c,f.mul(ps[0][m],f.mul(ps[1][i],f.mul(ps[2][k],ps[3][l]))));E[j]=f.add(E[j],c)
    return E

def check_compact(terms,chart):
    zeta=f.pw(25,f.M//3)
    probes=json.loads((ROOT/'continuation/evidence/sylvester_probes.json').read_text())['probes']
    for i,d in enumerate(probes,1):
        H,w,q,mu,x,y=(d[k] for k in ('H','w','q','mu','x','y'))
        E=eval_compact(terms,H,q,mu,x);px=f.pe(f.P,x);tx=f.pe(f.t,x)
        W=f.add(f.add(f.mul(f.pw(q,2),f.pw(E[0],3)),f.mul(f.mul(q,px),f.pw(E[1],3))),f.add(f.mul(f.pw(px,2),f.pw(E[2],3)),f.mul(f.mul(2,f.mul(q,px)),f.mul(E[0],f.mul(E[1],E[2])))))
        assert W==d['W_value']
        G=f.evaluate_chart(chart,f.div(H,w),w);U=[f.pe(f.Q,x),0,0,0,0,1]
        for a in range(3):
            yy=f.mul(y,f.pw(zeta,a));r=f.div(yy,w)
            Evalue=f.mul(f.mul(f.pw(q,-16),f.pw(w,2)),f.add(E[0],f.add(f.mul(E[1],r),f.mul(E[2],f.pw(r,2)))))
            S=[v.curve_eval(G[k],x,yy) for k in (3,2,1,0)];D=[S[1],f.mul(2,S[2]),f.mul(3,S[3])]
            C=f.mul(f.pw(tx,3),f.pw(yy,10))
            poly=f.pa(f.pa(f.sc(f.pp(U,2),f.mul(w,mu)),f.pm(U,S)),[C])
            det=v.fixed_sylvester(poly,D)
            assert det==d['resultants'][a]
            assert Evalue==f.div(det,f.mul(f.pw(yy,40),f.pw(tx,5)))
        print(f'Independent original Sylvester comparison {i:02d}: three components/conjugates and full norm PASS',flush=True)

if __name__=='__main__':
    chart=json.loads((ROOT/'evidence/chart.json').read_text())
    check_delta(chart)
    terms=compact_data();check_compact(terms,chart)
    spec=importlib.util.spec_from_file_location('disc',ROOT/'elimination/src/discriminant_identity.py');disc=importlib.util.module_from_spec(spec);spec.loader.exec_module(disc)
    assert disc.out==load('discriminant_identity.json')
    print('Universal discriminant identity: exact F5 polynomial equality PASS',flush=True)
    print('All stated new results verified. No decision of the finite residual-square scheme is asserted.')
