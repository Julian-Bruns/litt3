"""Exact, demand-driven coefficients of global trace combinations.

No coefficient is discarded. A node represents a FULL polynomial, and
requesting its k-th coefficient recursively requests the shifted index
from each parent. Only requested coefficients are expanded and cached.

Usage:
  ROOT initial OUTPUT
  ROOT extend PARENT LIFT_STEM DEGREE OUTPUT

The initial stage uses the certified degree-eleven three-row identity.
An extension uses a leading-coefficient unit lift, retaining any units
removed from those leading numerators. All input trace data are reused;
no original interpolation or verification program is replayed.
"""
import sys, json, time
from pathlib import Path

root=Path(sys.argv[1]); mode=sys.argv[2]; start=time.time()
families=['global_multiplied','global_positive','global_companion']
original=[]
if mode=='selftest':
    R=PolynomialRing(GF(5),names=('H','q')); H,q=R.gens(); Psi=H+q+1
    original=[{3:(R.one(),(0,0,0)),1:(H,(0,0,0)),0:(q,(0,0,0))},
              {7:(R.one(),(0,0,0)),4:(q,(0,0,0)),2:(H+1,(0,0,0)),0:(R(2),(0,0,0))}]
else:
    for family in families:
        data=load(str(root/(family+'_rational_coefficients.sobj')))
        R=data['ring']; H,q=R.gens(); Psi=data['Psi']
        for j in range(3):
            original.append({int(n):(R(N),tuple(map(int,D)))
                             for jj,n,N,D in data['coefficients'] if jj==j and N})
    del data
zero=R.zero(); one=R.one(); powers={0:one}
def ps(n):
    if n not in powers: powers[n]=Psi^n
    return powers[n]
def norm(v,psi_cancel=False):
    N,D=v; D=list(D)
    if not N: return (zero,(0,0,0))
    ex=N.exponents(); a=min(e[0] for e in ex); b=min(e[1] for e in ex)
    if a or b:
        N=R({(e[0]-a,e[1]-b):c for e,c in N.dict().items()})
        D[0]-=a; D[1]-=b
    if psi_cancel:
        while D[2]>0:
            quotient,remainder=N.quo_rem(Psi)
            if remainder: break
            N=quotient; D[2]-=1
    return (N,tuple(D))
def add(a,b):
    if not a[0]: return b
    if not b[0]: return a
    D=tuple(max(a[1][i],b[1][i]) for i in range(3))
    def scaled(v):
        N,E=v
        return N*H^(D[0]-E[0])*q^(D[1]-E[1])*ps(D[2]-E[2])
    return norm((scaled(a)+scaled(b),D))
def mul(a,b):
    return norm((a[0]*b[0],tuple(a[1][i]+b[1][i] for i in range(3))))
def neg(a): return (-a[0],a[1])
def inverse_unit(a):
    N,D=norm(a); D=list(D)
    while len(N.dict())>1:
        quotient,remainder=N.quo_rem(Psi)
        if remainder: raise ValueError('Attempted to invert a nonunit')
        N=quotient; D[2]-=1
    (i,j),c=next(iter(N.dict().items()))
    return (R(1/c),(int(i-D[0]),int(j-D[1]),int(-D[2])))

nodes=[]; cache={}
def input_node(i):
    node={'input':int(i),'degree':max(original[i]),'label':families[i//3]+':'+str(i%3)}
    nodes.append(node); return len(nodes)-1
def combination_node(terms,degree,label):
    nodes.append({'terms':terms,'degree':int(degree),'label':label})
    return len(nodes)-1
def coefficient(i,k):
    if k<0 or k>nodes[i]['degree']: return (zero,(0,0,0))
    key=(int(i),int(k))
    if key in cache: return cache[key]
    node=nodes[i]
    if 'input' in node:
        result=norm(original[node['input']].get(k,(zero,(0,0,0))))
    else:
        result=(zero,(0,0,0))
        for parent,shift,factor in node['terms']:
            result=add(result,mul(factor,coefficient(parent,k-shift)))
        result=norm(result,True)
    cache[key]=result
    return result
def reduce_by(row,pivot,pdegree,inverse,tag):
    deg=nodes[row]['degree']
    while deg>=pdegree:
        leading=coefficient(row,deg)
        if leading[0]:
            factor=mul(leading,inverse)
            new=combination_node([(row,0,(one,(0,0,0))),
                                  (pivot,deg-pdegree,neg(factor))],deg,tag)
            # Check the cancelled coefficient before lowering the bound.
            assert coefficient(new,deg)==(zero,(0,0,0))
            nodes[new]['degree']=deg-1
            row=new
        else:
            nodes[row]['degree']=deg-1
        deg-=1
    return row
def checkpoint(stem,rows,stage):
    save({'ring':R,'Psi':Psi,'nodes':nodes,'cache':cache,'active_rows':rows,
          'stage':stage,'source_families':families},str(root/(stem+'_dag')))

if mode=='selftest':
    pivot=input_node(0); row=input_node(1)
    output=reduce_by(row,pivot,3,(one,(0,0,0)),'test_shifted_division')
    FF=R.fraction_field(); PP=PolynomialRing(FF,'mu_test'); mu=PP.gen()
    def rational(value):
        N,D=value; return FF(N)/(H^D[0]*q^D[1]*Psi^D[2])
    def full_input(i):
        return sum((rational(value)*mu^k for k,value in original[i].items()),PP.zero())
    expected=full_input(1)%full_input(0)
    assert all(rational(coefficient(output,k))==expected[k] for k in range(8))
    # A further shifted combination requests a formerly low parent term.
    factor=(H+q,(2,-1,1))
    combined=combination_node([(output,4,factor),(pivot,1,(one,(0,0,0)))],6,'nested_shift')
    expected2=rational(factor)*mu^4*expected+mu*full_input(0)
    assert all(rational(coefficient(combined,k))==expected2[k] for k in range(7))
    assert (pivot,0) in cache
    print('PASS: shifted exact division and nested rational-coefficient shifts; no omitted lower terms',flush=True)
    sys.exit(int(0))
elif mode=='initial':
    stem=sys.argv[3]
    rows=[input_node(i) for i in range(9)]
    pivot=rows[1]; inverse=inverse_unit(coefficient(pivot,12))
    for j in range(9):
        if j!=1: rows[j]=reduce_by(rows[j],pivot,12,inverse,'reduce_at12:'+str(j))
        print('degree12 row',j,'seconds',round(time.time()-start,2),flush=True)
    leading=load(str(root/'trace_leading_bezout.sobj'))
    old=load(str(root/'trace_top_reduction.sobj'))
    target=norm((leading['target'],(0,0,0)))
    target_inv=inverse_unit(target); terms=[]
    for j,W in leading['weights'].items():
        # These three OLD leading coefficients were not affected by the
        # discarded-term error; nevertheless match them to exact queries.
        difference=add(coefficient(rows[j],11),neg(old['rows'][j]['coeff'][11]))
        assert not difference[0], 'changed selected degree-eleven coefficient in row '+str(j)
        D=old['rows'][j]['coeff'][11][1]
        factor=mul((W,tuple(-x for x in D)),target_inv)
        terms.append((rows[j],0,factor))
    pivot=combination_node(terms,11,'exact_global_monic11')
    assert coefficient(pivot,11)==(one,(0,0,0))
    rows.append(pivot)
    for j in range(9):
        rows[j]=reduce_by(rows[j],pivot,11,(one,(0,0,0)),'reduce_at11:'+str(j))
        checkpoint(stem,rows,{'completed_row':j,'monic_degree':11})
        print('degree11 row',j,'seconds',round(time.time()-start,2),flush=True)
    degree=10
elif mode=='extend':
    parent,liftstem=sys.argv[3:5]; pdegree=int(sys.argv[5]); stem=sys.argv[6]
    state=load(str(root/(parent+'_dag.sobj')))
    nodes=state['nodes']; cache=state['cache']; rows=state['active_rows']
    lift=load(str(root/(liftstem+'.sobj')))
    inverse_target=inverse_unit((lift['target'],(0,0,0)))
    removed={int(i):(factor,D) for i,factor,D in lift.get('removed_units',[])}
    terms=[]
    for j,W in lift['weights']:
        N,D=coefficient(rows[j],pdegree)
        removed_factor=removed.get(int(j),(one,D))[0]
        factor=mul((W,tuple(-x for x in D)),inverse_target)
        factor=mul(factor,inverse_unit((removed_factor,(0,0,0))))
        terms.append((rows[j],0,factor))
    pivot=combination_node(terms,pdegree,'exact_global_monic'+str(pdegree))
    assert coefficient(pivot,pdegree)==(one,(0,0,0))
    for j in range(len(rows)):
        rows[j]=reduce_by(rows[j],pivot,pdegree,(one,(0,0,0)),
                          'reduce_at'+str(pdegree)+':'+str(j))
        checkpoint(stem,rows+[pivot],{'completed_row':j,'monic_degree':pdegree})
        print('reduced row',j,'seconds',round(time.time()-start,2),flush=True)
    rows.append(pivot); degree=pdegree-1
else:
    raise ValueError('Unknown mode')

out=[]; report=[]
for j,node in enumerate(rows):
    bound=nodes[node]['degree']
    if bound<=degree:
        value=coefficient(node,degree)
        N,D=value
        out.append({'label':nodes[node]['label'],'coeff':{degree:value} if N else {}})
        report.append({'row':int(j),'degree_bound':int(bound),'terms':len(N.dict()),
                       'H_degree':int(N.degree(H)),'q_degree':int(N.degree(q))})
    else:
        value=coefficient(node,bound)
        out.append({'label':nodes[node]['label'],'coeff':{bound:value}})
    print('extracted row',j,'seconds',round(time.time()-start,2),flush=True)
    checkpoint(stem,rows,{'extracted_row':j,'next_degree':degree})
save({'ring':R,'Psi':Psi,'rows':out,'cutoff':degree,'exact':True,
      'dag':stem+'_dag.sobj'},str(root/(stem+'_leading')))
checkpoint(stem,rows,{'complete':True,'next_degree':degree})
(root/(stem+'.json')).write_text(json.dumps({'scope':'exact full-operation graph; queried coefficients only',
             'rows':report,'nodes':len(nodes),'cached_coefficients':len(cache),
             'seconds':time.time()-start},indent=2)+'\n')
print('complete',stem,'seconds',round(time.time()-start,2),flush=True)
