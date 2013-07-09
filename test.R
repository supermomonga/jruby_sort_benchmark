
quick <- read.csv("~/Develops/jruby-sorts/test.csv")
plot(quick[,c("要素数")], quick[,c("時間.ms.")])

par(new=TRUE)

x = 1:1000000
y = x * log2(x)
plot(x,y,type="l")