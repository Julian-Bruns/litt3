// Exact sparse presentation of one endpoint-content curve.
// Reads the archived local coefficients; does not decide square existence.
#include "pro_two_sheet_quintic_20260927/two_sheet/src/io.hpp"

std::array<LP,2> affine_coefficients(const LP& f) {
    std::array<LP,2> a;
    for (auto [ee,c] : f.a) {
        auto e = ee;
        assert(e[0] == 0 || e[0] == 1);
        int h = e[0]; e[0] = 0; a[h].put(e,c);
    }
    return a;
}

LP homogeneous_evaluate(const LP& g, const LP& c, const LP& b) {
    LP out;
    for (auto [ee,a] : g.a) {
        auto e = ee;
        int j = e[2]; e[2] = 0;
        assert(0 <= j && j <= 6);
        out += LP::mon(e,a) * lpow(c,j) * lpow(b,6-j);
    }
    return out;
}

int main(int argc, char** argv) {
    if (argc != 3) throw std::runtime_error("usage: endpoint_content_mobius evidence-dir output-dir");
    F::init();
    for (int root : {145049,211895,211959}) {
        std::ifstream in(std::string(argv[1])+"/endpoint_"+std::to_string(root)+".txt");
        std::string header; getline(in,header);
        assert(header == "ENDPOINT_V1 H v unused unused");
        int r,p,m,zeta; in >> r >> p >> m >> zeta; assert(r == root);
        auto a=readLP(in), b=readLP(in), c=readLP(in), d=readLP(in), ell=readLP(in), j=readLP(in);
        const auto B=affine_coefficients(b), C=affine_coefficients(c), E=affine_coefficients(ell);
        const LP delta=B[1]*C[0]-B[0]*C[1]; assert(bool(delta));
        const LP z=LP::var(2), denominator=B[1]*z-C[1];
        const LP g=E[0]*denominator+E[1]*(C[0]-B[0]*z)
                  -d*denominator*frob(z)+LP(F(2)*F::raw(m))*delta*lpow(z,2);
        assert(homogeneous_evaluate(g,c,b)==delta*j);
        assert(j == frob(b)*ell-d*frob(c)+LP(F(2)*F::raw(m))*lpow(b,4)*lpow(c,2));
        stats("root "+std::to_string(root)+" delta",delta);
        stats("sparse equation",g);
        for (int zi : {0,1,2,5,6}) {
            LP coeff;
            for(auto [ee,a] : g.a) if(ee[2]==zi){auto e=ee;e[2]=0;coeff.put(e,a);}
            stats("z^"+std::to_string(zi),coeff);
        }
        std::ofstream out(std::string(argv[2])+"/mobius_"+std::to_string(root)+".txt");
        out << "MOBIUS_V1 H v z unused\n" << r << ' ' << p << ' ' << m << '\n';
        saveLP(out,delta);saveLP(out,g);
        for (const auto& p : {B[0],B[1],C[0],C[1],E[0],E[1],d}) saveLP(out,p);
        std::cout << "PASS root " << root << ": B^6 G(C/B)=delta*J exactly\n";
    }
}
