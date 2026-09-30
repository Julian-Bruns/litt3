#define RESIDUAL_LIBRARY
#include "residual.cpp"
int main(int argc,char**argv){try{initdata();std::string dest=argc>1?argv[1]:"data";
 for(unsigned ix=0;ix<ROOTS.size();ix++){
  F r=ROOTS[ix],q=QBOUND[ix];auto c=parametrize(r);
  auto get=[&](const Bi&n){F ans=0;for(auto[e,k]:n.t)if(e.first==2){assert(e.second%3==0);ans=add(ans,mul(k,fpow(q,e.second/3)));}return ans;};
  F u=get(c.kernelnum[0]),v=get(c.kernelnum[1]);std::array<Poly,4>S;Poly xr={neg(r),1};
  for(int k=5;k<=6;k++)for(int i=0;i<4;i++){assert(c.c.s[k][i].a[0].empty());assert(c.c.s[k][i].a[1].empty());}
  // Only the two kernel directions contribute to H^2. Every other
  // coordinate on the graph has H-degree at most one.
  for(int i=0;i<4;i++)for(int j=0;j<3;j++)for(const auto &co:c.num[i][j])for(auto [e,z]:co.t)assert(e.first<=2);
  for(int i=0;i<4;i++){S[i]=scale(c.c.s[5][i].a[2],u)+scale(c.c.s[6][i].a[2],v);S[i]=quo(S[i],xr);}
  auto a=S[0],b=S[1],cc=S[2],d=S[3];auto VV=frob(a)*power(Q,2)+frob(b)*Q+scale(frob(cc),2);auto KK=power(a,2)*power(d,2)+a*b*cc*d+scale(power(b,3)*d,2)+scale(power(b,2)*power(cc,2),2)+scale(a*power(cc,3),2);
  F ar=eval(a,r),vr=eval(VV,r),kr=eval(KK,r);
  std::cout<<"H-infinity q=q_r r="<<r<<" q="<<q<<" a00(r)="<<ar<<" V00(r)="<<vr<<" K00(r)="<<kr<<" parity-certificate="<<(ar&&vr&&kr?"PASS":"FAIL")<<'\n';
  assert(ar&&vr&&kr);
  std::ofstream o(dest+"/infinity_"+std::to_string(r)+".json");o<<"{\"r\":"<<r<<",\"q\":"<<q<<",\"kernel_coefficients\":["<<u<<','<<v<<"],\"S00\":[";for(int i=0;i<4;i++){if(i)o<<',';printpoly(o,S[i]);}o<<"],\"a00_at_r\":"<<ar<<",\"V00_at_r\":"<<vr<<",\"K00_at_r\":"<<kr<<",\"v_orders\":{\"scale_slower_than_H2\":17,\"scale_equal_to_H2\":13,\"scale_faster_than_H2\":13}}\n";
 }
 return 0;}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
