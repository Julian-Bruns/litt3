#!/usr/bin/env sage -python
"""Prepare exact pointed pencils for the native finite-field row engine.

The infinity chart stays an independent finite-field matrix calculation.
The first four whole Krylov rows are compared entrywise through hashes
against Sage polynomial multiplication. Mathematical data use canonical F125.
"""
import argparse
import hashlib
import json
from pathlib import Path
import struct
import subprocess
import time
from sage.all import *
from pointed_frobenius_polynomial import build_polynomial_blocks


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--height',type=int,required=True)
    ap.add_argument('--torsions',default=','.join(map(str,range(16))))
    ap.add_argument('--output-dir',type=Path,required=True)
    args=ap.parse_args()
    root=Path(__file__).resolve().parents[2];dest=args.output_dir.resolve()
    assert not dest.is_relative_to(root)
    dest.mkdir(parents=True,exist_ok=True)
    k=GF(125,'b');poly=PolynomialRing(k,'u');u=poly.gen()
    alpha=(u**3+u+1).roots(multiplicities=False)[0]
    F=u*(u-1)*(u-2)*(u-3)*(u-alpha)
    branch=[k(0),k(1),k(2),k(3),alpha]
    twists=[poly(1)]+[u-a for a in branch]
    twists += [(u-a)*(u-b) for i,a in enumerate(branch) for b in branch[i+1:]]
    def code(c):return sum(int(a)*5**i for i,a in enumerate(k(c).polynomial().list()))
    elements=[k([i%5,(i//5)%5,i//25]) for i in range(125)]
    assert [code(a) for a in elements]==list(range(125))
    def bytes_matrix(M):return bytes(code(c) for c in M.list())
    def row_hash(row):
        degree=max(c.degree() for c in row)
        data=[code(c[d]) for d in range(degree+1) for c in row]
        value=1469598103934665603
        for a in data:value=((value^a)*1099511628211)&((1<<64)-1)
        return str(value)
    source=Path(__file__).with_name('pointed_popov_native.cpp')
    executable=dest/'pointed_popov_native'
    subprocess.run(['c++','-O3','-std=c++17',str(source),'-o',str(executable)],check=True)
    records=[];packets=[];started=time.monotonic()
    for label in map(int,args.torsions.split(',')):
        assert 0<=label<16
        for part,block in enumerate(build_polynomial_blocks(F,twists[label],5**args.height)):
            M0,M1,M2=block['matrices'];n=M0.ncols()
            if n==0:continue
            selected=list(M0.transpose().pivots());assert len(selected)==n
            extra=[i for i in range(n+2) if i not in selected]
            base=M0.matrix_from_rows(selected);inv=base.inverse()
            assert base*inv==inv*base==identity_matrix(k,n)
            A=inv*M1.matrix_from_rows(selected);B=inv*M2.matrix_from_rows(selected)
            low=M0.matrix_from_rows(extra)
            C=M1.matrix_from_rows(extra)-low*A;D=M2.matrix_from_rows(extra)-low*B
            observed=[];row=D
            for power in range(n):
                observed.extend(row.rows())
                if len(observed)>=n and matrix(k,observed).rank()==n:break
                row=row*B
            infinity_rank=matrix(k,observed).rank();assert infinity_rank==n
            R=PolynomialRing(k,'t');t=R.gen()
            T=A.change_ring(R)+t*B.change_ring(R)
            moving=C.change_ring(R)+t*D.change_ring(R)
            hashes=[]
            for p in range(min(4,n)):
                hashes.append([row_hash(row) for row in moving.rows()])
                if p+1<min(4,n):moving=moving*T
            records.append(dict(torsion=label,block=part,columns=n,infinity_rank=infinity_rank,sage_row_hashes=hashes))
            packets.append(struct.pack('<III',label,part,n)+b''.join(bytes_matrix(M) for M in (A,B,C,D)))
            print('Prepared',label,part,n,'seconds',round(time.monotonic()-started,2),flush=True)
    packet=dest/'pencils.bin';raw=dest/'native_rows.json';final=dest/'receipt.json'
    with packet.open('wb') as stream:
        stream.write(struct.pack('<II',0x31504f50,125))
        stream.write(bytes(code(a+b) for a in elements for b in elements))
        stream.write(bytes(code(a*b) for a in elements for b in elements))
        stream.write(bytes(code(-a) for a in elements))
        stream.write(bytes(0 if not a else code(1/a) for a in elements))
        stream.write(struct.pack('<I',len(packets)))
        for p in packets:stream.write(p)
    subprocess.run([str(executable),str(packet),str(raw)],check=True)
    result=json.loads(raw.read_text());assert len(result['blocks'])==len(records)
    for reference,actual in zip(records,result['blocks']):
        assert all(reference[key]==actual[key] for key in ('torsion','block','columns'))
        checked=min(len(actual['stages']),len(reference['sage_row_hashes']))
        assert [s['row_hashes'] for s in actual['stages'][:checked]]==reference['sage_row_hashes'][:checked]
    receipt=dict(kind='native_pointed_observability',height=args.height,
                 field_modulus=str(k.modulus()),alpha=str(alpha),
                 wrapper_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                 engine_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                 builder_sha256=hashlib.sha256(Path(__file__).with_name('pointed_frobenius_polynomial.py').read_bytes()).hexdigest(),
                 packet_sha256=hashlib.sha256(packet.read_bytes()).hexdigest(),
                 references=records,result=result,
                 all_requested_blocks_pass=all(b['whole_row_module'] for b in result['blocks']),
                 seconds=round(time.monotonic()-started,2),status='exact_computation_pending_bounded_review')
    final.write_text(json.dumps(receipt,indent=2,default=int)+'\n')
    print('Receipt',final,'all pass',receipt['all_requested_blocks_pass'],'seconds',receipt['seconds'],flush=True)


if __name__=='__main__':main()
