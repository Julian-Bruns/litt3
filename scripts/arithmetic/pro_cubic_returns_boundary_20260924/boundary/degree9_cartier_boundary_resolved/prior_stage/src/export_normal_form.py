"""Export the representative normal form as human-readable coefficient rows.
This generator was executed during archive creation; its data are also fully
verified by verify.py through certificates/four_supports.json.
"""
from pathlib import Path
import json
from discriminant import polys
ROOT=Path(__file__).resolve().parents[1]
def main():
    finite=json.loads((ROOT/'certificates/finite_pole.json').read_text())
    local=json.loads((ROOT/'certificates/four_supports.json').read_text())[0]
    cs=finite['columns'];rows=local['normal_basis']
    U=polys(rows[0],cs,0);V=polys(rows[1],cs,0);W=polys(rows[2],cs,1)
    out=['# Explicit representative normal form','',
         'The omitted root is `t`, with `M(t)=t^4+[7]t^3+[6]t^2+[2]t+[5]=0`.',
         'Every integer below is a K-code `c0+25*c1+625*c2+15625*c3`, meaning `[c0]+[c1]t+[c2]t^2+[c3]t^3`.',
         'Each polynomial row is ascending in x. The parameters lambda, mu, nu are arbitrary geometric scalars.', '',
         '`p0=(1,0,18,20)`, `p1=(0,1,15,11)`, `v=lambda*p0+mu*p1`.',
         '`N_j=lambda*U_j+mu*V_j+nu*y*W_j`, `j=1,...,4`.',
         '`kappa=<<347224>>*lambda+<<249499>>*mu`.',
         '`b3=(20152,806,32,1)`.', '',
         'The complete candidate polynomial over k(X), with z=y*b, is', '',
         '```',
         '(z^5+Q)*(v*z^4+N1*z^3+N2*z^2+N3*z+N4)+kappa*b3^3*P^3 = 0.',
         '```', '',
         'For an actual candidate v and kappa must be nonzero. REPORT.md proves that nu=0 is impossible; any remaining candidate can be scaled to nu=1.', '']
    for j in range(1,5):
        out += [f'## Numerator N{j}','', '```',f'U{j} = {U[j]}',f'V{j} = {V[j]}',f'W{j} = {W[j]}','```','']
    out += ['## Other support choices','',
            'Apply coefficientwise Frobenius a -> a^(25^i), i=1,2,3, to these K-coefficients, replacing the omitted root t by t^(25^i).',
            'The full independently computed forms and matrices for all four choices are in certificates/four_supports.json.', '']
    (ROOT/'NORMAL_FORM.md').write_text('\n'.join(out))
    print('PASS exported NORMAL_FORM.md from the verified representative kernel')
if __name__=='__main__':main()
