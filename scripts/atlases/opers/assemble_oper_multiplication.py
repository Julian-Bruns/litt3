"""Assemble one multiplication operator from lossless rows and NF batches.

This proposes an operator, not an independent Groebner-basis certificate.
The subsequent univariate presentation must satisfy the original equations.
"""
import argparse
import array
import json
import mmap
from pathlib import Path
import struct
import sys


def keys(path):
    data = array.array('Q')
    data.frombytes(Path(path).read_bytes())
    if sys.byteorder != 'little':
        data.byteswap()
    return data


def assemble(prefix, nf_prefix, output, variable):
    prefix, nf_prefix, output = map(str, (prefix, nf_prefix, output))
    standards = keys(prefix+'.standard.u64')
    leading = keys(prefix+'.lm.u64')
    d = len(standards)
    si = {key:i for i,key in enumerate(standards)}
    li = {key:i for i,key in enumerate(leading)}
    assert len(si)==d and len(li)==len(leading) and standards[0]==0
    handles = []
    views = []
    def mapped(path):
        f = open(path, 'rb'); handles.append(f)
        view = mmap.mmap(f.fileno(), 0, access=mmap.ACCESS_READ)
        views.append(view)
        return view
    rewrite = mapped(prefix+'.u8')
    assert len(rewrite)==d*len(leading)
    extra = {}
    for batch in sorted(Path(nf_prefix).parent.glob(Path(nf_prefix).name+'.*.keys.u64')):
        batchkeys=keys(batch)
        rows=mapped(str(batch).replace('.keys.u64','.u8'))
        assert len(rows)==len(batchkeys)*d
        for i,key in enumerate(batchkeys):
            assert key not in extra
            extra[key]=(rows,i*d)
    targets=[]
    for key in standards:
        assert (key>>(4*variable))&15<15
        targets.append(key+(1<<(4*variable)))
    missing=set(targets)-si.keys()-li.keys()
    assert missing==extra.keys(), (len(missing),len(extra),len(missing-extra.keys()))
    temporary=Path(output+'.u8.partial')
    mapfile=Path(output+'.map.i32.partial')
    assert not Path(output+'.u8').exists() and not Path(output+'.map.i32').exists()
    dense=0
    with temporary.open('xb') as stream, mapfile.open('xb') as mapping:
        for key in targets:
            if key in si:
                position=si[key]
            else:
                if key in li:
                    row=rewrite[li[key]*d:(li[key]+1)*d]
                else:
                    view,start=extra[key];row=view[start:start+d]
                assert len(row)==d and max(row,default=0)<5
                stream.write(row);dense+=1;position=-dense
            mapping.write(struct.pack('<i',position))
    temporary.rename(output+'.u8');mapfile.rename(output+'.map.i32')
    coordinates=[si[1<<(4*j)] for j in range(15)]
    Path(output+'.meta').write_text(f'{d} {dense} {variable} {len(extra)}\n'+' '.join(map(str,coordinates))+'\n')
    names=['c0','c1','c2','c3']+[f'a{i}' for i in range(10)]+['zeta']
    report={'status':'candidate_multiplication_operator_NOT_original_ideal_certified',
        'dimension':d,'dense_rows':dense,'variable':names[variable],
        'missing_normal_forms':len(extra),'matrix_bytes':dense*d}
    Path(output+'.json').write_text(json.dumps(report,indent=2)+'\n')
    for view in views:view.close()
    for handle in handles:handle.close()
    print(json.dumps(report),flush=True)


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('prefix');p.add_argument('nf_prefix');p.add_argument('output')
    p.add_argument('--variable',type=int,default=13)
    args=p.parse_args()
    assemble(args.prefix,args.nf_prefix,args.output,args.variable)
