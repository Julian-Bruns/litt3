#!/usr/bin/env python3
"""Combine certified pole-linear relations with the complete cofactor chart.

The cofactor theorem guarantees its leading coefficient is nonzero on
every actual map. Its inverse is retained. All input equations are kept;
this changes representation, not the mathematical exclusion verdict.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix, prod
from cysignals.alarm import alarm, cancel_alarm, AlarmInterrupt
from scripts.atlases.algebra.sparse_polynomial_substitution import SparsePolynomialTransport

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('recursive_source',type=Path)
p.add_argument('affine_source',type=Path)
p.add_argument('reduced_source',type=Path)
p.add_argument('out',type=Path)
p.add_argument('--seconds',type=int,default=180)
args=p.parse_args();args.out.mkdir(exist_ok=False);start=time.monotonic()
read=lambda path:json.loads(path.read_text())
rec,aff,src=map(read,[args.recursive_source,args.affine_source,args.reduced_source])
assert aff['variables']==src['variables']
for key in ['field_modulus','field_degree']:
    assert rec[key]==aff[key]==src[key]
k=GF(5**src['field_degree'],'a',modulus=PolynomialRing(GF(5),'z')(src['field_modulus']))
R=PolynomialRing(k,rec['original_variables'],order='degrevlex')
Ra=PolynomialRing(k,aff['original_variables'],order='degrevlex')
S0=PolynomialRing(k,['c2','c3','c5'],order='degrevlex')
decode=lambda ring,f:ring({tuple(e):k(c) for e,c in f})
encode=lambda f:[[list(e),list(map(int,c.polynomial().list()))] for e,c in f.dict().items()]
S=PolynomialRing(k,['b8','b9','lead_inv','c2','c3','c5','pole0_inv'],order='degrevlex')
result=dict(status='running',scope='Actual-map necessary cofactor chart; no exclusion',
            theorem='triangle237_cofactor_necessary_system')
alarm(args.seconds)
try:
    cv={j:S0('c%d'%j) for j in (2,3,5)}
    for j in (0,1):cv[j]=S0(decode(Ra,aff['substitutions']['c%d'%j]))
    cv[4]=S0(decode(R,rec['substitutions']['c4']))
    U0=PolynomialRing(k,'u');u0=U0.gen()
    alpha=(u0**3+u0+1).roots(multiplicities=False)[0]
    betas=(u0**5+(alpha+1)*u0**4+(2*alpha**2-2)*u0**3-2*alpha**2*u0**2+
           (-2*alpha**2+alpha+1)*u0+2*alpha**2+2*alpha-2).roots(multiplicities=False)
    F0=prod(u0-t for t in [k(0),k(1),k(2),k(3),alpha])
    # The stored a17 relation identifies the chosen dormant orbit member.
    a17=decode(R,rec['substitutions']['a17'])
    c5=R('c5')
    constants=[]
    for beta in betas:
        p1=beta**2+3*F0[4]*beta+3*F0[3]
        p0=-F0[2]+(F0[4]+2*beta)*p1
        P0=2*u0**3+beta*u0**2+p1*u0+p0
        columns=[F0*(u0**j).derivative(2)+4*F0.derivative()*(u0**j).derivative()
                 +(3*F0.derivative(2)-P0)*u0**j for j in range(5)]
        basis=matrix(k,8,5,lambda i,j:columns[j][i],implementation='generic').right_kernel().basis()
        if len(basis)!=2:continue
        h=[sum(v[j]*u0**j for j in range(5)) for v in basis]
        # For degree24 H, its next coefficient is forced by the ODE.
        V=PolynomialRing(R,'u');u=V.gen();H=u**24+(a17+c5)*u**23
        ode=V(F0)*H.derivative(2)+4*V(F0).derivative()*H.derivative()+(3*V(F0).derivative(2)-V(P0))*H
        if ode[26]==0:constants.append((beta,P0,h))
    assert len(constants)==1,('dormant normalization not identified',len(constants))
    beta,P0,h=constants[0]
    wr=h[0]*h[1].derivative()-h[0].derivative()*h[1]
    assert h[0].gcd(h[1])==1 and wr and wr%F0==0 and (wr//F0).degree()==0
    ST=PolynomialRing(S0,'T');T=ST.gen()
    mat=[[ST.zero() for _ in range(6)] for _ in range(5)]
    for j in range(4):
        for power in range(7):
            coef=cv[power] if power<6 else S0.one()
            mat[(power+j)%5][j]+=coef*T**((power+j)//5)
    for j,H in enumerate(h):
        for i in range(5):mat[i][4+j]=-H[i]
    perms=list(itertools.permutations(range(5)))
    signs=[(-1)**sum(p[i]>p[j] for i in range(5) for j in range(i+1,5)) for p in perms]
    cof=[]
    for excluded in range(6):
        cols=[i for i in range(6) if i!=excluded]
        cof.append((-1)**excluded*sum(sign*prod(mat[i][cols[p[i]]] for i in range(5))
                                       for sign,p in zip(signs,perms)))
    assert all(sum(mat[i][j]*cof[j] for j in range(6))==0 for i in range(5))
    U=PolynomialRing(S0,'u');u=U.gen()
    inflate=lambda f:sum(c*u**(5*j) for j,c in enumerate(f.list()))
    Araw=sum(u**j*inflate(cof[j]) for j in range(4))
    C=u**6+sum(cv[j]*u**j for j in range(6));H=Araw*C
    assert U(F0)*H.derivative(2)+4*U(F0).derivative()*H.derivative()+(3*U(F0).derivative(2)-U(P0))*H==0
    assert Araw.degree()<=18 and all(Araw[i]==0 for i in [4,9,14])
    lead=Araw[18];assert lead
    print(json.dumps(dict(stage='three_pole_cofactor_ready',seconds=time.monotonic()-start,
          lead_degree=int(lead.total_degree()),lead_terms=len(lead.dict()),
          numerator_terms=sum(len(f.dict()) for f in Araw))),flush=True)
    old=PolynomialRing(k,src['variables'],order='degrevlex')
    images=[]
    for name in src['variables']:
        if name.startswith('a') and name[1:].isdigit():images.append(S('lead_inv')*S(Araw[int(name[1:])]))
        else:images.append(S(name))
    transport=SparsePolynomialTransport(old,S,images)
    equations=[]
    for i,f in enumerate(src['equations']):
        moved=transport(decode(old,f))
        if moved:equations.append(moved)
        if i%40==0:print(json.dumps(dict(stage='transport',row=i,terms=len(moved.dict()),
                                        seconds=time.monotonic()-start)),flush=True)
    equations.append(S('lead_inv')*S(lead)-1)
    equations=list(dict.fromkeys(equations))
    payload=dict(prime=5,field_degree=src['field_degree'],field_modulus=src['field_modulus'],
                 variables=list(S.variable_names()),equations=[encode(f) for f in equations],
                 scope=result['scope'],source=str(args.reduced_source.resolve()),
                 source_sha256=hashlib.sha256(args.reduced_source.read_bytes()).hexdigest(),
                 source_variables=src['variables'],substitution_images=[encode(f) for f in images],
                 recursive_source=str(args.recursive_source.resolve()),affine_source=str(args.affine_source.resolve()),
                 cofactor_lead=encode(S(lead)),cofactor_numerators=[encode(S(f)) for f in Araw],
                 chosen_alpha=list(map(int,alpha.polynomial().list())),chosen_beta=list(map(int,beta.polynomial().list())))
    (args.out/'source.json').write_text(json.dumps(payload,separators=(',',':'))+'\n')
    result.update(status='complete',variables=S.ngens(),equations=len(equations),
                  terms=sum(len(f.dict()) for f in equations),degrees=sorted(set(int(f.total_degree()) for f in equations)))
except AlarmInterrupt:result['status']='time_limit_no_verdict'
except Exception as error:
    result.update(status='implementation_error_no_verdict',error=repr(error))
    raise
finally:
    cancel_alarm();result['seconds']=time.monotonic()-start
    (args.out/'result.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)
if result['status']!='complete':raise SystemExit(3)
