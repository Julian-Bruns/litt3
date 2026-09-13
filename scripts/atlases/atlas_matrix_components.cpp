// Read-only diagnostic: exact support components of the row-column graph.
// Connected components can be solved independently, but this is NOT a
// rank test and does not assert any polynomial-ideal conclusion.
#define ATLAS_BLACKBOX_LIBRARY
#include "algebra/atlas_sparse_blackbox.cpp"
#include <map>
#include <numeric>

int main(int argc,char**argv)try {
    if(argc<2||argc>3)throw std::runtime_error("usage: program matrix.bin [equations]");
    CSR M(argv[1]);std::vector<uint32_t> parent(M.cols),size(M.cols,1);
    std::iota(parent.begin(),parent.end(),0);
    auto root=[&](uint32_t a){while(parent[a]!=a){parent[a]=parent[parent[a]];a=parent[a];}return a;};
    for(uint32_t row=0;row<M.rows;row++) {
        if(M.ptr[row]==M.ptr[row+1])continue;
        auto first=M.idx[M.ptr[row]];
        for(auto j=M.ptr[row]+1;j<M.ptr[row+1];j++) {
            auto a=root(first),b=root(M.idx[j]);
            if(a==b)continue;
            if(size[a]<size[b])std::swap(a,b);
            parent[b]=a;size[a]+=size[b];
        }
    }
    std::map<uint32_t,std::array<uint64_t,3>> counts;
    for(uint32_t col=0;col<M.cols;col++)++counts[root(col)][0];
    for(uint32_t row=0;row<M.rows;row++)if(M.ptr[row]<M.ptr[row+1]) {
        auto&v=counts[root(M.idx[M.ptr[row]])];++v[1];v[2]+=M.ptr[row+1]-M.ptr[row];
    }
    std::map<std::array<uint64_t,3>,uint32_t> histogram;
    for(const auto&kv:counts)++histogram[kv.second];
    auto target=counts[root(M.cols-1)];
    std::cout<<"{\"components\":"<<counts.size()<<",\"target\":{\"columns\":"<<target[0]
       <<",\"rows\":"<<target[1]<<",\"nonzeros\":"<<target[2]<<"},\"histogram\":[";
    bool first=true;
    for(const auto&kv:histogram){if(!first)std::cout<<",";first=false;
        std::cout<<"{\"columns\":"<<kv.first[0]<<",\"rows\":"<<kv.first[1]
         <<",\"nonzeros\":"<<kv.first[2]<<",\"count\":"<<kv.second<<"}";}
    std::cout<<"]";
    if(argc==3) {
        auto neq=std::stoul(argv[2]);
        if(!neq||M.rows%neq)throw std::runtime_error("equation block size");
        std::map<Bytes,size_t> groups;
        auto target_root=root(M.cols-1);
        for(size_t offset=0;offset<M.rows;offset+=neq) {
            Bytes mask(neq,0);
            for(size_t i=0;i<neq;i++)if(M.ptr[offset+i]<M.ptr[offset+i+1])
                mask[i]=root(M.idx[M.ptr[offset+i]])==target_root;
            ++groups[mask];
        }
        std::cout<<",\"multiplier_groups\":[";first=true;
        for(const auto&kv:groups) {
            if(!first)std::cout<<",";first=false;
            std::cout<<"{\"equations\":"<<std::count(kv.first.begin(),kv.first.end(),1)
              <<",\"multipliers\":"<<kv.second<<"}";
        }
        std::cout<<"]";
    }
    std::cout<<"}"<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}
