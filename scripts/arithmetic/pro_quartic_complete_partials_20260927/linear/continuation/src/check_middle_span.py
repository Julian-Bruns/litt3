"""Try a constant-coefficient certificate for the third-stage gap branch.

Proves a GLOBAL linear-independence statement if the recorded evaluation
matrix is invertible. This is NOT a search for square parameter points.
"""
from __future__ import annotations
import json,time,hashlib,sys,argparse
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
import field as F,poly as U,evaluate as E
from frobenius_rank import determinant


def triple(i):
    out=[]
    for label in ('h','w','lambda'):
        raw=hashlib.sha256(('r9-middle-span-v1:'+str(i)+':'+label).encode()).digest()
        out.append(1+int.from_bytes(raw,'big')%(F.ORDER-1))
    return out


def run(checkpoint=None):
    start=time.time()
    columns=list(range(16,125))+[140]
    rows=[];pars=[];echelon=[];pivots=[];candidate=0
    state=Path(checkpoint) if checkpoint else None
    if state and state.exists():
        z=json.loads(state.read_text())
        assert z['version']=='r9-middle-span-v1'
        rows,pars,echelon,pivots,candidate=[z[k] for k in ['rows','pars','echelon','pivots','candidate']]
        print('resuming at candidate',candidate,'with rank',len(rows),flush=True)
    while len(rows)<110 and candidate<200:
        h,w,lam=triple(candidate);candidate+=1
        q=F.powk(w,3)
        if q in E.INP['removed_q_K_codes']:continue
        try:dic,_,fs,_=E.cramer(h,w)
        except ValueError:continue
        if not fs[6]:continue
        R=E.residual(dic,lam)
        assert len(R)==141
        row=[R[j] for j in columns]
        red=row[:]
        for er,pivot in zip(echelon,pivots):
            a=red[pivot]
            if a:
                for j in range(pivot,110):red[j]=F.sub(red[j],F.mul(a,er[j]))
        pivot=next((j for j,c in enumerate(red) if c),None)
        if pivot is None:continue
        inv=F.inv(red[pivot]);red=[F.mul(c,inv) for c in red]
        at=next((j for j,p in enumerate(pivots) if p>pivot),len(pivots))
        pivots.insert(at,pivot);echelon.insert(at,red)
        rows.append(row)
        pars.append({'candidate_index':candidate-1,'h':h,'w':w,'lambda':lam,'q':q,'F6':fs[6]})
        if len(rows)%10==0:
            print('independent evaluation rows:',len(rows),flush=True)
            if state:
                z={'version':'r9-middle-span-v1','rows':rows,'pars':pars,'echelon':echelon,'pivots':pivots,'candidate':candidate}
                tmp=state.with_suffix('.tmp');tmp.write_text(json.dumps(z,separators=(',',':')));tmp.replace(state)
    rank=len(rows)
    val=determinant(rows) if rank==110 else 0
    assert rank==110 and val
    out={'objective':'Test a constant K-linear combination of middle coefficients against the leading coefficient',
      'statement':'The 109 coefficient functions [x^j]S_model, 16<=j<=124, together with [x^140]S_model are K-linearly independent.',
      'status':'computationally_checked_global_independence',
      'proof':'Any global K-linear relation would hold after each displayed specialization. The 110x110 evaluation matrix for R has nonzero determinant. S_model differs from R by a nonzero scalar in every displayed row, so its evaluation matrix is also invertible.',
      'coefficient_columns':columns,'parameter_rows':pars,
      'matrix_determinant_for_original_R_K_code':val,
      'candidate_rows_examined':candidate,
      'gap':'This rules out only a CONSTANT-coefficient linear certificate for the high-multiplicity gap branch. Parameter-dependent polynomial certificates and the entire square locus remain undecided.',
      'not_a_square_search':True,'seconds':round(time.time()-start,3)}
    (ROOT/'continuation/evidence/middle_span.json').write_text(json.dumps(out,indent=2)+'\n')
    print('rank 110; determinant',val,'PASS; square decision UNRESOLVED',flush=True)
if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--checkpoint');a=p.parse_args();run(a.checkpoint)
