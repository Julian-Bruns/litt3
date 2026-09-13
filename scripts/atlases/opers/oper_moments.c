/* Exact F5 Krylov moments: byte matrices, ARM integer dot products, OpenMP.
 * No floating point and no GB correctness assumption. A proposed univariate
 * algebra must still pass independent substitution of the original equations.
 * Usage: oper-moments MATRIX_PREFIX LENGTH [THREADS]
 * Matrix formats come from assemble_oper_multiplication.py.
 */
#include <arm_neon.h>
#include <omp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <time.h>

static void die(const char*s){fprintf(stderr,"oper_moments: %s\n",s);exit(2);}
static void *mem(size_t n){void*p=calloc(n,1);if(!p)die("allocation");return p;}
static char *path(const char*p,const char*s){char*r=mem(strlen(p)+strlen(s)+1);strcpy(r,p);strcat(r,s);return r;}
static void *mapped(const char*p,size_t*bytes){int fd=open(p,O_RDONLY);struct stat st;if(fd<0||fstat(fd,&st))die("input");*bytes=st.st_size;void*r=mmap(NULL,*bytes,PROT_READ,MAP_PRIVATE,fd,0);close(fd);if(r==MAP_FAILED)die("mmap");return r;}
static FILE *create(const char*p){FILE*f=fopen(p,"wx");if(!f)die("output exists or unwritable");return f;}
static void finish(FILE*f){if(fflush(f)||fsync(fileno(f))||fclose(f))die("flush");}
static uint32_t dot(const uint8_t*a,const uint8_t*b,size_t n){
    uint32x4_t c0=vdupq_n_u32(0),c1=c0,c2=c0,c3=c0;size_t j=0;
    for(;j+64<=n;j+=64){
        c0=vdotq_u32(c0,vld1q_u8(a+j),vld1q_u8(b+j));
        c1=vdotq_u32(c1,vld1q_u8(a+j+16),vld1q_u8(b+j+16));
        c2=vdotq_u32(c2,vld1q_u8(a+j+32),vld1q_u8(b+j+32));
        c3=vdotq_u32(c3,vld1q_u8(a+j+48),vld1q_u8(b+j+48));
    }
    uint32_t s=vaddvq_u32(vaddq_u32(vaddq_u32(c0,c1),vaddq_u32(c2,c3)));
    for(;j<n;j++)s+=(uint32_t)a[j]*b[j];return s;
}
static void checkpoint(const char*prefix,size_t d,size_t length,size_t done,const uint8_t*v,const uint8_t*seq){
    char*target=path(prefix,".moments.checkpoint"),*tmp=path(prefix,".moments.checkpoint.partial");FILE*f=fopen(tmp,"wb");if(!f)die("checkpoint");
    uint64_t header[]={UINT64_C(0x4c495454334b5259),d,length,done};
    if(fwrite(header,8,4,f)!=4||fwrite(v,1,d,f)!=d||fwrite(seq,1,16*length,f)!=16*length)die("checkpoint write");finish(f);if(rename(tmp,target))die("checkpoint rename");free(target);free(tmp);
}
int main(int argc,char**argv){
    if(argc<3||argc>4)die("PREFIX LENGTH [THREADS]");const char*prefix=argv[1];size_t length=strtoull(argv[2],NULL,10);int threads=argc==4?atoi(argv[3]):10;if(threads<1||threads>32)die("thread count");
    FILE*f=fopen(path(prefix,".meta"),"r");size_t d,n,extra;int var;unsigned coord[15];
    if(!f||fscanf(f,"%zu %zu %d %zu",&d,&n,&var,&extra)!=4)die("matrix metadata");
    for(int i=0;i<15;i++)if(fscanf(f,"%u",coord+i)!=1||coord[i]>=d)die("coordinate index");fclose(f);
    if(length<2*d||16*d>=UINT32_MAX||var<0||var>=15)die("length/overflow bound");
    size_t bytes;uint8_t*matrix=mapped(path(prefix,".u8"),&bytes);if(bytes!=n*d)die("matrix size");
    int32_t*map=mapped(path(prefix,".map.i32"),&bytes);if(bytes!=4*d)die("map size");
    for(size_t i=0;i<n*d;i++)if(matrix[i]>4)die("non-F5 matrix coefficient");
    for(size_t i=0;i<d;i++)if(map[i]>=0?(size_t)map[i]>=d:(size_t)(-(int64_t)map[i]-1)>=n)die("map index");
    uint8_t*v=mem(d),*next=mem(d),*seq=mem(16*length);size_t done=0;
    uint64_t seed=UINT64_C(0x719eb231da4916f5);for(size_t i=0;i<d;i++){seed^=seed<<13;seed^=seed>>7;seed^=seed<<17;v[i]=seed%5;}
    f=fopen(path(prefix,".moments.checkpoint"),"rb");if(f){uint64_t h[4];
        if(fread(h,8,4,f)!=4||h[0]!=UINT64_C(0x4c495454334b5259)||h[1]!=d||h[2]!=length||h[3]>length)die("checkpoint header");done=h[3];
        if(fread(v,1,d,f)!=d||fread(seq,1,16*length,f)!=16*length||fgetc(f)!=EOF)die("checkpoint data");fclose(f);
        for(size_t i=0;i<d;i++)if(v[i]>4)die("checkpoint vector");
        for(size_t i=0;i<16*length;i++)if(seq[i]>4)die("checkpoint moment");
    }
    fprintf(stderr,"integer Krylov: %zu/%zu steps, %zu x %zu byte matrix, %d threads\n",done,length,n,d,threads);time_t started=time(NULL);omp_set_num_threads(threads);
    #pragma omp parallel shared(v,next,seq)
    {
        for(size_t step=done;step<length;step++){
            #pragma omp single
            {seq[step]=v[0];for(int i=0;i<15;i++)seq[(i+1)*length+step]=v[coord[i]];}
            #pragma omp for schedule(static)
            for(size_t i=0;i<d;i++)next[i]=map[i]>=0?v[map[i]]:(uint8_t)(dot(matrix+(size_t)(-(int64_t)map[i]-1)*d,v,d)%5);
            #pragma omp single
            {
                uint8_t*swap=v;v=next;next=swap;
                if((step+1)%128==0){fprintf(stderr,"moments %zu/%zu elapsed %lds\n",step+1,length,(long)(time(NULL)-started));fflush(stderr);}
                if((step+1)%2048==0)checkpoint(prefix,d,length,step+1,v,seq);
            }
        }
    }
    f=create(path(prefix,".moments.u8"));if(fwrite(seq,1,16*length,f)!=16*length)die("moments write");finish(f);
    const char*names[]={"c0","c1","c2","c3","a0","a1","a2","a3","a4","a5","a6","a7","a8","a9","zeta"};
    const char*base=strrchr(prefix,'/');base=base?base+1:prefix;
    f=create(path(prefix,".moments.json"));fprintf(f,"{\n\"dimension\":%zu,\n\"separator\":\"%s\",\n\"coordinate_names\":[",d,names[var]);
    for(int i=0;i<15;i++)fprintf(f,"%s\"%s\"",i?",":"",names[i]);
    fprintf(f,"],\n\"binary_file\":\"%s.moments.u8\",\n\"sequence_length\":%zu,\n\"arithmetic\":\"exact uint8 products and uint32 sums with 16D<2^32\",\n\"certified_original_algebra\":false\n}\n",base,length);finish(f);
    fprintf(stderr,"moments complete\n");return 0;
}
