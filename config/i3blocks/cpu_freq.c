#include<stdio.h>
#include<dirent.h>
#include<stdlib.h>
#include<string.h>

int main(void)
{
    float a[4], b[4], loadavg;
    FILE *fp;
    char msg[512];

    fp = fopen("/proc/stat", "r");
    fscanf(fp, "%*s %f %f %f %f", &a[0], &a[1], &a[2], &a[3]);
    fclose(fp);

    sleep(1);

    fp = fopen("/proc/stat", "r");
    fscanf(fp, "%*s %f %f %f %f", &b[0], &b[1], &b[2], &b[3]);
    fclose(fp);
    
    loadavg = (b[0]+b[1]+b[2]-a[0]-a[1]-a[2])/(b[0]+b[1]+b[2]+b[3]-a[0]-a[1]-a[2]-a[3]);

    DIR       *d;
    struct    dirent *dir;
    int       n_cpu = 0;
    //int const n_cpu_max = 64;
    int       f_cpu = 0, f_cpu_max = 0;
    char      dir_path[] = "/sys/devices/system/cpu/cpufreq/";
    char      cpu_path[256];
    d = opendir(dir_path);
    if(d)
    {
        while((dir = readdir(d)) != NULL)
        {
            if(dir->d_type == DT_DIR && !strncmp(dir->d_name, "policy", 6))
            {
                FILE *f;

                sprintf(cpu_path, "%s%s/scaling_cur_freq", dir_path, dir->d_name);
                f = fopen(cpu_path, "r");
                if(f)
                {
                    int tmpf;
                    fscanf(f, "%d", &tmpf);
                    f_cpu = tmpf>f_cpu ? tmpf : f_cpu;
                    fclose(f);
                }
                
                sprintf(cpu_path, "%s%s/scaling_max_freq", dir_path, dir->d_name);
                f = fopen(cpu_path, "r");
                if(f)
                {
                    int tmpf;
                    fscanf(f, "%d", &tmpf);
                    f_cpu_max = tmpf>f_cpu ? tmpf : f_cpu_max;
                    fclose(f);
                }
                
                ++n_cpu;
            }
        }
        FILE *fp = fopen("/sys/devices/system/cpu/intel_pstate/max_perf_pct","r");
        if(n_cpu > 0 && fp)
        {
            int max_pct;
            fscanf(fp, "%d", &max_pct);
            fclose(fp);
            printf("%4.2f%% %d/%dMHz\n", loadavg*100.0, f_cpu/1000, (int)(f_cpu_max/100000.0*max_pct));
        }
        else
        {
            printf("%4.2f\%\n", loadavg*100.0);
        }
    }

    return 0;
}
