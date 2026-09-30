#!/usr/bin/env python3
"""Package only the arithmetic/chart/primary inputs for a fresh sixth task.

The original evidence is untouched. The only source trims remove the old
fourth CLI/comparison driver and base report formatting; mathematical
constructors and all their checks are preserved byte-for-byte.
"""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import zipfile


def trim_source(name, source):
    tree=ast.parse(source);lines=source.splitlines(keepends=True);edits=[]
    if name=='rank125_fourth.py':
        for node in tree.body:
            if isinstance(node,ast.ClassDef) and node.name=='Calculation':
                for method in node.body:
                    if isinstance(method,ast.FunctionDef) and method.name=='compare':
                        edits.append((method.lineno-1,method.end_lineno,''))
            if isinstance(node,ast.FunctionDef) and node.name=='main':
                edits.append((node.lineno-1,node.end_lineno,''))
            if isinstance(node,ast.If) and '__name__' in ast.unparse(node.test):
                edits.append((node.lineno-1,node.end_lineno,''))
    if name=='reconstruct_base_reference.py':
        for node in tree.body:
            if isinstance(node,ast.FunctionDef) and node.name=='reconstruct':
                ret=node.body[-1];assert isinstance(ret,ast.Return)
                edits.append((ret.lineno-1,ret.end_lineno,"    return {'_objects':locals()}\n"))
            if isinstance(node,ast.FunctionDef) and node.name=='main':
                edits.append((node.lineno-1,node.end_lineno,''))
            if isinstance(node,ast.If) and '__name__' in ast.unparse(node.test):
                edits.append((node.lineno-1,node.end_lineno,''))
    for start,end,replacement in sorted(edits,reverse=True):
        lines[start:end]=[replacement]
    result=''.join(lines);ast.parse(result) if name.endswith('.py') else None
    return result,edits


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--engine-dir',type=Path,required=True)
    ap.add_argument('--output-dir',type=Path,required=True)
    args=ap.parse_args()
    assert not args.output_dir.resolve().is_relative_to(Path(__file__).resolve().parents[3])
    args.output_dir.mkdir(parents=True,exist_ok=True)
    names=['witt_cubic.py','reconstruct_base_reference.py','primary.py','field.py',
           'schur.py','batch_witt.py','exact_batch_conv.cpp','neutral5_gmp_convolution.py',
           'build_exact.py','cover_char5.py','fourth_engine.py','rank125_fourth.py',
           'normal_projection.py']
    sources={};provenance={}
    for name in names:
        original=(args.engine_dir/name).read_text()
        source,edits=trim_source(name,original) if name.endswith('.py') else (original,[])
        sources[name]=source
        provenance[name]={'original_sha256':hashlib.sha256(original.encode()).hexdigest(),
                          'packaged_sha256':hashlib.sha256(source.encode()).hexdigest(),
                          'edits':edits}
    unpack="""import json,pathlib
root=pathlib.Path(__file__).resolve().parent
for name,source in json.loads((root/'sources.json').read_text()).items():
    assert pathlib.Path(name).name==name
    (root/name).write_text(source)
print('Sources unpacked. In this directory run: python3 build_exact.py; python3 primary.py; python3 schur.py')
"""
    readme="""Run unpack_sources.py, then build_exact.py, primary.py and schur.py
in this directory. Requires NumPy, C++17 and GMP headers.
Set LITT3_REFERENCE_MODULUS=625 and LITT3_REFERENCE_PRECISION=1800
before imports. Sixth precision/tuple extensions remain the task.
Constructors and checks are unchanged; old report drivers were removed.
"""
    contents={'sources.json':json.dumps(sources,separators=(',',':')).encode(),
              'unpack_sources.py':unpack.encode(),'README.md':readme.encode()}
    output=args.output_dir/'rank125_sixth_inputs.zip'
    with zipfile.ZipFile(output,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for name,blob in contents.items():z.writestr(name,blob)
    size=output.stat().st_size
    report={'zip_bytes':size,'uncompressed_member_bytes':sum(map(len,contents.values())),
            'unbundled_source_bytes':sum(len(x.encode()) for x in sources.values()),
            'zip_sha256':hashlib.sha256(output.read_bytes()).hexdigest(),
            'source_provenance':provenance,
            'scope':'Arithmetic inputs only; no actual sixth computation or output claimed'}
    (args.output_dir/'package_provenance.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps({k:v for k,v in report.items() if k!='source_provenance'},indent=2))
    assert size<=20000,'Pro ZIP exceeds the required limit'


if __name__=='__main__':main()
