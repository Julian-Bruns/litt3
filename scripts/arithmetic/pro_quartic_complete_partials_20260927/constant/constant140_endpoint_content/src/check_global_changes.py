#!/usr/bin/env python3
"""Check the exact ratio-source data and Newton support (not a locus decision)."""
import json
from pathlib import Path
import argparse

def add25(a,b):
    return (a%5+b%5)%5+5*((a//5+b//5)%5)
def mul25(a,b):
    a0,a1,b0,b1=a%5,a//5,b%5,b//5
    return (a0*b0+3*a1*b1)%5+5*((a0*b1+a1*b0+a1*b1)%5)
def neg25(a):
    return (-a%5)+5*(-(a//5)%5)
def add(a,b):
    out=0
    for p in (1,25,625,15625):
        out += p*add25((a//p)%25,(b//p)%25)
    return out
def mul(a,b):
    av=[(a//25**i)%25 for i in range(4)]
    bv=[(b//25**i)%25 for i in range(4)]
    r=[0]*7
    for i in range(4):
        for j in range(4):
            r[i+j]=add25(r[i+j],mul25(av[i],bv[j]))
    for i in range(6,3,-1):
        for j,c in enumerate((5,2,6,7)):
            r[i-4+j]=add25(r[i-4+j],neg25(mul25(r[i],c)))
    return sum(r[i]*25**i for i in range(4))

def power(a,n):
    r=1
    while n:
        if n&1: r=mul(r,a)
        a=mul(a,a); n//=2
    return r

def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--root',type=Path,default=Path('.'))
    ap.add_argument('--output',type=Path,default=Path('regenerated/ratio_source.json'))
    args=ap.parse_args()
    root=args.root
    tok=(root/'inputs/source_affine.dat').read_text().split()
    assert tok[0]=='CONSTANT140_AFFINE_V1'
    at=1;basis=[]
    for k in range(7):
        ss=[]
        for g in range(4):
            curve=[]
            for j in range(3):
                n=int(tok[at]);at+=1
                curve.append(list(map(int,tok[at:at+n])));at+=n
            ss.append(curve)
        basis.append(ss)
    assert at==len(tok)
    chart=json.loads((root/'inputs/chart_laurent.json').read_text())
    # G_i = w U_i + y V_i + (y^2/w^4) Z_i(H,q), H=h*w, q=w^3.
    for g in range(4):
        assert not basis[0][g][0] and not basis[0][g][2]
        assert not basis[2][g][1] and not basis[2][g][2]
        for k in (1,3,4,5,6):
            assert not basis[k][g][0] and not basis[k][g][1]
    source=[]
    terms=[[1,0,1]],chart['e'],chart['f'],chart['kernel0'],chart['kernel1']
    for g in range(4):
        z={}
        for k,coeff_terms in zip((1,3,4,5,6),terms):
            for hh,ww,c in coeff_terms:
                exp=ww+4-hh
                assert exp%3==0 and exp>=0
                qq=exp//3
                for x,a in enumerate(basis[k][g][2]):
                    val=mul(a,c)
                    if val:
                        key=(hh,qq,x)
                        z[key]=add(z.get(key,0),val)
                        if not z[key]: del z[key]
        for hh,qq,x in z:
            assert hh<=1 and qq-hh>=0 and qq+3*hh<=5
        source.append({'i':g+2,'U':basis[2][g][0],'V':basis[0][g][1],
                       'Z_terms_H_q_x_code':[[*k,v] for k,v in sorted(z.items())]})
    data={'formula':'G_i=w*U_i(x)+y*V_i(x)+(y^2/w^4)*Z_i(H,q,x)',
          'convention':'H=h*w, q=w^3; all codes are the specified K codes',
          'source':source}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(data,indent=2)+'\n')
    rows=[]
    with (root/'inputs/E_records.tsv').open() as f:
        assert next(f).strip()=='CONSTANT140_E_V1'
        rows=[tuple(map(int,line.split())) for line in f]
    epsilon=359499; cstar=299619
    lead_factor=mul(mul(3,power(epsilon,8)),power(power(cstar,2),390623))
    expected_lead={}
    for n,c in enumerate((89654,311173,214299,163299,315361,33043,356725,245794)):
        expected_lead[(3,14+n,0)]=mul(lead_factor,c)
    for n,c in ((1,299833),(2,232505)):
        expected_lead[(4,14+n,0)]=mul(lead_factor,c)
    actual_lead={(h,n,m):c for j,h,n,m,x,c in rows if j==2 and x==40}
    assert actual_lead==expected_lead
    stats=[]
    for j in range(3):
        rr=[r for r in rows if r[0]==j]
        lower=min(3*n-3*h-5*m for _,h,n,m,x,c in rr)
        upper=max(9*h+3*n+10*m for _,h,n,m,x,c in rr)
        td=max(h+m for _,h,n,m,x,c in rr)
        assert lower>=j-2 and upper<=178+j and td<=12
        stats.append({'component':j,'records':len(rr),
                      'min_3q_minus_3H_minus_5mu':lower,'proved_lower_bound':j-2,
                      'max_9H_plus_3q_plus_10mu':upper,'proved_upper_bound':178+j,
                      'max_H_plus_mu':td,'max_q':max(r[2] for r in rr)})
    print(json.dumps({'global_E2_leading_identity':'PASS', 'ratio_source_terms':sum(len(s['Z_terms_H_q_x_code']) for s in source),
                      'newton_bounds':stats,'status':'PASS; no geometric square-locus decision'},indent=2))
if __name__=='__main__':
    main()
