options(scipen=999)
library(zoo)
x<-read.csv("in/1.txt",header=F)$V1
1791==sum(diff(x)>0)
1822==sum(diff(rollsum(x,3))>0)
x<-read.csv("in/2.txt",header=F,sep="")
2187380==sum((x$V1=="forward")*x$V2)*sum(with(x[x$V1!="forward",],ifelse(V1=="up",-1,1)*V2))
2086357770==sum((x$V1=="forward")*x$V2)*sum(with(x,(V1=="forward")*V2*cumsum(ifelse(V1=="forward",0,ifelse(V1=="up",-1,1))*V2)))
x<-data.frame(matrix(unlist(strsplit(read.csv("in/3.txt",header=F,colClasses="character")$V1,"")),ncol=12,byrow=T))
conv<-function(v)strtoi(paste0(v,collapse=""),base=2)
com<-function(x,i)apply(x,2,function(cl)names(sort(table(cl)))[i])
life<-function(x,v,i=1)if(nrow(x)==1)x else life(x[x[i]==com(x,v)[i],],v,i+1)
3277364==conv(com(x,2))*conv(com(x,1))
5736383==conv(life(x,2))*conv(life(x,1))


#life<-function(x,v){
#  i<-1
#  while(nrow(x)>1) {
#    x<-x[x[i]==com(x,v)[i],]
#    i<-i+1
#  }
#  x
#}


#4
draws<-c(1,76,38,96,62,41,27,33,4,2,94,15,89,25,66,14,30,0,71,21,48,44,87,73,60,50,77,45,29,18,5,99,65,16,93,95,37,3,52,32,46,80,98,63,92,24,35,55,12,81,51,17,70,78,61,91,54,8,72,40,74,68,75,67,39,64,10,53,9,31,6,7,47,42,90,20,19,36,22,43,58,28,79,86,57,49,83,84,97,11,85,26,69,23,59,82,88,34,56,13)

x<-read.csv("in/4.txt",header=F,sep="")
boards<-split(x, rep(1:100,each=5))

last<-c()
xx<-boards
for(draw in draws){
  for(i in 1:100) {
   b <- xx[[i]]
   b[b == draw] <- NA
   xx[[i]] <- b
  }

  win<-which(unlist(lapply(xx, function(b) any(apply(b, 2, function(x) all(is.na(x)))) || any(apply(b, 1, function(x) all(is.na(x)))))))
  
  cwin <- win[which(!win %in% last)]
  last <- win

#  if(length(win)>0) {
#    print(win)
#    print(draw)
#    return(NA)
#  }

  if(length(win)==100) {
    print(cwin)
    print(draw)
    return(NA)
  }

}

sum(xx[[73]],na.rm=T) * 49

# 5


coords_to_matrix<-function(x1,y1,x2,y2,N=1+max(x)){
  m<-matrix(0,N,N)
  ifelse(x1==x2|y1==y2,m[x1:x2,y1:y2]<-1,diag(m[x1:x2,y1:y2])<-1)
  m
}

x<-read.csv("in/5.txt",header=F,col.names=c("x1","y1","x2","y2"))
5608==sum(Reduce("+",lapply(apply(x[with(x,x1==x2|y1==y2),],1,as.list),function(x)do.call(coords_to_matrix,x)))>1)
20299==sum(Reduce("+",lapply(apply(x,1,as.list),function(x)do.call(coords_to_matrix,x)))>1)

# 6
x<-as.vector(t(read.csv("in/6.txt",header=F)))

sim<-function(x,d=1,to=10)if(d==to+1) x else sim(c(ifelse(x-1==-1,6,x-1),rep(8,sum(x==0))),d+1,to)
385391==length(sim(x,to=80))

sim<-function(v,d=1,to=10)if(d>to) v else sim(c(v[2:7],v[8]+v[1],v[9],v[1]),d+1,to)
1728611055389==sum(sim(c(0,table(x),0,0,0),to=256))


# 10


e_stack <- function(x) {
	q <- c()
	for(e in x) {
		if(any(e %in% c("<", "{", "(", "["))) {
			q <- c(e, q)
		}
		else {
			popped <- q[1]
                	q <- q[-1]
			if(popped != "<" && e == ">") return(25137)
			if(popped != "{" && e == "}") return(1197)
			if(popped != "[" && e == "]") return(57)
			if(popped != "(" && e == ")") return(3)
		}
	}
	return(0)
}

x<-read.csv("in/10.txt",header=F)$V1
339411==sum(unlist(lapply(strsplit(x, ""), e_stack)))

e_stack2 <- function(x) {
	q <- c()
	for(e in x) {
		if(any(e %in% c("<", "{", "(", "["))) {
			q <- c(e, q)
		}
		else {
			popped <- q[1]
                	q <- q[-1]
		}
	}
        score = 0
        r = c()
	for(e in q) {
            if(e == "(") score <- score*5 + 1
            else if(e == "[") score <- score*5 + 2
            else if(e == "{") score <- score*5 + 3
            else score <- score*5 + 4
        }
        return(score)
}


2289754624==median(unlist(lapply(strsplit(x[unlist(lapply(strsplit(x, ""), e_stack)) == 0], ""), e_stack2)))




