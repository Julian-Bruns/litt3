"""Audit the partial return and prepare a genuinely smaller univariate task.

This computes fourth-level input data, not the requested fifth function.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import ast
import hashlib
import io
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import zipfile

from scripts.deformations.rank25 import rank25_pro_data_model as m
from scripts.deformations.rank25.package_rank25_all_fifth_prompt import pack as pack_lists

Z, O = m.ZERO, m.ONE
add, neg, mul, power = m.add, m.neg, m.mul, m.power


def code(c):
    return sum(v*5**i for i, v in enumerate(c))


def pack(value):
    def lists(x):
        return [lists(v) for v in x] if isinstance(x,(list,tuple)) else x
    return pack_lists(lists(value))


def plus(a, b):
    out = dict(a)
    for e, c in b.items():
        out[e] = add(out.get(e, Z), c)
    return {e: c for e, c in out.items() if c != Z}


def times(a, b):
    out = {}
    for i, c in a.items():
        for j, d in b.items():
            out = plus(out, {i+j: mul(c, d)})
    return out


def scale(a, c):
    return {e: mul(v, c) for e, v in a.items() if mul(v, c) != Z}


def frob(a):
    return {5*e: power(c, 5) for e, c in a.items()}


def vecsum(vectors):
    return [m.total(row) for row in zip(*vectors)]


def specialize(block, x):
    y = [frob(v) for v in x]
    result = [{0: c} if c != Z else {} for c in block['constant']]
    def put(vec, factor):
        for j, c in enumerate(vec):
            result[j] = plus(result[j], scale(factor, c))
    for i, row in enumerate(block['ordinary']):
        put(row, x[i])
    for i, row in enumerate(block['frobenius']):
        put(row, y[i])
    for i, j, row in block['quadratic']:
        put(row, times(y[i], y[j]))
    return result


def solve_many(matrix, right_sides):
    a = [list(row)+list(rhs) for row, rhs in zip(matrix, zip(*right_sides))]
    width = len(matrix[0])
    pivots = []
    for col in range(width):
        row = next((j for j in range(len(pivots), len(a)) if a[j][col] != Z), None)
        if row is None:
            continue
        r = len(pivots)
        a[r], a[row] = a[row], a[r]
        inverse = power(a[r][col], 623)
        a[r] = [mul(inverse, v) for v in a[r]]
        for j in range(len(a)):
            if j != r and a[j][col] != Z:
                factor = a[j][col]
                a[j] = [add(v, neg(mul(factor, w))) for v, w in zip(a[j], a[r])]
        pivots.append(col)
    assert all(all(v == Z for v in row[width:]) for row in a[len(pivots):])
    outputs = []
    for k in range(len(right_sides)):
        v = [Z]*width
        for row, col in enumerate(pivots):
            v[col] = a[row][width+k]
        assert m.mv(matrix, v) == right_sides[k]
        outputs.append(v)
    return outputs, pivots


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('returned', type=Path)
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[3]
    old = Path('/Users/julian/Documents/litt3-computation-data/rank25-two-family-returns-20260912-rpDDk0/second/rank25_family_partial_audit')
    d, fourth, repairs = m.load(old)

    # The recovered line certificate is an exact polynomial identity, but
    # its identification with a geometric cochain still lacks a producer.
    line = json.loads((args.returned/'retained_work/line_locus.json').read_text())
    equations = [{i: tuple(c) for i,c in enumerate(row) if any(c)} for row in line['polynomials']]
    bezout = [{i: tuple(c) for i,c in enumerate(row) if any(c)} for row in line['bezout']]
    certificate = {}
    for f, g in zip(equations, bezout):
        certificate = plus(certificate, times(f, g))
    assert certificate == {0: O}

    # Parameter q, later replaced by lambda^5 to clear the one inverse
    # Frobenius in solving the fourth curve digit.
    u0 = (2,1,3,0)
    alpha, beta, kappa = (4,3,3,1), (2,2,3,4), (3,1,1,2)
    x = [{0:u0, -2:O}, {1:alpha}, {1:beta}, {0:(3,0,0,3)},
         {0:(0,3,1,4)}, {1:kappa}, {1:O}, {}, {}]
    assert not any(specialize(fourth['obstruction'], x))
    origin = vecsum([d['primary_repair'],
                     [mul((3,0,0,3),c) for c in d['kernel_basis'][3]],
                     [mul((0,3,1,4),c) for c in d['kernel_basis'][4]]])
    direction = vecsum([[mul(a,c) for c in d['kernel_basis'][i]]
                        for i,a in [(1,alpha),(2,beta),(5,kappa),(6,O)]])
    nu0 = d['kernel_basis'][0]

    # A/s is constant on this curve, so the first nontrace quotient row
    # is fixed, not a rational family of 75-coordinate rows.
    b7, b8 = (4,0,1,4), (0,3,2,0)
    R = [Z]*9
    R[3], R[4], R[7], R[8] = (3,0,0,0), O, neg(b7), neg(b8)
    omega = m.mv(list(zip(*d['obstruction_dual_rows'])), R)
    y = [frob(v) for v in x]
    # J is affine in y. Contract its individual coefficient vectors.
    projected_j = [{0:m.total(mul(R[k],fourth['obstruction']['frobenius'][j][k]) for k in range(9))} for j in range(9)]
    projected_j = [{e:c for e,c in row.items() if c != Z} for row in projected_j]
    for i,j,row in fourth['obstruction']['quadratic']:
        a = m.total(mul(R[k],row[k]) for k in range(9))
        projected_j[i] = plus(projected_j[i],scale(y[j],a))
        projected_j[j] = plus(projected_j[j],scale(y[i],a))
    assert not any(projected_j)
    omega0 = d['obstruction_dual_rows'][0]
    assert m.mv(list(zip(*d['hodge_matrix'])),omega) == [Z]*75

    normal = specialize(fourth['normal_on_candidates'], x)
    exponents = sorted(set().union(*(set(v) for v in normal)))
    rhs = [[v.get(e,Z) for v in normal] for e in exponents]
    solutions, pivots = solve_many(d['hodge_matrix'],rhs)
    zeta = [[power(c,125) for c in row] for row in solutions]
    assert all(m.mv(d['hodge_matrix'],[power(c,5) for c in row]) == target
               for row,target in zip(zeta,rhs))

    # Actual affine first-Hodge primitive, not a chosen cohomology class.
    # Powers are in lambda: x_i^5 now has exponent 25 times its q exponent.
    affine = {}
    def add_affine(exponent, row, factor):
        bucket = affine.setdefault(exponent,{})
        for *mon,c in row:
            key = tuple(mon)
            bucket[key] = add(bucket.get(key,Z),mul(factor,c))
    add_affine(0,repairs[0],O)
    for i, polynomial in enumerate(x[:7]):
        for e,c in frob(polynomial).items():
            add_affine(5*e,repairs[i+1],c)
    affine_records = [[e,[list(mon)+[code(c)] for mon,c in sorted(row.items()) if c!=Z]]
                      for e,row in sorted(affine.items()) if any(c!=Z for c in row.values())]

    # Retained trace data now have a formal algebra check on this curve.
    # This is NOT a new proof that those data are the geometric trace.
    trace = json.loads((args.returned/'retained_work/universal_trace.json').read_text())
    dirs = [x[0],x[1],x[2],{}, {},x[6]]
    restriction = {}
    for row in trace['terms']:
        v = {0:tuple(row['coefficient'])}
        for level,i in row['monomial']:
            factor = dirs[i]
            for _ in range(level):factor=frob(factor)
            v = times(v,factor)
        restriction = plus(restriction,v)
    assert restriction == {}

    payload = {
        'field_polynomial':[3,4,1,4,1],
        'parameter':'lambda !=0, q=lambda^5; all exponent labels below refer to lambda unless explicitly stated',
        'matrix':pack(d['hodge_matrix']), 'xi_origin':pack(origin),
        'direction':pack(direction), 'nu0':pack(nu0), 'u0':code(u0),
        'dual_row':pack(omega),
        'normal4':[[5*e,pack(row)] for e,row in zip(exponents,rhs)],
        'fourth_digit':[[e,pack(row)] for e,row in zip(exponents,zeta)],
        'first_affine_primitive':affine_records,
        'known_at_lambda1':{'L':code((2,0,1,0))},
    }
    blob = json.dumps(payload,separators=(',',':')).encode()+b'\n'
    files = {
        'inputs.json':blob,
        'algebra.py':(root/'scripts/deformations/rank25/rank25_one_parameter_algebra.py').read_bytes(),
        'README.md':(
            '# One scalar function on one rank25 curve\n\n'
            'Finite inputs only, not a fifth-level replay engine. No prior reports are needed.\n'
            'Field coefficients use a0+5*a1+25*a2+125*a3 for a0+a1*t+a2*t²+a3*t³.\n'
            'Sparse tensors use row-major indices; omitted entries vanish.\n'
            'The 75 coordinates are (i,j,epsilon), lexicographic in i,j=0..4, then epsilon=-3,-1,1.\n'
            'Use q=lambda^5. normal4 and fourth_digit are lists [lambda exponent,75-vector].\n'
            'They satisfy M*zeta(lambda)^[5]=normal4(lambda) coefficientwise.\n'
            'The curve overlap is exp((5*xi_C-25*Xi(lambda)-125*zeta(lambda))*D).\n'
            'The actual affine first primitive is sum lambda^e times the listed polynomial.\n'
            'A record [i,j,v_power,u_power,c] means c*w1^i*w2^j*v^v_power*u^u_power.\n'
            'Its sign is already u_U=-affine(rho2); u_O=(rho2+u_U)/z² is the full regular formal quotient.\n'
            'Run python3 algebra.py for the supplied fourth equation and fixed dual-row checks.\n'
            'The requested fifth function L is not supplied or presumed computed.\n'
        ).encode(),
    }
    archive = io.BytesIO()
    with zipfile.ZipFile(archive,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for name,content in files.items():
            info=zipfile.ZipInfo(name,(2026,9,12,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED
            z.writestr(info,content,compresslevel=9)
    raw=archive.getvalue()
    assert len(raw)<=20_000
    with tempfile.TemporaryDirectory(prefix='rank25-one-parameter-check-') as directory:
        for name,content in files.items():(Path(directory)/name).write_bytes(content)
        run=subprocess.run([sys.executable,'algebra.py'],cwd=directory,capture_output=True,text=True,timeout=60)
        assert run.returncode==0,run.stdout+run.stderr
    output=root/'Research/pro_inputs/rank25_one_parameter_inputs.zip'
    output.write_bytes(raw)
    receipt={
        'status':'PASS finite specialization and smaller input packet; new fifth functions not computed',
        'returned_bundle':str(args.returned), 'line_bezout_identity':'exactly1; geometric producer still absent',
        'curve_fourth_obstruction':'identically zero coefficientwise',
        'constant_nontrace_row':'annihilates full relative J coefficientwise',
        'ordinary_fourth_normal_q_exponents':exponents,'matrix_pivots':pivots,
        'fourth_digit_lambda_exponents':exponents,
        'actual_first_affine_lambda_exponents':[row[0] for row in affine_records],
        'returned_trace_restriction':'zero as a formal polynomial; geometric claim not certified',
        'xi_origin':origin,'direction':direction,'dual_rows':[omega0,omega],
        'packet':str(output),'bytes':len(raw),'uncompressed_bytes':sum(map(len,files.values())),
        'files':{name:{'bytes':len(content),'sha256':hashlib.sha256(content).hexdigest()} for name,content in files.items()},
        'sha256':hashlib.sha256(raw).hexdigest(),'isolated_check':run.stdout.strip(),
        'scope':'One scalar function on Gm only. Its vanishing is necessary, not sufficient for W5.',
    }
    (root/'Research/computations/rank25_one_parameter_checks.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps({k:v for k,v in receipt.items() if k not in ['xi_origin','direction','dual_rows','matrix_pivots']},indent=2))


if __name__=='__main__':main()
