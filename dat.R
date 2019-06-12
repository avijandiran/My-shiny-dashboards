
library(ggplot2)
dput (dat)

dat <- structure(list(AAP = structure(c(1L, 1L, 2L, 2L, 3L, 3L, 4L, 
4L, 5L, 5L), .Label = c("12d", "18d", "24d", "3d", "6d"), class = "factor"), 
Sex = structure(c(1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L), .Label = c("Female", 
"Male"), class = "factor"), min = c(100.97, 24.69, 195.01, 
487.75, 248.58, 556.6, 4.87, 3.23, 3.2, 4.64), max = c(702.36, 
1090.15, 4204.68, 4941.3, 3556.11, 4463.22, 16.93, 16.35, 
37.63, 94.93), mean = c(444.07389, 469.482, 1273.72, 1452.37937, 
1583.09958, 1589.50318, 12.86571, 8.13, 15.075, 28.393), 
sd = c(197.970342, 262.89378, 1105.568111, 1232.659688, 925.263382, 
973.225661, 4.197987, 5.364383, 11.502331, 30.671206)), .Names = c("AAP", 
"Sex", "min", "max", "mean", "sd"), class = "data.frame", row.names = c(NA, 
-10L))

trans <- function(x){pmin(x,40) + 0.05*pmax(x-40,0)}

yticks <- c(0, 20, 40, 500, 1000, 1500, 2000)

#Transform the data onto the display scale
dat$mean_t <- trans(dat$mean)
dat$sd_up_t <- trans(dat$mean + dat$sd)
dat$sd_low_t <- pmax(trans(dat$mean - dat$sd),1) 

ggplot(data=dat, aes(x=AAP, y=mean_t, group=Sex,fill=Sex)) +
  geom_errorbar(aes(ymin=sd_low_t, ymax=sd_up_t),position="dodge") + 
  geom_col(position="dodge") +
  geom_rect(aes(xmin=0, xmax=6, ymin=42, ymax=48), fill="white") +
  scale_y_continuous(limits=c(0,NA), breaks=trans(yticks), labels=yticks) +
  labs(y="Relative titer of CLas")



ggplot(data=example_data, aes(x=a, y=b)) +geom_point()+
  geom_rect(aes(xmin=as.POSIXct("2015-01-02 05:00:00, origin="1901-01-01"), xmax=as.POSIXct("2015-01-03 10:30:36",origin="1901-01-01"), ymin=4, ymax=5), fill="white") + 
  scale_x_datetime(date_labels = "%d/%m/%Y %H:%M:%S",limits =c(as.POSIXct("2015-01-02 06:07:27","2015-01-03 09:42:36",origin = "1970-01-01",format="%d/%m/%Y %H:%M")))