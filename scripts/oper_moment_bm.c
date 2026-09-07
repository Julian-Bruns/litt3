/* Batch FLINT Berlekamp--Massey. stdin: raw F5 bytes; stdout: JSON
   coefficients in ascending order. Build against the running Sage FLINT:
   cc -O2 -I$SAGE_LOCAL/include scripts/oper_moment_bm.c \
      -L$SAGE_LOCAL/lib -Wl,-rpath,$SAGE_LOCAL/lib -lflint -o /tmp/oper_moment_bm
   Batch reduce uses FLINT's accelerated Euclidean implementation. */
#include <stdio.h>
#include <stdlib.h>
#include <flint/nmod_poly.h>

int main(void) {
    size_t count = 0, capacity = 1024;
    ulong *points = malloc(capacity * sizeof(ulong));
    if (!points) return 2;
    int c;
    while ((c = getchar()) != EOF) {
        if (c >= 5) { fprintf(stderr, "Non-F5 byte\n"); free(points); return 2; }
        if (count == capacity) {
            capacity *= 2;
            ulong *grown = realloc(points, capacity * sizeof(ulong));
            if (!grown) { free(points); return 2; }
            points = grown;
        }
        points[count++] = (ulong)c;
    }
    if (ferror(stdin) || !count) { free(points); return 2; }
    nmod_berlekamp_massey_t B;
    nmod_berlekamp_massey_init(B, 5);
    nmod_berlekamp_massey_add_points(B, points, count);
    nmod_berlekamp_massey_reduce(B);
    const nmod_poly_struct *V = nmod_berlekamp_massey_V_poly(B);
    printf("[");
    for (slong i = 0; i < V->length; i++)
        printf("%s%lu", i ? "," : "", nmod_poly_get_coeff_ui(V, i));
    puts("]");
    nmod_berlekamp_massey_clear(B);
    free(points);
    return 0;
}
