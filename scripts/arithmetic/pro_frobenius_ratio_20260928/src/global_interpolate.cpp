// Exact batched Lagrange interpolation over the original K-code field.
// Coefficients are ascending; no modular image or probabilistic check is used.
#include "field.cpp"
extern "C" int ff_interpolate_batch(const F* nodes, const F* values,
                                     int n, int width, F* result) {
  if(n<1 || width<1) return 0;
  ff_init();
  std::vector<F> m(1,1);
  for(int i=0;i<n;++i) {
    std::vector<F> mm(m.size()+1,0);
    for(size_t j=0;j<m.size();++j) {
      mm[j]=add(mm[j],neg(mul(nodes[i],m[j])));
      mm[j+1]=add(mm[j+1],m[j]);
    }
    m.swap(mm);
  }
  std::fill(result,result+(size_t)n*width,0);
  std::vector<F> li(n),vv(width);
  for(int i=0;i<n;++i) {
    li[n-1]=m[n];
    for(int j=n-2;j>=0;--j) li[j]=add(m[j+1],mul(nodes[i],li[j+1]));
    F deriv=0;
    for(int j=n-1;j>=0;--j) deriv=add(mul(deriv,nodes[i]),li[j]);
    if(!deriv) return 0;
    F iv=inv(deriv);
    for(int k=0;k<width;++k) vv[k]=mul(values[(size_t)i*width+k],iv);
    for(int j=0;j<n;++j) if(li[j]) {
      F* row=result+(size_t)j*width;
      for(int k=0;k<width;++k) if(vv[k]) row[k]=add(row[k],mul(li[j],vv[k]));
    }
  }
  return 1;
}
extern "C" void ff_eval_batch(const F* coefficients,int n,int width,F x,F*out) {
  ff_init();std::fill(out,out+width,0);
  for(int j=n-1;j>=0;--j)for(int k=0;k<width;++k)
    out[k]=add(mul(out[k],x),coefficients[(size_t)j*width+k]);
}
