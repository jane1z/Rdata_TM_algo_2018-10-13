if("stringr" %in% installed.packages("stringr") == FALSE)install.packages("stringr")
library(stringr)
if("KoNLP" %in% installed.packages("KoNLP") == FALSE)install.packages("KoNLP")
library(KoNLP)
if("wordcloud" %in% installed.packages("wordcloud") == FALSE)install.packages("wordcloud")
library(wordcloud)
if("RColorBrewer" %in% installed.packages("RColorBrewer") == FALSE)install.packages("RColorBrewer")
library(RColorBrewer)
setwd("C:\\Users\\Administrator\\rlang_weekend\\data")
getwd()

gsb <- readLines("jeju__gsb.txt")
tgt1 <- readLines("jeju.txt")
mrg <- readLines("jeju__mrg.txt")
# class(mrg)
useSejongDic()
mrg <- data.frame(mrg,"ncn") # 비서술형명사
KoNLP::buildDictionary(
  ext_dic = c('sejong','woorimalsam'),
  user_dic = mrg
)
tgt1 <- sapply(tgt1, 
               extractNoun,
               USE.NAMES = F,
               autoSpacing=T)
tgt2 <- unlist(tgt1)
tgt3 <- stringr::str_replace_all(tgt2,'[^[:alpha:]]','')
gsub4 <- function(){
 
  t <- c(
    ' ', '[~!@#$%&*()_+=?<>]',"\\[",
    '[ㄱ-ㅎ]','(ㅜ|ㅠ)',"\\d+"
  )
  i <- 0
  for(i in 1:length(t)){
    tgt4 <- gsub(t[i],"",tgt3)
  }
  return (tgt4)
}
gsub5 <- function(){
  tgt5 = gsub("\\S*일출", "성산일출봉", tgt4)
  tgt5 = gsub("성산\\S*", "성산일출봉", tgt4)
  #tgt5 = gsub("성산\\S*", "성산일출봉", tgt5)
  tgt5 = gsub("한라\\S*", "한라산", tgt5)
  tgt5 = gsub("랜드", "에코랜드", tgt5)
  tgt5 = gsub("에코에코랜드", "에코랜드", tgt5)
  tgt5 = gsub("주상\\S*", "주상절리", tgt5)
  tgt5 = gsub("\\S*절리", "주상절리", tgt5)
  tgt5 = gsub("용두", "용두암", tgt5)
  tgt5 = gsub("용두암암", "용두암", tgt5)
  tgt5<- gsub('폭포','',tgt5)
  tgt5<- gsub('연폭','',tgt5)
  tgt5 = gsub("천지", "천지연폭포", tgt5)
  tgt5<- gsub('공원','',tgt5)
  tgt5<- gsub('관광','',tgt5)
  tgt5<- gsub("산방\\S*","산방산",tgt5)
  tgt5<- gsub('까지','',tgt5)
  tgt5<- gsub('으로','',tgt5)
  tgt5<- gsub('박물','',tgt5)
  return (tgt5)
}

tgt4 <- gsub4()
tgt4
tgt5 <- gsub5()
gsb__cnt <- length(gsb)
i <- 0
for(i in 1:gsb__cnt){
  tgt5 <- gsub(gsb[i],"",tgt5)
}
tgt6 <- Filter(function(x){nchar(x) >= 2},tgt5)
# tgt6
tgt6 <- unlist(tgt6)
write(tgt6,'jeju__temp.txt')
tgt7 <- read.table('jeju__temp.txt')
# class(tgt7)
tgt8 <- table(tgt7)
# class(tgt8)
tgt9 <- head(sort(tgt8,decreasing = T),30)
tgt9
pal <- brewer.pal(8,"Dark2")
set.seed(1234)
wordcloud(
  names(tgt8),
  freq = tgt8,
  scale = c(2.5,0.1), # 단어크기 0.1 ~ 2.5
  rot.per = 0.25, # 회전비율
  min.freq = 2, # 최저 빈도수 2회이상
  random.order = F, # 고빈도 단어 중앙배치
  random.color = T,
  colors = pal
)

### TEXT MINING 편집함수

top10 <- head(sort(tgt9,decreasing = T),10)
top10
pie(top10,main = "제주도 여행코스 탑 10")

pie(top10,
    col = rainbow(10),
    radius = 1,
    main = "제주도 여행코스 탑 10")

pct <- round(top10/sum(top10)*100,1)
names(top10)
lab <- paste(names(top10),'\n',pct,"%")

pie(top10,
    col = rainbow(10),
    radius = 1,
    cex = 0.9,
    labels = lab,
    main = "제주도 여행코스 탑 10"
    )

## 바차트
bp <- barplot(
  top10,
  main = "제주도 여행코스 탑 10",
  col = rainbow(10),
  cex.names = 1.0,
  las = 2,
  ylim = c(0,30)
)
text(x = bp,
     y = top10,
     labels = lab,
     col = 'black',
     cex = 0.9
     )
text(
  x = bp,
  y = top10-2.5,
  labels = paste(top10,"건"),
  col = 'black',
  cex = 0.7
)

##3D파이차트
install.packages("plotrix")
library(plotrix)
plotrix::pie3D(
  top10,
  col = rainbow(10),
  cex = 0.1,
  labels = lab,
  explode = 0.1
)





















