"""Exact restriction-of-scalars adapter for the existing F25 Krylov finder.

Input is an actual finite-field polynomial system, not an atlas tensor.
The exported matrix has PRIME-field entries. Extending it to the finder's
F25 is harmless; the constant coefficient of a primal is an F5 primal.
Generated data belong outside the research library.
"""
import array
import hashlib
import itertools
import json
import struct
import time
from pathlib import Path


def export_system(ring, equations, folder, c_degree=3, field_only=False,
                  full_degree=1, mixed_linear_c_degree=0,eliminate_linear=True):
    from sage.all import PolynomialRing
    started=time.monotonic()
    c_degree=int(c_degree);full_degree=int(full_degree)
    mixed_linear_c_degree=int(mixed_linear_c_degree)
    folder=Path(folder)
    folder.mkdir(exist_ok=False)
    field=ring.base_ring()
    p=int(field.characteristic()); degree=int(field.degree())
    assert p==5
    def coeff(c):
        data=[int(v) for v in field(c).polynomial().list()]
        return data+[0]*(degree-len(data))
    def encoded(poly):
        return [[list(exponent),coeff(c)] for exponent,c in sorted(poly.dict().items())]

    original=[f for f in equations if f]
    # A18's tracked affine elimination must be iterated: substituting the
    # first linear block can expose new linear equations among the old
    # quadratic rows. A single pass left three such equations in degree84.
    substitutions={};linear_stages=[];current=list(original)
    while eliminate_linear:
        linear=[f for f in current if f.total_degree()==1]
        if not linear:break
        gb=list(ring.ideal(linear).groebner_basis())
        if any(g and g.total_degree()==0 for g in gb):
            raise ValueError('Linear equations already give a unit: extract their original-row certificate first')
        fresh={}
        for g in gb:
            assert g.total_degree()==1
            variable=g.lm().variables()[0]
            assert variable not in substitutions
            fresh[variable]=variable-g/g.monomial_coefficient(variable)
        assert fresh and all(not set(s.variables()).intersection(fresh) for s in fresh.values())
        assert all(g.subs(fresh)==0 for g in gb)
        linear_stages.append({str(v):encoded(s) for v,s in fresh.items()})
        substitutions={v:s.subs(fresh) for v,s in substitutions.items()}
        substitutions.update(fresh)
        current=[f.subs(fresh) for f in current]
        current=[f for f in current if f]
    assert all(not set(s.variables()).intersection(substitutions) for s in substitutions.values())
    remaining=[v for v in ring.gens() if v not in substitutions]
    # Explicit arity keeps tuple-valued exponent dictionaries even when
    # affine elimination leaves only one variable.
    small=PolynomialRing(field,len(remaining),names=[str(v) for v in remaining],order='degrevlex')
    positions=[ring.gens().index(v) for v in remaining]
    reduced=[]
    for f in original:
        ff=f.subs(substitutions)
        data={tuple(exponent[j] for j in positions):c for exponent,c in ff.dict().items()}
        q=small(data)
        assert ring(q)==ff
        if q and q not in reduced:
            reduced.append(q)
    n=small.ngens()
    zero=tuple([0]*n)
    multipliers={zero}
    for i in range(n):
        exponent=[0]*n; exponent[i]=1; multipliers.add(tuple(exponent))
    c_positions=[i for i,name in enumerate(small.variable_names()) if name.startswith('c')]
    for d in range(2,c_degree+1):
        for indices in itertools.combinations_with_replacement(c_positions,d):
            exponent=[0]*n
            for i in indices: exponent[i]+=1
            multipliers.add(tuple(exponent))
    for d in range(2,full_degree+1):
        for indices in itertools.combinations_with_replacement(range(n),d):
            exponent=[0]*n
            for i in indices: exponent[i]+=1
            multipliers.add(tuple(exponent))
    # Cross terms can cancel B^3*C^d passport terms against a B-multiple
    # of the B^2 derivative relation; C-only multipliers cannot do this.
    for d in range(1,mixed_linear_c_degree+1):
        for indices in itertools.combinations_with_replacement(c_positions,d):
            for j in range(n):
                exponent=[0]*n;exponent[j]=1
                for i in indices:exponent[i]+=1
                multipliers.add(tuple(exponent))
    multipliers=sorted(multipliers,key=lambda e:(sum(e),e))
    assert multipliers[0]==zero
    term_polys=[sorted(q.dict().items()) for q in reduced]
    base_monomials=sorted({e for terms in term_polys for e,c in terms})
    monomials={tuple(a+b for a,b in zip(e,m)) for m in multipliers for e in base_monomials}
    assert zero in monomials
    monomials=sorted(monomials,key=lambda e:(sum(e),e))
    monomial_index={m:i for i,m in enumerate(monomials)}
    nc=len(monomials)*degree
    target=monomial_index[zero]*degree
    def col(m,j):
        x=monomial_index[m]*degree+j
        return nc-1 if x==target else target if x==nc-1 else x

    powers=[field.gen()**j for j in range(degree)]
    cache={}
    rows=[]
    for terms in term_polys:
        for power in powers:
            row=[]
            for exponent,c in terms:
                key=(c,power)
                if key not in cache: cache[key]=coeff(c*power)
                row.extend((exponent,j,v) for j,v in enumerate(cache[key]) if v)
            rows.append(row)
    neq=len(rows); nr=neq*len(multipliers)
    nnz=sum(map(len,rows))*len(multipliers)
    source=dict(schema=1,scope='Necessary degree84 system, exact linear substitution and bounded multiplier ansatz',
        prime=p,field_degree=degree,field_modulus=[int(v) for v in field.modulus().list()],
        original_variables=list(ring.variable_names()),original_equations=[encoded(f) for f in original],
        substitutions={str(v):encoded(s) for v,s in substitutions.items()},
        variables=list(small.variable_names()),equations=[encoded(f) for f in reduced],
        multipliers=[list(m) for m in multipliers],monomials=[list(m) for m in monomials],
        original_target_column=target,rows=nr,columns=nc,base_rows=neq,
        equations_count=len(reduced),nonzeros=nnz,c_degree=c_degree,
        full_degree=full_degree,mixed_linear_c_degree=mixed_linear_c_degree)
    source['eliminate_linear']=bool(eliminate_linear)
    source['linear_substitution_stages']=linear_stages
    source_path=folder/'source.json'
    source_path.write_text(json.dumps(source,separators=(',',':'))+'\n')
    if field_only:
        receipt=dict(stage='field_source_export_complete',rows=nr,columns=nc,
            field_rows=len(reduced)*len(multipliers),field_monomials=len(monomials),
            nonzeros=nnz,base_rows=neq,
            source_sha256=hashlib.sha256(source_path.read_bytes()).hexdigest(),
            seconds=time.monotonic()-started)
        (folder/'export.json').write_text(json.dumps(receipt,indent=2)+'\n')
        print(json.dumps(receipt),flush=True)
        return receipt
    print(json.dumps(dict(stage='export_plan',variables=n,equations=len(reduced),
        field_degree=degree,base_monomials=len(base_monomials),multipliers=len(multipliers),
        rows=nr,columns=nc,nonzeros=nnz,matrix_bytes=8+4*nr+5*nnz,
        dense_table_bytes=12*neq*len(base_monomials)*degree,
        seconds=time.monotonic()-started)),flush=True)
    path=folder/'matrix.bin'
    with path.open('wb') as stream:
        stream.write(struct.pack('<II',nr,nc))
        for mi,m in enumerate(multipliers):
            destinations={(e,j):col(tuple(a+b for a,b in zip(e,m)),j)
                          for e in base_monomials for j in range(degree)}
            for row in rows:
                indices=array.array('I',(destinations[e,j] for e,j,v in row))
                stream.write(struct.pack('<I',len(row)))
                stream.write(indices.tobytes())
                stream.write(bytes(v for e,j,v in row))
            if mi%10==0:
                print(json.dumps(dict(stage='matrix_export',multipliers_done=mi+1,
                      multipliers_total=len(multipliers),seconds=time.monotonic()-started)),flush=True)
    digest=hashlib.sha256()
    with path.open('rb') as stream:
        for block in iter(lambda:stream.read(1024*1024),b''): digest.update(block)
    receipt=dict(stage='export_complete',rows=nr,columns=nc,base_rows=neq,nonzeros=nnz,
                 matrix_sha256=digest.hexdigest(),source_sha256=hashlib.sha256(source_path.read_bytes()).hexdigest(),
                 seconds=time.monotonic()-started)
    (folder/'export.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt),flush=True)
    return receipt
