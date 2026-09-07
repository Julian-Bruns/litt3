#!/usr/bin/env sage
"""Check constant-kernel elimination on all33 known genus-two atlas points.

Only saved small exact tensors are read. No atlas solver is run and no
production input is changed. The output is explicitly external.
"""
import argparse
import hashlib
import itertools
import json
import time
from pathlib import Path


def run(output):
    started = time.monotonic()
    root = Path(__file__).resolve().parents[1]
    source = root/'Research/computations/genus_two_intrinsic_tensor.json'
    d = json.loads(source.read_text())
    saved_source = root/'Research/computations/genus_two_intrinsic_solutions.json'
    saved = json.loads(saved_source.read_text())
    k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'z')([2,4,1]))
    a = k.gen()
    get = lambda s: k(sage_eval(s, locals={'a':a}))
    I = matrix(k, [[get(c) for c in row] for row in d['I']])
    ell = matrix(k, [[get(c) for c in row] for row in d['ell']])
    assert I == identity_matrix(k,4).stack(zero_matrix(k,8,4))
    assert ell.is_invertible()
    tensor = [matrix(k, [[get(d['tensor_plus_Jinverse_alpha5_p'][i][j][h])
                          for j in range(4)] for h in range(12)]) for i in range(4)]
    ns = [entry.matrix_from_rows(range(4,12)) for entry in tensor]
    rs = [-ell*entry.matrix_from_rows(range(4)) for entry in tensor]
    # Find an exact constant row change into two alternating4-square blocks.
    equations = []
    for i in range(4):
        for j in range(i,4):
            for h in range(4):
                row = [k.zero()]*32
                for r in range(8):
                    row[8*j+r] += ns[i][r,h]
                    row[8*i+r] += ns[j][r,h]
                equations.append(row)
    space = matrix(k,equations).right_kernel().basis_matrix()
    candidates = [matrix(k,4,8,list(row)) for row in space.rows()]
    chosen = None
    for u,v in itertools.combinations(candidates,2):
        if u.stack(v).rank() == 8:
            chosen = (u,v)
            break
    if chosen is None:
        set_random_seed(20260907)
        for _ in range(100):
            pair = [sum((k.random_element()*m for m in candidates),zero_matrix(k,4,8))
                    for _ in range(2)]
            if pair[0].stack(pair[1]).rank()==8:
                chosen = tuple(pair)
                break
    assert chosen is not None
    change = chosen[0].stack(chosen[1])
    nn = [change*m for m in ns]
    for block in range(2):
        for i in range(4):
            assert nn[i].row(4*block+i).is_zero()
            for j in range(i):
                assert nn[i].row(4*block+j)+nn[j].row(4*block+i)==0

    big = GF(5**6,name='q')
    Z = PolynomialRing(big,'z')
    z = Z.gen()
    aa = Z([2,4,1]).roots(multiplicities=False)[0]
    embed = lambda c: sum((big(cc)*aa**j for j,cc in enumerate(k(c).polynomial().list())),big.zero())
    emat = lambda m: matrix(big,m.nrows(),m.ncols(),[embed(c) for c in m.list()])
    nn, rs, tensor, ell, I = ([emat(m) for m in nn], [emat(m) for m in rs],
                             [emat(m) for m in tensor], emat(ell), emat(I))
    f = Z(sage_eval(saved['projective_degree11_polynomial'],locals={'a':aa,'z':z}))
    hh = Z(sage_eval(saved['normalization_lambda_cubed'],locals={'a':aa,'z':z}))
    roots = f.roots(multiplicities=False)
    assert len(roots)==11

    def pfadj4(mat):
        pf = mat[0,1]*mat[2,3]-mat[0,2]*mat[1,3]+mat[0,3]*mat[1,2]
        adj = zero_matrix(mat.base_ring(),4)
        for i in range(4):
            for j in range(i+1,4):
                remain = [h for h in range(4) if h not in [i,j]]
                adj[i,j] = (-1)**(i+j)*mat[remain[0],remain[1]]
                adj[j,i] = -adj[i,j]
        assert mat*adj==pf*identity_matrix(mat.base_ring(),4)
        return pf,adj
    def matrices(b):
        bf = vector(big,[c**5 for c in b])
        out = [entry*bf for entry in nn]
        pair = [matrix(big,[[out[i][4*s+j] for i in range(4)] for j in range(4)])
                for s in range(2)]
        cmat = matrix(big,[entry*bf for entry in rs]).transpose()
        return pair,cmat,ell*b
    points = []
    for zz in roots:
        lambdas = (z**3-hh(zz)).roots(multiplicities=False)
        assert len(lambdas)==3
        c = 1/((aa+1)*zz**10+(-aa+2)*zz**5+2*aa)
        for lam in lambdas:
            ps = lam**(-4)*c*((-2*aa+2)*zz**5-aa-1)
            pt = -lam**(-4)*c*(zz**5+aa+2)
            bx,by = lam*zz,lam
            p = vector(big,[-(2*aa+1)*pt,aa*ps-pt,ps,pt])
            b = vector(big,[-(2*aa+1)*bx+(2*aa+2)*by,
                            -(2*aa+1)*bx+(2*aa+1)*by,bx,by])
            bf = vector(big,[cc**5 for cc in b])
            assert I*b+sum((p[i]*(tensor[i]*bf) for i in range(4)),vector(big,12))==0
            pair,cmat,beta = matrices(b)
            assert pair[0]*p==0 and pair[1]*p==0
            assert cmat*p==beta and beta*p==1
            assert [m.rank() for m in pair]==[2,2]
            assert pair[0].stack(pair[1]).rank()==3
            # In the canonical-pencil decomposition H0(E omega)=A+A,
            # this is the exact cohomological realization of
            # H0(End(E) omega), via evaluation on the nowhere-zero u.
            higgs = pair[0].augment(pair[1]).right_kernel().basis_matrix().transpose()
            assert higgs.nrows()==8 and higgs.ncols()==5
            scalar_images = matrix(big,[list(p)+[big.zero()]*4,
                                       [big.zero()]*4+list(p)]).transpose()
            assert pair[0].augment(pair[1])*scalar_images==0
            combined_higgs = scalar_images.augment(higgs)
            higgs_mod_scalars = combined_higgs.matrix_from_columns(list(combined_higgs.pivots()))
            assert higgs_mod_scalars.ncols()==5
            assert higgs_mod_scalars.matrix_from_columns([0,1])==scalar_images
            trace_pivot = next(i for i,c in enumerate(p) if c)
            quotient_rows = [i for i in range(4) if i!=trace_pivot]
            for tt in [embed(cc) for cc in k]+[None]:
                if tt is None:
                    ev = higgs.matrix_from_rows(range(4))
                    form = pair[1]
                    half = higgs.matrix_from_rows(range(4,8))
                    reduced_ev = higgs_mod_scalars.matrix_from_rows(range(4))
                else:
                    ev = higgs.matrix_from_rows(range(4,8))-tt*higgs.matrix_from_rows(range(4))
                    form = pair[0]+tt*pair[1]
                    half = higgs.matrix_from_rows(range(4))
                    reduced_ev = (higgs_mod_scalars.matrix_from_rows(range(4,8))
                                  -tt*higgs_mod_scalars.matrix_from_rows(range(4)))
                assert ev.rank()==3 and form.rank()==2
                lifted = half*ev.right_kernel().basis_matrix().transpose()
                assert lifted.rank()==2 and form*lifted==0
                _,member_adj = pfadj4(form)
                intrinsic_extra = member_adj*beta
                assert intrinsic_extra!=0 and form*intrinsic_extra==0
                assert beta*intrinsic_extra==0
                assert pair[0].stack(pair[1])*intrinsic_extra!=0
                # Quotient the scalar-Higgs image, retaining three source
                # representatives modulo the two canonical scalar sections.
                rest = reduced_ev.matrix_from_columns([2,3,4])
                small = (rest.matrix_from_rows(quotient_rows)
                         -matrix(big,3,1,[p[i]/p[trace_pivot] for i in quotient_rows])
                         *matrix(big,1,3,list(rest.row(trace_pivot))))
                assert small.rank()==2 and 1+small.right_nullity()==4-form.rank()
            pf,adj = pfadj4(pair[0])
            assert pf==0
            charts = []
            for j in range(4):
                u = adj*pair[1].column(j)
                h = beta*u
                if not h: continue
                assert pair[1]*u==0 and cmat*u==h*beta and u/h==p
                q = pair[1].column(j)
                border = block_matrix(big,[[pair[0],matrix(big,4,1,list(beta)),matrix(big,4,1,list(q))],
                    [matrix(big,1,4,list(-beta)),zero_matrix(big,1,1),zero_matrix(big,1,1)],
                    [matrix(big,1,4,list(-q)),zero_matrix(big,1,1),zero_matrix(big,1,1)]])
                assert border.pfaffian()==h and border.det()==h**2
                charts.append(j)
            assert charts
            # Scaling b by2 preserves N and permits normalization, but fails R.
            weak,wrong_c,wrong_beta = matrices(2*b)
            _,wrong_adj = pfadj4(weak[0])
            rejected = []
            for j in range(4):
                u = wrong_adj*weak[1].column(j)
                h = wrong_beta*u
                if not h: continue
                assert weak[0]*u==0 and weak[1]*u==0
                assert wrong_beta*(u/h)==1
                assert wrong_c*u != h*wrong_beta
                rejected.append(j)
            assert rejected
            points.append({'z':str(zz),'lambda':str(lam),'accepted_charts':charts,
                           'scaled_weak_point_rejected_by_R_charts':rejected})
    assert len(points)==33

    def singular_block():
        first = matrix(GF(5),[[0,0,1],[0,0,0],[-1,0,0]])
        second = matrix(GF(5),[[0,1,0],[-1,0,0],[0,0,0]])
        return first,second
    s0,s1 = singular_block()
    varying0 = block_diagonal_matrix([s0,s0])
    varying1 = block_diagonal_matrix([s1,s1])
    assert varying0.stack(varying1).right_nullity()==0
    assert all((varying0+t*varying1).rank()==4 for t in GF(5))
    # Sharp high-corank example: K0 + nine K1 blocks + a regular4-block.
    regular = block_diagonal_matrix([matrix(GF(5),[[0,1],[-1,0]])]*2)
    sharp0 = block_diagonal_matrix([zero_matrix(GF(5),1)]+[s0]*9+[regular])
    sharp1 = block_diagonal_matrix([zero_matrix(GF(5),1)]+[s1]*9+[zero_matrix(GF(5),4)])
    assert sharp0.nrows()==32 and sharp0.rank()==22
    assert sharp0.stack(sharp1).rank()==31
    principal = list(sharp0.pivots())
    complement = [i for i in range(32) if i not in principal]
    mm = sharp0.matrix_from_rows_and_columns(principal,principal)
    bb = sharp0.matrix_from_rows_and_columns(principal,complement)
    ee = sharp0.matrix_from_rows_and_columns(complement,complement)
    # This particular principal block is a direct sum of11 two-square
    # blocks. Avoid a generic22-square Pfaffian expansion in a tiny test.
    assert all(mm[i,j]==0 for i in range(22) for j in range(22)
               if i//2 != j//2)
    pp = prod(mm[i,i+1] for i in range(0,22,2))
    padj = pp*mm.inverse()
    assert pp != 0 and mm*padj == pp*identity_matrix(GF(5),22)
    assert pp*ee+bb.transpose()*padj*bb==0
    ker = zero_matrix(GF(5),32,10)
    top = -padj*bb
    for i,r in enumerate(principal): ker.set_row(r,top.row(i))
    for i,r in enumerate(complement): ker[r,i]=pp
    assert sharp0*ker==0
    ff = sharp1*ker
    row_indices = list(ff.transpose().pivots())
    assert len(row_indices)==9
    small = ff.matrix_from_rows(row_indices)
    ww = vector(GF(5),[(-1)**j*small.matrix_from_columns([i for i in range(10) if i!=j]).det()
                       for j in range(10)])
    beta = vector(GF(5),[1]+[0]*31)
    u = ker*ww
    assert ff*ww==0 and beta*u !=0 and u/(beta*u)==beta
    cmat = matrix(GF(5),32,1,list(beta))*matrix(GF(5),1,32,list(beta))
    assert cmat*u==(beta*u)*beta
    report = {'scope':'Exact bounded common-constant-kernel checks; no Litt3 exclusion.',
        'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
        'saved_solutions_sha256':hashlib.sha256(saved_source.read_bytes()).hexdigest(),
        'alternating_row_change':[[str(c) for c in row] for row in change.rows()],
        'alternating_row_map_space_dimension':int(space.nrows()),
        'full_constant_row_change_verified':True,
        'all_33_original_solutions_checked':True,'all_33_reconstructed_by_pfaffian_columns':True,
        'all_33_scaled_weak_points_rejected_by_R':True,
        'all_33_canonical_divisor_radicals_verified_at_26_parameters':True,
        'cohomological_H0_EndE_omega_dimension':5,
        'canonical_divisor_evaluation_rank':3,
        'all_33_scalar_Higgs_quotient_rank_two_at_26_parameters':True,
        'scalar_Higgs_quotient_matrix_dimension':3,
        'all_33_intrinsic_extra_radical_lines_at_26_parameters':True,
        'extra_radical_vectors_are_liftable_but_not_common_kernel_vectors':True,
        'bordered_determinant_identity_verified_at_every_selected_chart':True,
        'bordered_pfaffian_identity_verified_at_every_selected_chart':True,
        'varying_kernel_example_has_no_constant_kernel':True,
        'sharp_32_square_example':{'normal_rank':22,'normal_corank':10,'constant_kernel_dimension':1,
                                  'ten_coordinate_schur_reconstruction_verified':True},
        'points':points,'elapsed_seconds':time.monotonic()-started}
    output = Path(output)
    output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text(json.dumps(report,indent=2,default=int)+'\n')
    print(json.dumps({key:val for key,val in report.items() if key not in ['points','alternating_row_change']},
                     indent=2,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',required=True)
    args=parser.parse_args()
    run(args.output)
