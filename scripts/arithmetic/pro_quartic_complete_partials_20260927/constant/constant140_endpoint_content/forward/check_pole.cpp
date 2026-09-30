// Direct verification of the global resultant certificate by Horner evaluation.
// No FFT/interpolation is used to check the three polynomial identities.
#define main archived_pole_builder_main
#include "pole_certificate.cpp"
#undef main

int main(int argc,char**argv){try{
    ff::init();init_source();tests();
    auto rows=records(argc>1?argv[1]:"inputs/E_records.tsv");
    std::ifstream in(argc>2?argv[2]:"certificates/pole_rank.dat");
    std::string head;in>>head;
    if(head!="POLE_RANK_CERTIFICATE_V1")throw std::runtime_error("certificate header");
    std::array<F,3> endpoints,leads;
    std::array<int,3> valuations;
    std::array<Poly,3>S;
    for(int i=0,p=25;i<3;i++,p*=25){
        in>>endpoints[i]>>valuations[i]>>leads[i];S[i]=readpoly(in);
        if(endpoints[i]!=ff::pow(alpha,p)||valuations[i]!=612||!leads[i]||
           S[i].deg()!=1728||S[i].v.back()!=1)throw std::runtime_error("certificate metadata");
    }
    for(int i=0;i<3;i++)for(int j=i+1;j<3;j++){
        int a,b;in>>a>>b;Poly u=readpoly(in),v=readpoly(in);
        if(a!=i||b!=j||u.deg()!=1727||v.deg()!=1727||
           !(u*S[i]+v*S[j]==Poly(1)))throw std::runtime_error("stored Bezout identity");
    }
    if(!in)throw std::runtime_error("truncated certificate");
    std::string extra;if(in>>extra)throw std::runtime_error("extra certificate data");
    constexpr int N=5008;
    F root=ff::pow(alpha,ff::ORD/N);
    if(ff::pow(root,N)!=1||ff::pow(root,N/2)==1||ff::pow(root,N/313)==1)
        throw std::runtime_error("direct-check grid nodes not distinct");
    std::vector<F>nodes(N);nodes[0]=1;
    for(int n=1;n<N;n++)nodes[n]=ff::mul(nodes[n-1],root);
    for(int i=0;i<3;i++){
        F x=endpoints[i];
        if(eval(t,x)||!eval(P,x))throw std::runtime_error("endpoint convention");
        auto b0=evaluated(rows,0,1,x),b1=evaluated(rows,1,1,x),b2=evaluated(rows,2,1,x);
        for(int j=0;j<3;j++)if(!evaluated(rows,j,2,x).empty())
            throw std::runtime_error("mu2 endpoint coefficient");
        BP f=removeq(ba(bm(b1,b1),bs(bm(b0,b2),4)),4);
        BP g=removeq(ba(bq(bm(b0,b1),1),bs(bm(b2,b2),ff::neg(eval(P,x)))),5);
        if(f.size()!=22||g.size()!=22||qdegree(f)!=105||qdegree(g)!=105)
            throw std::runtime_error("global degree bounds");
        const int bound=21*qdegree(f)+21*qdegree(g);
        if(N<=bound||valuations[i]+S[i].deg()>bound)
            throw std::runtime_error("insufficient identity-check nodes");
        std::vector<int>bad(N),drop(N);
#pragma omp parallel for num_threads(4)
        for(int n=0;n<N;n++){
            F q=nodes[n];Poly fh=evalq(f,q),gh=evalq(g,q);
            F lhs=fixedres(fh,21,gh,21);
            F rhs=ff::mul(leads[i],ff::mul(ff::pow(q,valuations[i]),eval(S[i],q)));
            bad[n]=(lhs!=rhs);drop[n]=(fh.deg()<21||gh.deg()<21);
        }
        if(std::accumulate(bad.begin(),bad.end(),0))throw std::runtime_error("direct polynomial identity check");
        std::cout<<"DIRECT_GLOBAL_IDENTITY endpoint "<<x<<" q_degree_bound "<<bound
                 <<" distinct_nodes "<<N<<" degree_drop_nodes "
                 <<std::accumulate(drop.begin(),drop.end(),0)<<" PASS\n";
    }
    std::cout<<"DIRECT_POLE_CERTIFICATE PASS all_three_resultants all_three_Bezout_identities; GLOBAL_SQUARE_LOCUS_UNRESOLVED\n";
}catch(const std::exception&e){std::cerr<<"ERROR "<<e.what()<<"\n";return 1;}return 0;}
