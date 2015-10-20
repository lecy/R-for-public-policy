
# READ DATA FROM GITHUB

library( RCurl )

url <- "https://raw.githubusercontent.com/lecy/R-for-public-policy/master/Data/Same%20Sex%20Marriage%20Polling%20Data.csv"
dat.temp <- getURL( url, ssl.verifypeer = FALSE )
dat <- read.csv( textConnection( dat.temp ), stringsAsFactors=FALSE )  

rm( url )
rm( dat.temp )




# "StateName" - name of state
# "StateAbb"  - abbreviated state name
# "X2004"     - polling data from 2004, do you support same sex marriage?
# "X2011"     - polling data from 2011, do you support same sex marriage?
# "Amendment" - has the state passed an ammendment banning SSM?
# "Obam2008"  - state voted for Obama in 2008?




# ORDER DATA BY 2011 POLL RESULTS

dat <- dat[ order( dat$X2011, decreasing=T ), ]

state.name <- dat$StateName
poll.2004 <- dat$X2004
poll.2011 <- dat$X2011
amendment <- dat$Amendment



# CREATE COLOR VECTORS

col.vec.amendment <- NULL

col.vec.amendment[ dat$Amendment==1 ] <- "black"
col.vec.amendment[ dat$Amendment==0 ] <- "dark Gray"


col.vec.party <- NULL

col.vec.party[ dat$Obam2008==1 ] <- "blue"
col.vec.party[ dat$Obam2008==0 ] <- "red"


pch.amendment <- NULL

pch.amendment[ dat$Amendment==1 ] <- 15
pch.amendment[ dat$Amendment==0 ] <- 19

pch.amendment <- as.numeric(pch.amendment)




###################
###################




plot( poll.2011, 51:1, 
      xlim=c(10,120), ylim=c(0,53), 
      col=col.vec.amendment, pch=pch.amendment, 
      bty="n", ylab="", yaxt="n", xlab="", xaxt="n", 
      main="Percentage Supporting Same Sex Marriage"  
    )



# ADD VERTICLE BARS FOR % SUPPORT

segments( x0=50, y0=0, y1=51, col="gray", lty=1 )

segments( x0=20, y0=0, y1=51, col="gray", lty=3 )

segments( x0=30, y0=0, y1=51, col="gray", lty=3 )

segments( x0=40, y0=0, y1=51, col="gray", lty=3 )

segments( x0=60, y0=0, y1=51, col="gray", lty=3 )

segments( x0=70, y0=0, y1=51, col="gray", lty=3 )





points( poll.2011, 51:1, col=col.vec.amendment, pch=pch.amendment )

points( poll.2004, 51:1, col=col.vec.amendment, pch=pch.amendment )

segments( x0=poll.2011, x1=poll.2004, y0=51:1, col=col.vec.amendment, lty=1 )
 
 
 

text( poll.2011, 51:1, state.name, pos=4, cex=0.6, col=col.vec.party )

text( c( (poll.2004[1]), poll.2011[1]), c(54,54), c("2004","2011"), cex=0.8 )



# ADD LABELS AND LEGEND

text( c(20,30,40,50,60,70), -1, c("20%","30%","40%","50%","60%","70%"), col="dark gray", cex=0.8 )
text( 50, -1, "50%",  cex=0.8 )

points( 80, 20, pch=15 )
text( 80, 20, "Constitutional amendment passed", cex=0.7, pos=4  )

points( 80, 18, pch=19, col="dark gray" )
text( 80, 18, "No vote on amendment", cex=0.7, pos=4  )

text( 80, 15, "Voted Obama 2008", cex=0.7, pos=4, col="blue" )
text( 80, 13, "Voted McCain 2008", cex=0.7, pos=4, col="red" )
