if("rJava" %in% installed.packages("rJava") == FALSE)install.packages("rJava")
library(rJava)
if("memoise" %in% installed.packages("memoise") == FALSE)install.packages("memoise")
library(memoise)
if("KoNLP" %in% installed.packages("KoNLP") == FALSE)install.packages("KoNLP")
library(KoNLP)
if("tm" %in% installed.packages("tm") == FALSE)install.packages("tm")
library(tm)
if("wordcloud" %in% installed.packages("wordcloud") == FALSE)install.packages("wordcloud")
library(wordcloud)
if("dplyr" %in% installed.packages("dplyr") == FALSE)install.packages("dplyr")
library(dplyr)
if("stringr" %in% installed.packages("stringr") == FALSE)install.packages("stringr")
library(stringr)
if("RColorBrewer" %in% installed.packages("RColorBrewer") == FALSE)install.packages("RColorBrewer")
library(RColorBrewer)
KoNLP::useSejongDic()
getwd()
# step 1. 데이터를 로딩한다
txt <- readLines("C:\\Users\\Administrator\\rlang_weekend\\data\\jeju.txt")
head(txt,10)
# step 2. 명사만 추출
nouns <- 
  sapply(
    txt,
    extractNoun,
    USE.NAMES = F
  )
class(nouns)
head(nouns,10)
cdata <- unlist(nouns)
cdata <- stringr::str_replace_all(txt,"[^[:alpha:]]"," ")
cdata <- gsub(" ","",cdata)

gsubTxt <- readLines("C:\\Users\\Administrator\\rlang_weekend\\data\\제주도여행코스gsub.txt")
cnt <- length(gsubTxt)
for(i in 1:cnt){
  cdata <- gsub(gsubTxt[i],"", cdata)
}
cdata
cdata <- Filter(function(x){nchar(x) >= 2},cdata)
write(unlist(cdata),"jeju_2.txt")
nouns <- read.table("jeju_2.txt")
nrow(nouns)
wordcount <- 




# step 3. 특수문자 제거
txt <- stringr::str_replace_all(txt,"\\W"," ")
head(txt)
txt <- stringr::str_replace_all(txt,"[^[:alpha:]]"," ")
head(txt)








# step 3-1, 특정단어 삭제하기

gsubTxt <- readLines("C:\\Users\\Administrator\\rlang_weekend\\data\\제주도여행코스gsub.txt")
gsubTxt
cnt <- length(gsubTxt)
for(i in 1:cnt){
  nouns <- gsub(gsubTxt[i],"", nouns)
}
nouns




# step 4. 단어별 빈도표 작성
wordcount <- table(unlist(nouns2))
head(wordcount,10)
top10 <- head(sort(wordcount,decreasing = 10))
pie(top10,
    col = rainbow(10),
    radius = 1,
    main="제주도 추천 여행코스 Top 10")

df_word <- as.data.frame(wordcount,stringsAsFactors = F)



# step 5. 변수명 수정
names(df_word)
df_word <- dplyr::rename(
  df_word,
  word = Var1,
  freq = Freq
)
# step 6. 2 글자 이상만 추출
df_word <- dplyr::filter(df_word, nchar(word)>=2)
# step 7. 빈도순 정렬 후 상위 20단어만 추출
top_20 <- df_word %>% 
  dplyr::arrange(desc(freq)) %>% 
  head(20)
top_20
wordcloud::wordcloud(
  words = df_word$word,
  freq = df_word$freq,
  min.freq = 2,
  max.words = 200,
  random.order = F,
  rot.per = .1,
  scale = c(4, 0.3),
  colors = brewer.pal(8,"Dark2")
)



















