#!/usr/bin/env python3
"""Independent exact checks of sampled native syndromes in the degree56 field for seven-label endpoints.

These are bounded implementation checks. Completeness is supplied by the
entire retained endpoint enumeration and matching, not by these samples.
"""
import argparse,json,struct,time,hashlib
from pathlib import Path
from sage.all import GF,PolynomialRing

def main():
    ap=argparse.ArgumentParser();ap.add_argument('output',type=Path);ap.add_argument('samples',nargs='+',type=Path)
    args=ap.parse_args();start=time.monotonic()
    R=PolynomialRing(GF(5),'b');b=R.gen();B=GF(25,'b',modulus=b*b-b-3);b=B.gen()
    dec=lambda c:B(c%5)+B(c//5)*b;code=lambda c:int(B(c)[0])+5*int(B(c)[1])
    R=PolynomialRing(B,'z');K=B.extension(R([dec(c) for c in [4,22,7,20,21,7,24,1]]),'z');z=K.gen();assert z**29==1
    T=PolynomialRing(K,'a');L=K.extension(T([K(dec(c)) for c in [5,2,6,7,1]]),'a');a=L.gen()
    roots=[a**(25**i) for i in range(4)];R=PolynomialRing(L,'x')
    families=[[R([L(dec(c)) for c in row])(t) for t in roots] for row in [[22,7,9,23],[1,3,8,15],[20,12,13,8],[21,21,20,2]]]
    table=[[[f[i]*L(z**(e*j%29)) for j in range(29)] for i in range(4)] for f,e in zip(families,[5,8,17,4])]
    eta=L(dec(22));checks=[]
    for path in args.samples:
        raw=path.read_bytes();assert len(raw)%111==0;count=0
        for off in range(0,len(raw),111):
            row=raw[off:off+111];ec=struct.unpack('<I',row[:4])[0];labels=list(row[4:11]);side,first=row[11:13]
            epsilon=L.zero();v=ec
            for i in range(4):epsilon+=L(dec(v%25))*a**i;v//=25
            if side:epsilon=1/epsilon
            eps=[epsilon.lift()[i] for i in range(4)];pivot=next(i for i in range(1,4) if eps[i])
            C,E,U,V=[sum((family[l%4][l//4] for l in labels),L.zero()) for family in table]
            W=((epsilon*(E if first else C)) if not side else -(C if first else E))/eta
            wc=[W.lift()[i] for i in range(4)];yy=wc[pivot]/eps[pivot];xx=eps[0]*yy-wc[0]
            X,Y=(yy**(5**7),xx**(5**7)) if first else (xx,yy)
            out=bytearray(code((wc[i]-eps[i]*yy).lift()[j]) for j in range(7) for i in range(1,4) if i!=pivot)
            if first:r0=(epsilon*C if not side else -E)-eta*(epsilon*L(Y)-L(X))
            else:r0=(epsilon*E if not side else -C)-eta*(epsilon*L(X**(5**7))-L(Y**(5**7)))
            r1=(epsilon*U+V if not side else L.zero())-eta*(epsilon*L(X**625)-L(Y**(5**8)))
            r2=(U+epsilon*V if side else L.zero())-eta*(L(X**(5**11))-epsilon*L(Y**5))
            out.extend(code(r.lift()[i].lift()[j]) for r in [r0,r1,r2] for j in range(7) for i in range(4))
            assert len(out)==98 and out==row[13:],(path.name,off,ec,labels,side,first)
            count+=1
        checks.append(dict(file=path.name,records=count,sha256=hashlib.sha256(raw).hexdigest()))
        print('PASS',path.name,count,flush=True)
    result=dict(status='PASS_BOUNDED_INDEPENDENT_LITERAL_TRACE_CHECKS',checks=checks,seconds=time.monotonic()-start,
                method='Sage degree56 tower; literal equations and direct Frobenius powers; no native field or Frobenius tables',
                scope='implementation audit including every seven-distinct-phase endpoint and systematic samples; not the exhaustive proof')
    args.output.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True)

if __name__=='__main__':main()
