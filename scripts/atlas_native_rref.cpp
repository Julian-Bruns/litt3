// Exact FLINT linear algebra over F5[z]/(irreducible f), for EVERY degree.
// Chart parallelism is outside this process. No probabilistic specialization.
#include <flint/flint.h>
#include <flint/fq_nmod.h>
#include <flint/fq_nmod_mat.h>
#include <flint/nmod_poly.h>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>
using namespace std;

template<class T> T read_value(ifstream& in) {
    T value; in.read(reinterpret_cast<char*>(&value),sizeof(value));
    if (!in) throw runtime_error("truncated exact matrix input");
    return value;
}
template<class T> void write_value(ofstream& out,T value) {
    out.write(reinterpret_cast<const char*>(&value),sizeof(value));
}
void read_element(ifstream& in,fq_nmod_t value,uint32_t degree) {
    uint32_t n=read_value<uint32_t>(in);
    if (n>degree) throw runtime_error("noncanonical field coefficient");
    for(uint32_t i=0;i<n;++i) {
        auto c=read_value<uint8_t>(in);
        if(c>=5) throw runtime_error("coefficient outside F5");
        nmod_poly_set_coeff_ui(value,i,c);
    }
}
void write_element(ofstream& out,const fq_nmod_t value) {
    uint32_t n=nmod_poly_length(value); write_value(out,n);
    for(uint32_t i=0;i<n;++i) write_value(out,uint8_t(nmod_poly_get_coeff_ui(value,i)));
}

void read_matrix(ifstream& in,fq_nmod_mat_t M,uint32_t rows,uint32_t cols,
                 uint32_t degree,const fq_nmod_ctx_t field) {
    for(uint32_t i=0;i<rows;++i) {
        uint32_t terms=read_value<uint32_t>(in),last=0;
        if(terms>cols) throw runtime_error("too many product-row entries");
        for(uint32_t h=0;h<terms;++h) {
            uint32_t j=read_value<uint32_t>(in);
            if(j>=cols || (h && j<=last)) throw runtime_error("noncanonical product row");
            last=j; read_element(in,fq_nmod_mat_entry(M,i,j),degree);
        }
    }
}

int product(ifstream& in,const char* target,bool base_left) {
    auto begin=chrono::steady_clock::now();
    auto seconds=[&](){return chrono::duration<double>(chrono::steady_clock::now()-begin).count();};
    uint32_t degree=read_value<uint32_t>(in),rows=read_value<uint32_t>(in),
        inner=read_value<uint32_t>(in),cols=read_value<uint32_t>(in);
    if(!degree || degree>100000 || !rows || rows>100000 || !inner || inner>100000 || !cols || cols>100000)
        throw runtime_error("invalid exact product dimensions");
    nmod_poly_t modulus; nmod_poly_init(modulus,5);
    for(uint32_t i=0;i<=degree;++i) {
        auto c=read_value<uint8_t>(in);
        if(c>=5) throw runtime_error("invalid product modulus coefficient");
        nmod_poly_set_coeff_ui(modulus,i,c);
    }
    if(nmod_poly_degree(modulus)!=degree || nmod_poly_get_coeff_ui(modulus,degree)!=1)
        throw runtime_error("invalid product modulus");
    fq_nmod_ctx_t field; fq_nmod_ctx_init_modulus(field,modulus,"z");
    fq_nmod_mat_t left,right,answer;
    fq_nmod_mat_init(left,base_left ? 0 : rows,inner,field);
    fq_nmod_mat_init(right,inner,cols,field); fq_nmod_mat_init(answer,rows,cols,field);
    fq_nmod_t a,test,temp0,temp1; fq_nmod_init(a,field); fq_nmod_init(test,field);
    fq_nmod_init(temp0,field); fq_nmod_init(temp1,field);
    vector<uint8_t> c0,c1;
    if(base_left) {
        read_element(in,a,degree);
        fq_nmod_mul(test,a,a,field); nmod_poly_scalar_addmul_nmod(test,a,4);
        fq_nmod_set_ui(temp0,2,field); fq_nmod_add(test,test,temp0,field);
        if(!fq_nmod_is_zero(test,field)) throw runtime_error("wrong F25 embedding");
        c0.resize(size_t(rows)*inner); c1.resize(size_t(rows)*inner);
        for(size_t i=0;i<c0.size();++i) {
            c0[i]=read_value<uint8_t>(in); c1[i]=read_value<uint8_t>(in);
            if(c0[i]>=5 || c1[i]>=5) throw runtime_error("invalid F25 product coefficient");
        }
    } else read_matrix(in,left,rows,inner,degree,field);
    read_matrix(in,right,inner,cols,degree,field);
    if(in.peek()!=EOF) throw runtime_error("trailing exact product input");
    double loaded=seconds();
    if(base_left) {
        for(uint32_t i=0;i<rows;++i) for(uint32_t j=0;j<cols;++j) {
            fq_nmod_zero(temp0,field); fq_nmod_zero(temp1,field);
            for(uint32_t h=0;h<inner;++h) {
                size_t at=size_t(i)*inner+h;
                if(c0[at]) nmod_poly_scalar_addmul_nmod(temp0,fq_nmod_mat_entry(right,h,j),c0[at]);
                if(c1[at]) nmod_poly_scalar_addmul_nmod(temp1,fq_nmod_mat_entry(right,h,j),c1[at]);
            }
            fq_nmod_mul(fq_nmod_mat_entry(answer,i,j),a,temp1,field);
            fq_nmod_add(fq_nmod_mat_entry(answer,i,j),fq_nmod_mat_entry(answer,i,j),temp0,field);
        }
    } else fq_nmod_mat_mul(answer,left,right,field);
    double multiplied=seconds(); ofstream out(target,ios::binary);
    write_value(out,uint64_t(0x41544c41534d4f31ULL)); write_value(out,degree);
    write_value(out,rows); write_value(out,cols);
    for(uint32_t i=0;i<rows;++i) for(uint32_t j=0;j<cols;++j)
        write_element(out,fq_nmod_mat_entry(answer,i,j));
    out.close(); if(!out) throw runtime_error("failed exact product output");
    cout<<"{\"backend\":\"FLINT_fq_nmod_"<<(base_left ? "F25_product" : "product")
        <<"\",\"degree_F5\":"<<degree<<",\"rows\":"<<rows<<",\"inner\":"<<inner
        <<",\"columns\":"<<cols<<",\"read_seconds\":"<<loaded
        <<",\"multiply_seconds\":"<<multiplied-loaded<<",\"total_seconds\":"<<seconds()<<"}"<<endl;
    fq_nmod_clear(temp1,field); fq_nmod_clear(temp0,field); fq_nmod_clear(test,field); fq_nmod_clear(a,field);
    fq_nmod_mat_clear(answer,field); fq_nmod_mat_clear(right,field); fq_nmod_mat_clear(left,field);
    fq_nmod_ctx_clear(field); nmod_poly_clear(modulus); flint_cleanup(); return 0;
}

int main(int argc,char** argv) {
    try {
        if(argc!=3) throw runtime_error("usage: atlas_native_rref INPUT OUTPUT");
        auto begin=chrono::steady_clock::now();
        auto seconds=[&](){return chrono::duration<double>(chrono::steady_clock::now()-begin).count();};
        flint_set_num_threads(1);
        ifstream in(argv[1],ios::binary);
        auto magic=read_value<uint64_t>(in);
        if(magic==0x41544c41534d5531ULL || magic==0x41544c4153424131ULL)
            return product(in,argv[2],magic==0x41544c4153424131ULL);
        if(magic!=0x41544c4153465131ULL) throw runtime_error("wrong matrix format");
        uint32_t degree=read_value<uint32_t>(in),rows=read_value<uint32_t>(in),cols=read_value<uint32_t>(in);
        if(!degree || degree>100000 || !rows || rows>100000 || !cols || cols>100000)
            throw runtime_error("invalid matrix dimensions");
        nmod_poly_t modulus; nmod_poly_init(modulus,5);
        for(uint32_t i=0;i<=degree;++i) {
            auto c=read_value<uint8_t>(in);
            if(c>=5) throw runtime_error("modulus coefficient outside F5");
            nmod_poly_set_coeff_ui(modulus,i,c);
        }
        if(nmod_poly_degree(modulus)!=degree || nmod_poly_get_coeff_ui(modulus,degree)!=1)
            throw runtime_error("field modulus must be monic of the stated degree");
        fq_nmod_ctx_t field; fq_nmod_ctx_init_modulus(field,modulus,"z");
        fq_nmod_mat_t original,augmented,reduced;
        fq_nmod_mat_init(original,rows,cols,field);
        fq_nmod_mat_init(augmented,rows,cols+rows,field);
        fq_nmod_mat_init(reduced,rows,cols+rows,field);
        for(uint32_t i=0;i<rows;++i) {
            uint32_t terms=read_value<uint32_t>(in),last=0;
            if(terms>cols) throw runtime_error("too many row entries");
            for(uint32_t h=0;h<terms;++h) {
                uint32_t j=read_value<uint32_t>(in);
                if(j>=cols || (h && j<=last)) throw runtime_error("noncanonical sparse row");
                last=j; read_element(in,fq_nmod_mat_entry(original,i,j),degree);
                fq_nmod_set(fq_nmod_mat_entry(augmented,i,j),fq_nmod_mat_entry(original,i,j),field);
            }
            fq_nmod_one(fq_nmod_mat_entry(augmented,i,cols+i),field);
        }
        if(in.peek()!=EOF) throw runtime_error("trailing matrix input");
        double loaded=seconds();
        if(fq_nmod_mat_rref(reduced,augmented,field)!=rows) throw runtime_error("augmented identity rank lost");
        double eliminated=seconds(); uint32_t rank=0;
        for(uint32_t i=0;i<rows;++i) {
            bool nonzero=false;
            for(uint32_t j=0;j<cols;++j) nonzero |= !fq_nmod_is_zero(fq_nmod_mat_entry(reduced,i,j),field);
            if(nonzero) {
                if(i!=rank) throw runtime_error("noncanonical RREF row order");
                ++rank;
            }
        }
        // Verify the complete original-row identity, not only a reported rank.
        fq_nmod_mat_t combinations,answer,check;
        fq_nmod_mat_init(combinations,rank,rows,field);
        fq_nmod_mat_init(answer,rank,cols,field);
        fq_nmod_mat_init(check,rank,cols,field);
        for(uint32_t i=0;i<rank;++i) {
            for(uint32_t j=0;j<cols;++j)
                fq_nmod_set(fq_nmod_mat_entry(answer,i,j),fq_nmod_mat_entry(reduced,i,j),field);
            for(uint32_t j=0;j<rows;++j)
                fq_nmod_set(fq_nmod_mat_entry(combinations,i,j),fq_nmod_mat_entry(reduced,i,cols+j),field);
        }
        fq_nmod_mat_mul(check,combinations,original,field);
        if(!fq_nmod_mat_equal(check,answer,field)) throw runtime_error("C times original != reduced rows");
        double verified=seconds();
        ofstream out(argv[2],ios::binary);
        write_value(out,uint64_t(0x41544c4153525231ULL)); write_value(out,degree);
        write_value(out,rows); write_value(out,cols); write_value(out,rank);
        for(uint32_t i=0;i<rank;++i)
            for(uint32_t j=0;j<cols+rows;++j) write_element(out,fq_nmod_mat_entry(reduced,i,j));
        out.close(); if(!out) throw runtime_error("failed exact matrix output");
        cout<<"{\"backend\":\"FLINT_fq_nmod\",\"degree_F5\":"<<degree
            <<",\"rows\":"<<rows<<",\"columns\":"<<cols<<",\"rank\":"<<rank
            <<",\"read_seconds\":"<<loaded<<",\"rref_seconds\":"<<eliminated-loaded
            <<",\"identity_verification_seconds\":"<<verified-eliminated
            <<",\"total_seconds\":"<<seconds()<<",\"original_row_identity_verified\":true}"<<endl;
        fq_nmod_mat_clear(check,field); fq_nmod_mat_clear(answer,field); fq_nmod_mat_clear(combinations,field);
        fq_nmod_mat_clear(reduced,field); fq_nmod_mat_clear(augmented,field); fq_nmod_mat_clear(original,field);
        fq_nmod_ctx_clear(field); nmod_poly_clear(modulus); flint_cleanup();
        return 0;
    } catch(const exception& e) { cerr<<e.what()<<endl; return 1; }
}
