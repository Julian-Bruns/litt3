"""Check the delivered small packet's new mathematics, in isolation."""
import importlib.util
import json
from pathlib import Path
import re
import tempfile
import zipfile


def main():
    root = Path(__file__).resolve().parents[3]
    archive = root/'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip'
    prompt = (root/'Research/requests/rank25_all_fifth_lifts_request.md').read_text()
    assert archive.stat().st_size <= 20_000
    assert not re.search(r'https?://|\]\(|/Users/|sandbox:', prompt)
    assert prompt.count('Put all output files in one ZIP archive.') == 1
    assert 'treat it as a candidate to verify' in prompt
    with tempfile.TemporaryDirectory(prefix='rank25-open-packet-') as target:
        with zipfile.ZipFile(archive) as z:
            assert len(z.namelist()) == 6 and all('/' not in n for n in z.namelist())
            z.extractall(target)
        spec = importlib.util.spec_from_file_location('isolated_rank25', Path(target)/'model.py')
        model = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(model)
        d, fourth, _ = model.load(Path(target))
        family = json.loads((Path(target)/'family.json').read_text())
        zero, one = model.ZERO, model.ONE
        digits, add, mul, power = model.digits, model.add, model.mul, model.power
        ell = [zero]*75
        for i, c in family['ell_nonzero']:
            ell[i] = digits(c)
        assert model.mv(list(zip(*d['hodge_matrix'])), ell) == [power(c, 5) for c in d['obstruction_dual_rows'][0]]

        def poly_eval(p, vs):
            result = zero
            for mon, coefficient in p:
                value = digits(coefficient)
                for i in mon:
                    value = mul(value, vs[i])
                result = add(result, value)
            return result

        # A/B and J are affine in six variables: origin plus six basis
        # tests compares all coefficients, not just arbitrary samples.
        r = (0, 2, 2, 4)
        for i in range(-1, 6):
            vs = [one if j == i else zero for j in range(6)]
            y = vs[:5]+[mul(r, vs[5]), vs[5], zero, zero]
            J = model.jacobian_fourth(y, fourth)
            A = [add(J[4][j], mul(digits(3), J[3][j])) for j in (7, 8)]
            B = [[J[k][j] for j in (7, 8)] for k in (5, 6)]
            assert A == [poly_eval(p, vs) for p in family['A']]
            assert B == [[poly_eval(p, vs) for p in row] for row in family['B']]
            for k in range(2):
                for j in range(2):
                    assert J[7+k][7+j] == mul(vs[5], digits(family['K'][k][j]))
        k = [[digits(c) for c in row] for row in family['K']]
        det = add(mul(k[0][0], k[1][1]), model.neg(mul(k[0][1], k[1][0])))
        assert det == digits(family['det_K']) != zero

        x = [digits(c) for c in family['geometric_test']['x']]
        assert model.evaluate_fourth(x, fourth) == [zero]*9
        assert x[6] != zero
        J = model.jacobian_fourth([power(c, 5) for c in x], fourth)
        assert model.rank(J) == 5
        theta = zero
        UABq = [x[0], zero, zero, one]
        for powers, c in family['theta_candidate']:
            value = digits(c)
            for a, exponent in zip(UABq, powers):
                value = mul(value, power(a, exponent))
            theta = add(theta, value)
        assert theta == zero
        reported = [digits(c) for c in family['geometric_test']['quotient']]
        assert reported == [zero, (2, 0, 1, 0), (2, 2, 1, 3), (3, 1, 3, 4)]
        assert '3130,4331,2234,3003,0314,3112,1000,0000,0000' in prompt
    result = {'status': 'PASS', 'bytes': archive.stat().st_size,
              'checks': ['isolated imports and six complete inputs', 'adjoint identity',
                         'all affine A/B/K coefficients against the full Jacobian',
                         'nonzero determinant', 'actual open W4 test point',
                         'candidate trace specialization', 'new residual and prompt coordinate agreement',
                         'one output ZIP, no prompt links, boundary scope and candidate status'],
              'scope': 'Finite packet checks; geometric point calculation has its separate receipt. No universal fifth trace or zero-locus verdict inferred.'}
    (root/'Research/computations/rank25_open_packet_checks.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
