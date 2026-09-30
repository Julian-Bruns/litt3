"""Exact Bezout witnesses for branch exclusion and all open factors."""
from algebra import *
import json

def xgcd(a,b):
    r,s=a[:],b[:];u,v=[1],[];uu,vv=[],[1]
    while s:
        q,t=pdivrem(r,s);r,s=s,t
        u,uu=uu,psub(u,pmul(q,uu));v,vv=vv,psub(v,pmul(q,vv))
    c=inv(r[-1]);return pscale(r,c),pscale(u,c),pscale(v,c)

def main():
    inc=json.loads((ROOT/'data/incidence.json').read_text())
    a3=[0]*10
    for h,q,x,c in inc['A3']:assert h==q==0;a3[x]=c
    g,u,v=xgcd(P,a3);assert g==[1] and padd(pmul(P,u),pmul(a3,v))==[1]
    branch={'P':P,'A3':a3,'coefficient_of_P':u,'coefficient_of_A3':v}
    (ROOT/'data/branch_bezout.json').write_text(json.dumps(branch,indent=2)+'\n')
    shape=json.loads((ROOT/'data/shape.json').read_text());F=shape['minimal_polynomial'];xx=shape['coordinates']['x'];ss=shape['coordinates']['inverse_qt']
    def compose(a,b):
        r=[]
        for c in reversed(a):r=pmod(padd(pmul(r,b),[c]),F)
        return r
    opens=dict(shape['open_factors']);opens.update({'P_at_incidence_point':compose(P,xx),'t_at_incidence_point':compose(t,xx)})
    assert pmod(pmul(pmul(ss,[0,1]),opens['t_at_incidence_point']),F)==[1]
    cert={}
    for name,a in opens.items():
        g,u,v=xgcd(F,a);assert g==[1]
        assert padd(pmul(F,u),pmul(a,v))==[1]
        cert[name]={'factor':a,'coefficient_of_minpoly':u,'inverse':v}
    (ROOT/'data/open_unit_certificates.json').write_text(json.dumps(cert,indent=2)+'\n')
    print('gcd(P,A3)=1: exact polynomial Bezout identity verified')
    print('all',len(cert),'open/branch units verified by exact Bezout identities')
    print('inverse(q*t) coordinate verified in the shape algebra')
if __name__=='__main__':main()
