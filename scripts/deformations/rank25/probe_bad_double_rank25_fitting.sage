"""Actual special-fiber rank25 module; distinguish its ordinary channel.

This is not a higher-Witt calculation. Reuses the audited affine/Laurent
reducer, reconstructs the whole operator from six regular free columns,
and checks the kernel-to-cokernel map in the SAME tangent coordinates.
"""
import argparse, itertools, json, sys, time
from pathlib import Path

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('--parameter-polynomial', default='2,0,1')
p.add_argument('--precision', type=int, default=320)
p.add_argument('--plane', choices=['nodal', 'invariant'], default='nodal')
p.add_argument('--mix-second',type=int,default=0,choices=range(5),
    help='For nodal plane, add this multiple of the second invariant class to the anti class.')
p.add_argument('--output', type=Path, required=True)
opts = p.parse_args()
old_argv = sys.argv
sys.argv = ['diagnose_bad_double_noninvariant_covers.sage', '--covers', '0',
    '--parameter-polynomial', opts.parameter_polynomial,
    '--precision', str(opts.precision)]
load('scripts/genus_two/diagnose_bad_double_noninvariant_covers.sage')
sys.argv = old_argv
assert len(roots) == 5
begun = time.monotonic()
all_shifts = [(sum(cl[i]*z**[-3,-1][i] for i in range(2)),zero) for cl in fixed]
all_shifts.append((zero, anti_root*z))
shifts = [all_shifts[0], all_shifts[2 if opts.plane == 'nodal' else 1]]
if opts.mix_second:
    assert opts.plane=='nodal'
    shifts[1]=add(shifts[1],scal(Fp(opts.mix_second),all_shifts[1]))
rhs = []
for shift in shifts:
    discrepancy = add(fift(shift), neg(shift))
    rem0, aff0 = reduce0(discrepancy[0])
    rem1, aff1 = reduce_anti(discrepancy[1])
    assert rem0.valuation() >= 1 and rem1.valuation() >= 2
    rhs.append((aff0, aff1))
indices = list(itertools.product(range(5), repeat=2))
pos = {v:i for i,v in enumerate(indices)}
shift_powers = [[power(neg(s), i) for i in range(5)] for s in shifts]
rhs_powers = [[power(s, i) for i in range(5)] for s in rhs]
local = {}
for ab in indices:
    entries = []
    for ij in itertools.product(*(range(v+1) for v in ab)):
        if ij == ab:
            continue
        coefficient = (LS.one(), zero)
        for j in range(2):
            coefficient = mul(coefficient,
                scal(binomial(ab[j],ij[j]),shift_powers[j][ab[j]-ij[j]]))
        entries.append((pos[ij], coefficient))
    local[ab] = entries

def reduce_multi(vec):
    vec = list(vec)
    for ab in reversed(indices):
        nn = pos[ab]
        canonical, tail = canon_tangent(vec[nn])
        assert min(c.precision_absolute() for c in vec[nn]) > 4
        for at, entry in local[ab]:
            vec[at] = add(vec[at], neg(mul(entry,tail)))
        vec[nn] = canonical
    return vector(k,[laurent_coefficient(vec[n][parity], exponent)
        for n in range(25) for parity, exps in enumerate([inv_orders,anti_orders])
        for exponent in exps])

PX = PolynomialRing(Fp,'X'); xx = PX.gen(); polys = [xx**4]
for _ in range(4):
    polys.append(polys[-1](xx+1)-polys[-1])
tri = matrix(Fp,5,5,lambda i,j:polys[j][i])
conv = tri.tensor_product(tri).tensor_product(identity_matrix(Fp,6)).change_ring(k)
convi = conv.inverse()
terms = []
for ab in indices:
    term = (LS.one(),zero)
    for j in range(2):
        term = mul(term,scal(binomial(4,ab[j]),rhs_powers[j][4-ab[j]]))
    terms.append(term)
cols = []
for parity, exps in enumerate([inv_orders,anti_orders]):
    for exponent in exps:
        monomial = (z**exponent,zero) if parity == 0 else (zero,z**exponent)
        leading = scal(A,fift(monomial))
        cols.append(convi*reduce_multi([mul(leading,term) for term in terms]))
        print('FREE_COLUMN',len(cols),round(time.monotonic()-begun,3),flush=True)

# In the regular basis every remaining column is an augmentation shift.
psi = matrix(k,150,150,0,implementation='generic')
for ab in indices:
    for cd in indices:
        total = tuple(ab[i]+cd[i] for i in range(2))
        if max(total) >= 5:
            continue
        for row in range(6):
            for col in range(6):
                psi[6*pos[total]+row,6*pos[ab]+col] = cols[col][6*pos[cd]+row]
assert psi.matrix_from_columns(range(6)) == matrix(k,cols).transpose()
frob = lambda mat: matrix(k,mat.nrows(),mat.ncols(),[c**5 for c in mat.list()],implementation='generic')
iterate = identity_matrix(k,150); ranks = []
twist = psi
for j in range(5):
    iterate = iterate*twist
    ranks.append(int(iterate.rank()))
    twist = frob(twist)
ker = matrix(k,[[c**(5**(k.degree()-1)) for c in row]
    for row in psi.right_kernel().basis()],implementation='generic')
assert psi*frob(ker.transpose()) == 0
ordinary_rank = int(psi.augment(ker.transpose()).rank()-psi.rank())
# Direct and iterate formulas agree for the semilinear kernel.
assert ordinary_rank == 150-2*ranks[0]+ranks[1]
deck_ranks = []
for axis in range(2):
    ee = matrix(k,150,150,0,implementation='generic')
    for ab in indices:
        to = list(ab); to[axis] += 1; to = tuple(to)
        if to[axis] >= 5:
            continue
        for i in range(6):
            ee[6*pos[to]+i,6*pos[ab]+i] = 1
    assert ee*psi == psi*frob(ee)
    deck_ranks.append(int(ee.rank()))
encode = lambda c:[int(a) for a in coordinates(c)]
result = dict(status='PASS',scope='Actual characteristic-five operator, not a Witt-lift verdict',
    parameter_polynomial=opts.parameter_polynomial,parameter=encode(t),
    field_modulus=[int(c) for c in k.modulus()],field_degree=int(k.degree()),
    precision=int(opts.precision),plane=opts.plane,mix_second=int(opts.mix_second),source_genus=int(51),
    ranks=ranks,defect=int(150-ranks[0]),ordinary_kernel_to_cokernel_rank=ordinary_rank,
    deck_ranks=deck_ranks,regular_free_columns=[[encode(c) for c in col] for col in cols],
    seconds=time.monotonic()-begun)
opts.output.write_text(json.dumps(result,separators=(',',':'))+'\n')
print(json.dumps({key:val for key,val in result.items()
    if key not in ['regular_free_columns','field_modulus','parameter']}),flush=True)
