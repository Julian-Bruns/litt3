"""Read-only verification of one finite-algebra square obstruction.
Use --full to recompute the original resultant, cubic norm and exact quotient.
Every invocation has its own finite-algebra context.
"""
from linear_138_square import *

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--constant',action='store_true');ap.add_argument('--index',type=int);ap.add_argument('--factor',type=int);ap.add_argument('--full',action='store_true');args=ap.parse_args()
    if args.constant:
        d=json.loads((ROOT/'data'/'constant_138_square.json').read_text())
        g,sv,lam,pbar,qbar,Hs=build_constant_context();v=FP(1);label='constant-v'
        assert list(g.c)==d['parameter_modulus']
    else:
        assert 1<=args.index<=10 and args.factor is not None
        shape=json.loads((ROOT/'data'/f'linear_138_shape_{args.index}.json').read_text());mod=shape['factors'][args.factor]
        assert is_irreducible(FP(mod))
        d=json.loads((ROOT/'data'/f'linear_138_square_{args.index}_{args.factor}.json').read_text())
        sv,lam,pbar,qbar,Hs,v=build_linear_context(args.index,shape,mod)
        assert mod==d['parameter_modulus'];label=f'linear-v {args.index}, factor {args.factor}, degree {len(mod)-1}'
    assert list(sv.c)==d['s_element'] and list(lam.c)==d['lambda'] and list(pbar.c)==d['pbar'] and list(qbar.c)==d['qbar']
    assert [h.data() for h in Hs]==d['Hbar']
    rc=[EP([E(c) for c in row]) for row in d['inverse_kappa_R_coefficients']]
    if args.full:
        rr=inverse_kappa_resultant(Hs,v);nm=norm_quadratic(rr);den=EP(P**40*t**15*(v**3 if v.deg else FP(1)))
        rebuilt=[z//den for z in nm];assert rebuilt==rc
    lc,J,errors=square_equations(rc,138)
    assert list(lc.c)==d['leading_coefficient'] and [z.data() for z in J]==d['monic_root_coefficients'] and [z.data() for z in errors]==d['first_two_errors']
    a,b=[EP([E(c) for c in row]) for row in d['bezout']]
    assert a*errors[0]+b*errors[1]==EP(1)
    assert d['gcd']==EP(1).data()
    print(label+': '+('original resultant/norm/quotient and ' if args.full else 'stored residual and ')+'square-root recursion and Bezout identity PASS',flush=True)

if __name__=='__main__':main()
