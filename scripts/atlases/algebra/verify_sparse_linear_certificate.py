#!/usr/bin/env python3
"""Independently replay one native F25 primal/dual sparse-matrix certificate.

This uses only the Python standard library, not the solver's arithmetic.
A primal matrix certificate proves a polynomial unit only after the input
rows' provenance is verified. A dual only rejects the bounded row span.
"""
import argparse,array,hashlib,json,struct,time
from pathlib import Path

def main():
    ap=argparse.ArgumentParser();ap.add_argument('matrix',type=Path)
    ap.add_argument('certificate',type=Path);ap.add_argument('--kind',choices=['primal','dual'],required=True)
    args=ap.parse_args();start=time.monotonic();data=args.matrix.read_bytes();c=args.certificate.read_bytes()
    nr,nc=struct.unpack_from('<II',data);pos=8
    assert len(c)==(nr if args.kind=='primal' else nc) and all(x<25 for x in c)
    zero=[x%5 for x in c];one=[x//5 for x in c];nnz=0
    if args.kind=='primal':s0=[0]*nc;s1=[0]*nc
    for row in range(nr):
        count,=struct.unpack_from('<I',data,pos);pos+=4;nnz+=count
        idx=array.array('I');idx.frombytes(data[pos:pos+4*count]);pos+=4*count
        vals=data[pos:pos+count];pos+=count
        assert len(vals)==count and all(j<nc for j in idx) and all(0<a<25 for a in vals)
        if args.kind=='dual':
            r0=r1=0
            for j,a in zip(idx,vals):
                a0,a1=a%5,a//5;b0,b1=zero[j],one[j]
                r0+=a0*b0+3*a1*b1;r1+=a0*b1+a1*b0+a1*b1
            assert r0%5==0 and r1%5==0,('dual row',row)
        else:
            b0,b1=zero[row],one[row]
            for j,a in zip(idx,vals):
                a0,a1=a%5,a//5
                s0[j]+=a0*b0+3*a1*b1;s1[j]+=a0*b1+a1*b0+a1*b1
    assert pos==len(data)
    if args.kind=='dual':assert c[-1]!=0
    else:
        assert s0[-1]%5==1 and all(x%5==0 for x in s0[:-1]) and all(x%5==0 for x in s1)
    print(json.dumps(dict(status='exact_certificate_replay_pass',kind=args.kind,rows=nr,columns=nc,nonzeros=nnz,
        matrix_sha256=hashlib.sha256(data).hexdigest(),certificate_sha256=hashlib.sha256(c).hexdigest(),
        seconds=time.monotonic()-start,scope='Bounded matrix statement only; polynomial input provenance remains a separate prerequisite'),indent=2))

if __name__=='__main__':main()
