x <- 7
y <- 5
x + y
#식으로 표현하기
cat(x,"+",y,"=",x+y)
plus <- function(x,y){
  return(x+y);
}
plus(3,8)

plus <- function(x,y){
  return(cat(x,"+",y,"=",x+y));
}
plus(3,8)

minus <- function(x,y){
  return(cat(x,"-",y,"=",x-y));
}
minus(3,8)

multi <- function(x,y){
  return(cat(x,"*",y,"=",x*y));
}
multi(3,8)

div.float <- function(x,y){
  return(cat(x,"/",y,"=",x/y));
}
div.float(8,3)

div.integer <- function(x,y){
  return(cat(x,"%/%",y,"=",x%/%y));
}
div.integer(8,3)

div.remainder <- function(x,y){
  return(cat(x,"%%",y,"=",x%%y));
}
div.remainder(8,3)

## 계산기
x <- 3
op <- "+"
y <- 2

if (op=="+") plus(x,y) else
if (op=="-") minus(x,y) else
if (op=="*") multi(x,y) else
if (op=="/") div.float(x,y) else
if (op=="%/%") div.integer(x,y) else
if (op=="%%") div.remainder(x,y) else
print("error")

calc <- function(x,op,y){
  if (op=="+") plus(x,y) else
  if (op=="-") minus(x,y) else
  if (op=="*") multi(x,y) else
  if (op=="/") div.float(x,y) else
  if (op=="%/%") div.integer(x,y) else
  if (op=="%%") div.remainder(x,y) else
  print("error")
  }
calc(8,"*",3)


calc2 <- function(x,op,y){
  switch(
    op,
    "+"=plus(x,y),
    "-"=minus(x,y),
    "*"=multi(x,y),
    "/"=div.float(x,y),
    "%/%"=div.integer(x,y),
    "%%"=div.remainder(x,y)
  )
}
calc2(5,"*",6)





