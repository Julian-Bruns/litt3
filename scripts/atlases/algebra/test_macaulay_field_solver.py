#!/usr/bin/env python3
"""Small exact primal/dual regression tests. Run with sage -python."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import json
import subprocess
import sys
import tempfile
from pathlib import Path
from sage.all import GF, PolynomialRing
from scripts.atlases.algebra.export_polynomial_macaulay import export_system

scripts=Path(__file__).resolve().parent
work=Path(tempfile.mkdtemp(prefix='litt3-field-solver-test-'))
K=GF(25,'a',modulus=PolynomialRing(GF(5),'z')([-2,0,1]))
a=K.gen();R=PolynomialRing(K,'x,y');x,y=R.gens()
for label,equations,kind in [
    ('unit',[x*x-a,x*y-1,y*y-a],'primal'),
    ('point',[x*y-1,x*x-a],'dual')]:
    folder=work/label
    export_system(R,equations,folder,c_degree=0,full_degree=2,field_only=True)
    subprocess.run([sys.executable,str(scripts/'diagnose_macaulay_field_support.py'),
                    str(folder/'source.json'),'--receipt',str(folder/'peeling.json')],check=True)
    subprocess.run([sys.executable,str(scripts/'solve_macaulay_field_dual.py'),
                    str(folder/'source.json'),str(folder/'peeling.json'),str(folder/'solve')],check=True)
    result=json.loads((folder/'solve/result.json').read_text())
    assert result['stage']=='original_field_'+kind+'_constructed',result
    certificate=folder/'solve'/('primal.json' if kind=='primal' else 'dual.bin')
    subprocess.run(['python3',str(scripts/'verify_field_macaulay_certificate.py'),
                    str(folder/'source.json'),str(certificate),'--kind',kind],check=True)
    if label=='unit':
        low_peel=folder/'peeling_low2.json'
        subprocess.run([sys.executable,str(scripts/'diagnose_macaulay_field_support.py'),
            str(folder/'source.json'),'--preserve-degree','2','--receipt',str(low_peel)],check=True)
        for rule,engine in [('column','python'),('markowitz','python'),('column','cython')]:
            low_out=folder/('low_consequences_'+rule+'_'+engine)
            subprocess.run([sys.executable,str(scripts/'extract_macaulay_low_degree.py'),
                str(folder/'source.json'),str(low_peel),str(low_out),'--degree','2',
                '--consequence-form','sparsest','--certificates','0','--pivot-rule',rule,'--engine',engine],check=True)
            assert json.loads((low_out/'result.json').read_text())['unit_candidate']
            subprocess.run(['python3',str(scripts/'verify_field_macaulay_certificate.py'),
                str(folder/'source.json'),str(low_out/'unit.json'),'--kind','primal'],check=True)
        partial=folder/'partial_cython';resumed=folder/'resumed_cython'
        subprocess.run([sys.executable,str(scripts/'extract_macaulay_low_degree.py'),
            str(folder/'source.json'),str(low_peel),str(partial),'--degree','2',
            '--pivot-limit','2','--engine','cython','--consequence-form','sparsest','--certificates','0'],check=True)
        assert (partial/'checkpoint.pickle').is_file()
        subprocess.run([sys.executable,str(scripts/'extract_macaulay_low_degree.py'),
            str(folder/'source.json'),str(low_peel),str(resumed),'--degree','2',
            '--resume',str(partial/'checkpoint.pickle'),'--engine','cython',
            '--consequence-form','sparsest','--certificates','0'],check=True)
        complete=folder/'low_consequences_column_cython'
        assert (resumed/'unit.json').read_bytes()==(complete/'unit.json').read_bytes()
        print('CHECKPOINT_RESUME_IDENTICAL_CERTIFICATE_PASS',flush=True)
print('INDEPENDENT_PRIMAL_AND_DUAL_REPLAY_PASS',work,flush=True)

# Recursive affine elimination must retain special cases and reveal old
# nonlinear rows which become linear after a substitution. No division by
# an unknown polynomial is allowed in this preprocessing.
S=PolynomialRing(K,'x,y,z,w',order='degrevlex');x,y,z,w=S.gens()
folder=work/'recursive_affine'
export_system(S,[x-a,x*y-z,y+1,w*w-1],folder,field_only=True,full_degree=1)
data=json.loads((folder/'source.json').read_text())
assert len(data['linear_substitution_stages'])==2
subs={S(v):S({tuple(e):K(c) for e,c in f}) for v,f in data['substitutions'].items()}
assert set(subs)=={x,y,z} and subs[x]==a and subs[y]==-1 and subs[z]==-a
assert all(f.subs(subs)==0 for f in [x-a,x*y-z,y+1])
print('RECURSIVE_AFFINE_SUBSTITUTION_REPLAY_PASS',flush=True)
