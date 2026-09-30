"""Export exact matrices as plain CSV, and the sparse tensor as CSV triplets."""
from pathlib import Path
import json
import numpy as np
import period_two as p

HERE = Path(__file__).resolve().parent
OUT = HERE / 'portable'
OUT.mkdir(exist_ok=True)

def export() -> None:
    e = {(-i, 2): c for i, c in enumerate(p.ff.C_COEFFICIENTS, 1)}
    matrix, kernel, pivots, columns, rows, _ = p.kernel_sections(5, e)
    assert matrix.shape == (32, 23) and kernel.shape[1] == 0
    np.savez_compressed(HERE / 'first_return_data.npz', matrix=matrix,
                        rows=np.array(rows), columns=np.array(columns))
    np.savetxt(OUT / 'first_return_matrix.csv', matrix, fmt='%d', delimiter=',')
    for filename, arrays in {
        'symmetric_shift_data.npz': ['matrix'],
        'period_two_data.npz': ['section_matrix', 'section_kernel'],
        'new_progress_data.npz': ['cup_matrix', 'cup_kernel', 'maximal_minor',
                                   'square_pencil_0', 'square_pencil_1'],
        'hom_test_data.npz': ['matrix', 'kernel'],
    }.items():
        data = np.load(HERE / filename)
        for key in arrays:
            if data[key].size:
                np.savetxt(OUT / f'{Path(filename).stem}_{key}.csv', data[key],
                           fmt='%d', delimiter=',')
    z = np.load(HERE / 'period_two_data.npz')
    tensor = z['cup_tensor']
    index = np.array(np.nonzero(tensor)).T
    records = np.column_stack([index, tensor[tuple(index.T)]])
    np.savetxt(OUT / 'cup_tensor_nonzero.csv', records, fmt='%d', delimiter=',',
               header='row_zero_based,section_zero_based,extension_zero_based,coefficient_code', comments='')
    (OUT / 'README.md').write_text(
        '# Portable exact data\n\nAll entries are F_25 codes, not integer residues modulo 25.\n'
        'Use c0+5*c1 = c0+c1*a with a^2=a+3. CSV matrix indices start at zero.\n'
        'The sparse tensor has shape (32,11,19); unspecified entries are zero.\n'
        'Basis definitions and selected maximal minors are in the adjacent JSON files.\n')
    print('Portable CSV matrices and sparse tensor exported.')

if __name__ == '__main__':
    export()
