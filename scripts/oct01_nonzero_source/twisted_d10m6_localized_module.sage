#!/usr/bin/env sage
"""Exact eta row-module certificate for a degree-one lambda left inverse.

All divisions of rows are by known-open scalar factors. Euclidean row
operations are logged so that membership can be replayed independently.
"""
from sage.all import *
import argparse,time,json,numpy as np
from pathlib import Path
from itertools import combinations_with_replacement
ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True);ap.add_argument('--root',type=int,default=145049);ap.add_argument('--seconds',type=int,default=1800);args=ap.parse_args();data=args.work/'data';start=time.time()
s=load(str(data/f'twisted_d10m6_incidence_setup_{args.root}.sobj'));meta=load(str(data/f'twisted_d10m6_incidence_compact_metadata_{args.root}.sobj'));global_top=load(str(data/f'twisted_d10m6_global_top_kernel_{args.root}.sobj'));K=s['K'];RR=s['RR'];eta,lam=RR.gens();N=PolynomialRing(K,'ee',implementation='NTL');ee=N.gen();J=s['top_compatibility'];g=RR.one()
def eta_poly(f):
    return N({int(ep):cc for (ep,lp),cc in RR(f).dict().items() if not lp})
H=eta_poly(s['H']);delta=N(s['auxiliary_delta'].list());gp=eta_poly(g);unit=H*delta*gp
remaining_g=gp
while True:
    divisor=remaining_g.gcd(H*delta)
    if divisor.degree()<=0:break
    remaining_g//=divisor
print('TOP_PIVOT','DEG',gp.degree(),'OUTSIDE_H_DELTA_DEG',remaining_g.degree(),flush=True)
B=global_top['global_kernel'];assert B is not None
assert (J*B).is_zero()
bc=[[[N({int(ep):cc for (ep,lp),cc in B[i,j].dict().items() if lp==ll}) for ll in range(2)] for j in range(6)] for i in range(8)];column_contents=[]
for col in range(6):
    content=N.zero()
    for i in range(8):
        for f in bc[i][col]:content=content.gcd(f)
    assert content and not gp%content
    column_contents.append(content)
    for i in range(8):bc[i][col]=[f//content for f in bc[i][col]]
def pmul(a,b):
    result=[N.zero()]*(len(a)+len(b)-1)
    for i,f in enumerate(a):
        for j,h in enumerate(b):result[i+j]+=f*h
    return result
def padd(a,b):return [x+y for x,y in zip(a,b)]
pairs=list(combinations_with_replacement(range(6),2));T=[]
for i,j in meta['pairs']:
    row=[]
    for f,h in pairs:
        if i==j:coefficient=[cc*(1 if f==h else 2) for cc in pmul(bc[i][f],bc[i][h])]
        elif f==h:coefficient=pmul(bc[i][f],bc[j][f])
        else:coefficient=padd(pmul(bc[i][f],bc[j][h]),pmul(bc[i][h],bc[j][f]))
        row.append(coefficient)
    T.append(row)
encoded=np.load(str(data/f'twisted_d10m6_incidence_compact_{args.root}.npz'))['coefficients'];lookup=[K.from_integer(i) for i in range(int(K.order()))];code_lookup={cc:i for i,cc in enumerate(lookup)}
def coefficients(code):return [N([lookup[int(cc)] for cc in code[ll::int(3)]]) for ll in range(3)]
ops=[];row_divisors=[];base=[]
def supported_part(f):
    f=N(f);result=N.one();power=0
    while f.degree()>0:
        piece=f.gcd(unit)
        if piece.degree()<=0:break
        result*=piece;f//=piece;power+=1
    assert not (unit**power)%result
    return result,power
def strip(row,index,record=True):
    content=N.zero()
    for f in row:
        if f:content=content.gcd(f)
        if content.degree()==0:break
    if not content:return
    divisor,power=supported_part(content)
    if divisor.degree()>0:
        for j in range(len(row)):assert not row[j]%divisor;row[j]//=divisor
        if record:ops.append(('divide_known_unit',index,divisor,power))
    return divisor,power
for r,raw in enumerate(encoded):
    raw=[coefficients(code) for code in raw];row=[]
    for col in range(21):
        output=[N.zero()]*5
        for i in range(36):
            if any(T[i][col]):output=padd(output,pmul(raw[i],T[i][col]))
        row.extend(output)
    if meta['row_tags'][r][0]=='compatibility':assert not any(row);continue
    result=strip(row,r,False);row_divisors.append(result);base.append(row)
    if len(base)%100==0:print('PREPARED_ROWS',len(base),'SECONDS',time.time()-start,flush=True)
rows=[]
for offset in range(2):
    for row in base:
        shifted=[]
        for col in range(21):shifted.extend(([N.zero()]*offset)+row[5*col:5*col+5]+([N.zero()]*(1-offset)))
        rows.append(shifted)
print('MODULE_READY','ROWS',len(rows),'COLS',126,'MAXDEG',max(f.degree() for row in rows for f in row),'COLUMN_CONTENT_DEGREES',[f.degree() for f in column_contents],'SECONDS',time.time()-start,flush=True)
original_count=len(rows);rank=0;pivots=[];status='running'
try:
    for col in range(126):
        candidates=[i for i in range(rank,len(rows)) if rows[i][col]]
        if not candidates:continue
        chosen=min(candidates,key=lambda i:rows[i][col].degree())
        if chosen!=rank:rows[rank],rows[chosen]=rows[chosen],rows[rank];ops.append(('swap',rank,chosen))
        while True:
            candidates=[i for i in range(rank+1,len(rows)) if rows[i][col]]
            if not candidates:break
            i=min(candidates,key=lambda j:rows[j][col].degree());q,remainder=rows[i][col].quo_rem(rows[rank][col])
            if q:
                for j in range(col,126):rows[i][j]-=q*rows[rank][j]
                ops.append(('subtract',i,rank,q));strip(rows[i],i)
            if rows[i][col]:rows[rank],rows[i]=rows[i],rows[rank];ops.append(('swap',rank,i))
            if time.time()-start>args.seconds:raise TimeoutError('bounded module run')
        scalar=~rows[rank][col].leading_coefficient()
        if scalar!=1:rows[rank]=[f*scalar for f in rows[rank]];ops.append(('scale',rank,scalar))
        pivots.append(col);rank+=1
        print('PIVOT',rank,'COLUMN',col,'DEG',rows[rank-1][col].degree(),'ROWMAX',max(f.degree() for f in rows[rank-1]),'OPS',len(ops),'SECONDS',time.time()-start,flush=True)
    targets=[];bad=N.one()
    for targetcol in range(21):
        target=[N.zero()]*126;target[6*targetcol]=N.one();actions=[]
        for i,col in enumerate(pivots):
            coefficient=target[col]
            if not coefficient:continue
            q,rem=coefficient.quo_rem(rows[i][col])
            if not rem:
                target=[f-q*h for f,h in zip(target,rows[i])];actions.append(('subtract',i,q))
            else:
                pivot=rows[i][col];target=[pivot*f-coefficient*h for f,h in zip(target,rows[i])];actions.append(('fractionfree',i,pivot,coefficient));allowed,_=supported_part(pivot);bad=bad.lcm(pivot//allowed)
                result=strip(target,-1,False)
                if result and result[0].degree()>0:actions.append(('divide_known_unit',result[0],result[1]))
        targets.append({'column':targetcol,'actions':actions,'remainder':target})
    status='target_membership_pass' if all(not any(t['remainder']) for t in targets) else 'target_membership_failed'
except TimeoutError as exc:
    status='bounded_partial';targets=[];bad=N.zero();print(str(exc),flush=True)
save({'scope':'localized eta module; conditional on sourceH auxiliarydelta and any stated additionalbadfactor; global topkernel retains all slopes','root':int(args.root),'K':K,'N':N,'unit':unit,'H':H,'delta':delta,'top_pivot':gp,'global_top_kernel_path':str(data/f'twisted_d10m6_global_top_kernel_{args.root}.sobj'),'top_column_contents':column_contents,'base_row_divisors':row_divisors,'row_operations':ops,'initial_row_count':original_count,'echelon_rows':rows[:rank],'pivot_columns':pivots,'targets':targets,'additional_bad_factor':bad,'status':status,'compact_input':str(data/f'twisted_d10m6_incidence_compact_{args.root}.npz')},str(data/f'twisted_d10m6_localized_module_{args.root}.sobj'))
print('MODULE_RESULT',status,'RANK',rank,'BADDEG',bad.degree(),'SECONDS',time.time()-start,flush=True)
