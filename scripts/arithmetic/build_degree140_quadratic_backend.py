#!/usr/bin/env python3
"""Build the exact quadratic-coefficient variant in an external evidence tree."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
from degree140_quadratic_field import CPP_BACKEND,install


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('verified_workspace',type=Path)
    ap.add_argument('output_workspace',type=Path)
    a=ap.parse_args();source=a.verified_workspace.resolve();out=a.output_workspace.resolve()
    if 'litt3-computation-data' not in out.parts:raise ValueError('external evidence tree required')
    out.mkdir(exist_ok=False)
    for folder in ('src','data','certificates','logs'):(out/folder).mkdir()
    sources={}
    for p in (source/'src').iterdir():
        if p.suffix in ('.py','.cpp','.hpp'):
            shutil.copyfile(p,out/'src'/p.name)
            sources[p.name]=hashlib.sha256(p.read_bytes()).hexdigest()
    for name in ('field_log.bin','field_exp.bin','field_add.bin','spaces.json','charts.json','exceptional.json','boundary_series.json'):
        shutil.copyfile(source/'data'/name,out/'data'/name)
    p=out/'src/fast.hpp';s=p.read_text();start=s.index('using F=int32_t;');end=s.index('struct Poly:')
    p.write_text(s[:start]+CPP_BACKEND+s[end:])
    for name in ('parametric_eval.cpp','interpolate.cpp','verify_big.cpp'):
        p=out/'src'/name;s=p.read_text()
        s=s.replace('4*vals.size()','sizeof(F)*vals.size()').replace('4*(int64_t)vals.size()','(int64_t)sizeof(F)*(int64_t)vals.size()').replace('4*out.size()','sizeof(F)*out.size()')
        p.write_text(s)
    for exe in ('residual','parametric_eval','interpolate','verify_big'):
        cmd=['/opt/homebrew/opt/llvm/bin/clang++','-O3','-std=c++17']
        if exe=='parametric_eval':cmd+=['-fopenmp','-I/opt/homebrew/opt/libomp/include','-L/opt/homebrew/opt/libomp/lib','-Wl,-rpath,/opt/homebrew/opt/libomp/lib']
        cmd+=[str(out/'src'/f'{exe}.cpp'),'-o',str(out/'src'/exe)]
        subprocess.run(cmd,check=True)
    sys.path.insert(0,str(out/'src'));import ff
    install(ff)
    rows=[]
    for i in range(1,161):
        x=(i*12917)%390625+390625*((i*3571)%390625)
        y=(i*21101+3)%390625+390625*((i*1291+7)%390625)
        rows.append([x,y,ff.add(x,y),ff.mul(x,y),ff.div(x,y),ff.powf(x,5),ff.powf(x,390625)])
    (out/'data/quadratic_backend_checks.json').write_text(json.dumps({'encoding':'a+390625*b represents a+b*sqrt(alpha)','nonresidue':25,'checks':rows},indent=2)+'\n')
    (out/'data/quadratic_backend_checks.txt').write_text('\n'.join(' '.join(map(str,r)) for r in rows)+'\n')
    test=r'''#include "fast.hpp"
using namespace exact;
int main(int argc,char**argv){loadfield(argv[1]);std::ifstream in(argv[2]);F a,b,s,m,d,p,c;int n=0;
while(in>>a>>b>>s>>m>>d>>p>>c){if(add(a,b)!=s||mul(a,b)!=m||divide(a,b)!=d||power(a,5)!=p||power(a,390625)!=c)return 1;n++;}
if(n!=160)return 2;std::cout<<"PASS: 160 independent Python/C++ quadratic-field cases and Frobenius conjugates\n";}
'''
    (out/'src/check_quadratic_backend.cpp').write_text(test)
    subprocess.run(['/opt/homebrew/opt/llvm/bin/clang++','-O2','-std=c++17',str(out/'src/check_quadratic_backend.cpp'),'-o',str(out/'src/check_quadratic_backend')],check=True)
    subprocess.run([str(out/'src/check_quadratic_backend'),str(out/'data'),str(out/'data/quadratic_backend_checks.txt')],check=True)
    manifest={'original_source_sha256':sources,'modified_source_sha256':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (out/'src').iterdir() if p.suffix in ('.cpp','.hpp')},'changes':'Only scalar backend and native binary element widths; resultant, interpolation and Bezout algorithms retained.'}
    (out/'data/backend_provenance.json').write_text(json.dumps(manifest,indent=2)+'\n')


if __name__=='__main__':main()
