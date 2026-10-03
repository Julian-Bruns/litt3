#!/usr/bin/env python3
"""Reuse exact matrix while removing the m6 leading coefficient from units."""
import argparse,json,os,shutil
from pathlib import Path
import numpy as np
p=argparse.ArgumentParser();p.add_argument('directory',type=Path);a=p.parse_args();src=a.directory;root=int(json.loads((src/'metadata.json').read_text())['root']);dst=src.parent/f'native_smallcritical_module_{root}';dst.mkdir(exist_ok=True)
for name in ('header.bin','matrix.bin','kernel.bin','logs.bin','exps.bin','addhalf.bin','fixtures.bin','fixtures.json'):
    target=dst/name
    if not target.exists():target.symlink_to((src/name).resolve())
raw=np.fromfile(src/'units.bin',dtype='<u4');pos=0;units=[]
while pos<len(raw):
    n=int(raw[pos]);pos+=1;units.append(raw[pos:pos+n].tolist());pos+=n
assert len(units)==3
units=[units[0],units[2]];out=[]
for f in units:out.append(len(f));out.extend(f)
np.array(out,dtype='<u4').tofile(dst/'units.bin');(dst/'units.json').write_text(json.dumps(units)+'\n')
meta=json.loads((src/'metadata.json').read_text());meta['units']='H, nonzero selected critical leading; exact m6 leading NOT inverted';meta['source_matrix']=str(src/'matrix.bin');meta['scope']='same concentrated source family allowing S4 exact pole3 or6';(dst/'metadata.json').write_text(json.dumps(meta)+'\n')
shutil.copyfile(src/'native_source.cpp' if (src/'native_source.cpp').exists() else Path('scripts/oct01_nonzero_source/native_d10m6_module.cpp'),dst/'native_source.cpp');print(dst)
