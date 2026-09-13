"""Bounded fork-worker reservations; the controller still enforces tree RSS."""
def release_scratch():
    """Drop unreachable CAS cycles and return free allocator pages to the OS."""
    import ctypes,gc,sys
    gc.collect()
    libc=ctypes.CDLL(None)
    if sys.platform=='darwin' and hasattr(libc,'malloc_zone_pressure_relief'):
        fn=libc.malloc_zone_pressure_relief
        fn.argtypes=[ctypes.c_void_p,ctypes.c_size_t];fn.restype=ctypes.c_size_t
        return int(fn(None,0))
    if hasattr(libc,'malloc_trim'):
        libc.malloc_trim.argtypes=[ctypes.c_size_t]
        return int(libc.malloc_trim(0))
    return 0


def resident_rss():
    """Current resident bytes, NOT the process's historical allocation peak."""
    import os,subprocess
    return int(subprocess.check_output(['ps','-o','rss=','-p',str(os.getpid())],text=True).strip())*1024


def fork_workers(requested,pending,parent_rss,memory_bytes):
    # Fork shares the immutable parent input. Reserve a full parent-sized
    # *additional* working set per worker, with a512MiB minimum, plus parent.
    # The previous2x-parent-per-worker rule needlessly suppressed core10.
    estimate=max(512*1024**2,int(parent_rss))
    room=max(0,int(memory_bytes)-int(parent_rss))
    count=max(1,min(int(requested),int(pending),room//estimate))
    return count,estimate
