// Exact coefficient-table factorization of a repeated-multiplier matrix.
// Requires CSR/F25 definitions from atlas_sparse_blackbox.cpp.
// All source terms are checked, not merely sampled. Accelerate computes
// sums of nonnegative integers <=64*max(neq,nbase)<2^24, exactly in FP32.
// Accepted proof certificates are still replayed with scalar arithmetic.
#include <Accelerate/Accelerate.h>

struct MacaulayFactor {
    uint32_t rows,cols,neq,nbase,nmult;
    std::vector<uint32_t> map,reverse_ptr,reverse_idx;
    std::array<std::vector<float>,3> table,input,output;
    Bytes coded;
    explicit MacaulayFactor(const CSR& M,uint32_t equations):
        rows(M.rows),cols(M.cols),neq(equations) {
        if(!neq||rows%neq)throw std::runtime_error("invalid equation block size");
        nmult=rows/neq;
        std::vector<int32_t> basis(cols,-1);
        nbase=0;
        for(uint32_t i=0;i<neq;i++)for(auto j=M.ptr[i];j<M.ptr[i+1];j++)
            if(basis[M.idx[j]]<0)basis[M.idx[j]]=nbase++;
        if(uint64_t(64)*std::max(nbase,neq)>=(1<<24))
            throw std::runtime_error("FP32 exact-integer bound exceeded");
        map.assign(size_t(nbase)*nmult,UINT32_MAX);
        for(auto& f:table)f.assign(size_t(neq)*nbase,0);
        for(uint32_t i=0;i<neq;i++)for(auto j=M.ptr[i];j<M.ptr[i+1];j++) {
            size_t p=size_t(i)*nbase+basis[M.idx[j]];auto c=M.val[j];
            if(table[0][p]||table[1][p])throw std::runtime_error("duplicate base term");
            table[0][p]=c%5;table[1][p]=c/5;table[2][p]=c%5+c/5;
        }
        for(uint32_t m=0;m<nmult;m++)for(uint32_t i=0;i<neq;i++) {
            auto start=M.ptr[size_t(m)*neq+i],end=M.ptr[size_t(m)*neq+i+1];
            if(end-start!=M.ptr[i+1]-M.ptr[i])throw std::runtime_error("nonrepeated term count");
            for(auto p=start;p<end;p++) {
                auto q=M.ptr[i]+p-start;
                if(M.val[p]!=M.val[q])throw std::runtime_error("nonrepeated coefficient");
                auto& dest=map[size_t(basis[M.idx[q]])*nmult+m];
                if(dest!=UINT32_MAX&&dest!=M.idx[p])throw std::runtime_error("inconsistent monomial product");
                dest=M.idx[p];
            }
        }
        reverse_ptr.assign(size_t(cols)+1,0);
        for(auto col:map){if(col==UINT32_MAX)throw std::runtime_error("missing product index");++reverse_ptr[col+1];}
        for(size_t j=1;j<reverse_ptr.size();j++)reverse_ptr[j]+=reverse_ptr[j-1];
        auto next=reverse_ptr;reverse_idx.resize(map.size());
        for(size_t p=0;p<map.size();p++)reverse_idx[next[map[p]]++]=p;
        size_t cap=size_t(std::max(nbase,neq))*nmult;
        for(auto& a:input)a.resize(cap);
        for(auto& a:output)a.resize(cap);
        coded.resize(size_t(nbase)*nmult);
    }
    void apply(const Bytes& x,Bytes& y,bool transpose=false) {
        if(x.size()!=(transpose?rows:cols))throw std::runtime_error("bad factored vector");
        uint32_t k=transpose?neq:nbase,m=transpose?nbase:neq;
        #pragma omp parallel for schedule(static)
        for(size_t p=0;p<size_t(k)*nmult;p++) {
            auto c=transpose?x[(p%nmult)*neq+p/nmult]:x[map[p]];
            input[0][p]=c%5;input[1][p]=c/5;input[2][p]=c%5+c/5;
        }
        for(int component=0;component<3;component++)
            cblas_sgemm(CblasRowMajor,transpose?CblasTrans:CblasNoTrans,CblasNoTrans,
                m,nmult,k,1,table[component].data(),nbase,
                input[component].data(),nmult,0,output[component].data(),nmult);
        y.resize(transpose?cols:rows);
        #pragma omp parallel for schedule(static)
        for(size_t p=0;p<size_t(m)*nmult;p++) {
            uint32_t t0=output[0][p],t1=output[1][p],t2=output[2][p];
            uint8_t c=(t0+3*t1)%5+5*((t2-t0)%5);
            if(transpose)coded[p]=c;else y[(p%nmult)*neq+p/nmult]=c;
        }
        if(transpose) {
            #pragma omp parallel for schedule(static)
            for(uint32_t j=0;j<cols;j++) {
                uint64_t a0=0,a1=0;
                for(auto p=reverse_ptr[j];p<reverse_ptr[j+1];p++) {
                    auto c=coded[reverse_idx[p]];a0+=c%5;a1+=c/5;
                }
                y[j]=a0%5+5*(a1%5);
            }
        }
    }
    // Fused M^t diag(d) M: keep the small dense intermediate in its
    // native layout, and reduce only once per final output coordinate.
    // This avoids two full layout conversions and a temporary row vector.
    void gram(const Bytes& x,const Bytes& diagonal,Bytes& y) {
        if(x.size()!=cols||diagonal.size()!=rows)throw std::runtime_error("bad Gram vectors");
        #pragma omp parallel for schedule(static)
        for(size_t p=0;p<map.size();p++) {
            auto c=x[map[p]];input[0][p]=c%5;input[1][p]=c/5;input[2][p]=c%5+c/5;
        }
        for(int c=0;c<3;c++)
            cblas_sgemm(CblasRowMajor,CblasNoTrans,CblasNoTrans,neq,nmult,nbase,
                1,table[c].data(),nbase,input[c].data(),nmult,0,output[c].data(),nmult);
        #pragma omp parallel for schedule(static)
        for(size_t p=0;p<size_t(neq)*nmult;p++) {
            uint32_t t0=output[0][p],t1=output[1][p],t2=output[2][p];
            auto d=diagonal[(p%nmult)*neq+p/nmult];
            uint32_t a0=(t0+3*t1)%5,a1=(t2-t0)%5,d0=d%5,d1=d/5;
            auto c0=(a0*d0+3*a1*d1)%5,c1=(a0*d1+a1*d0+a1*d1)%5;
            input[0][p]=c0;input[1][p]=c1;input[2][p]=c0+c1;
        }
        for(int c=0;c<3;c++)
            cblas_sgemm(CblasRowMajor,CblasTrans,CblasNoTrans,nbase,nmult,neq,
                1,table[c].data(),nbase,input[c].data(),nmult,0,output[c].data(),nmult);
        y.resize(cols);
        #pragma omp parallel for schedule(static)
        for(uint32_t j=0;j<cols;j++) {
            uint64_t a0=0,a1=0;
            for(auto p=reverse_ptr[j];p<reverse_ptr[j+1];p++) {
                auto h=reverse_idx[p];
                uint32_t t0=output[0][h],t1=output[1][h],t2=output[2][h];
                a0+=t0+3*t1;a1+=t2-t0;
            }
            y[j]=a0%5+5*(a1%5);
        }
    }
    // Multiple independent Krylov directions, interleaved by coordinate.
    // Diagnostic alternative: retain one OpenMP team across the five stages
    // and run the three independent field-component GEMMs concurrently.
    // No arithmetic change; use only after original scalar replay/timing.
    void gram_team(const Bytes& x,const Bytes& diagonal,Bytes& y) {
        if(x.size()!=cols||diagonal.size()!=rows)throw std::runtime_error("bad Gram vectors");
        y.resize(cols);
        #pragma omp parallel
        {
            #pragma omp for schedule(runtime)
            for(size_t p=0;p<map.size();p++) {
                auto c=x[map[p]];input[0][p]=c%5;input[1][p]=c/5;input[2][p]=c%5+c/5;
            }
            #pragma omp for schedule(static)
            for(int c=0;c<3;c++)
                cblas_sgemm(CblasRowMajor,CblasNoTrans,CblasNoTrans,neq,nmult,nbase,
                    1,table[c].data(),nbase,input[c].data(),nmult,0,output[c].data(),nmult);
            #pragma omp for schedule(runtime)
            for(size_t p=0;p<size_t(neq)*nmult;p++) {
                uint32_t t0=output[0][p],t1=output[1][p],t2=output[2][p];
                auto d=diagonal[(p%nmult)*neq+p/nmult];
                uint32_t a0=(t0+3*t1)%5,a1=(t2-t0)%5,d0=d%5,d1=d/5;
                auto c0=(a0*d0+3*a1*d1)%5,c1=(a0*d1+a1*d0+a1*d1)%5;
                input[0][p]=c0;input[1][p]=c1;input[2][p]=c0+c1;
            }
            #pragma omp for schedule(static)
            for(int c=0;c<3;c++)
                cblas_sgemm(CblasRowMajor,CblasTrans,CblasNoTrans,nbase,nmult,neq,
                    1,table[c].data(),nbase,input[c].data(),nmult,0,output[c].data(),nmult);
            #pragma omp for schedule(runtime)
            for(uint32_t j=0;j<cols;j++) {
                uint64_t a0=0,a1=0;
                for(auto p=reverse_ptr[j];p<reverse_ptr[j+1];p++) {
                    auto h=reverse_idx[p];
                    uint32_t t0=output[0][h],t1=output[1][h],t2=output[2][h];
                    a0+=t0+3*t1;a1+=t2-t0;
                }
                y[j]=a0%5+5*(a1%5);
            }
        }
    }

    // Multiple independent Krylov directions, interleaved by coordinate.
    // The coefficient table and monomial map are shared by every column.
    void gram_block(const Bytes& x,const Bytes& diagonal,Bytes& y,uint32_t block) {
        if(block==1){gram(x,diagonal,y);return;}
        if(!block||x.size()!=size_t(cols)*block||diagonal.size()!=rows)
            throw std::runtime_error("bad block Gram dimensions");
        size_t width=size_t(nmult)*block,cap=size_t(std::max(nbase,neq))*width;
        for(auto&v:input)v.resize(cap);for(auto&v:output)v.resize(cap);
        #pragma omp parallel for schedule(static)
        for(size_t p=0;p<map.size();p++)for(uint32_t j=0;j<block;j++) {
            auto c=x[size_t(map[p])*block+j];size_t q=p*block+j;
            input[0][q]=c%5;input[1][q]=c/5;input[2][q]=c%5+c/5;
        }
        for(int c=0;c<3;c++)
            cblas_sgemm(CblasRowMajor,CblasNoTrans,CblasNoTrans,neq,width,nbase,
                1,table[c].data(),nbase,input[c].data(),width,0,output[c].data(),width);
        #pragma omp parallel for schedule(static)
        for(size_t p=0;p<size_t(neq)*nmult;p++) {
            auto d=diagonal[(p%nmult)*neq+p/nmult];uint32_t d0=d%5,d1=d/5;
            for(uint32_t j=0;j<block;j++) {
                size_t q=p*block+j;uint32_t t0=output[0][q],t1=output[1][q],t2=output[2][q];
                uint32_t a0=(t0+3*t1)%5,a1=(t2-t0)%5;
                auto c0=(a0*d0+3*a1*d1)%5,c1=(a0*d1+a1*d0+a1*d1)%5;
                input[0][q]=c0;input[1][q]=c1;input[2][q]=c0+c1;
            }
        }
        for(int c=0;c<3;c++)
            cblas_sgemm(CblasRowMajor,CblasTrans,CblasNoTrans,nbase,width,neq,
                1,table[c].data(),nbase,input[c].data(),width,0,output[c].data(),width);
        y.resize(size_t(cols)*block);
        #pragma omp parallel for schedule(static)
        for(uint32_t j=0;j<cols;j++)for(uint32_t c=0;c<block;c++) {
            uint64_t a0=0,a1=0;
            for(auto p=reverse_ptr[j];p<reverse_ptr[j+1];p++) {
                auto h=size_t(reverse_idx[p])*block+c;
                uint32_t t0=output[0][h],t1=output[1][h],t2=output[2][h];
                a0+=t0+3*t1;a1+=t2-t0;
            }
            y[size_t(j)*block+c]=a0%5+5*(a1%5);
        }
    }
};
