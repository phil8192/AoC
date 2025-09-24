x<-read.csv("input.txt",header=F,sep=" ")

# 1
outcomes<-setNames(list(4,8,3, 1,5,9, 7,2,6),
		   paste0(rep(c("A","B","C"),each=3), c("X","Y","Z")))
sum(unlist(outcomes[with(x,paste0(V1, V2))]))

# 2
l<-with(x[x$V2=="X",],ifelse(V1=="A",3,ifelse(V1=="B",1,2)))
d<-with(x[x$V2=="Y",],ifelse(V1=="A",4,ifelse(V1=="B",5,6)))
w<-with(x[x$V2=="Z",],ifelse(V1=="A",8,ifelse(V1=="B",9,7)))
sum(l,d,w)


## nicer way..
x<-data.frame(V1=as.integer(factor(x$V1)),
	      V2=as.integer(factor(x$V2)))

# 1
w<-6+x[with(x,V1==1&V2==2|V1==2&V2==3|V1==3&V2==1),]$V2
d<-3+x[with(x,V1==V2),]$V2
l<-0+x[with(x,V1==1&V2==3|V1==2&V2==1|V1==3&V2==2),]$V2
sum(w,d,l)

# 2
w<-6+with(x[x$V2==3,],ifelse(V1==1,2,ifelse(V1==2,3,1)))
d<-3+with(x[x$V2==2,],V1)
l<-0+with(x[x$V2==1,],ifelse(V1==1,3,ifelse(V1==2,1,2)))
sum(w,d,l)


## even nicer..
with(x-1,sum((V2-V1+1)%%3*3,V2+1))
with(x-1,sum((V2+V1-1)%%3+1,V2*3))

