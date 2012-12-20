NB. android.util.Log

ANDROID_LOG_UNKNOWN=: 0
ANDROID_LOG_DEFAULT=: 1
ANDROID_LOG_VERBOSE=: 2
ANDROID_LOG_DEBUG=: 3
ANDROID_LOG_INFO=: 4
ANDROID_LOG_WARN=: 5
ANDROID_LOG_ERROR=: 6
ANDROID_LOG_FATAL=: 7
ANDROID_LOG_SILENT=: 8

log_v=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_VERBOSE&;)
log_d=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_DEBUG&;)
log_i=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_INFO&;)
log_w=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_WARN&;)
log_e=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_ERROR&;)
log_f=: 'liblog.so __android_log_print > i i *c *c'&(15!:0) @: (ANDROID_LOG_FATAL&;)
