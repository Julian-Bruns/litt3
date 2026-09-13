// Rank-free Wiedemann search for a checked certificate of M^t lambda=e_last.
// Native F25, a^2=a+3. Diagnostic matrix/provenance must identify the actual
// polynomial multiples; an inconsistent ansatz does NOT prove existence.
// Random diagonal squaring need not preserve rank in characteristic five.
// We therefore accept ONLY an independently replayed primal or dual vector.
#define ATLAS_BLACKBOX_LIBRARY
#include "../algebra/atlas_sparse_blackbox.cpp"
#include "atlas_macaulay_factor.hpp"
#include <filesystem>
#include <memory>

static uint8_t subf[25][25],invf[25];
static void extra_tables() {
    for(int a=0;a<25;a++)for(int b=0;b<25;b++) {
        subf[a][b]=(a%5-b%5+5)%5+5*((a/5-b/5+5)%5);
        if(product[a][b]==1)invf[a]=b;
    }
}
static void save(const std::string& file,const Bytes& a) {
    std::ofstream f(file,std::ios::binary);
    f.write((const char*)a.data(),a.size());if(!f)throw std::runtime_error("output write failure");
}
struct GramBox {
    const CSR &M,&MT;
    Bytes diagonal;
    size_t applications=0;
    MacaulayFactor* factor=nullptr;
    void apply(const Bytes& x,Bytes& y) {
        if(factor){factor->gram(x,diagonal,y);++applications;return;}
        Bytes tmp;
        M.apply(x,tmp,1);
        #pragma omp parallel for schedule(static)
        for(size_t i=0;i<tmp.size();i++)tmp[i]=product[diagonal[i]][tmp[i]];
        MT.apply(tmp,y,1);
        ++applications;
    }
};
static uint8_t dot(const Bytes& a,const Bytes& b) {
    uint64_t c0=0,c1=0;
    for(size_t i=0;i<a.size();i++){c0+=lo[a[i]][b[i]];c1+=hi[a[i]][b[i]];}
    return c0%5+5*(c1%5);
}
int main(int argc,char** argv)try {
    if(argc<4)throw std::runtime_error("usage: program matrix.bin out_directory seconds [seed=20260908] [equation_count=0]");
    std::filesystem::path out(argv[2]);
    bool resume=std::filesystem::exists(out/"checkpoint.bin");
    if(!resume&&!std::filesystem::create_directory(out))throw std::runtime_error("use a new output directory or a checkpoint");
    if(std::filesystem::exists(out/"solution.bin")||std::filesystem::exists(out/"dual.bin"))
        throw std::runtime_error("already completed: verify the saved certificate, do not rerun");
    int seed=argc>4?std::stoi(argv[4]):20260908;
    double limit=std::stod(argv[3]);if(limit<=0)throw std::runtime_error("positive time limit required");
    auto start=Clock::now();auto elapsed=[&](){return std::chrono::duration<double>(Clock::now()-start).count();};
    omp_set_num_threads(10);omp_set_dynamic(0);init_field();extra_tables();
    CSR M(argv[1]),MT=M.transpose();GramBox B{M,MT,Bytes(M.rows)};
    std::unique_ptr<MacaulayFactor> factor;
    if(argc>5&&std::stoul(argv[5])) {
        factor=std::make_unique<MacaulayFactor>(M,std::stoul(argv[5]));B.factor=factor.get();
        // Verify every coordinate in both directions before enabling BLAS.
        Bytes probe(M.cols,24),factored,scalar;
        factor->apply(probe,factored);M.apply(probe,scalar,1,true);
        if(factored!=scalar)throw std::runtime_error("factor forward replay failed");
        probe.assign(M.rows,24);factor->apply(probe,factored,true);MT.apply(probe,scalar,1,true);
        if(factored!=scalar)throw std::runtime_error("factor transpose replay failed");
    }
    std::mt19937 rng(seed);for(auto& c:B.diagonal)c=1+rng()%24;
    if(factor) {
        Bytes x(M.cols),y,tmp,reference;for(auto& c:x)c=rng()%25;
        factor->gram(x,B.diagonal,y);M.apply(x,tmp,1,true);
        for(size_t i=0;i<tmp.size();i++)tmp[i]=product[tmp[i]][B.diagonal[i]];
        MT.apply(tmp,reference,1,true);
        if(y!=reference)throw std::runtime_error("fused Gram/scalar replay failed");
        // Do not alter the seeded projection sequence by performing a test.
        rng.seed(seed);for(auto& c:B.diagonal)c=1+rng()%24;
    }
    Bytes u(M.cols),e(M.cols,0),v,next;for(auto& c:u)c=rng()%25;e.back()=1;v=e;
    Bytes seq,C(1,1),old(1,1),z;size_t L=0,shift=1,last_change=0,replay_next=1;
    uint8_t last_discrepancy=1;
    size_t maximum=2*size_t(M.cols)+128;
    uint64_t matrix_hash=1469598103934665603ULL;
    auto hash_bytes=[&](const void* p,size_t n){auto b=(const uint8_t*)p;for(size_t i=0;i<n;i++){matrix_hash^=b[i];matrix_hash*=1099511628211ULL;}};
    hash_bytes(&M.rows,4);hash_bytes(&M.cols,4);hash_bytes(M.ptr.data(),M.ptr.size()*8);
    hash_bytes(M.idx.data(),M.idx.size()*4);hash_bytes(M.val.data(),M.val.size());
    uint32_t phase=0;double inherited=0,last_checkpoint=0;
    if(resume) {
        std::ifstream f(out/"checkpoint.bin",std::ios::binary);
        auto read=[&](auto& x){if(!f.read((char*)&x,sizeof(x)))throw std::runtime_error("truncated checkpoint");};
        uint64_t magic,h,seed_old;read(magic);read(h);read(seed_old);
        if(magic!=0x574945444E415431ULL||h!=matrix_hash||seed_old!=uint64_t(seed))throw std::runtime_error("checkpoint/input mismatch");
        read(phase);read(inherited);read(L);read(shift);read(last_change);read(replay_next);read(last_discrepancy);read(B.applications);
        for(auto* p:{&B.diagonal,&u,&v,&seq,&C,&old,&z}) {
            uint64_t n;read(n);if(n>std::max(size_t(M.rows),maximum)+256)throw std::runtime_error("checkpoint vector too large");
            p->resize(n);if(!f.read((char*)p->data(),n))throw std::runtime_error("truncated checkpoint vector");
            if(std::any_of(p->begin(),p->end(),[](auto c){return c>=25;}))throw std::runtime_error("invalid checkpoint field element");
        }
        if(phase>1||B.diagonal.size()!=M.rows||u.size()!=M.cols||v.size()!=M.cols||L>M.cols+64||last_discrepancy==0)
            throw std::runtime_error("invalid checkpoint dimensions");
        char trailing;if(f.get(trailing))throw std::runtime_error("trailing checkpoint data");
    }
    auto checkpoint=[&](){
        std::ofstream f(out/"checkpoint.tmp",std::ios::binary);
        auto put=[&](auto x){f.write((const char*)&x,sizeof(x));};
        put(uint64_t(0x574945444E415431ULL));put(matrix_hash);put(uint64_t(seed));
        put(phase);put(inherited+elapsed());put(L);put(shift);put(last_change);put(replay_next);put(last_discrepancy);put(B.applications);
        for(auto* p:{&B.diagonal,&u,&v,&seq,&C,&old,&z}){put(uint64_t(p->size()));f.write((const char*)p->data(),p->size());}
        f.close();if(!f)throw std::runtime_error("checkpoint write failed");
        std::filesystem::rename(out/"checkpoint.tmp",out/"checkpoint.bin");last_checkpoint=elapsed();
    };
    std::cout<<"{\"stage\":\"start\",\"rows\":"<<M.rows<<",\"columns\":"<<M.cols
      <<",\"nonzeros\":"<<M.val.size()<<",\"seed\":"<<seed<<",\"rank_assumption\":false,\"resumed\":"<<(resume?"true":"false")
      <<",\"factored_backend\":"<<(factor?"true":"false")<<"}"<<std::endl;
    size_t initial_terms=seq.size();
    for(size_t n=seq.size();phase==0&&n<maximum;n++) {
        seq.push_back(dot(u,v));
        uint8_t discrepancy=seq.back();
        uint64_t d0=discrepancy%5,d1=discrepancy/5;
        for(size_t j=1;j<=L;j++) {
            auto c=j<C.size()?C[j]:0;d0+=lo[c][seq[n-j]];d1+=hi[c][seq[n-j]];
        }
        discrepancy=d0%5+5*(d1%5);
        if(discrepancy) {
            auto previous=C;uint8_t factor=product[discrepancy][invf[last_discrepancy]];
            C.resize(std::max(C.size(),old.size()+shift));
            for(size_t j=0;j<old.size();j++)C[j+shift]=subf[C[j+shift]][product[factor][old[j]]];
            if(2*L<=n){L=n+1-L;old=std::move(previous);last_discrepancy=discrepancy;shift=1;}
            else ++shift;
            last_change=n;
        }else ++shift;
        if(n%2000==0) {
            double rate=(n+1-initial_terms)/std::max(0.001,elapsed());
            // Use the dimension scale until a recurrence has stabilized.
            // Early current-degree extrapolation misleadingly underestimates.
            size_t estimated_sequence_end=std::max(2*size_t(M.cols)+64,n+1);
            std::cout<<"{\"stage\":\"sequence\",\"terms\":"<<n+1<<",\"recurrence_degree\":"<<L
              <<",\"seconds\":"<<elapsed()<<",\"estimated_remaining_seconds\":"
              <<double(estimated_sequence_end-(n+1)+M.cols)/rate
              <<",\"eta_basis\":\"matrix-dimension Krylov and replay work; heuristic\"}"<<std::endl;
        }
        if(n>=2*L+64&&n>=last_change+64)break;
        B.apply(v,next);v.swap(next);
        if(elapsed()-last_checkpoint>=20||elapsed()>limit)checkpoint();
        if(elapsed()>limit){std::cout<<"{\"status\":\"checkpointed_time_limit\",\"seconds\":"<<elapsed()<<"}"<<std::endl;return 2;}
    }
    C.resize(L+1);
    // Do not repeat the quadratic-cost scalar recurrence test. It is not
    // a proof certificate. Final independent scalar M^t lambda=e or
    // Mz=0 replay is both necessary and sufficient for the claimed result.
    save((out/"sequence.bin").string(),seq);save((out/"recurrence.bin").string(),C);
    save((out/"diagonal.bin").string(),B.diagonal);save((out/"projection.bin").string(),u);
    std::cout<<"{\"stage\":\"polynomial_replay\",\"degree\":"<<L<<",\"constant\":"<<int(C[L])
      <<",\"seconds\":"<<elapsed()<<"}"<<std::endl;
    // f(t)=t^L+C1*t^(L-1)+...+CL. Compute (f(t)-CL)/t at B on e.
    if(phase==0){z=e;phase=1;replay_next=1;checkpoint();}
    for(size_t j=replay_next;j<L;j++) {
        B.apply(z,next);z.swap(next);
        // e is exactly the last standard basis vector; never scan all
        // coordinates to add a vector with just one nonzero entry.
        z.back()=add(z.back(),C[j]);
        replay_next=j+1;
        if(j%2000==0)std::cout<<"{\"stage\":\"polynomial_replay\",\"done\":"<<j
            <<",\"total\":"<<L-1<<",\"seconds\":"<<elapsed()<<"}"<<std::endl;
        if(elapsed()-last_checkpoint>=20||elapsed()>limit)checkpoint();
        if(elapsed()>limit){std::cout<<"{\"status\":\"checkpointed_time_limit\",\"seconds\":"<<elapsed()<<"}"<<std::endl;return 2;}
    }
    bool primal=false,dual=false;
    if(C[L]) {
        auto scale=subf[0][invf[C[L]]];for(auto& c:z)c=product[c][scale];
        Bytes lambda;M.apply(z,lambda,1,true);
        for(size_t i=0;i<lambda.size();i++)lambda[i]=product[B.diagonal[i]][lambda[i]];
        MT.apply(lambda,next,1,true);primal=next==e;
        if(primal)save((out/"solution.bin").string(),lambda);
    }else {
        M.apply(z,next,1,true);
        dual=z.back()!=0&&std::all_of(next.begin(),next.end(),[](auto c){return !c;});
        if(dual)save((out/"dual.bin").string(),z);
    }
    std::cout<<"{\"status\":\""<<(primal?"linear_certificate_verified":dual?"bounded_ansatz_dual_verified":"randomized_test_inconclusive")
      <<"\",\"seconds\":"<<elapsed()<<",\"cumulative_seconds\":"<<inherited+elapsed()<<",\"gram_applications\":"<<B.applications
      <<",\"primal_verified\":"<<(primal?"true":"false")<<",\"dual_verified\":"<<(dual?"true":"false")<<"}"<<std::endl;
    return primal||dual?0:2;
}catch(const std::exception& e){std::cerr<<e.what()<<std::endl;return 1;}
