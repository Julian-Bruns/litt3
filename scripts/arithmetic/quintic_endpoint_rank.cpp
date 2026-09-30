// Exhaustive necessary-condition test for five endpoint labels.
// Output is finite-field linear algebra, not a search for actual covers.
#include "pro_quartic_complete_partials_20260927/quartic/src/fast_field.hpp"
#include <cassert>
#include <fstream>
#include <string>

using exact::K;
using Row = std::array<K, 6>;
using Labels = std::array<int, 5>;

Row plus(const Row& a, const Row& b) {
    Row c;
    for (int i = 0; i < 6; ++i) c[i] = a[i] + b[i];
    return c;
}

// These are the three nonconstant alpha-coordinates of C and E.
// Thus rank2 == true means span_K(1,C,E) has dimension at most two.
bool deficient(const Row& a) {
    return a[0] * a[4] == a[1] * a[3]
        && a[0] * a[5] == a[2] * a[3]
        && a[1] * a[5] == a[2] * a[4];
}

Labels canonical(Labels a) {
    Labels best = a;
    for (int s : a) {
        Labels b = a;
        for (int& x : b) x = 4 * ((x / 4 - s / 4 + 29) % 29) + x % 4;
        std::sort(b.begin(), b.end());
        best = std::min(best, b);
    }
    return best;
}

int main(int argc, char** argv) {
    if (argc != 2) throw std::runtime_error("usage: quintic_endpoint_rank output.txt");
    exact::init();
    const K z = exact::zeta();
    assert(z.pow(29) == K(1) && z != K(1));
    assert(z.frob(7) == z.pow(28));
    const int C[4][4] = {{22,7,9,23},{15,11,10,2},{21,17,6,23},{2,20,5,12}};
    const int E[4][4] = {{1,3,8,15},{0,23,3,0},{16,24,14,5},{5,10,10,5}};
    // Cross-check the transcribed alpha-coordinate rows against the
    // independently implemented quartic theta-coordinate label table.
    exact::init_labels();
    exact::F alpha;
    alpha.c = {K::code(7), K(0), K::code(21), K(4)};
    std::array<Row, 116> rows;
    for (int j = 0; j < 29; ++j) for (int i = 0; i < 4; ++i) {
        for (int kind = 0; kind < 2; ++kind) {
            exact::F value;
            for (int r = 3; r >= 0; --r)
                value = value * alpha + exact::F(K::code(kind ? E[i][r] : C[i][r]));
            value = value.times(z.pow((kind ? 8 : 5) * j));
            assert(value == exact::labels[4*j+i][kind]);
        }
        for (int r = 1; r < 4; ++r) {
            rows[4*j+i][r-1] = K::code(C[i][r]) * z.pow(5*j);
            rows[4*j+i][r+2] = K::code(E[i][r]) * z.pow(8*j);
        }
    }
    std::ofstream out(argv[1]);
    if (!out) throw std::runtime_error("cannot open output");
    uint64_t total = 0, bad = 0, nonconcentrated = 0;
    // Common phase translation preserves rank. Every orbit has a member
    // with a phase-zero label, equivalently the smallest label is <4.
    for (int a = 0; a < 4; ++a) {
        for (int b = a; b < 116; ++b) {
            const auto ab = plus(rows[a], rows[b]);
            for (int c = b; c < 116; ++c) {
                const auto abc = plus(ab, rows[c]);
                for (int d = c; d < 116; ++d) {
                    const auto abcd = plus(abc, rows[d]);
                    for (int e = d; e < 116; ++e) {
                        ++total;
                        if (!deficient(plus(abcd, rows[e]))) continue;
                        ++bad;
                        if (a != e) ++nonconcentrated;
                        Labels ix{a,b,c,d,e};
                        if (canonical(ix) != ix) continue;
                        out << "DEFICIENT";
                        for (int x : ix) out << ' ' << x % 4 << ':' << x / 4;
                        out << '\n';
                    }
                }
            }
        }
        std::cerr << "smallest label " << a << ": total=" << total
                  << " deficient=" << bad << " nonconcentrated=" << nonconcentrated << '\n';
    }
    out << "TOTAL " << total << " DEFICIENT " << bad
        << " NONCONCENTRATED " << nonconcentrated << '\n';
    std::cout << "TOTAL " << total << " DEFICIENT " << bad
              << " NONCONCENTRATED " << nonconcentrated << '\n';
    assert(total == 30188536 && bad == 4 && nonconcentrated == 0);
}
