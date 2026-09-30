#!/usr/bin/env python3
"""Package the executed projected Bézout certificate in a compact binary format."""
from __future__ import annotations
import argparse, array, hashlib, json, pathlib, struct, sys
ROOT=pathlib.Path(__file__).resolve().parent.parent

def seal(projection=None, bezout=None):
    projection=pathlib.Path(projection or ROOT/'work/projection.polynomials.json')
    bezout=pathlib.Path(bezout or ROOT/'work/rebuilt_gcd.json')
    raw=json.loads(projection.read_text())
    bez=json.loads(bezout.read_text())
    assert bez['G']==[1]
    # The normal eliminate.cpp output carries its exact factor orders.
    # A G,U,V-only file can also be resealed with the already archived orders.
    entries=bez.get('unit_factors')
    if entries is None:
        entries=json.loads((ROOT/'data/global_unit_certificate.json').read_text())['unit_factors']
    factors=[{'polynomial':x['polynomial'],'orders':x['orders']} for x in entries
             if x['orders'][0] or x['orders'][1]]
    allowed=json.loads((ROOT/'data/known_unit_factors.json').read_text())['unit_factors']
    assert all(x['polynomial'] in allowed and len(x['orders'])==2 and min(x['orders'])>=0 for x in factors)
    rows=[raw['P12'],raw['P13'],bez['U'],bez['V'],bez['G']]
    for row in rows: assert row and row[-1] and all(0<=v<390625 for v in row)
    path=ROOT/'data/global_unit_certificate.bin'
    with path.open('wb') as f:
        f.write(b'CMP140C1');f.write(struct.pack('<II',1,len(rows)))
        for row in rows:
            f.write(struct.pack('<Q',len(row)))
            for start in range(0,len(row),65536):
                v=array.array('I',row[start:start+65536]);assert v.itemsize==4
                if sys.byteorder!='little':v.byteswap()
                f.write(v.tobytes())
    rd=[len(rows[j])-1-sum((len(x['polynomial'])-1)*x['orders'][j] for x in factors) for j in range(2)]
    doc={'format':'CMP140C1','version':1,'field':'K codes from FULL_INPUT.md',
         'row_order':['P12','P13','U','V','G'],'degrees':[len(r)-1 for r in rows],
         'unit_factors':factors,'reduced_degrees':rd,
         'identity':'U*(P12/product f^orders[0])+V*(P13/product f^orders[1])=G=1',
         'certificate_sha256':hashlib.file_digest(path.open('rb'),'sha256').hexdigest(),
         'raw_projection_json_sha256':hashlib.file_digest(projection.open('rb'),'sha256').hexdigest(),
         'bezout_rows_json_sha256':hashlib.sha256((json.dumps({k:bez[k] for k in ('G','U','V')},separators=(',',':'))+'\n').encode()).hexdigest(),
         'binary_format':'8-byte ASCII magic; uint32 LE version; uint32 LE row count; for each row uint64 LE length then that many uint32 LE ascending K codes'}
    (ROOT/'data/global_unit_certificate.json').write_text(json.dumps(doc,indent=2)+'\n')
    print(json.dumps({'sealed_global_certificate_degrees':doc['degrees'],'reduced_degrees':rd,'nonzero_unit_factors':len(factors),'bytes':path.stat().st_size,'sha256':doc['certificate_sha256']}))

if __name__=='__main__':
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--projection');ap.add_argument('--bezout');args=ap.parse_args()
    seal(args.projection,args.bezout)
