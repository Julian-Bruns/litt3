// Backup-only low-memory exact solve or separating dual certificate.
// Unlike a full provenance RREF, only ONE right-hand side is carried.
#include <flint/flint.h>
#include <flint/fq_nmod.h>
#include <flint/fq_nmod_mat.h>
#include <flint/nmod_poly.h>
#include <chrono>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <vector>
using namespace std;

template<class T> T read_value(ifstream& in) {
    T value; in.read(reinterpret_cast<char*>(&value),sizeof(value));
    if(!in) throw runtime_error("truncated backup linear input");
    return value;
}
template<class T> void write_value(ofstream& out,T value) {
    out.write(reinterpret_cast<const char*>(&value),sizeof(value));
}
void read_element(ifstream& in,fq_nmod_t value,uint32_t degree) {
    uint32_t n=read_value<uint32_t>(in);
    if(n>degree) throw runtime_error("noncanonical finite-field coefficient");
    for(uint32_t i=0;i<n;++i) {
        uint8_t c=read_value<uint8_t>(in);
        if(c>=5) throw runtime_error("coefficient outside F5");
        nmod_poly_set_coeff_ui(value,i,c);
    }
}
void read_matrix(ifstream& in,fq_nmod_mat_t M,uint32_t rows,uint32_t cols,uint32_t degree) {
    for(uint32_t i=0;i<rows;++i) {
        uint32_t count=read_value<uint32_t>(in),last=0;
        if(count>cols) throw runtime_error("too many sparse row entries");
        for(uint32_t h=0;h<count;++h) {
            uint32_t j=read_value<uint32_t>(in);
            if(j>=cols || (h && j<=last)) throw runtime_error("noncanonical sparse row");
            last=j;read_element(in,fq_nmod_mat_entry(M,i,j),degree);
        }
    }
}
void write_element(ofstream& out,const fq_nmod_t value) {
    uint32_t n=nmod_poly_length(value);write_value(out,n);
    for(uint32_t j=0;j<n;++j)write_value(out,uint8_t(nmod_poly_get_coeff_ui(value,j)));
}

// Small, backup-only finite-module operations.  No full row-operation
// identity matrix is ever stored.  Kernel vectors and every requested
// row identity are checked again against the original input below.
int module_operation(ifstream& in,const char* output,uint64_t magic) {
    auto begin=chrono::steady_clock::now();
    auto seconds=[&](){return chrono::duration<double>(chrono::steady_clock::now()-begin).count();};
    bool kernel=magic==0x424b504c494e5333ULL;
    uint32_t degree=read_value<uint32_t>(in),rows=read_value<uint32_t>(in),cols=read_value<uint32_t>(in);
    uint32_t count=kernel ? 0 : read_value<uint32_t>(in);
    if(!degree || degree>100000 || !rows || !cols || rows>100000 || cols>100000 || count>128)
        throw runtime_error("invalid module dimensions");
    nmod_poly_t modulus;nmod_poly_init(modulus,5);
    for(uint32_t i=0;i<=degree;++i) {
        uint8_t c=read_value<uint8_t>(in);if(c>=5)throw runtime_error("invalid module modulus coefficient");
        nmod_poly_set_coeff_ui(modulus,i,c);
    }
    if(nmod_poly_degree(modulus)!=degree || nmod_poly_get_coeff_ui(modulus,degree)!=1)
        throw runtime_error("invalid module monic modulus");
    fq_nmod_ctx_t field;fq_nmod_ctx_init_modulus(field,modulus,"c");
    fq_nmod_mat_t original,target,augmented,reduced,answer;
    fq_nmod_mat_init(original,rows,cols,field);read_matrix(in,original,rows,cols,degree);
    fq_nmod_mat_init(target,count,cols,field);
    if(!kernel)read_matrix(in,target,count,cols,degree);
    if(in.peek()!=EOF)throw runtime_error("trailing module input");
    uint32_t ar=kernel ? rows : cols,ac=kernel ? cols : rows+count;
    fq_nmod_mat_init(augmented,ar,ac,field);fq_nmod_mat_init(reduced,ar,ac,field);
    if(kernel)fq_nmod_mat_set(augmented,original,field);
    else for(uint32_t j=0;j<cols;++j) {
        for(uint32_t i=0;i<rows;++i)
            fq_nmod_set(fq_nmod_mat_entry(augmented,j,i),fq_nmod_mat_entry(original,i,j),field);
        for(uint32_t h=0;h<count;++h)
            fq_nmod_set(fq_nmod_mat_entry(augmented,j,rows+h),fq_nmod_mat_entry(target,h,j),field);
    }
    double loaded=seconds();slong rank=fq_nmod_mat_rref(reduced,augmented,field);
    fq_nmod_mat_clear(augmented,field);
    uint32_t out_rows=kernel ? cols : count,out_cols=kernel ? cols-rank : rows;
    fq_nmod_mat_init(answer,out_rows,out_cols,field);
    if(kernel) {
        vector<uint32_t> pivots;vector<bool> is_pivot(cols,false);
        for(slong i=0;i<rank;++i) {
            uint32_t j=0;while(j<cols && fq_nmod_is_zero(fq_nmod_mat_entry(reduced,i,j),field))++j;
            if(j==cols)throw runtime_error("missing kernel pivot");
            pivots.push_back(j);is_pivot[j]=true;
        }
        uint32_t h=0;
        for(uint32_t j=0;j<cols;++j)if(!is_pivot[j]) {
            fq_nmod_one(fq_nmod_mat_entry(answer,j,h),field);
            for(slong i=0;i<rank;++i)
                fq_nmod_neg(fq_nmod_mat_entry(answer,pivots[i],h),fq_nmod_mat_entry(reduced,i,j),field);
            ++h;
        }
    } else {
        for(slong i=0;i<rank;++i) {
            uint32_t pivot=0;while(pivot<rows+count && fq_nmod_is_zero(fq_nmod_mat_entry(reduced,i,pivot),field))++pivot;
            if(pivot>=rows)throw runtime_error("requested target is outside the bounded source rowspace");
            for(uint32_t h=0;h<count;++h)
                fq_nmod_set(fq_nmod_mat_entry(answer,h,pivot),fq_nmod_mat_entry(reduced,i,rows+h),field);
        }
    }
    fq_nmod_mat_clear(reduced,field);double solved=seconds();
    fq_nmod_t sum,term;fq_nmod_init(sum,field);fq_nmod_init(term,field);
    for(uint32_t i=0;i<(kernel ? rows : count);++i)
      for(uint32_t j=0;j<(kernel ? out_cols : cols);++j) {
        fq_nmod_zero(sum,field);
        for(uint32_t h=0;h<(kernel ? cols : rows);++h) {
            const nmod_poly_struct* a=kernel ? fq_nmod_mat_entry(original,i,h) : fq_nmod_mat_entry(answer,i,h);
            const nmod_poly_struct* b=kernel ? fq_nmod_mat_entry(answer,h,j) : fq_nmod_mat_entry(original,h,j);
            if(!fq_nmod_is_zero(a,field) && !fq_nmod_is_zero(b,field)) {
                fq_nmod_mul(term,a,b,field);fq_nmod_add(sum,sum,term,field);
            }
        }
        if(kernel ? !fq_nmod_is_zero(sum,field) : !fq_nmod_equal(sum,fq_nmod_mat_entry(target,i,j),field))
            throw runtime_error("failed original module matrix identity");
    }
    double verified=seconds();ofstream out(output,ios::binary);
    write_value(out,uint64_t(0x424b504c494e5335ULL));write_value(out,degree);
    write_value(out,uint32_t(kernel ? 2 : 3));write_value(out,out_rows);write_value(out,out_cols);write_value(out,uint32_t(rank));
    for(uint32_t i=0;i<out_rows;++i)for(uint32_t j=0;j<out_cols;++j)write_element(out,fq_nmod_mat_entry(answer,i,j));
    out.close();if(!out)throw runtime_error("failed module output");
    cout<<"{\"backend\":\"backup_FLINT_bounded_module\",\"operation\":\""<<(kernel ? "kernel" : "row_identities")
        <<"\",\"degree_F5\":"<<degree<<",\"rows\":"<<rows<<",\"columns\":"<<cols<<",\"targets\":"<<count
        <<",\"rank\":"<<rank<<",\"read_seconds\":"<<loaded<<",\"solve_seconds\":"<<solved-loaded
        <<",\"identity_verification_seconds\":"<<verified-solved<<",\"total_seconds\":"<<seconds()
        <<",\"original_matrix_identity_verified\":true}"<<endl;
    fq_nmod_clear(term,field);fq_nmod_clear(sum,field);fq_nmod_mat_clear(answer,field);
    fq_nmod_mat_clear(target,field);fq_nmod_mat_clear(original,field);
    fq_nmod_ctx_clear(field);nmod_poly_clear(modulus);flint_cleanup();return 0;
}

int main(int argc,char** argv) {
  try {
    if(argc!=3) throw runtime_error("usage: backup_native_linear INPUT OUTPUT");
    flint_set_num_threads(1);
    auto begin=chrono::steady_clock::now();
    auto seconds=[&](){return chrono::duration<double>(chrono::steady_clock::now()-begin).count();};
    ifstream in(argv[1],ios::binary);
    uint64_t magic=read_value<uint64_t>(in);
    if(magic==0x424b504c494e5333ULL || magic==0x424b504c494e5334ULL)
        return module_operation(in,argv[2],magic);
    if(magic!=0x424b504c494e5331ULL) throw runtime_error("wrong backup linear format");
    uint32_t degree=read_value<uint32_t>(in),rows=read_value<uint32_t>(in),cols=read_value<uint32_t>(in);
    if(!degree || degree>100000 || !rows || !cols || rows>100000 || cols>100000)
        throw runtime_error("invalid backup linear dimensions");
    nmod_poly_t modulus;nmod_poly_init(modulus,5);
    for(uint32_t i=0;i<=degree;++i) {
        uint8_t c=read_value<uint8_t>(in);if(c>=5)throw runtime_error("invalid modulus coefficient");
        nmod_poly_set_coeff_ui(modulus,i,c);
    }
    if(nmod_poly_degree(modulus)!=degree || nmod_poly_get_coeff_ui(modulus,degree)!=1)
        throw runtime_error("invalid monic field modulus");
    fq_nmod_ctx_t field;fq_nmod_ctx_init_modulus(field,modulus,"c");
    fq_nmod_mat_t original,target,augmented,reduced,answer;
    fq_nmod_mat_init(original,rows,cols,field);fq_nmod_mat_init(target,1,cols,field);
    read_matrix(in,original,rows,cols,degree);read_matrix(in,target,1,cols,degree);
    if(in.peek()!=EOF)throw runtime_error("trailing backup linear data");
    fq_nmod_mat_init(augmented,cols,rows+1,field);fq_nmod_mat_init(reduced,cols,rows+1,field);
    for(uint32_t j=0;j<cols;++j) {
        for(uint32_t i=0;i<rows;++i)
            fq_nmod_set(fq_nmod_mat_entry(augmented,j,i),fq_nmod_mat_entry(original,i,j),field);
        fq_nmod_set(fq_nmod_mat_entry(augmented,j,rows),fq_nmod_mat_entry(target,0,j),field);
    }
    double loaded=seconds();
    slong augmented_rank=fq_nmod_mat_rref(reduced,augmented,field);
    fq_nmod_mat_clear(augmented,field);
    bool inconsistent=false;uint32_t rank=0;
    for(slong i=0;i<augmented_rank;++i) {
        uint32_t pivot=0;while(pivot<=rows && fq_nmod_is_zero(fq_nmod_mat_entry(reduced,i,pivot),field))++pivot;
        if(pivot==rows)inconsistent=true;else if(pivot<rows)++rank;
    }
    uint32_t kind=inconsistent ? 1 : 0,length=inconsistent ? cols : rows;
    fq_nmod_mat_init(answer,1,length,field);
    if(!inconsistent) {
        for(slong i=0;i<augmented_rank;++i) {
            uint32_t pivot=0;while(pivot<rows && fq_nmod_is_zero(fq_nmod_mat_entry(reduced,i,pivot),field))++pivot;
            if(pivot<rows)fq_nmod_set(fq_nmod_mat_entry(answer,0,pivot),fq_nmod_mat_entry(reduced,i,rows),field);
        }
        fq_nmod_mat_clear(reduced,field);
    } else {
        // Find d with original*d=0 and target*d=1, not a rank-only verdict.
        fq_nmod_mat_clear(reduced,field);
        fq_nmod_mat_init(augmented,rows+1,cols+1,field);fq_nmod_mat_init(reduced,rows+1,cols+1,field);
        for(uint32_t i=0;i<rows;++i)for(uint32_t j=0;j<cols;++j)
            fq_nmod_set(fq_nmod_mat_entry(augmented,i,j),fq_nmod_mat_entry(original,i,j),field);
        for(uint32_t j=0;j<cols;++j)fq_nmod_set(fq_nmod_mat_entry(augmented,rows,j),fq_nmod_mat_entry(target,0,j),field);
        fq_nmod_one(fq_nmod_mat_entry(augmented,rows,cols),field);
        slong dual_rank=fq_nmod_mat_rref(reduced,augmented,field);fq_nmod_mat_clear(augmented,field);
        for(slong i=0;i<dual_rank;++i) {
            uint32_t pivot=0;while(pivot<=cols && fq_nmod_is_zero(fq_nmod_mat_entry(reduced,i,pivot),field))++pivot;
            if(pivot==cols)throw runtime_error("inconsistent separating-dual system");
            if(pivot<cols)fq_nmod_set(fq_nmod_mat_entry(answer,0,pivot),fq_nmod_mat_entry(reduced,i,cols),field);
        }
        fq_nmod_mat_clear(reduced,field);
    }
    double solved=seconds();
    fq_nmod_t sum,term;fq_nmod_init(sum,field);fq_nmod_init(term,field);
    if(!inconsistent) {
        for(uint32_t j=0;j<cols;++j) {
            fq_nmod_zero(sum,field);
            for(uint32_t i=0;i<rows;++i) {
                fq_nmod_mul(term,fq_nmod_mat_entry(answer,0,i),fq_nmod_mat_entry(original,i,j),field);
                fq_nmod_add(sum,sum,term,field);
            }
            if(!fq_nmod_equal(sum,fq_nmod_mat_entry(target,0,j),field))throw runtime_error("failed original primal identity");
        }
    } else {
        for(uint32_t i=0;i<=rows;++i) {
            fq_nmod_zero(sum,field);
            for(uint32_t j=0;j<cols;++j) {
                fq_nmod_mul(term,i==rows ? fq_nmod_mat_entry(target,0,j) : fq_nmod_mat_entry(original,i,j),fq_nmod_mat_entry(answer,0,j),field);
                fq_nmod_add(sum,sum,term,field);
            }
            if(i<rows ? !fq_nmod_is_zero(sum,field) : !fq_nmod_is_one(sum,field))throw runtime_error("failed original dual identity");
        }
    }
    double verified=seconds();ofstream out(argv[2],ios::binary);
    write_value(out,uint64_t(0x424b504c494e5332ULL));write_value(out,degree);write_value(out,kind);write_value(out,length);write_value(out,rank);
    for(uint32_t j=0;j<length;++j)write_element(out,fq_nmod_mat_entry(answer,0,j));
    out.close();if(!out)throw runtime_error("failed backup linear output");
    cout<<"{\"backend\":\"backup_FLINT_single_rhs\",\"degree_F5\":"<<degree
        <<",\"rows\":"<<rows<<",\"columns\":"<<cols<<",\"rank\":"<<rank
        <<",\"dual\":"<<(inconsistent ? "true" : "false")<<",\"read_seconds\":"<<loaded
        <<",\"solve_seconds\":"<<solved-loaded<<",\"identity_verification_seconds\":"<<verified-solved
        <<",\"total_seconds\":"<<seconds()<<",\"original_vector_identity_verified\":true}"<<endl;
    fq_nmod_clear(term,field);fq_nmod_clear(sum,field);fq_nmod_mat_clear(answer,field);
    fq_nmod_mat_clear(target,field);fq_nmod_mat_clear(original,field);
    fq_nmod_ctx_clear(field);nmod_poly_clear(modulus);flint_cleanup();return 0;
  } catch(const exception& e) {cerr<<e.what()<<endl;return 1;}
}
