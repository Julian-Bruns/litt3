#ifndef COMPANION_FFT_HPP
#define COMPANION_FFT_HPP
#include "algebra.hpp"
#include <memory>
#include <map>
namespace comp {
// Exact mixed-radix DFT over K; prime 313 uses Rader's 312-term convolution.
// No floating-point arithmetic, and every transform length divides |K*|.
class DFT {
 int n_,radix_=0,m_=0;
 F root_;
 std::unique_ptr<DFT> sub_;
 std::vector<F> small_,twist_,kernel_;
 std::vector<int> gp_,gn_;
 std::unique_ptr<DFT> conv_,iconv_;
 static int imodpow(int a,int b,int p){int z=1;while(b){if(b&1)z=z*a%p;b>>=1;if(b)a=a*a%p;}return z;}
public:
 explicit DFT(int n,F root):n_(n),root_(root){
  if(n<1||F::NN%n||root.pow(n)!=F(1))throw std::runtime_error("invalid finite-field DFT length or root");
  for(int p:{2,3,13,313})if(n%p==0&&root.pow(n/p)==F(1))throw std::runtime_error("nonprimitive DFT root");
  if(n==1)return;
  if(n==313){
   int g=2;while(imodpow(g,156,313)==1||imodpow(g,104,313)==1||imodpow(g,24,313)==1)g++;
   gp_.resize(312);gn_.resize(312);int z=1;for(int i=0;i<312;i++){gp_[i]=z;z=z*g%313;}
   for(int i=0;i<312;i++)gn_[i]=gp_[(312-i)%312];
   F w=F(F::exps[F::NN/312]);conv_=std::make_unique<DFT>(312,w);iconv_=std::make_unique<DFT>(312,w.inverse());
   std::vector<F>b(312);for(int i=0;i<312;i++)b[i]=root.pow(gn_[i]);kernel_=conv_->apply(b);return;
  }
  for(int r:{2,3,13})if(n%r==0){radix_=r;break;}if(!radix_)throw std::runtime_error("unsupported DFT prime");
  m_=n/radix_;sub_=std::make_unique<DFT>(m_,root.pow(radix_));
  F w=root.pow(m_);small_.resize(radix_*radix_);for(int i=0;i<radix_;i++)for(int j=0;j<radix_;j++)small_[i*radix_+j]=w.pow(i*j);
  twist_.resize(n);for(int t=0;t<radix_;t++){F z=1,v=root.pow(t);for(int k=0;k<m_;k++){twist_[t*m_+k]=z;z*=v;}}
 }
 int size()const{return n_;}
 std::vector<F> apply(const std::vector<F>&a)const{
  if((int)a.size()!=n_)throw std::runtime_error("wrong DFT input size");std::vector<F>out(n_);run(a.data(),1,out.data());return out;
 }
 void run(const F*a,int stride,F*out)const{
  if(n_==1){out[0]=a[0];return;}
  if(n_==313){
   std::vector<F>b(312);F total=a[0];for(int i=0;i<312;i++){b[i]=a[gp_[i]*stride];total+=b[i];}
   auto fb=conv_->apply(b);for(int i=0;i<312;i++)fb[i]*=kernel_[i];auto c=iconv_->apply(fb);F factor=F(2).inverse();
   out[0]=total;for(int i=0;i<312;i++)out[gn_[i]]=a[0]+c[i]*factor;return;
  }
  std::vector<F>b(n_);for(int t=0;t<radix_;t++)sub_->run(a+t*stride,stride*radix_,b.data()+t*m_);
  std::array<F,13>z;
  for(int k=0;k<m_;k++){
   for(int t=0;t<radix_;t++)z[t]=b[t*m_+k]*twist_[t*m_+k];
   for(int j=0;j<radix_;j++){F v=0;for(int t=0;t<radix_;t++)v+=z[t]*small_[j*radix_+t];out[k+m_*j]=v;}
  }
 }
};
}
#endif
