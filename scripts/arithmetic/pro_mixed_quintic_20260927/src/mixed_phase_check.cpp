// Complete endpoint-classification certificate, NOT a bounded curve search.
// All geometric scalars have already been reduced theoretically to the
// normalized finite group in REPORT Sections 26.3 and 28.
//
// Two algorithms are provided. They share generated field data but use
// transposed rank elimination and reciprocal/cross-product scalar tests.
// No assertion may be disabled: compile WITHOUT -DNDEBUG.
#include <array>
#include <cassert>
#include <cstdint>
#include <cstdlib>
#include <iostream>
#include <string>
#include <utility>
#include "mixed_phase_data.h"

using std::array;
constexpr int FIELD_ORDER = 390625;
constexpr int GROUP_ORDER = FIELD_ORDER - 1;
static uint16_t add625[625][625];
static int logarithm8[FIELD_ORDER], exponential8[2 * GROUP_ORDER];
static int negative8[FIELD_ORDER];
static bool permitted[FIELD_ORDER];
static uint8_t signature[116][5][14];
static int u_table[116][7], v_table[116][7];

int add8(int a, int b) {
    return add625[a % 625][b % 625] + 625 * add625[a / 625][b / 625];
}
int sub8(int a, int b) { return add8(a, negative8[b]); }

// Independent polynomial-reduction multiplication used to construct and
// audit the logarithm table. Codes are base-25 lists of F25 coefficients.
int polynomial_mul8(int a, int b) {
    int aa[4], bb[4], cc[7] = {};
    for (int i = 0; i < 4; ++i) {
        aa[i] = a % 25; bb[i] = b % 25; a /= 25; b /= 25;
    }
    for (int i = 0; i < 4; ++i)
        for (int j = 0; j < 4; ++j)
            cc[i+j] = add25[cc[i+j]][mul25[aa[i]][bb[j]]];
    for (int i = 6; i >= 4; --i)
        for (int j = 0; j < 4; ++j)
            cc[i-4+j] = add25[cc[i-4+j]][neg25[mul25[cc[i]][Amonic[j]]]];
    return cc[0] + 25*cc[1] + 625*cc[2] + 15625*cc[3];
}
int polynomial_pow8(int a, int exponent) {
    int result = 1;
    while (exponent) {
        if (exponent & 1) result = polynomial_mul8(result, a);
        a = polynomial_mul8(a, a); exponent >>= 1;
    }
    return result;
}
int mul8(int a, int b) {
    return a && b ? exponential8[logarithm8[a] + logarithm8[b]] : 0;
}
int div8(int a, int b) {
    assert(b != 0);
    return a ? exponential8[logarithm8[a] + GROUP_ORDER - logarithm8[b]] : 0;
}

void initialize_fields() {
    for (int a = 0; a < 625; ++a)
        for (int b = 0; b < 625; ++b)
            add625[a][b] = add25[a%25][b%25] + 25*add25[a/25][b/25];
    for (int a = 0; a < FIELD_ORDER; ++a)
        negative8[a] = neg25[a%25] + 25*neg25[(a/25)%25]
                     + 625*neg25[(a/625)%25] + 15625*neg25[a/15625];
    // 390624 = 2^5 * 3 * 13 * 313. Check every prime divisor.
    int generator = 2;
    for (;; ++generator) {
        bool primitive = true;
        for (int prime : {2, 3, 13, 313})
            if (polynomial_pow8(generator, GROUP_ORDER / prime) == 1)
                primitive = false;
        if (primitive) break;
        assert(generator < FIELD_ORDER);
    }
    int value = 1;
    for (int j = 0; j < GROUP_ORDER; ++j) {
        exponential8[j] = exponential8[j+GROUP_ORDER] = value;
        logarithm8[value] = j;
        value = polynomial_mul8(value, generator);
    }
    assert(value == 1);
    for (int j = 0; j < GROUP_ORDER; ++j)
        assert(logarithm8[exponential8[j]] == j);
    for (int a = 0; a < 25; ++a)
        for (int b = 0; b < 25; ++b)
            assert(mul8(a, b) == mul25[a][b]);
    // Deterministic implementation audit, not the exhaustiveness argument.
    for (int i = 0; i < 10000; ++i) {
        int a = (7919LL*i + 37) % FIELD_ORDER;
        int b = (104729LL*i + 251) % FIELD_ORDER;
        assert(mul8(a, b) == polynomial_mul8(a, b));
        assert(add8(a, negative8[a]) == 0);
    }
    int count = 0;
    for (int a = 1; a < FIELD_ORDER; ++a) {
        int j = logarithm8[a];
        // Cube; outside F_(5^4); fourth power outside F25.
        permitted[a] = j % 3 == 0 && j % 626 != 0 && j % 4069 != 0;
        count += permitted[a];
    }
    assert(count == 129984);
    std::cout << "FIELD primitive_generator " << generator
              << " permitted_scalars " << count << '\n';
}

void initialize_signatures() {
    const int weights[4][4] = {{1,1,1,1}, {1,2,4,3},
                                {1,4,1,4}, {1,3,4,2}};
    for (int label = 0; label < 116; ++label) {
        for (int row = 0; row < 5; ++row) {
            int weight = weights[row < 3 ? row+1 : row-2][label%4];
            int power = row < 3 ? 17 : 4;
            for (int j = 0; j < 7; ++j) {
                int code = phase[(power*(label/4))%29][j];
                signature[label][row][2*j] = (weight*(code%5))%5;
                signature[label][row][2*j+1] = (weight*(code/5))%5;
            }
        }
        for (int j = 0; j < 7; ++j) {
            u_table[label][j] = mul8(f0_values[label%4], phase[17*(label/4)%29][j]);
            v_table[label][j] = mul8(f1_values[label%4], phase[4*(label/4)%29][j]);
        }
    }
}

// Returns min(rank,4); this is sufficient for the rank <= 3 test.
int row_rank(const uint16_t sums[5][14]) {
    int matrix[5][7];
    for (int i = 0; i < 5; ++i)
        for (int j = 0; j < 7; ++j)
            matrix[i][j] = sums[i][2*j]%5 + 5*(sums[i][2*j+1]%5);
    int rank = 0;
    for (int col = 0; col < 7; ++col) {
        int pivot = rank;
        while (pivot < 5 && !matrix[pivot][col]) ++pivot;
        if (pivot == 5) continue;
        for (int j = col; j < 7; ++j) std::swap(matrix[pivot][j], matrix[rank][j]);
        int inverse = inv25[matrix[rank][col]];
        for (int i = rank+1; i < 5; ++i) {
            if (!matrix[i][col]) continue;
            int factor = mul25[matrix[i][col]][inverse];
            for (int j = col+1; j < 7; ++j)
                matrix[i][j] = add25[matrix[i][j]][neg25[mul25[factor][matrix[rank][j]]]];
            matrix[i][col] = 0;
        }
        if (++rank == 4) return 4;
    }
    return rank;
}

// Separate, transposed, normalized-pivot algorithm. No early row reductions
// or pivots from row_rank are reused.
int column_rank(const uint16_t sums[5][14]) {
    int matrix[7][5];
    for (int i = 0; i < 7; ++i)
        for (int j = 0; j < 5; ++j)
            matrix[i][j] = sums[j][2*i]%5 + 5*(sums[j][2*i+1]%5);
    int rank = 0;
    for (int col = 0; col < 5; ++col) {
        int pivot = rank;
        while (pivot < 7 && !matrix[pivot][col]) ++pivot;
        if (pivot == 7) continue;
        for (int j = 0; j < 5; ++j) std::swap(matrix[pivot][j], matrix[rank][j]);
        int inverse = inv25[matrix[rank][col]];
        for (int j = col; j < 5; ++j) matrix[rank][j] = mul25[matrix[rank][j]][inverse];
        for (int i = rank+1; i < 7; ++i) {
            int factor = matrix[i][col];
            for (int j = col; j < 5; ++j)
                matrix[i][j] = add25[matrix[i][j]][neg25[mul25[factor][matrix[rank][j]]]];
        }
        if (++rank == 4) return 4;
    }
    return rank;
}

bool member_by_pivot(int value, int scalar, int pivot, int inverse_pivot) {
    int coordinate = value;
    for (int i = 0; i < pivot; ++i) coordinate /= 25;
    int multiplier = mul25[coordinate%25][inverse_pivot];
    return sub8(value, mul8(multiplier, scalar)) < 25;
}

bool member_by_minors(int value, int scalar) {
    // All 2x2 minors of the two nonconstant coordinate vectors vanish.
    // The scalar is outside F25, so its nonconstant vector is not zero.
    int w[3], d[3]; value /= 25; scalar /= 25;
    for (int i = 0; i < 3; ++i) {
        w[i] = value%25; d[i] = scalar%25; value /= 25; scalar /= 25;
    }
    assert(d[0] || d[1] || d[2]);
    for (int i = 0; i < 3; ++i)
        for (int j = i+1; j < 3; ++j)
            if (mul25[w[i]][d[j]] != mul25[w[j]][d[i]]) return false;
    return true;
}

struct Counts {
    uint64_t rank[5] = {}, candidates = 0, accepted = 0;
    uint64_t phase_zero = 0, mixed_shape = 0, reciprocal_fallbacks = 0;
};

void test_scalar(const array<int,5>& labels, bool reciprocal, Counts& counts) {
    int U[7] = {}, V[7] = {};
    for (int label : labels)
        for (int j = 0; j < 7; ++j) {
            U[j] = add8(U[j], u_table[label][j]);
            V[j] = add8(V[j], v_table[label][j]);
        }
    int u_index = 0;
    while (u_index < 7 && U[u_index] < 25) ++u_index;
    assert(u_index < 7); // Also proved using five-phase independence.
    int v_index = 0;
    while (v_index < 7 && V[v_index] < 25) ++v_index;
    bool reverse = reciprocal && v_index < 7;
    if (reciprocal && !reverse) ++counts.reciprocal_fallbacks;
    int chosen = reverse ? v_index : u_index;
    for (int a = 0; a < 25; ++a) {
        for (int b = 0; b < 25; ++b) {
            int epsilon, d = 0;
            if (reverse) {
                // U + d*V = a + d*b, where d=epsilon^-1.
                d = div8(sub8(a, U[chosen]), sub8(V[chosen], b));
                if (!d) continue;
                epsilon = div8(1, d);
            } else {
                // epsilon*U + V = epsilon*a + b.
                epsilon = div8(sub8(b, V[chosen]), sub8(U[chosen], a));
            }
            if (!permitted[epsilon]) continue;
            ++counts.candidates;
            bool ok = true;
            if (reverse) {
                for (int j = 0; j < 7; ++j)
                    if (!member_by_minors(add8(U[j], mul8(d, V[j])), d)) { ok = false; break; }
            } else if (reciprocal) {
                for (int j = 0; j < 7; ++j)
                    if (!member_by_minors(add8(mul8(epsilon, U[j]), V[j]), epsilon)) { ok = false; break; }
            } else {
                int pivot = 1, tail = epsilon/25;
                while (tail%25 == 0) { ++pivot; tail /= 25; }
                assert(pivot <= 3);
                int inverse = inv25[tail%25];
                for (int j = 0; j < 7; ++j)
                    if (!member_by_pivot(add8(mul8(epsilon, U[j]), V[j]), epsilon, pivot, inverse)) { ok = false; break; }
            }
            if (ok) {
                ++counts.accepted;
                std::cout << "UNEXPECTED_SCALAR " << epsilon;
                for (int label : labels) std::cout << ' ' << label;
                std::cout << '\n';
            }
        }
    }
}

void add_label(uint16_t next[5][14], const uint16_t previous[5][14], int label) {
    for (int i = 0; i < 5; ++i)
        for (int j = 0; j < 14; ++j) next[i][j] = previous[i][j] + signature[label][i][j];
}

void check_shape(const array<int,5>& labels, Counts& counts) {
    if (labels[4] < 4) { ++counts.phase_zero; return; }
    int phase_index = labels[1]/4;
    bool mixed = labels[0] == 0 && phase_index > 0;
    for (int i = 1; i < 5; ++i) mixed = mixed && labels[i] == 4*phase_index+i-1;
    assert(mixed);
    ++counts.mixed_shape;
}

int main(int argc, char** argv) {
    bool reciprocal = false;
    int first_phase = 0, last_phase = 28;
    for (int i = 1; i < argc; ++i) {
        std::string arg = argv[i];
        if (arg == "--reciprocal") reciprocal = true;
        else if ((arg == "--first-phase" || arg == "--last-phase") && i+1 < argc) {
            int value = std::stoi(argv[++i]);
            if (arg == "--first-phase") first_phase = value; else last_phase = value;
        } else { std::cerr << "Invalid argument: " << arg << '\n'; return 2; }
    }
    if (first_phase < 0 || last_phase > 28 || first_phase > last_phase) return 2;
    initialize_fields(); initialize_signatures();
    std::cout << "MODE " << (reciprocal ? "reciprocal_minors" : "direct_pivot") << '\n';
    Counts counts;
    uint16_t empty[5][14] = {}, s1[5][14], s2[5][14], s3[5][14], s4[5][14], s5[5][14];
    for (int phase_index = first_phase; phase_index <= last_phase; ++phase_index) {
        int a = 4*phase_index;
        add_label(s1, empty, a);
        for (int b = a; b < 116; ++b) { add_label(s2, s1, b);
            for (int c = b; c < 116; ++c) { add_label(s3, s2, c);
                for (int d = c; d < 116; ++d) { add_label(s4, s3, d);
                    for (int e = d; e < 116; ++e) { add_label(s5, s4, e);
                        int rank = reciprocal ? column_rank(s5) : row_rank(s5);
                        ++counts.rank[rank];
                        if (rank >= 4) continue;
                        array<int,5> labels = {a,b,c,d,e};
                        if (rank == 0) { assert(a == e); continue; }
                        if (rank == 1) { check_shape(labels, counts); continue; }
                        test_scalar(labels, reciprocal, counts);
                    }
                }
            }
        }
        uint64_t total = 0;
        for (auto number : counts.rank) total += number;
        std::cout << "PHASE " << phase_index << " cumulative_endpoints " << total
                  << " scalar_candidates " << counts.candidates
                  << " accepted_rank2_or_3 " << counts.accepted << '\n';
    }
    uint64_t total = 0;
    for (auto number : counts.rank) total += number;
    std::cout << "SUMMARY endpoints " << total;
    for (int r = 0; r < 5; ++r)
        std::cout << " rank" << (r == 4 ? "_at_least4" : std::to_string(r)) << ' ' << counts.rank[r];
    std::cout << " phase_zero_shapes " << counts.phase_zero << " mixed_shapes " << counts.mixed_shape
              << " scalar_candidates " << counts.candidates << " accepted " << counts.accepted
              << " reciprocal_fallbacks " << counts.reciprocal_fallbacks << '\n';
    assert(counts.accepted == 0);
    if (first_phase == 0 && last_phase == 28) {
        assert(total == 50706761);
        assert(counts.rank[0] == 29 && counts.rank[1] == 62 && counts.rank[2] == 260155);
        assert(counts.rank[3] == 229121 && counts.rank[4] == 50217394);
        assert(counts.phase_zero == 34 && counts.mixed_shape == 28);
    }
    std::cout << "PASS: complete normalized endpoint classification on the requested phase interval.\n";
}
