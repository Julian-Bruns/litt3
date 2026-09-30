"""Reproduce labelled diagnostic maps, which are not requested witnesses."""
import json,tempfile,shutil,subprocess,sys
from pathlib import Path
from evaluate_f25 import evaluate
ROOT=Path(__file__).resolve().parents[1]
def main():
    result=evaluate([0]*10+[16,22,12,7,21,1],all_maps=True)
    saved=json.loads((ROOT/'data/sanity_maps.json').read_text())
    assert result==saved
    assert result['T_rank']==28 and result['Q_rank']==12
    assert all(m['generic_rank']==1 and m['global_obstructions_zero'] for m in result['maps'])
    print('PASS: all seven full-kernel diagnostic maps reconstructed exactly; Hom dimensions 7 and 4; generic ranks all one')
    with tempfile.TemporaryDirectory() as td:
        td=Path(td);(td/'src').mkdir();(td/'data').mkdir()
        for f in ['branch_sanity.py','exact.py']:shutil.copy2(ROOT/'src'/f,td/'src'/f)
        for f in ['pencils.npz','middle_system.npz','unmatched.npz']:shutil.copy2(ROOT/'data'/f,td/'data'/f)
        subprocess.run([sys.executable,str(td/'src/branch_sanity.py')],check=True)
        assert json.loads((td/'data/branch_sanity.json').read_text())==json.loads((ROOT/'data/branch_sanity.json').read_text())
    print('PASS: four specified branch-point connecting-image diagnostics reproduced; not an exhaustive search')
if __name__=='__main__':main()
