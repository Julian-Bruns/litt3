"""Run deterministic bounded arithmetic implementation audits, not locus searches."""
from pathlib import Path
import json, subprocess, sys
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'build/arithmetic_audits';OUT.mkdir(parents=True,exist_ok=True)
LOG=ROOT/'logs/arithmetic_audits';LOG.mkdir(parents=True,exist_ok=True)
records=[]
for name in ['audit_packing','audit_block_division','audit_hgcd','audit_radical','audit_finite_reduction','audit_finite_series']:
    binary=OUT/name
    compile_cmd=['g++','-O3','-std=c++17',str(ROOT/'src'/f'{name}.cpp'),'-lgmp','-o',str(binary)]
    subprocess.run(compile_cmd,check=True)
    result=subprocess.run([str(binary)],check=True,text=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
    (LOG/(name+'.log')).write_text(result.stdout)
    print(name,result.stdout,flush=True)
    records.append({'name':name,'status':'PASS','compile_command':compile_cmd,'run_command':[str(binary)],'log':(LOG/(name+'.log')).relative_to(ROOT).as_posix()})
(ROOT/'evidence/arithmetic_audits.json').write_text(json.dumps({'status':'PASS','scope':'bounded implementation audits only; not geometric-point searches or locus certificates','records':records},indent=2)+'\n')
