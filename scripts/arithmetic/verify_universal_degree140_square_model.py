"""Sage implementation checks of the universal 140-row linear square model.

The theorem is a ring identity; these are bounded implementation checks.
No geometric square-locus decision is inferred. Output stays external.
"""
import argparse, json, random, time
from pathlib import Path
from sage.all import GF, PolynomialRing


def truncate(f, n=141):
    return f.parent()(f.list()[:n])


def power_truncated(f, e, n=141):
    out = f.parent()(1)
    while e:
        if e & 1:
            out = truncate(out * f, n)
        e >>= 1
        if e:
            f = truncate(f * f, n)
    return out


def root_recurrence(alpha):
    R = alpha.parent().base_ring()
    b = [R(1)]
    for n in range(1, 71):
        b.append(R(3) * (alpha[n] - sum((b[i]*b[n-i] for i in range(1, n)), R(0))))
    return alpha.parent()(b)


def carry_residual(alpha, b):
    T = alpha.parent().gen()
    return truncate(b * power_truncated(alpha, 62)) - 1 - 3 * alpha[1]**125 * T**125


def check_case(alpha, b=None):
    b0 = root_recurrence(alpha)
    assert b0 == power_truncated(alpha, 63, 71)
    if b is None:
        b = b0
    e = truncate(b*b-alpha)
    h = carry_residual(alpha, b)
    # The exact identity (2), before imposing either equation system.
    T = alpha.parent().gen()
    v = truncate(b * power_truncated(alpha, 312)) - 1
    assert v == truncate(h * (1+2*alpha[1]**125*T**125))
    assert (not e) == (not h)
    assert not any(carry_residual(alpha,b0)[i] for i in range(1,71))
    return not e


def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--output', required=True)
    args=ap.parse_args(); start=time.time(); rng=random.Random(27192026)
    K=GF(5**4, name='a'); a=K.gen()
    S=PolynomialRing(K,'e'); R=S.quotient(S.gen()**2,'eps'); eps=R.gen()
    records=[]
    def field_code(n):
        return sum((K((n//(5**j))%5)*a**j for j in range(4)), K(0))
    for base,name in ((K,'F625'),(R,'F625[eps]/eps^2')):
        PT=PolynomialRing(base,'T'); T=PT.gen(); accepted=0; rejected=0
        def rc():
            z=field_code(rng.randrange(625))
            return base(z) if base is K else base(z)+eps*field_code(rng.randrange(625))
        for _ in range(3):
            b=PT([base(1)]+[rc() for _ in range(70)])
            alpha=b*b
            assert check_case(alpha,b); accepted+=1
            for n in (71,125,140):
                perturb=base(1) if base is K else eps
                assert not check_case(alpha+perturb*T**n); rejected+=1
        for _ in range(3):
            alpha=PT([base(1)]+[rc() for _ in range(140)])
            ok=check_case(alpha); accepted+=int(ok); rejected+=int(not ok)
        trap=1+(base(1) if base is K else eps)*T**125
        assert not check_case(trap,PT(1)); rejected+=1
        records.append({'base':name,'accepted_squares':accepted,'rejected':rejected,
                        'first70_triangular_root_checked':True,'all140_rows_retained':True,
                        'explicit_carry_and_truncated_exponent_agree':True})
        print('Completed implementation checks over',name,flush=True)
    out={'status':'PASS','scope':'bounded implementation checks; no actual locus decision',
         'cases':records,'seconds':round(time.time()-start,3)}
    Path(args.output).parent.mkdir(parents=True,exist_ok=True)
    Path(args.output).write_text(json.dumps(out,indent=2)+'\n'); print(json.dumps(out))


if __name__=='__main__': main()
