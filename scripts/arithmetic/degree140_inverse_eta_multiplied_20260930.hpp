// Endpoint-cleared inverse-discriminant traces; one profile call, no
// parameter scan and no replay of incoming certificate code.
#pragma once
#include "degree140_low_trace_infinity_20260929.hpp"
#include "degree140_endpoint_trace_native_20260929.hpp"
namespace inverseetamultiplied {
using namespace exact;
inline std::array<Poly,3> profiles(F h,F w){
 auto raw=lowtrace::profiles(h,w,{{0,0},{1,0},{2,0},{3,0},{4,0},{5,0}},-1);
 auto ep=endpointtrace::correction(h,w,criticaltrace::T,true,-1);
 std::array<Poly,3> out;
 for(int j=0;j<3;j++){
  for(int i=0;i<=3;i++)out[j]=out[j]+scale(raw[0][i+j],criticaltrace::T[i]);
  out[j].resize(std::max(out[j].size(),size_t(3)));
  for(int n=0;n<3;n++)out[j][n]=add(out[j][n],ep[0][n][j]);
  out[j].trim();
 }
 return out;
}
}
