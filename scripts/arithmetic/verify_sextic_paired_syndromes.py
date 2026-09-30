#!/usr/bin/env python3
"""Reconstruct every paired-endpoint syndrome from the four literal traces.

Independent Sage tower arithmetic: no generated arithmetic tables or native
syndrome routine are called. Compare all 600*116*42 field coordinates.
"""
import argparse,hashlib,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing

def main():
    ap=argparse.ArgumentParser();ap.add_argument('native_dump',type=Path);ap.add_argument('output',type=Path)
    args=ap.parse_args();start=time.monotonic()
    R=PolynomialRing(GF(5),'b');b=R.gen();B=GF(25,'b',modulus=b*b-b-3);b=B.gen()
    dec=lambda c:B(c%5)+B(c//5)*b
    code=lambda c:int(B(c)[0])+5*int(B(c)[1])
    R=PolynomialRing(B,'x');x=R.gen()
    E=B.extension(R([dec(c) for c in [5,2,6,7,1]]),'a');a=E.gen()
    roots=[a**(25**i) for i in range(4)]
    rows=[[22,7,9,23],[1,3,8,15],[20,12,13,8],[21,21,20,2]]
    values=[[R([dec(c) for c in row])(z) for z in roots] for row in rows]
    a2=4*sum((E(pow(2,(-2*i)%4,5))*values[2][i] for i in range(4)),E.zero())
    assert a2*a2==E(dec(9))
    pairs=[]
    for family in values:
        pp=[]
        for p in range(2):
            v=family[p]+family[p+2]
            c1=v.lift()[1]/a2.lift()[1];c0=v.lift()[0]-c1*a2.lift()[0]
            assert v==E(c0)+E(c1)*a2;pp.append((c0,c1))
        pairs.append(pp)
    K=B.extension(R([dec(c) for c in [4,22,7,20,21,7,24,1]]),'z');z=K.gen()
    assert z**29==1 and z!=1
    T=PolynomialRing(K,'t');t=T.gen();L=K.extension(t*t-K(dec(9)),'t');t=L.gen()
    pair=[[L(c0)+L(c1)*t for c0,c1 in family] for family in pairs]
    eta=L(dec(22));raw=bytearray();scalars=0
    powers={e:[L(z**(e*j%29)) for j in range(29)] for e in [4,5,8,17]}
    for ac in range(25):
        for bc in range(1,25):
            av,bv=dec(ac),dec(bc);eps=L(av)+L(bv)*t
            for side in range(2):
                for label in range(58):
                    j,p=divmod(label,2)
                    C=pair[0][p]*powers[5][j];EE=pair[1][p]*powers[8][j]
                    U=pair[2][p]*powers[17][j];V=pair[3][p]*powers[4][j]
                    W=(eps*C if side==0 else -EE)/eta
                    Y=W.lift()[1]/K(bv);X=K(av)*Y-W.lift()[0]
                    assert eps*L(Y)-L(X)==W
                    rx=eps*EE if side==0 else -C
                    r0=rx-eta*(eps*L(X**(5**7))-L(Y**(5**7)))
                    r1=(eps*U+V if side==0 else L.zero())-eta*(eps*L(X**625)-L(Y**(5**8)))
                    r2=(U+eps*V if side==1 else L.zero())-eta*(L(X**(5**11))-eps*L(Y**5))
                    raw.extend(code(r.lift()[i].lift()[j]) for r in [r0,r1,r2] for i in range(2) for j in range(7))
            scalars+=1
            if scalars%100==0:print('checked',scalars,'seconds',round(time.monotonic()-start,2),flush=True)
    expected=args.native_dump.read_bytes();assert raw==expected
    result=dict(status='PASS_ALL_COORDINATES',scalars=scalars,labels_per_side=58,coordinates_per_label=42,
        bytes_compared=len(raw),sha256=hashlib.sha256(raw).hexdigest(),seconds=time.monotonic()-start,
        pair_values=[[[code(c) for c in v] for v in family] for family in pairs],
        method='literal four trace equations in independent Sage field tower; moments solved by coefficient comparison')
    args.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)

if __name__=='__main__':main()
