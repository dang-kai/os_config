#include <stdio.h>

int main(void) {
    FILE *fp = NULL;
    fp = fopen("/sys/class/thermal/thermal_zone0/temp", "r");

    if (fp == NULL) {
        return 0;
    }

    float temp = 0.0f, temp_warning = 70.0f, temp_critical = 90.0f;

    fscanf(fp, "%f", &temp);
    temp /= 1000.0f;
    
    printf("%4.1f°C\n", temp);
    printf("%4.1f°C\n", temp);

    if (temp > temp_warning) {
        printf("#FFFC00\n");
    } else if (temp > temp_critical) {
        printf("#FF0000\n");
        return 33;
    }
    return 0;
}
