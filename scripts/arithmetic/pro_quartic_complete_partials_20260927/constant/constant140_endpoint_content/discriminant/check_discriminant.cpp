// Exact one-variable discriminants at specified ratios, NOT a varying-ratio decision.
#include "../forward/square_engine.hpp"
#include "../forward/resultant_engine.hpp"
#include <filesystem>

Poly mu_content(const XP& W) {
    Poly g;
    for (int j=0;j<=6;++j) {
        Poly b; for(const auto& a:W)b.v.push_back(a.at(j));b.trim();
        g=gcd(g,b);
    }
    return g;
}
Poly at_mu(const XP& W,F mu) {
    Poly a;for(const auto& b:W)a.v.push_back(eval(b,mu));a.trim();return a;
}
F disc_at(const XP& W,F mu) {
    auto a=at_mu(W,mu);if(a.deg()!=140 || a.at(140)!=1)throw std::runtime_error("monicity lost");
    return fixedres(a,140,derivative(a),139); // (-1)^(140*139/2)=1
}
Poly square_monic(const Poly& a) {
    if(a.deg()%2 || a.v.back()!=1)throw std::runtime_error("square monic input");
    int n=a.deg()/2;Poly j;j.v.resize(n+1);j.v[n]=1;
    for(int i=1;i<=n;++i)j.v[n-i]=ff::mul(3,ff::sub(a.at(2*n-i),(j*j).at(2*n-i)));
    j.trim();if(!(j*j==a))throw std::runtime_error("not monic square");return j;
}
void one(const std::vector<Record>&records,F H,F q,const std::string&dir) {
    if(!allowed(H,q,1))throw std::runtime_error("disallowed ratio");
    XP W=evaluateW(records,H,q);F L=W[140].at(0);W=scaleXP(W,ff::inv(L));
    Poly content=mu_content(W);
    Poly top;for(const auto& a:W)top.v.push_back(a.at(6));top.trim();
    auto sq=exactdiv(top,ppow(t,3));sq=scale(sq,ff::inv(sq.v.back()));
    Poly mm=square_monic(sq);
    std::cout<<"RATIO H "<<H<<" q "<<q<<" content_degree "<<content.deg()
             <<" M_degree "<<mm.deg()<<" M_derivative_gcd_degree "<<gcd(mm,derivative(mm)).deg()
             <<" M_t_gcd_degree "<<gcd(mm,t).deg()<<std::endl;
    const int N=2504;
    F root=ff::pow(25,ff::ORD/N);if(ff::pow(root,N)!=1||ff::pow(root,N/2)==1||ff::pow(root,N/313)==1)throw std::runtime_error("FFT root order");
    std::vector<F> nodes(N),values(N);nodes[0]=1;for(int i=1;i<N;++i)nodes[i]=ff::mul(nodes[i-1],root);
    #pragma omp parallel for num_threads(4) schedule(static)
    for(int i=0;i<N;++i)values[i]=disc_at(W,nodes[i]);
    auto co=fft(values,ff::inv(root));for(auto& a:co)a=ff::mul(a,ff::inv(N%5));Poly disc(co);
    if(disc.deg()>1668)throw std::runtime_error("universal discriminant degree exceeded");
    if(disc.deg()>1539)throw std::runtime_error("proposed degree 1539 bound exceeded");
    for(F mu:std::vector<F>{0,5,25,71,125,390624,35625,117,888,10000})
        if(eval(disc,mu)!=disc_at(W,mu))throw std::runtime_error("off-grid discriminant mismatch");
    auto direct_input=at_mu(W,7);
    if(sylvester(direct_input,140,derivative(direct_input),139)!=eval(disc,7))
        throw std::runtime_error("direct 279-by-279 Sylvester mismatch");
    std::cout<<"DIRECT_279_SYLVESTER H "<<H<<" q "<<q<<" mu 7 PASS"<<std::endl;
    auto eq=equations(W);Poly g;for(const auto& a:eq)g=gcd(g,a);
    if(!disc.zero() && !rem(disc,ppow(g,70)).zero())throw std::runtime_error("square ideal seventieth power divisibility");
    std::string p=dir+"/H"+std::to_string(H)+"_q"+std::to_string(q);
    writepoly(p+"_discriminant.dat",disc);writepoly(p+"_content.dat",content);
    writepoly(p+"_square_ideal.dat",g);
    std::cout<<"EXACT_FIXED_RATIO_DISC H "<<H<<" q "<<q<<" degree "<<disc.deg()<<" leading_code "
             <<(disc.zero()?0:disc.v.back())<<" square_ideal_degree "<<g.deg()
             <<" interpolation_nodes "<<N<<" offgrid_checks 10 PASS"<<std::endl;
}
int main(int argc,char**argv) {try {
    if(argc!=3)throw std::runtime_error("usage: check_discriminant E_records.tsv output_dir");
    ff::init();init_source();tests();std::cout<<"RESULTANT_AND_FFT_FIXTURES PASS"<<std::endl;
    std::filesystem::create_directories(argv[2]);auto records=load(argv[1]);
    for(auto [H,q]:std::vector<std::pair<F,F>>{{1,3},{5,15625},{31,48151}})one(records,H,q,argv[2]);
    std::cout<<"FIXED_RATIO_IDENTITIES PASS; VARYING_RATIO_LOCUS UNRESOLVED"<<std::endl;
}catch(const std::exception& e){std::cerr<<"ERROR "<<e.what()<<std::endl;return 1;} return 0; }
