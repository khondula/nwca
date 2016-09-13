# analyze results

f_cond$IMPAIRED <- f_cond$SRCE_DESCR == "IMPAIRED"

plot(f_cond$VMMI, f_cond$IMPAIRED)
