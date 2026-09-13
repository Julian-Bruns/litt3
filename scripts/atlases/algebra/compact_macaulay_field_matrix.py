#!/usr/bin/env python3
"""Retain field-peeling rows and their columns, preserving every input entry.

The output is a ragged matrix (native equations argument 0). It is exactly
the selected subsystem, not yet a certificate for the original ansatz.
Primal coefficients extend by zero. Duals require reverse field elimination.
"""
import argparse
import array
import hashlib
import json
import struct
import time
from pathlib import Path


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source',type=Path)
    parser.add_argument('peeling',type=Path)
    parser.add_argument('matrix',type=Path)
    parser.add_argument('out',type=Path)
    args=parser.parse_args()
    start=time.monotonic()
    source=json.loads(args.source.read_text())
    peel=json.loads(args.peeling.read_text())
    degree=source['field_degree']
    nr,nc=source['rows'],source['columns']
    rows=[i*degree+j for i in peel['remaining_row_indices'] for j in range(degree)]
    raw_cols=[i*degree+j for i in peel['remaining_monomial_indices'] for j in range(degree)]
    target=source['original_target_column']
    swap=lambda j:nc-1 if j==target else target if j==nc-1 else j
    cols=sorted(swap(j) for j in raw_cols)
    assert cols[-1]==nc-1 and len(set(cols))==len(cols)
    row_set=set(rows)
    col_map=array.array('i',[-1])*nc
    for i,j in enumerate(cols):col_map[j]=i
    args.out.mkdir(exist_ok=False)
    original_hash=hashlib.sha256();compact_hash=hashlib.sha256()
    old_terms=kept_terms=0
    with args.matrix.open('rb') as original,(args.out/'matrix.bin').open('xb') as compact:
        def read(n):
            data=original.read(n)
            if len(data)!=n:raise ValueError('truncated original matrix')
            original_hash.update(data)
            return data
        def write(data):
            compact_hash.update(data);compact.write(data)
        assert struct.unpack('<II',read(8))==(nr,nc)
        write(struct.pack('<II',len(rows),len(cols)))
        for i in range(nr):
            count,=struct.unpack('<I',read(4))
            index_bytes=read(4*count);values=read(count);old_terms+=count
            if i not in row_set:continue
            indices=array.array('I');indices.frombytes(index_bytes)
            mapped=array.array('I')
            for j in indices:
                k=col_map[j]
                if k<0:raise ValueError('retained row has an omitted column')
                mapped.append(k)
            write(struct.pack('<I',count));write(mapped.tobytes());write(values)
            kept_terms+=count
        assert not original.read(1)
    assert old_terms==source['nonzeros']
    receipt=dict(scope='Exact selected-subsystem export; no original dual or ideal verdict',
        original_rows=nr,original_columns=nc,original_nonzeros=old_terms,
        rows=len(rows),columns=len(cols),nonzeros=kept_terms,
        original_matrix_sha256=original_hash.hexdigest(),matrix_sha256=compact_hash.hexdigest(),
        source_sha256=hashlib.sha256(args.source.read_bytes()).hexdigest(),
        source=str(args.source.resolve()),peeling=str(args.peeling.resolve()),
        original_matrix=str(args.matrix.resolve()),
        retained_row_indices=rows,retained_column_indices=cols,
        seconds=time.monotonic()-start)
    with (args.out/'mapping.json').open('x') as f:json.dump(receipt,f,separators=(',',':'))
    print(json.dumps({k:v for k,v in receipt.items() if not k.startswith('retained_')},indent=2),flush=True)


if __name__=='__main__':main()
