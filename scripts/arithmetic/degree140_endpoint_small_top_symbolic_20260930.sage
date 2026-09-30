"""Exact fixed-algebra expressions for the small top endpoint traces.

Use only the content jet R and the endpoint value b.  Cubic norms are
retained separately instead of expanding a single nine-sheet denominator.
The output is a coefficient calculation, not a parameter-locus decision.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
data=load(str(root/'endpoint_content_norm.sobj'))
K=data['norm'].parent().base_ring();alpha=K.gen()
beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
def dec(n):
    out=K.zero()
    for i in range(4):
        c=n%25;n//=25;out+=(K(c%5)+(c//5)*beta)*alpha^i
    return out
R=PolynomialRing(K,names=('H','w'));H,w=R.gens()
B=PolynomialRing(K,names=('H','q'));HH,q=B.gens()
X=PolynomialRing(K,'x');x=X.gen()
P=X([dec(c) for c in [11,22,18,5,19,20,15,16,9,22,1]])
Q=X([dec(c) for c in [0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]])
AA=X([dec(c) for c in [1,21,14,22,13]])
L0=X([dec(c) for c in [18,20,20,15]])
tx=AA//(x-alpha)/dec(13)
U0,remainder=(Q-L0^5).quo_rem(tx^3);assert not remainder
it=iter((root/'family.txt').read_text().split());families=[]
for k in range(4):
    families.append([tuple(int(next(it)) for j in range(5)) for i in range(int(next(it)))])
def add(a,b):return [a[i]+b[i] for i in range(3)]
def scale(a,k):return [v*k for v in a]
def mul(a,b,pr):
    out=[R.zero()]*3
    for i in range(3):
        for j in range(3):out[(i+j)%3]+=a[i]*b[j]*(pr if i+j>=3 else 1)
    return out
def power(a,n,pr):
    out=[R.one(),R.zero(),R.zero()]
    while n:
        if n%2:out=mul(out,a,pr)
        n//=2
        if n:a=mul(a,a,pr)
    return out
def convert(num,den):
    nv=min(int(e[1]) for e in num.exponents());dv=min(int(e[1]) for e in den.exponents())
    common=min(nv,dv)
    nr={int(e[1]-common)%3 for e in num.exponents()};dr={int(e[1]-common)%3 for e in den.exponents()}
    assert len(nr)==len(dr)==1 and nr==dr,(nr,dr)
    residue=next(iter(nr));common+=residue
    assert common<=nv and common<=dv
    def ch(f):return B({(int(e[0]),int(e[1]-common)//3):c for e,c in f.dict().items()})
    return ch(num),ch(den)
records=[]
for i,record in enumerate(data['records']):
    r=record['root'];pr=P(r);tp=tx.derivative()(r);u=U0(r)
    rr=[R(co) for co in record['scaled_R'].lift().list()];rr+=[R.zero()]*(3-len(rr))
    gs=[]
    for terms in families[:2]:
        value=[R.zero()]*3
        for ix,iy,ih,iw,c in terms:
            value[iy]+=dec(c)*r^ix*H^ih*w^(iw-ih+5)
        gs.append(value)
    b=add(gs[1],scale(gs[0],-3*L0(r)))
    adj=[rr[0]^2-pr*rr[1]*rr[2],pr*rr[2]^2-rr[0]*rr[1],rr[1]^2-rr[0]*rr[2]]
    norm=R(record['norm'])
    assert mul(rr,adj,pr)==[norm,R.zero(),R.zero()]
    # 3 times the constant coefficient is the cubic trace.
    tt=mul(power(b,6,pr),adj,pr)
    tt=mul(tt,[R.zero(),R.zero(),R(1/pr)],pr)
    Tnum=6*tp*u^2*w*tt[0]
    tpair=convert(Tnum,norm)
    print('T2',i,'terms',len(tpair[0].dict()),'seconds',time.time()-start,flush=True)
    z4=[R.zero(),R(pr),R.zero()]
    qq=mul(mul(power(b,21,pr),power(adj,4,pr),pr),z4,pr)
    Qnum=9*tp*u^7*w^20*qq[0]
    qpair=convert(Qnum,norm^4)
    print('Q5',i,'terms',len(qpair[0].dict()),'seconds',time.time()-start,flush=True)
    qq4=mul(mul(power(b,16,pr),power(adj,3,pr),pr),z4,pr)
    Q4num=6*tp*u^5*w^14*qq4[0]
    q4pair=convert(Q4num,norm^3)
    records.append({'root':r,'T_degree2_normalized':tpair,
                    'Q_degree5_normalized':qpair,'tQ_degree4_normalized':q4pair})
    save({'ring':B,'records':records},str(root/'endpoint_small_top_symbolic_partial'))
    print('tQ4',i,'terms',len(q4pair[0].dict()),'seconds',time.time()-start,flush=True)
save({'ring':B,'records':records},str(root/'endpoint_small_top_symbolic'))
rows=[]
for record in records:
    row={}
    for key in ['T_degree2_normalized','Q_degree5_normalized','tQ_degree4_normalized']:
        n,d=record[key];row[key]={'numerator_degrees':list(map(int,n.degrees())),
            'denominator_degrees':list(map(int,d.degrees())),
            'numerator_terms':len(n.dict()),'denominator_terms':len(d.dict())}
    rows.append(row)
report={'scope':'closed endpoint top coefficients only','seconds':time.time()-start,'rows':rows}
(root/'endpoint_small_top_symbolic.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
