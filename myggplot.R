
#numeric variable cyl is a catgorical
ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +geom_point()+
  geom_rect(aes(xmin=3, xmax=6, ymin=15, ymax=18), fill="white")

ggplot(mtcars, aes(x = wt, y = mpg, color = disp)) +geom_point()

#Error: A continuous variable can not be mapped to shape
ggplot(mtcars, aes(x = wt, y = mpg, shape = disp)) +geom_point()

#ggplot() command. This will tell ggplot2 to draw points on the plot.
#geom_smooth() will draw a smoothed line over the points.
ggplot(diamonds, aes(x = carat, y = price))+ geom_point()+geom_smooth()

ggplot(diamonds, aes(x = carat, y = price,col=clarity)) +geom_point()

#Set alpha = 0.4 inside geom_point(). This will make the points 60% transparent/40% visible.
#we can add transparency (alpha) to avoid overplotting:

ggplot(diamonds, aes(x = carat, y = price,col=clarity)) +geom_point(alpha=0.4,aes(color=color))

#We can also specify the colors directly inside the mapping provided in the ggplot() function.
#This will be seen by any geom layers and the mapping will be determined by the x- and y-axis set up in aes().

ggplot(data = diamonds, mapping = aes(x = carat, y = price, color = color)) + geom_point(alpha = 0.1)

#ggplot2 has a special technique called faceting that allows the user to split
#one plot into multiple plots based on a factor included in the datase

ggplot(data = diamonds, mapping = aes(x = carat, y = price , color=color)) + geom_line() +labs(title="Scatterplot", x="Carat", y="Price") + facet_wrap(~ color)

#Usually plots with white background look more readable when printed. We can set the background to white using the function theme_bw(). 
#Additionally, you can remove the grid:

ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank())


dia_plot<- ggplot(diamonds, aes(x = carat, y =price))

dia_plot + geom_point()+ geom_smooth(aes(col= clarity),method="lm")

dia_plot +  geom_point(aes(color = clarity))

dia_plot <- dia_plot +geom_point(alpha=0.2)

dia_   plot + geom_smooth(aes(se=FALSE,col= clarity))

dia_plot + geom_point()+ geom_smooth(method="lm")

### facet

dia_plot + geom_point()+ geom_smooth(method="lm")+facet_grid(~cut)


dia_plot+labs(tittle="price vs carat",x="carat",fill="cut")

dia1<- dia_plot + geom_point()+ geom_smooth(method="lm")+facet_grid(~cut) 

dia1 + labs(title="price vs carat")

dia2 <- dia1 + labs(title="price vs carat")

dia3 <- dia2+theme(panel.background = element_rect(fill="palegreen1"))

dia4 <- dia3 +theme(plot.title = element_text(hjust=0.5,face="bold",colour="cadetblue"))

#We will use the tips dataset from the reshape2 package.
library(ggplot2)
sp <- ggplot(tips, aes(x=total_bill, y=tip/total_bill)) + geom_point(shape=1)
sp

sp+facet_grid(sex~.)

sp+facet_grid(.~sex)

sp + facet_grid(sex ~ day)

sp + facet_wrap( ~ day, ncol=2)

sp + facet_grid(sex ~ day) +
  theme(strip.text.x = element_text(size=8, angle=75),
        strip.text.y = element_text(size=12, face="bold"),
        strip.background = element_rect(colour="red", fill="#CCCCFF"))

ggplot(aes(x='date_hour', y='pageviews'), data=pageviews) + 
geom_point() +
geom_hline(yintercept=[10000])

ggplot(aes(x='date_hour', y='pageviews'), data=pageviews) + 
geom_point() +
geom_hline(yintercept=range(5000, 20000, 5000), color='coral', size=5)


ggplot(meat, aes(x='date', y='beef')) +
geom_line() +
geom_hline(yintercept=2500, color='red') +
geom_hline(yintercept=2000, color='yellow') +
geom_hline(yintercept=1500, color='green')

a <- as.POSIXct(c("2015-01-02 06:07:27", "2015-01-02 06:42:36", "2015-01-02 08:07:38", "2015-01-02 08:08:45", "2015-01-02 08:12:23", "2015-01-03 09:07:27", "2015-01-03 09:42:36"))

b <- c(1,11,4,10,2,8,9)

ggplot(data = example_data, aes(x=a,y=b))+geom_point()+geom_rect(aes(xmin=as.POSIXct(min(example_data$a)),xmax= as.POSIXct(max(example_data$a)),min(example_data$b),max(example_data$b)),fill="white")

scale_x_datetime(labels = date_format( %H-%M"),
                 00:00:00","2015-01-03 12:00:00"))


ggplot(data = example_data, aes(as.POSIXct(example_data$a, format="%d/%m/%Y %H:%M:%S"),y=b))
+geom_point()+geom_rect(aes(xmin=as.POSIXct(min(example_data$a)),xmax= as.POSIXct(max(example_data$a)),ymin=4,ymax=5,fill="white")) 
 scale_x_datetime(limits=lims)
     date_breaks = "3 hours",limits=lims)
                     as.POSIXct(data$Date, format="%d/%m/%Y %H:%M:%S")  
    
lims<-c(as.POSIXct("2015-01-02 06:07:27","2015-01-03 09:42:36",origin = "1970-01-01"))

lims<-c(as.POSIXct("2015-01-02 06:07:27","2015-01-03 09:42:36",origin = "1970-01-01",format="%d/%m/%Y %H:%M:%S",tz="America/Los_Angeles"))

lims<-c(as.POSIXct("2015-01-02
xticks <-as.POSIXct(c("2015-01-02 06:07:27", "2015-01-02 06:42:36", "2015-01-02 08:07:38", "2015-01-02 08:08:45", "2015-01-02 08:12:23", "2015-01-03 09:07:27", "2015-01-03 09:42:36"))


ggplot(data=example_data, aes(x=as.POSIXct(example_data$a), y=b)) +geom_point()+
  geom_rect(aes(xmin=0, xmax=6, ymin=42, ymax=48), fill="white")+
  scale_y_continuous(limits=c(0,NA), breaks=trans(eyticks), labels=eyticks) 
 
                                     
                                     
    ggplot(data=example_data, aes(x=as.POSIXct(example_data$a), y=b)) +geom_point()+
    geom_rect(aes(xmin=as.POSIXct(0),orgin="1901-01-01", xmax=as.POSIXct(6),orgin="1901-01-01", ymin=0, ymax=12), fill="white")+
    scale_y_continuous(limits=c(0,NA), breaks=trans(eyticks), labels=eyticks) 
    
    
    
    ggplot(data=example_data, aes(x=as.POSIXct(example_data$a), y=b)) +geom_point()+
    geom_rect(aes(xmin=as.POSIXct(, xmax=as.POSIXct(6),orgin="1901-01-01", ymin=0, ymax=12), fill="white")+
    scale_x_continuous(limits=c(0,NA), breaks=trans(eyticks), labels=eyticks) +
   
    
    
    ggplot(data=example_data, aes(x=a, y=b)) +geom_point()+geom_rect(aes(xmin=as.POSIXct("2015-01-02 06:07:27",origin="1901-01-01"), xmax=as.POSIXct("2015-01-03 09:42:36",origin="1901-01-01"), ymin=4, ymax=6), fill="white")
    
    +scale_x_datetime(date_labels = "%d/%m/%Y %H:%M:%S",limits=lims)
                                       
    ggplot(data=example_data, aes(x=a, y=b)) +
    geom_point()+
    
    q <- as.POSIXct("2015-01-02 06:07:27",origin="1901-01-01")
    
    geom_rect(aes(xmin=as.POSIXct("2015-01-02 06:07:27",origin="1901-01-01"), xmax=as.POSIXct("2015-01-03 09:42:36",origin="1901-01-01"), ymin=4, ymax=6), fill="white")+
    scale_x_continuous(limits=c(as.POSIXct("2015-01-02 06:07:27",origin="1901-01-01",as.POSIXct("2015-01-03 09:42:36",origin="1901-01-01"))))

    
    
    strptime("2015-01-02 06:07:27", f <- "%Y-%m-%d %H:%M:%OS", tz = "America/Los_Angeles")
    
    