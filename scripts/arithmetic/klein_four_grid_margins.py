#!/usr/bin/env python3
"""Explore exact root-grid margins; survivors are NOT geometric models.

For actual degree-n endpoint maps each A-row/column loses only its
parameter-end labels, and every P-row/column is n modulo3. This script
adds those necessary conditions to the existing singularity relaxation.
The emitted matrix is checked with integer arithmetic independently of
the solver. An infeasibility report alone is not a mathematical proof.
"""
import argparse
import json
from pathlib import Path
from ortools.sat.python import cp_model


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--n', type=int, default=91)
    ap.add_argument('--g', type=int, default=79)
    ap.add_argument('--m', type=int, default=26)
    ap.add_argument('--seconds', type=float, default=45)
    ap.add_argument('--end-contacts', action='store_true',
                    help='include contact>=3 at repeated parameter-end labels')
    ap.add_argument('--output', type=Path, required=True)
    args = ap.parse_args()
    n, g, m = args.n, args.g, args.m
    M, N, cap = 4*n-4, 7*n-3*g+15+3*m, n+12
    budget = (n-1)**2-g-(n-12)*(n-13)//2-m
    model = cp_model.CpModel()
    matrices, costs = [], []
    for name, size, total in [('A', 4, M), ('P', 10, N)]:
        mat = [[model.new_int_var(0, n, f'{name}_{i}_{j}')
                for j in range(size)] for i in range(size)]
        for row in mat:
            for x in row:
                cost = model.new_int_var(0, n*(n-1)//2, f'cost_{x.name}')
                for k in range(n):
                    model.add(cost >= k*x-k*(k+1)//2)
                costs.append(cost)
        model.add(sum(sum(row) for row in mat) == total)
        for i in range(size):
            row, col = sum(mat[i]), sum(mat[j][i] for j in range(size))
            if name == 'A':
                model.add(row <= n); model.add(row >= n-4)
                model.add(col <= n); model.add(col >= n-4)
                if args.end_contacts:
                    for tag, total in [('r', row), ('c', col)]:
                        deficit = model.new_int_var(0, 4, f'end_{tag}_{i}')
                        model.add(total+deficit == n)
                        contact = model.new_int_var(0, 18, f'contact_{tag}_{i}')
                        model.add_element(deficit, [0, 0, 3, 9, 18], contact)
                        costs.append(contact)
            else:
                fr = model.new_int_var(0, n//3, f'fr_{i}')
                fc = model.new_int_var(0, n//3, f'fc_{i}')
                model.add(row+3*fr == n)
                model.add(col+3*fc == n)
        matrices.append(mat)
    model.add(sum(mat[i][i] for mat in matrices for i in range(len(mat))) <= cap)
    model.add(sum(costs) <= budget)
    model.minimize(sum(costs))
    solver = cp_model.CpSolver()
    solver.parameters.max_time_in_seconds = args.seconds
    solver.parameters.num_search_workers = 4
    status = solver.solve(model)
    out = {'scope': 'Necessary integer matrices only, not actual curves.',
           'n': n, 'g': g, 'm': m, 'M': M, 'N': N, 'diagonal_cap': cap,
           'grid_budget': budget, 'status': solver.status_name(status),
           'end_contacts_included': args.end_contacts,
           'solver_bound': solver.best_objective_bound,
           'wall_time': solver.wall_time}
    if status in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        vals = [[[solver.value(x) for x in row] for row in mat] for mat in matrices]
        cost = sum(x*(x-1)//2 for mat in vals for row in mat for x in row)
        end_cost = sum(3*d*(d-1)//2 for i in range(4)
                       for d in (n-sum(vals[0][i]),
                                 n-sum(vals[0][j][i] for j in range(4))))
        if args.end_contacts:
            cost += end_cost
        assert cost <= budget
        for mat, total, size in zip(vals, [M, N], [4, 10]):
            assert sum(map(sum, mat)) == total
            for i in range(size):
                for s in (sum(mat[i]), sum(mat[j][i] for j in range(size))):
                    assert n-4 <= s <= n if size == 4 else 0 <= s <= n and (n-s)%3 == 0
        assert sum(mat[i][i] for mat in vals for i in range(len(mat))) <= cap
        out.update(A=vals[0], P=vals[1], exact_cost=cost, slack=budget-cost,
                   forced_end_contact_cost=end_cost,
                   witness_check='all integer margins, congruences and cost checked')
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(out, indent=2)+'\n')
    print(json.dumps({k:v for k,v in out.items() if k not in ('A','P')}, indent=2))


if __name__ == '__main__':
    main()
