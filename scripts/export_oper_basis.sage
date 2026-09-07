#!/usr/bin/env sage
"""Import an msolve basis, specialize the coefficient field, and certify length.

The input is generated locally by msolve -g 2 from fixed_x_dormant_opers.sage.
All costly intermediate bases are checkpointed. This does not yet enumerate roots.
"""
import sys, re, json, hashlib, subprocess, shutil
from pathlib import Path
args=list(sys.argv)
invariant='--invariant' in args
stem='invariant_oper' if invariant else 'full_oper'
if '--c4-zero' in args:
    stem='c4_zero_oper'
normalized='--normalized' in args
if normalized:
    assert not invariant and '--c4-zero' not in args
    stem='normalized_oper'
elif not invariant and '--c4-zero' not in args:
    raise SystemExit('Select --normalized, --invariant, or --c4-zero; the obsolete full search was retired.')
filename=Path('Research/computations')/(stem+'_msolve.gb')
if normalized:
    run=Path('Research/computations/normalized_oper_run.json')
    if run.exists():
        filename=Path(json.loads(run.read_text())['output'])
if normalized and '--staircase-only' not in args:
    # The small separator certificate supersedes symbolic import of the4.5GB
    # raw basis. It checks ORIGINAL equations and all known multiplicities.
    sage=shutil.which('sage')
    if not sage:
        raise SystemExit('Cannot locate sage for the exact certificate pipeline.')
    root=Path('Research/computations')
    if not (root/'normalized_oper_a9_parametrization.json').exists():
        raise SystemExit('Missing cyclic parametrization; continue from STATE.md, not a giant raw-basis import.')
    jobs=[
        [sage,'scripts/certify_oper_parametrization.sage',str(root/'normalized_oper_a9_parametrization.json'),'--output',str(root/'normalized_oper_algebra_certificate.json')],
        [sage,'tests/check_oper_original_input.sage'],
        [sage,'scripts/factor_oper_parametrization.sage'],
        [sys.executable,'scripts/export_complete_oper_list.py']]
    for job in jobs:
        subprocess.run(job,check=True)
    print('Complete exact census:28990 distinct opers, total multiplicity29375. No atlas exclusion.',flush=True)
    raise SystemExit(int(0))
if normalized and (filename.stat().st_size>256*1024**2 or '--staircase-only' in args):
    # The completed file has198 million terms. Never materialize it with
    # read_text/split/Sage dictionaries: retain the source and index it in C.
    # Leading-monomial counts alone are explicitly NOT a GB certificate.
    index=Path('Research/computations/normalized_oper_basis_index.tsv')
    rows=[list(map(int,line.split())) for line in index.read_text().splitlines()]
    with filename.open() as handle:
        header=[next(handle) for _ in range(7)]
    order=re.search(r'#variable order:\s*([^\n]+)',''.join(header)).group(1)
    qnames=[v.strip() for v in order.split(',')]
    assert len(qnames)==15 and len(rows)==15845
    assert all(len(row)==33 for row in rows)
    Q=PolynomialRing(GF(5),names=qnames,order='degrevlex')
    lm=[Q.monomial(*row[18:]) for row in rows]
    assert len(set(lm))==len(lm)
    initial=Q.ideal(lm)
    assert initial.dimension()==0
    standard=sorted(initial.normal_basis())
    assert len(standard)==19290
    exponents=[tuple(m.exponents()[0]) for m in standard]
    destination=Path('Research/computations/normalized_oper_standard_monomials.tsv')
    destination.write_text(''.join('\t'.join(map(str,e))+'\n' for e in exponents))
    stdset=set(exponents); lmset={tuple(row[18:]) for row in rows}
    border=[]
    for j,name in enumerate(qnames):
        counts=dict(variable=name,standard=0,direct_rewrite=0,needs_reduction=0)
        for e in exponents:
            ee=list(e);ee[j]+=1;ee=tuple(ee)
            key='standard' if ee in stdset else 'direct_rewrite' if ee in lmset else 'needs_reduction'
            counts[key]+=1
        border.append(counts)
    digest=hashlib.sha256()
    with filename.open('rb') as handle:
        for block in iter(lambda:handle.read(8*1024**2),b''):digest.update(block)
    report=dict(status='leading_staircase_only_NOT_a_Groebner_certificate',basis_path=str(filename),
        basis_bytes=int(filename.stat().st_size),basis_sha256=digest.hexdigest(),
        polynomial_count=len(rows),term_count=sum(row[3] for row in rows),
        variables=qnames,leading_colength_F5=len(standard),expected_actual_length_F25=9645,
        standard_max_degree=max(sum(e) for e in exponents),
        standard_monomials=str(destination),multiplication_border=border)
    Path('Research/computations/normalized_oper_basis_structure.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
    print(json.dumps(report,indent=2,default=int),flush=True)
    if '--staircase-only' in args:
        raise SystemExit(int(0))
    raise SystemExit('Use --normalized without --staircase-only for the completed exact certificate/export pipeline.')
raw=filename.read_text()
order=re.search(r'#variable order:\s*([^\n]+)',raw).group(1)
qnames=[v.strip() for v in order.split(',')]
Q=PolynomialRing(GF(5),names=qnames,order='degrevlex')
body='\n'.join(line for line in raw.splitlines() if not line.startswith('#')).strip()
assert body.startswith('[') and body.endswith(']:')
Gprime=[Q(s.strip()) for s in body[1:-2].split(',') if s.strip()]
print('prime_field_basis_size',len(Gprime),flush=True)
# Reload the independently generated F25 equations. The normalized search
# uses different coordinates and must not be interpreted as the original24.
if normalized:
    P,coefficients,As,Cs,Bs,lam=load('Research/computations/'+stem+'_quotient.sobj')
    k=P.base_ring()
    a=k.gen()
    names=list(P.variable_names())
else:
    source=Path('scripts/fixed_x_dormant_opers.sage').read_text()
    sys.argv=['fixed_x_dormant_opers.sage','--build-only']+(['--invariant'] if invariant else [])
    if '--c4-zero' in args:
        sys.argv.append('--c4-zero')
    exec(compile(source,'fixed_x_dormant_opers.sage','exec'))
assert qnames==names+['zeta']
specialize=Q.hom(list(P.gens())+[P(a)],P)
projected=list(dict.fromkeys(specialize(f) for f in Gprime if specialize(f)))
save((P,projected),'Research/computations/'+stem+'_projected_basis.sobj')
J=P.ideal(projected)
G=J.groebner_basis()
save((P,list(G)),'Research/computations/'+stem+'_groebner.sobj')
assert all(J.reduce(f)==0 for f in coefficients)
assert J.dimension()==0
length=J.vector_space_dimension()
expected=55 if invariant else 29375
if '--c4-zero' in args:
    expected=330
if normalized:
    expected=9645
assert length==expected,(length,expected)
# I is contained in J; both finite quotients have the known same length.
# Therefore I=J. This is also an exact independent check on field conversion.
print('CERTIFIED F25 basis; size',len(G),'length',length,flush=True)
if '--radical' in args:
    radical=J.radical()
    RG=radical.groebner_basis()
    save((P,list(RG)),'Research/computations/'+stem+'_radical.sobj')
    print('radical_length',radical.vector_space_dimension(),flush=True)
    if '--c4-zero' in args:
        assert radical.vector_space_dimension()==55
        assert all(radical.reduce(t)==0 for t in P.gens()[8:])
        print('All c4-zero geometric solutions have A=C=0',flush=True)
