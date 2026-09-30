// Entire degree-drop boundary of all six fixed-s ratio cubics.
// The finite-algebra generator here is u, not q.  The source reconstruction
// is the original general (q,u) construction from the preserved Pro code.
#define main preserved_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main

int main(int argc,char**argv){try{
 assert(argc==3||argc==4);init(argv[1]);
 if(argc==4){
  ptree model;boost::property_tree::read_json(argv[3],model);
  std::ofstream out(argv[2]);assert(out);
  out<<"{\"scope\":\"all six e=0 boundaries, all geometric scales\",\"rows\":[";
  int i=0;
  for(auto&[key,row]:model.get_child("rows")){
   unsigned sc=row.get<unsigned>("sigma");
   FP mod=frow(row.get_child("modulus_in_u")),qrep=frow(row.get_child("q_in_u"));
   E::setmod(mod);E q(qrep),u(FP(std::vector<F>{0,1}));
   q.inverse();u.inverse();at(getrow("d"),q).inverse();
   assert(!bool(at(getrow("e"),q)));
   auto ss=(at(getrow("a0"),q)+at(getrow("b"),q)/u+at(getrow("c"),q)/u.pow(2))/at(getrow("d"),q);
   assert(ss==E(F(sc)));
   auto rr=actual_residual(q,u);auto ta=tails(rr,74);assert(!bool(ta[72][54]));
   if(i++)out<<',';
   out<<"{\"sigma\":"<<sc<<",\"modulus_in_u\":";json(out,mod);
   out<<",\"q_in_u\":";json(out,qrep);out<<",\"blocks\":[";
   bool first=true;certify_block(mod,FP(std::vector<F>{0,1}),ta,out,first);out<<"]}";
   std::cout<<"{\"sigma\":"<<sc<<",\"sixteen_finite_ratios\":\"excluded for all scales\"}"<<std::endl;
  }
  assert(i==6);out<<"],\"geometric_ratio_count\":96}\n";return 0;
 }
 std::ofstream out(argv[2]);assert(out);
 out<<"{\"scope\":\"all six a_sigma=0 boundaries, all geometric scales\",\"rows\":[";
 int index=0;
 for(unsigned sc:{112400,246025,215500,360225,164100,272625}){
  F sigma(sc);FP aa=getrow("a0")-getrow("d").scale(sigma);
  assert(aa.deg()==1);F q0=-aa[0]/aa[1];assert(bool(q0));
  for(auto&[key,z]:INPUT.get_child("excluded_q"))assert(q0!=F(z.get_value<unsigned>()));
  F bv=at(getrow("b"),q0),cv=at(getrow("c"),q0),ev=at(getrow("e"),q0);
  assert(bool(bv)&&bool(ev)&&bool(cv*cv-F(4)*bv*ev));
  FP mod(std::vector<F>{ev,cv,bv});mod=mod.monic();E::setmod(mod);
  E q(q0),u(FP(std::vector<F>{0,1}));u.inverse();at(getrow("d"),q).inverse();
  E ss=(at(getrow("a0"),q)+at(getrow("b"),q)/u+at(getrow("c"),q)/u.pow(2)+at(getrow("e"),q)/u.pow(3))/at(getrow("d"),q);
  assert(ss==E(sigma));
  auto rr=actual_residual(q,u);auto ta=tails(rr,74);assert(!bool(ta[72][54]));
  if(index++)out<<',';
  out<<"{\"sigma\":"<<sc<<",\"q\":"<<q0.v<<",\"modulus_in_u\":";json(out,mod);
  out<<",\"blocks\":[";bool first=true;
  certify_block(mod,FP(std::vector<F>{0,1}),ta,out,first);
  out<<"]}";
  std::cout<<"{\"sigma\":"<<sc<<",\"q\":"<<q0.v<<",\"two_finite_roots\":\"excluded for all scales\"}"<<std::endl;
 }
 out<<"],\"geometric_ratio_count\":12}\n";
 return 0;
}catch(std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
