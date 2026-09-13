"""Full standard-library replay of a restricted-scalar Macaulay export.

This proves row provenance against the recorded reduced polynomials.
The geometric derivation and linear substitution are separate inputs.
"""
import argparse
import array
import hashlib
import json
import struct
import time
from pathlib import Path


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('folder',type=Path)
    args=parser.parse_args(); started=time.monotonic()
    source=args.folder/'source.json'; matrix=args.folder/'matrix.bin'
    data=json.loads(source.read_text()); receipt=json.loads((args.folder/'export.json').read_text())
    assert hashlib.sha256(source.read_bytes()).hexdigest()==receipt['source_sha256']
    modulus=data['field_modulus']; d=data['field_degree']
    assert len(modulus)==d+1 and modulus[-1]==1 and data['prime']==5
    cache={}
    def shifted(c,power):
        key=(tuple(c),power)
        if key not in cache:
            v=[0]*power+list(c)
            for i in range(len(v)-1,d-1,-1):
                a=v[i]%5
                for j in range(d): v[i-d+j]=(v[i-d+j]-a*modulus[j])%5
            cache[key]=tuple((v+[0]*d)[:d])
        return cache[key]
    monomials=[tuple(m) for m in data['monomials']]
    index={m:i for i,m in enumerate(monomials)}
    nc=data['columns']; target=data['original_target_column']
    base_rows=[]
    for polynomial in data['equations']:
        for power in range(d):
            row=[]
            for exponent,c in polynomial:
                row.extend((tuple(exponent),j,v) for j,v in enumerate(shifted(c,power)) if v)
            base_rows.append(row)
    assert len(base_rows)==data['base_rows']
    base_monomials={e for row in base_rows for e,j,c in row}
    digest=hashlib.sha256(); rows=nnz=0
    with matrix.open('rb') as stream:
        def read(n):
            block=stream.read(n); assert len(block)==n; digest.update(block); return block
        assert struct.unpack('<II',read(8))==(data['rows'],nc)
        for mi,m in enumerate(data['multipliers']):
            destinations={}
            for e in base_monomials:
                base=index[tuple(a+b for a,b in zip(e,m))]*d
                for j in range(d):
                    x=base+j
                    destinations[e,j]=nc-1 if x==target else target if x==nc-1 else x
            for row in base_rows:
                size,=struct.unpack('<I',read(4)); assert size==len(row)
                indices=array.array('I');indices.frombytes(read(4*size)); values=read(size)
                assert all(i==destinations[e,j] and v==c for i,v,(e,j,c) in zip(indices,values,row))
                rows+=1;nnz+=size
            if mi%20==0:
                print(json.dumps(dict(stage='row_provenance',multipliers_done=mi+1,
                    multipliers_total=len(data['multipliers']),seconds=time.monotonic()-started)),flush=True)
        assert not stream.read(1)
    assert rows==data['rows'] and nnz==data['nonzeros']
    assert digest.hexdigest()==receipt['matrix_sha256']
    result=dict(status='all_original_reduced_polynomial_rows_verified',rows=rows,columns=nc,
                nonzeros=nnz,matrix_sha256=digest.hexdigest(),source_sha256=receipt['source_sha256'],
                seconds=time.monotonic()-started,
                scope='Full row encoding, not a solver outcome or geometric exclusion')
    (args.folder/'encoding_verification.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result),flush=True)

if __name__=='__main__':main()
