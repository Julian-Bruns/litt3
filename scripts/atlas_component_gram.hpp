// Exact target-component restriction of a factored Macaulay matrix.
// A row joins all its nonzero columns. Rows in other support components
// cannot contribute to e_last, so the entire Krylov search stays here.
// Optional row masks restrict the candidate search, not final verification.
// Groups retain the original repeated-coefficient tables; no row reduction.
#include <map>
#include <numeric>

struct ComponentGram {
    struct Part {
        uint32_t neq,nbase,nmult;
        std::vector<uint32_t> input_map,row_map;
        std::array<std::vector<float>,3> table,input,output;
        size_t offset;
        bool prime=false;
        void run(const Bytes&x,const Bytes&diagonal,Bytes&coded) {
            size_t n=size_t(nbase)*nmult;
            for(size_t p=0;p<n;p++) {
                auto c=x[input_map[p]];
                input[0][p]=c%5;input[1][p]=c/5;input[2][p]=c%5+c/5;
            }
            for(int c=0;c<(prime?2:3);c++)cblas_sgemm(CblasRowMajor,CblasNoTrans,CblasNoTrans,
                neq,nmult,nbase,1,table[prime?0:c].data(),nbase,input[c].data(),nmult,
                0,output[c].data(),nmult);
            for(size_t p=0;p<size_t(neq)*nmult;p++) {
                uint32_t t0=output[0][p],t1=output[1][p];
                uint32_t t2=prime?0:output[2][p];
                auto a=prime?t0%5+5*(t1%5):(t0+3*t1)%5+5*((t2-t0)%5);
                auto c=product[a][diagonal[row_map[p]]];
                input[0][p]=c%5;input[1][p]=c/5;input[2][p]=c%5+c/5;
            }
            for(int c=0;c<(prime?2:3);c++)cblas_sgemm(CblasRowMajor,CblasTrans,CblasNoTrans,
                nbase,nmult,neq,1,table[prime?0:c].data(),nbase,input[c].data(),nmult,
                0,output[c].data(),nmult);
            for(size_t p=0;p<n;p++) {
                uint32_t t0=output[0][p],t1=output[1][p];
                uint32_t t2=prime?0:output[2][p];
                coded[offset+p]=prime?t0%5+5*(t1%5):(t0+3*t1)%5+5*((t2-t0)%5);
            }
        }
    };
    uint32_t cols,active_columns=0,active_rows=0;
    Bytes active,coded;
    std::vector<uint32_t> ptr,idx;
    std::vector<Part> parts;
    explicit ComponentGram(const CSR&M,const MacaulayFactor&F,
                           const Bytes*row_mask=nullptr,bool prime=false):cols(M.cols),active(M.cols,0) {
        if(row_mask&&row_mask->size()!=M.rows)throw std::runtime_error("invalid component row mask");
        std::vector<uint32_t> parent(cols),size(cols,1);
        std::iota(parent.begin(),parent.end(),0);
        auto root=[&](uint32_t a){while(parent[a]!=a){parent[a]=parent[parent[a]];a=parent[a];}return a;};
        for(uint32_t r=0;r<M.rows;r++)if((!row_mask||(*row_mask)[r])&&M.ptr[r]<M.ptr[r+1]) {
            auto first=M.idx[M.ptr[r]];
            for(auto p=M.ptr[r]+1;p<M.ptr[r+1];p++) {
                auto a=root(first),b=root(M.idx[p]);if(a==b)continue;
                if(size[a]<size[b])std::swap(a,b);
                parent[b]=a;size[a]+=size[b];
            }
        }
        auto target=root(cols-1);
        for(uint32_t c=0;c<cols;c++)if(root(c)==target){active[c]=1;++active_columns;}
        // Nothing to prune: the caller retains its faster persistent-team
        // full operator. Avoid allocating a duplicate full coefficient map.
        if(active_columns==cols&&!row_mask)return;
        std::map<Bytes,std::vector<uint32_t>> groups;
        for(uint32_t m=0;m<F.nmult;m++) {
            Bytes mask(F.neq,0);
            for(uint32_t e=0;e<F.neq;e++) {
                auto r=m*F.neq+e;
                if((!row_mask||(*row_mask)[r])&&M.ptr[r]<M.ptr[r+1])mask[e]=active[M.idx[M.ptr[r]]];
                active_rows+=mask[e];
            }
            groups[mask].push_back(m);
        }
        ptr.assign(size_t(cols)+1,0);
        size_t offset=0;
        for(const auto&group:groups) {
            std::vector<uint32_t> equations,bases;
            for(uint32_t e=0;e<F.neq;e++)if(group.first[e])equations.push_back(e);
            if(equations.empty())continue;
            for(uint32_t b=0;b<F.nbase;b++) {
                bool present=false;
                for(auto e:equations)if(F.table[0][size_t(e)*F.nbase+b]||F.table[1][size_t(e)*F.nbase+b])present=true;
                if(present)bases.push_back(b);
            }
            Part p;p.neq=equations.size();p.nbase=bases.size();p.nmult=group.second.size();p.offset=offset;p.prime=prime;
            auto cap=size_t(std::max(p.neq,p.nbase))*p.nmult;
            for(auto&v:p.input)v.resize(cap);for(auto&v:p.output)v.resize(cap);
            for(int c=0;c<3;c++) {
                p.table[c].reserve(size_t(p.neq)*p.nbase);
                for(auto e:equations)for(auto b:bases)p.table[c].push_back(F.table[c][size_t(e)*F.nbase+b]);
            }
            for(auto b:bases)for(auto m:group.second) {
                auto col=F.map[size_t(b)*F.nmult+m];
                if(!active[col])throw std::runtime_error("inconsistent target support block");
                p.input_map.push_back(col);++ptr[col+1];
            }
            for(auto e:equations)for(auto m:group.second)p.row_map.push_back(m*F.neq+e);
            offset+=p.input_map.size();parts.push_back(std::move(p));
        }
        if(offset>UINT32_MAX)throw std::runtime_error("target map too large");
        for(size_t i=1;i<ptr.size();i++)ptr[i]+=ptr[i-1];
        auto next=ptr;idx.resize(offset);coded.resize(offset);
        for(const auto&p:parts)for(size_t j=0;j<p.input_map.size();j++)idx[next[p.input_map[j]]++]=p.offset+j;
    }
    void gram(const Bytes&x,const Bytes&d,Bytes&y) {
        #pragma omp parallel for schedule(dynamic,1)
        for(size_t i=0;i<parts.size();i++)parts[i].run(x,d,coded);
        y.resize(cols);
        #pragma omp parallel for schedule(static)
        for(uint32_t j=0;j<cols;j++) {
            uint64_t a=0,b=0;
            for(auto p=ptr[j];p<ptr[j+1];p++){auto c=coded[idx[p]];a+=c%5;b+=c/5;}
            y[j]=a%5+5*(b%5);
        }
    }
};
