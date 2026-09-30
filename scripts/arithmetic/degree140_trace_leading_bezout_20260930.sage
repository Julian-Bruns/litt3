"""Construct a Laurent-polynomial monic degree-eleven trace combination.

No parameter specialization is used. All divisions in the resulting
certificate are by powers of q, which is an existing chart unit.
"""
import sys,json,time,itertools
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'trace_top_reduction.sobj'));R=d['ring'];H,q=R.gens();K=R.base_ring()
Q=PolynomialRing(K,'zq');zq=Q.gen()
base=d['rows'][0]['coeff'][11][0]
aa=Q({e[1]:c for e,c in base.dict().items() if e[0]==1})
bb=Q({e[1]:c for e,c in base.dict().items() if e[0]==0})
gb=aa.gcd(bb);aa//=gb;bb//=gb
toR=lambda p:R({(0,int(i)):c for i,c in p.dict().items()})
F=toR(aa)*H+toR(bb)
entries=[]
for idx,row in enumerate(d['rows']):
 if idx==0 or max(row['coeff'],default=0)!=11:continue
 N,D=row['coeff'][11];hd=int(N.degree(H));value=Q.zero()
 for (i,j),c in N.dict().items():value+=c*(-bb)^i*aa^(hd-i)*zq^j
 shift=0
 while value and value[0]==0:value//=zq;shift+=1
 quotient,remainder=(toR(aa)^hd*N-toR(value)*q^shift).quo_rem(F)
 assert not remainder
 entries.append({'row':idx,'polynomial':value,'q_shift':shift,'h_degree':hd,'quotient':quotient})
choices=[]
for i,j in itertools.combinations(range(len(entries)),2):
 a=entries[i]['polynomial'];b=entries[j]['polynomial'];g=a.gcd(b)
 print('pair',entries[i]['row'],entries[j]['row'],'gcd',g.degree(),flush=True)
 if g.degree()==0:choices.append((max(a.degree(),b.degree()),a.degree()+b.degree(),i,j))
if not choices:raise RuntimeError('No pair suffices; extend to a multirow Bezout search')
_,_,i,j=min(choices);f=entries[i]['polynomial'];g=entries[j]['polynomial']
one,u,v=f.xgcd(g);u/=one[0];v/=one[0]
assert u*f+v*g==1
chosen=[(entries[i],u),(entries[j],v)]
qden=max(e['q_shift'] for e,c in chosen)
weights={};baseweight=R.zero()
for e,c in chosen:
 weights[e['row']]=toR(c)*toR(aa)^e['h_degree']*q^(qden-e['q_shift'])
 baseweight-=toR(c)*e['quotient']*q^(qden-e['q_shift'])
# F=base/gb, and gb is a nonzero constant times q^12.
gbr=toR(gb)
assert len(gbr.dict())==1
(aexp,bexp),gconst=next(iter(gbr.dict().items()));assert aexp==0
weights={i:p*q^bexp*gconst for i,p in weights.items()}
weights[0]=baseweight
target=gconst*q^(qden+bexp)
assert sum(weights[i]*d['rows'][i]['coeff'][11][0] for i in weights)==target
out={'weights':weights,'target':target,'selected_rows':sorted(weights),
 'note':'Weights multiply leading numerators. For actual trace rows multiply each by its saved denominator.'}
save(out,str(root/'trace_leading_bezout'))
report={'scope':'global Laurent-unit leading certificate, not locus emptiness',
 'selected_rows':list(map(int,sorted(weights))),'weight_support':[{'row':int(i),'terms':len(p.dict()),
 'H_degree':int(p.degree(H)),'q_degree':int(p.degree(q))} for i,p in weights.items()],
 'target':str(target),'seconds':time.time()-start}
(root/'trace_leading_bezout.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
