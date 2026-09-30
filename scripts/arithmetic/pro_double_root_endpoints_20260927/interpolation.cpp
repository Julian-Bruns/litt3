// Exact matrix interpolation over the specified K. Field definitions are shared
// with the independently tested original implementation; no external libraries.
#include "field.cpp"
extern "C" {
void ff_matmul_batch(const int* A,const int* B,int* C,int n,int k,int m){
    std::fill(C,C+(size_t)n*m,0);
    for(int i=0;i<n;i++)for(int h=0;h<k;h++){
        int a=A[(size_t)i*k+h];if(!a)continue;
        for(int j=0;j<m;j++){
            int b=B[(size_t)h*m+j];
            if(b)C[(size_t)i*m+j]=add(C[(size_t)i*m+j],mul(a,b));
        }
    }
}
void ff_evaluate_rows(const int* coeff,int n,int m,int x,int* out){
    std::fill(out,out+m,0);
    for(int i=n-1;i>=0;i--)for(int j=0;j<m;j++)
        out[j]=add(mul(out[j],x),coeff[(size_t)i*m+j]);
}
}
extern "C" {
// Radix recombination: input coefficients of P(u)^i*u^k, k<block.
void ff_radix_combine(const int* a,const int* powers,int nb,int block,int m,int nout,int* out){
 std::fill(out,out+(size_t)nout*m,0);
 for(int i=0;i<nb;i++)for(int j=0;j<nout;j++){
  int c=powers[i*nout+j];if(!c)continue;
  for(int k=0;k<block&&j+k<nout;k++)for(int h=0;h<m;h++){
   int v=a[((size_t)i*block+k)*m+h];
   if(v)out[((size_t)j+k)*m+h]=add(out[((size_t)j+k)*m+h],mul(c,v));
  }
 }
}
// Inverse radix transform, using monic sparse P of degree block.
void ff_radix_decompose(const int* f,const int* p,int nb,int block,int m,int* out){
 int n=nb*block;vector<int> a(f,f+(size_t)n*m);std::fill(out,out+(size_t)n*m,0);
 for(int bi=0;bi<nb;bi++){
  int nq=n-block;vector<int> q((size_t)max(0,nq)*m,0);
  for(int j=n-1;j>=block;j--){
   for(int h=0;h<m;h++)q[((size_t)j-block)*m+h]=a[(size_t)j*m+h];
   for(int k=0;k<block;k++)if(p[k])for(int h=0;h<m;h++){
    int v=a[(size_t)j*m+h];if(v)a[((size_t)j-block+k)*m+h]=sub(a[((size_t)j-block+k)*m+h],mul(p[k],v));
   }
  }
  copy(a.begin(),a.begin()+(size_t)block*m,out+(size_t)bi*block*m);
  a.swap(q);n-=block;
 }
}
}
