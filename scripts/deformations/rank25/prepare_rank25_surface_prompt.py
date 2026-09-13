"""Prepare a compact two-parameter W5 problem from accepted finite W4 data."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import hashlib
import io
import json
from pathlib import Path
import zipfile

from scripts.deformations.rank25 import rank25_pro_data_model as m
from scripts.deformations.rank25.prepare_rank25_one_parameter import solve_many, pack, code

Z,O=m.ZERO,m.ONE


def plus(a,b):
    c=dict(a)
    for e,v in b.items():c[e]=m.add(c.get(e,Z),v)
    return {e:v for e,v in c.items() if v!=Z}


def scale(a,c):return {e:m.mul(v,c) for e,v in a.items() if m.mul(v,c)!=Z}


def times(a,b):
    c={}
    for i,v in a.items():
        for j,w in b.items():c=plus(c,{tuple(x+y for x,y in zip(i,j)):m.mul(v,w)})
    return c


def frob(a):return {tuple(5*i for i in e):m.power(v,5) for e,v in a.items()}


def evaluate(block,x):
    y=[frob(v) for v in x]
    out=[{(0,0):v} if v!=Z else {} for v in block['constant']]
    def put(row,p):
        for i,c in enumerate(row):out[i]=plus(out[i],scale(p,c))
    for i,row in enumerate(block['ordinary']):put(row,x[i])
    for i,row in enumerate(block['frobenius']):put(row,y[i])
    for i,j,row in block['quadratic']:put(row,times(y[i],y[j]))
    return out


def univariate(p):
    out={}
    for (a,b),c in p.items():out=plus(out,{(b-2*a,):c})
    return {e[0]:c for e,c in out.items()}


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('returned',type=Path)
    args=p.parse_args();root=Path(__file__).resolve().parents[3]
    old=Path('/Users/julian/Documents/litt3-computation-data/rank25-two-family-returns-20260912-rpDDk0/second/rank25_family_partial_audit')
    d,fourth,repairs=m.load(old)
    u0=(2,1,3,0);alpha=(4,3,3,1);beta=(2,2,3,4);kap=(3,1,1,2)
    # Surface coordinates (s,lambda); original x0=u0+s^5 and x6=lambda^5.
    x=[{(0,0):u0,(5,0):O},{(0,5):alpha},{(0,5):beta},
       {(0,0):(3,0,0,3)},{(0,0):(0,3,1,4)},{(0,5):kap},{(0,5):O},{},{}]
    assert not any(evaluate(fourth['obstruction'],x))
    y=[frob(v) for v in x]
    J=[[{(0,0):fourth['obstruction']['frobenius'][j][i]} if fourth['obstruction']['frobenius'][j][i]!=Z else {}
        for j in range(9)] for i in range(9)]
    for a,b,row in fourth['obstruction']['quadratic']:
        for i,c in enumerate(row):
            J[i][a]=plus(J[i][a],scale(y[b],c))
            J[i][b]=plus(J[i][b],scale(y[a],c))
    # The complete relative matrix, formed before restricting to the surface.
    je=sorted(set().union(*(set(p) for row in J for p in row)))
    Jcoeff=[[[J[i][j].get(e,Z) for j in range(9)] for i in range(9)] for e in je]
    R=[Z]*9;R[3]=(3,0,0,0);R[4]=O;R[7]=(1,0,4,1);R[8]=(0,2,3,0)
    assert all(m.mv(list(zip(*mat)),R)==[Z]*9 for mat in Jcoeff)
    assert not any(J[0])
    # The fixed sK pivot is lambda^25*K in these parameter coordinates.
    K=[[(2,0,1,3),(1,0,4,1)],[(3,2,4,3),(2,2,3,1)]]
    assert all(J[7+i][7+j]=={(0,25):K[i][j]} for i in range(2) for j in range(2))
    normal=evaluate(fourth['normal_on_candidates'],x)
    exponents=sorted(set().union(*(set(v) for v in normal)))
    rhs=[[v.get(e,Z) for v in normal] for e in exponents]
    solutions,pivots=solve_many(d['hodge_matrix'],rhs)
    zeta=[[m.power(c,125) for c in row] for row in solutions]
    assert all(all(i%5==0 for i in e) for e in exponents)
    oldin=json.loads((args.returned/'RANK25_ONE_PARAMETER_COMPLETED/inputs/inputs.json').read_text())
    oldparsed=m.unpack(oldin)
    # Reuse the exact previously submitted particular fourth-origin convention.
    newcurve=[{} for _ in range(75)]
    for e,row in zip(exponents,zeta):
        se=tuple(i//5 for i in e)
        for i,c in enumerate(row):newcurve[i]=plus(newcurve[i],{(se[1]-2*se[0],):c})
    oldcurve=[{} for _ in range(75)]
    for e,row in oldparsed['fourth_digit']:
        for i,c in enumerate(row):oldcurve[i]=plus(oldcurve[i],{(e,):c})
    assert newcurve==oldcurve
    affine={}
    def putaff(e,row,factor):
        out=affine.setdefault(e,{})
        for *mon,c in row:
            mon=tuple(mon);out[mon]=m.add(out.get(mon,Z),m.mul(factor,c))
    putaff((0,0),repairs[0],O)
    for i,poly in enumerate(x[:7]):
        for e,c in frob(poly).items():putaff(e,repairs[i+1],c)
    affine_records=[[*e,[list(mon)+[code(c)] for mon,c in sorted(row.items()) if c!=Z]]
                    for e,row in sorted(affine.items()) if any(c!=Z for c in row.values())]
    omega=m.mv(list(zip(*d['obstruction_dual_rows'])),R)
    assert omega==oldparsed['dual_row']
    # Candidate trace restricts to the previously known polynomial, not a new geometric proof.
    ck=m.power((2,1,1,0),5)
    candidate={(25,50):ck,(0,0):m.neg(ck)}
    assert univariate(candidate)=={}
    payload={
      'field_polynomial':[3,4,1,4,1],
      'parameters':'(s,lambda), lambda!=0; x0=(2+t+3t^2)+s^5, x6=lambda^5; exponent pairs below in (s,lambda)',
      'matrix':pack(d['hodge_matrix']),'kernel':pack(d['kernel_basis']),
      'dual':pack(d['obstruction_dual_rows']), 'xi_origin':oldin['xi_origin'],
      'direction':oldin['direction'],'nu0':oldin['nu0'],'u0':code(u0),'omega':pack(omega),
      'relative_J':[[*e,pack(mat)] for e,mat in zip(je,Jcoeff)],
      'normal4':[[*e,pack(row)] for e,row in zip(exponents,rhs)],
      'fourth_digit':[[*(i//5 for i in e),pack(row)] for e,row in zip(exponents,zeta)],
      'first_affine_primitive':affine_records,
      'candidate_trace_NOT_PROVED':[[*e,code(v)] for e,v in candidate.items()],
      'known_curve_L':{}
    }
    zero=json.loads((args.returned/'RANK25_ONE_PARAMETER_COMPLETED/generated/zero_certificate.json').read_text())
    payload['known_curve_L']=zero['coefficients'];payload['known_curve_G']=zero['reduced_zero_polynomial']
    payload['G_irreducible_factors']=zero['monic_irreducible_factors_over_F625']
    payload['known_excluded_root']={'lambda':code((3,2,2,2)),
        'quotient':[0,0,code((0,4,2,2)),code((3,0,4,4))],
        'negative_root':'also excluded by the marked involution'}
    leverage=json.loads((root/'Research/computations/rank25_surface_trace_leverage.json').read_text())
    payload['optional_replacement_fourth_digit_10_0']=leverage['optional_replacement_fourth_digit_10_0']
    payload['filtered_fourth_source_degrees']=[[*v['fourth_digit_exponent'],v['minimal_source_AS_degree']]
                                             for v in leverage['filtered_fourth_solves']]
    payload['mixed_cubic_trace_coefficient_s25_lambda50']=code((3,0,4,0))
    payload['trace_support_SUGGESTION_NOT_PROVED']=[[0,0],[25,0],[0,50],[25,50]]
    exclusion=json.loads((root/'Research/computations/rank25_one_parameter_full_exclusion.json').read_text())
    assert exclusion['status'].startswith('PASS') and exclusion['root_count']==30
    payload['established_curve_exclusion']={key:exclusion[key] for key in (
        'G_monic','residual_polynomials_mod_G','separating_combination_coefficient',
        'bezout_G','bezout_separator')}
    payload['established_curve_exclusion']['scope']='Every geometric lambda!=0 on s=lambda^-2; all fourth choices.'
    # Keep only the new problem's finite inputs, not returned code or receipts.
    files={'surface.json':(json.dumps(payload,separators=(',',':'))+'\n').encode(),
           'algebra.py':(root/'scripts/deformations/rank25/rank25_surface_algebra.py').read_bytes(),
           'README.md':('Two-parameter finite W4 inputs, not a fifth-level engine.\n\n'
             'Fields use a0+5*a1+25*a2+125*a3 for a0+a1*t+a2*t^2+a3*t^3.\n'
             'Sparse tensors: row-major shape/nonzero; omitted entries are zero.\n'
             'Every exponent pair is (s,lambda), NOT original x coordinates.\n'
             'normal4/fourth_digit/relative_J entries: [s_power,lambda_power,tensor].\n'
             'Affine primitive entries: [s_power,lambda_power,terms], with each term\n'
             '[w1_power,w2_power,v_power,u_power,field_code].\n'
             'The kernel is a list of9 rows; M and J act on column vectors.\n'
             'On s=lambda^-2, the fourth digit agrees exactly with the previous\n'
             'one-parameter input. The claimed trace formula is a candidate.\n'
             'The entire curve s=lambda^-2 has already been excluded geometrically;\n'
             'established_curve_exclusion contains its finite Bezout identity.\n'
             'optional_replacement_fourth_digit_10_0 REPLACES only the s^10 coefficient;\n'
             'it is another solution of the same fourth equation, of AS degree2.\n'
             'The fifth obstruction requires actual regular Hodge generators.\n').encode()}
    archive=root/'Research/pro_inputs/rank25_surface_fifth_inputs.zip'
    stream=io.BytesIO()
    with zipfile.ZipFile(stream,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for name,data in files.items():z.writestr(name,data)
    blob=stream.getvalue();assert len(blob)<=20000,len(blob);archive.write_bytes(blob)
    result={'status':'PASS finite two-parameter preparation; no universal fifth trace inferred',
            'surface_F4_identically_zero':True,'full_relative_matrix_restricted_before_quotient':True,
            'normal4_exponents':exponents,'fourth_digit_equations':'all coefficients checked',
            'curve_fourth_origin_exactly_preserved':True,'first_primitive_sectors':[row[:2] for row in affine_records],
            'relative_J_exponents':je,'constant_Omega_annihilates_relative_J':True,
            'candidate_trace_constant':ck,'archive':str(archive),'archive_bytes':len(blob),
            'uncompressed_bytes':sum(map(len,files.values())),'files':{n:len(v) for n,v in files.items()},
            'sha256':hashlib.sha256(blob).hexdigest(),
            'leverage':'A two-dimensional W5-locus verdict. The whole curve s=lambda^-2 is now excluded; a uniform trace theorem would finish the surface. Support and divided-carry mechanism remain unproved.'}
    (root/'Research/computations/rank25_surface_prompt_checks.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))


if __name__=='__main__':main()
