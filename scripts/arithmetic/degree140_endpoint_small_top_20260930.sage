"""Closed endpoint formulas for three new top trace coefficients.

Only the first content jet and the value of b are used.  Compare the
new formulas with retained full local-residue fixtures; no parameter
search or incoming certificate replay is involved.
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
basis=[alpha^i*beta^j for i in range(4) for j in range(2)]
VK,fromV,toV=K.vector_space(map=True)
bm=matrix(GF(5),[toV(v) for v in basis]).transpose().inverse()
def enc(x):
    v=bm*toV(K(x))
    return int(sum((ZZ(v[2*i])+5*ZZ(v[2*i+1]))*25^i for i in range(4)))
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
fixtures=json.loads((root/'reciprocal_quintic_top.json').read_text())['rows']
outputs=[]
for fixture in fixtures:
    h=dec(fixture['h']);w=dec(fixture['w']);hh=h*w
    totals=[[K.zero()]*3 for i in range(3)]
    for record in data['records']:
        r=record['root'];pr=P(r);tp=tx.derivative()(r);u=U0(r)
        YY=PolynomialRing(K,'Y');Y=YY.gen();C=YY.quotient(Y^3-pr,names='yy');yy=C.gen()
        rr=C([co(hh,w) for co in record['scaled_R'].lift().list()])/w^30
        gs=[]
        for terms in families[:2]:
            gs.append(sum((C(dec(c)*h^ih*w^iw*r^ix)*yy^iy
                           for ix,iy,ih,iw,c in terms),C.zero()))
        b=gs[1]-3*L0(r)*gs[0]
        values=[3*yy^4*tp*b^21*u^7/rr^4,
                2*yy^4*tp*b^16*u^5/rr^3,
                2*tp*b^6*u^2/(yy*rr)]
        for k,value in enumerate(values):
            tr=3*value.lift()[0]
            for j in range(3):totals[k][j]+=r^j*tr
    actual=enc(totals[0][0]);expected=fixture['coeff'][0][2]
    assert actual==expected,('Q1 leading coefficient',fixture,actual,expected)
    outputs.append({'h':fixture['h'],'w':fixture['w'],
                    'Q_degree5_endpoint':[enc(v) for v in totals[0]],
                    'tQ_degree4_endpoint':[enc(v) for v in totals[1]],
                    'T_degree2_endpoint':[enc(v) for v in totals[2]],
                    'Q1_complete_agreement':True})
report={'scope':'new closed endpoint formulas; Q1 degree5 fully compared',
        'fixtures':len(fixtures),'rows':outputs,'seconds':time.time()-start}
(root/'endpoint_small_top.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items() if k!='rows'}),flush=True)
