"""Check the new codimension-one hypothesis for the global content bound.

This constructs the norms of the type-A coordinate b and chi, not a
replay of a square-locus or trace verifier.  A common factor would require
separate treatment before extending the type-A content-pole bound.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
source=Path(__file__).with_name('degree140_endpoint_content_norm_20260930.sage').read_text()
source=source[:source.index('norms=[];records=[]')]
exec(preparse(source))
rows=[];certificates=[]
def norm3(value,pr):
    a=value.lift().list();a += [R.zero()]*(3-len(a))
    return a[0]^3+pr*a[1]^3+pr^2*a[2]^3-3*pr*a[0]*a[1]*a[2]
for i in range(1,4):
    r=alpha^(25^i);pr=P(r);tp=tx.derivative()(r)
    C=YY.quotient(Y^3-R(pr),names='yy');yy=C.gen()
    J=PowerSeriesRing(C,'z',default_prec=2);z=J.gen()
    xs=(J(r)+z).add_bigoh(2)
    ys=(J(yy)*(1+P.derivative()(r)/(3*pr)*z)).add_bigoh(2)
    xp=[xs^j for j in range(23)];yp=[ys^j for j in range(3)]
    gs=[]
    for terms in families[:3]:
        value=J.zero()
        for ix,iy,hh,ww,c in terms:
            value+=C(dec(c)*H^hh*w^(ww-hh+5))*xp[ix]*yp[iy]
        gs.append(value)
    ls=sum((L0[j]*xp[j] for j in range(L0.degree()+1)),J.zero())
    bb=(gs[1]-3*ls*gs[0])[0]
    cs=gs[2]-2*ls*gs[1]+3*ls^2*gs[0]
    assert not cs[0]
    chi=cs[1]/C(tp)
    bn=norm3(bb,pr);cn=norm3(chi,pr)
    common=gcd(bn,cn)
    assert len(common.dict())==1
    exponent=next(iter(common.dict()))
    assert int(exponent[0])==0
    rows.append({'endpoint':int(i),'b_norm_degrees':list(map(int,bn.degrees())),
                 'chi_norm_degrees':list(map(int,cn.degrees())),
                 'common_w_power':int(exponent[1])})
    certificates.append({'root':r,'b_norm':bn,'chi_norm':cn,'gcd':common})
    print(rows[-1],flush=True)
save({'ring':R,'records':certificates},str(root/'endpoint_coordinate_poles'))
report={'scope':'no codimension-one simultaneous b=chi=0 on w!=0',
        'rows':rows,'seconds':time.time()-start}
(root/'endpoint_coordinate_poles.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
