#pragma once
#include "fast.hpp"
namespace exact {
inline std::vector<F> dft(const std::vector<F>&a,F omega){
 int n=a.size();if(n==1)return a;int r=2;while(r*r<=n&&n%r)r++;
 if(n%r)r=n;
 if(r==n){std::vector<F> out(n),wp(n);wp[0]=1;for(int i=1;i<n;i++)wp[i]=mul(wp[i-1],omega);for(int k=0;k<n;k++){F z=0;int e=0;for(int j=0;j<n;j++){z=add(z,mul(a[j],wp[e]));e+=k;if(e>=n)e-=n;}out[k]=z;}return out;}
 int m=n/r;std::vector<std::vector<F>>B(r);F om=power(omega,r);for(int j=0;j<r;j++){std::vector<F>s(m);for(int i=0;i<m;i++)s[i]=a[j+r*i];B[j]=dft(s,om);}
 std::vector<F>out(n);F wr=power(omega,m),w1=1;
 for(int k=0;k<m;k++){std::vector<F>s(r);F z=1;for(int j=0;j<r;j++){s[j]=mul(B[j][k],z);z=mul(z,w1);}auto t=dft(s,wr);for(int l=0;l<r;l++)out[k+m*l]=t[l];w1=mul(w1,omega);}
 return out;
}
}
