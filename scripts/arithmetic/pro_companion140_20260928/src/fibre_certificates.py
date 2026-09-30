"""Four geometric ratio exclusions: both sheets above q=1 and q=2.
The scale is an indeterminate: these are NOT bounded scale searches.
No assertion about other q values is made.
"""
from global_checks import *

def selected_s(q,u):
    aa,bb,cc,ee,dd=[peval(I[k],q) for k in ['a0','b','c','e','d']]
    return div(add(add(aa,div(bb,u)),add(div(cc,power(u,2)),div(ee,power(u,3)))),dd)

def verify_ratio(q,u,xi,s):
    b,c,e=[peval(I[k],q) for k in ['b','c','e']]
    C=sub(mul(c,c),mul(3,mul(b,e)))
    Delta=sub(mul(c,c),mul(4,mul(b,e)))
    assert power(xi,2)==C
    assert add(add(mul(Delta,power(u,2)),mul(3,mul(mul(c,e),u))),mul(2,power(e,2)))==0
    g=add(add(mul(b,power(u,2)),mul(2,mul(c,u))),mul(3,e))
    assert all([q,u,s,b,e,C,Delta,g,peval(I['d'],q)]) and q not in I['excluded_q']
    a=sub(peval(I['a0'],q),mul(s,peval(I['d'],q)))
    Bdiff=sub(power(b,2),mul(3,mul(a,c)))
    us=div(sub(sub(mul(power(a,2),e),mul(a,mul(b,c))),power(b,3)),mul(a,Bdiff))
    assert us==u

def run():
    ts=time.time();rows=[]
    for q in [1,2]:
        points=companion(q);assert len(points)==2
        for u,xi in points:
            s=selected_s(q,u);verify_ratio(q,u,xi,s)
            if q==1 and u==103571:
                rr=json.loads((ROOT/'data/sample_residual.json').read_text())['Rbar_scale_ascending']
            else:rr=residual(q,u)
            aa,cc,eq=tails(rr,74)
            gcd,U,V=pxgcd(eq[71],eq[72])
            assert gcd==[1]
            assert pa(pm(U,eq[71]),pm(V,eq[72]))==[1]
            assert eq[72][-1]==lc72(q,u,s)
            # Independently check the three tails by recursion at four scales.
            for mu in [0,1,25,101]:
                root,_=verify_square_test(rr,mu)
                for j in [71,72,73]:assert peval(eq[j],mu)==root[j]
            row={'q':q,'u':u,'H':div(u,q),'xi':xi,'s':s,'C71':eq[71],'C72':eq[72],
                 'U':U,'V':V,'leading_C72_formula':lc72(q,u,s),'scale_localization':'none; all geometric scales excluded'}
            rows.append(row)
            (ROOT/'data/fibre_certificates.json').write_text(json.dumps(rows,separators=(',',':'))+'\n')
            print(json.dumps({'q':q,'u':u,'xi':xi,'s':s,'H':div(u,q),'tail_degrees':[len(eq[71])-1,len(eq[72])-1],
                  'identity':'U*C71 + V*C72 = 1','independent_root_recursion_scales':[0,1,25,101],
                  'leading_C72_formula':'PASS','seconds':round(time.time()-ts,3)}),flush=True)
    assert len(rows)==4
if __name__=='__main__':run()
