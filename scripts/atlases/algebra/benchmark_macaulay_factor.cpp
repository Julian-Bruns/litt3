// Short, complete-coordinate validation/benchmark, not an ideal solver.
#define ATLAS_BLACKBOX_LIBRARY
#include "atlas_sparse_blackbox.cpp"
#include "../native/atlas_macaulay_factor.hpp"
#include <sys/resource.h>
int main(int argc,char**argv)try {
    if(argc<3)throw std::runtime_error("usage: program matrix.bin equation_count [repetitions=100] [threads=10] [block_test=0]");
    unsigned threads=argc>4?std::stoul(argv[4]):10;
    if(!threads||threads>10)throw std::runtime_error("thread limit");
    omp_set_num_threads(threads);omp_set_dynamic(0);init_field();
    CSR M(argv[1]),MT=M.transpose();MacaulayFactor F(M,std::stoul(argv[2]));
    unsigned repetitions=argc>3?std::stoul(argv[3]):100;
    std::cout<<"{\"equations\":"<<F.neq<<",\"base_monomials\":"<<F.nbase
        <<",\"multipliers\":"<<F.nmult<<",\"all_source_terms_verified\":true}"<<std::endl;
    std::mt19937 rng(20260909);
    if(argc>5&&std::string(argv[5])=="team") {
        Bytes x(M.cols),d(M.rows),baseline,parallel,tmp,reference;
        for(auto&c:d)c=1+rng()%24;
        for(int trial=0;trial<3;trial++) {
            for(auto&c:x)c=trial==0?24:rng()%25;
            F.gram(x,d,baseline);F.gram_team(x,d,parallel);
            M.apply(x,tmp,1,true);for(size_t j=0;j<tmp.size();j++)tmp[j]=product[tmp[j]][d[j]];
            MT.apply(tmp,reference,1,true);
            if(baseline!=reference||parallel!=reference)throw std::runtime_error("team/scalar mismatch");
        }
        for(int round=0;round<3;round++)for(int mode=0;mode<2;mode++) {
            auto cpu=[](){rusage r;getrusage(RUSAGE_SELF,&r);return double(r.ru_utime.tv_sec+r.ru_stime.tv_sec)+1e-6*(r.ru_utime.tv_usec+r.ru_stime.tv_usec);};
            double cpu_start=cpu();
            auto start=Clock::now();
            for(unsigned i=0;i<repetitions;i++) {
                x[i%x.size()]=i%25;
                if(mode)F.gram_team(x,d,parallel);else F.gram(x,d,parallel);
            }
            double elapsed=std::chrono::duration<double>(Clock::now()-start).count();
            std::cout<<"{\"round\":"<<round<<",\"team\":"<<mode<<",\"threads\":"<<threads
                <<",\"seconds_per_gram\":"<<elapsed/repetitions<<",\"cpu_cores\":"<<(cpu()-cpu_start)/elapsed
                <<",\"scalar_replay\":true}"<<std::endl;
        }
        return 0;
    }
    if(argc>5&&std::stoul(argv[5])) {
        Bytes d(M.rows);for(auto&c:d)c=1+rng()%24;
        for(unsigned block:{1,2,4,8,16}) {
            Bytes x(size_t(M.cols)*block),y,tmp,ref;for(auto&c:x)c=rng()%25;
            F.gram_block(x,d,y,block);
            M.apply(x,tmp,block,true);
            for(size_t i=0;i<tmp.size();i++)tmp[i]=product[tmp[i]][d[i/block]];
            MT.apply(tmp,ref,block,true);
            if(y!=ref)throw std::runtime_error("block Gram scalar replay failed");
            auto t=Clock::now();
            for(unsigned j=0;j<repetitions;j++){x[j%x.size()]=j%25;F.gram_block(x,d,y,block);}
            double dt=std::chrono::duration<double>(Clock::now()-t).count()/repetitions;
            t=Clock::now();
            for(unsigned j=0;j<repetitions;j++) {
                x[j%x.size()]=j%25;M.apply(x,tmp,block);
                #pragma omp parallel for schedule(static)
                for(size_t i=0;i<tmp.size();i++)tmp[i]=product[tmp[i]][d[i/block]];
                MT.apply(tmp,y,block);
            }
            double csr=std::chrono::duration<double>(Clock::now()-t).count()/repetitions;
            std::cout<<"{\"block\":"<<block<<",\"threads\":"<<threads<<",\"seconds\":"<<dt
              <<",\"seconds_per_direction\":"<<dt/block<<",\"sparse_block_seconds\":"<<csr
              <<",\"sparse_seconds_per_direction\":"<<csr/block<<",\"scalar_replay\":true}"<<std::endl;
        }
        return 0;
    }
    for(bool trans:{false,true}) {
        const CSR& A=trans?MT:M;Bytes x(A.cols),y,reference;
        for(int trial=0;trial<3;trial++) {
            for(auto& c:x)c=trial==0?24:rng()%25;
            F.apply(x,y,trans);A.apply(x,reference,1,true);
            if(y!=reference)throw std::runtime_error("factored/scalar mismatch");
        }
        auto start=Clock::now();
        for(unsigned i=0;i<repetitions;i++){x[i%x.size()]=i%25;F.apply(x,y,trans);}
        double factor=std::chrono::duration<double>(Clock::now()-start).count()/repetitions;
        start=Clock::now();
        for(unsigned i=0;i<repetitions;i++){x[i%x.size()]=i%25;A.apply(x,y,1);}
        double sparse=std::chrono::duration<double>(Clock::now()-start).count()/repetitions;
        std::cout<<"{\"transpose\":"<<(trans?"true":"false")<<",\"full_coordinate_replay\":true"
          <<",\"factored_seconds\":"<<factor<<",\"sparse_seconds\":"<<sparse
          <<",\"speedup\":"<<sparse/factor<<"}"<<std::endl;
    }
    Bytes x(M.cols),d(M.rows),y,tmp,ref;
    for(auto& c:d)c=1+rng()%24;
    for(int trial=0;trial<3;trial++) {
        for(auto& c:x)c=trial==0?24:rng()%25;
        F.gram(x,d,y);M.apply(x,tmp,1,true);
        for(size_t i=0;i<tmp.size();i++)tmp[i]=product[tmp[i]][d[i]];
        MT.apply(tmp,ref,1,true);
        if(y!=ref)throw std::runtime_error("fused Gram/scalar mismatch");
    }
    auto start=Clock::now();
    for(unsigned i=0;i<repetitions;i++){x[i%x.size()]=i%25;F.gram(x,d,y);}
    double fused=std::chrono::duration<double>(Clock::now()-start).count()/repetitions;
    start=Clock::now();
    for(unsigned i=0;i<repetitions;i++) {
        x[i%x.size()]=i%25;F.apply(x,tmp);
        for(size_t j=0;j<tmp.size();j++)tmp[j]=product[tmp[j]][d[j]];
        F.apply(tmp,y,true);
    }
    double separate=std::chrono::duration<double>(Clock::now()-start).count()/repetitions;
    std::cout<<"{\"fused_gram_full_replay\":true,\"fused_seconds\":"<<fused
      <<",\"separate_seconds\":"<<separate<<",\"speedup\":"<<separate/fused<<"}"<<std::endl;
    return 0;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}
