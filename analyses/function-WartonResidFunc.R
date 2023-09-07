################################################################
## Modification of Warton *et al.*'s (2017) S6residFunctions.R
##
## We have modified the code to work with our data structure
## Modifications are clearly marked and original code hashtagged
################################################################

## Load required libraries.

library(RPresence);
library(gplots);
library(lattice);
library(detect);
library(unmarked);
library(AICcmodavg);
library(mgcv);
library(rjags);
library(R2jags);

## Logit function.

Logit<-function(p){log(p/(1-p));}

## A function produce the Dunn-Smyth residuals.

## Arguments:
## object, the occMod object which must contain the following:
## $data$psi$est, fitted probabilities of occupancy.
## $data$p$est, fitted probabilities of detection.
## $data$det.data, binary matrix of detections, sites in rows and visits in columns. NA for missing values.

## Value: outputs a list with two components:
## det (Dunn-Smyth residuals for detection, based on cdf of #detections).
## occ (Dunn-Smyth residuals for occupancy, based on cdf of binary detected/not).

## To do:
## Generalise to mixture models given: number of components (for a mixture model); mixture probabilities.
## This will be straightforward, almost a one-liner.



################################################################
## Modification  (1)
################################################################
#residuals.occMod<-function(object,is.detect.constant=FALSE)
residuals.occMod<-function(object, det.data, is.detect.constant=FALSE)
{
  
  ################################################################
  ## Modifications  (2)
  ################################################################
  
  #det.data<-object$data$det.data;     # Binary matrix of detections, sites in rows, visits in columns.
  nSites<-dim(det.data)[1];           # Number of sites.
  #psi<-object$real$psi$est;           # Occupancy probabilities, assuming a vector.
  psi<-object$psi;           # Occupancy probabilities, assuming a vector.
  
  ## Get number of visits (ni) and probability of non-detection (prob0).
  
  ni<-apply(is.na(det.data)==FALSE,1,sum);    # Number of site visits, a vector across sites.
  xi<-apply(det.data,1,sum,na.rm=TRUE);       # Number of detections.
  xi2<-apply((object[,c("p", "psi")])$p,1,sum,na.rm=TRUE);       # Number of detections.
  xiOcc<-pmin(xi,1);                          # Make it binary to study occupancy "only".
  
  ################################################################
  ## Modification  (1)
  ################################################################
  
  #pi<-matrix(object$real$p$est,nrow=nSites);  # Detection probabilities.
  test<-object[complete.cases(object[ , "p"]),];  # Detection probabilities.
  
  ##### need to include some code to compute is.detect.constant from pi #####
  
  ## Below assumes equal probabilities of detection for each sampling time!!!
  
  if(is.detect.constant==TRUE)
  {
    pi<-object$real$p$est[1:nSites];   # Detection probabilities, assuming equal across sites.
    prob0<-pbinom(0,ni,pi);            # Probability of no detections when present, a site vector.
    
    ## Get cdf's for detection residuals - as a function of sum of detection events
    
    xi[xi==0]<-NA;                               # Ignore sites with no detections here.
    pdet<-(pbinom(xi,ni,pi)-prob0)/(1-prob0);   # CDF for number of detections xi, positive binomial.
    pdetMinus<-(pbinom(xi-1,ni,pi)-prob0)/(1-prob0); # Previous value of the cdf of xi.
  }
  
  if(is.detect.constant==FALSE)
  {
    prob0<-apply(1-pi,1,prod);    # Probability of no detections when present, a site vector.
    
    ## Define a function to get the pdf under unequal detections.
    
    hetpdf<-function(xiSite,niSite,piSite)
    {
      ind<-combn(niSite,xiSite);
      piMat<-matrix(piSite[ind],nrow=xiSite);
      
      return(sum(apply(piMat/(1-piMat),2,prod))*prod(1-piSite));
    }
    
    hetcdf<-function(xiSite,niSite,piSite)
    {
      if(xiSite==0){cdf<-0;}
      else
      {
        detiSite<-rep(NA,xiSite);
        
        for(iX in 1:xiSite)
        {
          detiSite[iX]<-hetpdf(iX,niSite,piSite);
        }
        
        cdf<-sum(detiSite);       
      }
      
      return(cdf);
    }
    
    ## Get cdf's for detection residuals - as a function of sum of detection events.
    
    isDetected<-xi>0;
    xi[isDetected==FALSE]<-NA;  # Ignores sites with no detections.
    
    pdet=pdetMinus=rep(NA,nSites);
    
    for(iSite in which(isDetected))
    {
      xiSite<-xi[iSite];
      niSite<-ni[iSite];
      piSite<-pi[iSite,];
      pdetMinus[iSite]<-hetcdf(xiSite-1,niSite,piSite);
      pdet[iSite]<-pdetMinus[iSite]+hetpdf(xiSite,niSite,piSite);
    }
    
    pdet<-pdet/(1-prob0);   # 'CDF' for number of detections xi in heterogeneous case.
    pdetMinus<-pdetMinus/(1-prob0); # Previous value of the cdf of xi.
  }
  
  ## Get cdf's for occupancy residuals - as a function of binary detected/not.
  
  probOcc<-psi*(1-prob0);                     # Probability of occupancy.
  pOcc<-1-probOcc+xiOcc*probOcc;              # CDF for occupancy, Bernoulli variable with param probOcc.
  pOccMinus<-xiOcc*(1-probOcc);               # Previous value of the cdf of occupancy.
  
  ## Jitter and get occupancy residuals.
  
  uOcc<-runif(nSites);                             # Standard uniform value to "jitter" the cdf.
  residOcc<-qnorm(pOcc*uOcc+pOccMinus*(1-uOcc));   # Dunn-Smyth residual, standard normal if cdf correct.
  
  ## Jitter and get detection residuals.
  
  u<-runif(nSites);                             # Standard uniform value to "jitter" the cdf.
  residDet<-qnorm(pdet*u+pdetMinus*(1-u));      # Dunn-Smyth residual, standard normal if cdf correct.
  
  residuals<-list(occ=residOcc,det=residDet);  
  
  return(residuals) # Return output (i.e., a list with occupancy residuals (occ) and detection residuals (det)).
}

## A function that plots DS residuals against either fitted occupancy/detection probs.

DS.resid.plot<-function(x,y,ylim=c(-1,1)*max(abs(y)),alpha=0.05,k=5)
{
  plot(x,y,pch=16,cex=1.2,col="blue",cex.axis=1.4,ylim=ylim,cex.main=0.9,ylab="",xlab="");
  
  lsmod<-gam(y~s(x,k=k));
  lsmod.p<-predict(lsmod,se.fit=TRUE);
  z.crit<-qnorm(1-alpha/2)
  upr<-lsmod.p$fit+(z.crit*lsmod.p$se.fit);
  lwr<-lsmod.p$fit-(z.crit*lsmod.p$se.fit);
  polygon(c(rev(sort(x)),sort(x)),c(rev(upr[order(x)]),(lwr[order(x)])),col='grey80',border=NA);
  points(x,y,pch=16,cex=1.2,col="blue");
  lines(sort(x),fitted(lsmod)[order(x)],lwd=2);
  abline(h=0,col="black",lwd=1);
}

## Bayesian .txt function/files requierd for jags.

sink("mod_1.txt");

cat("
    model {
    
    # Priors.
    
    mean.p ~ dunif(0, 1) # Detection intercept on prob. scale.
    alpha0 <- logit(mean.p) # Same on logit scale.
    mean.psi ~ dunif(0, 1) # Occupancy intercept on prob. scale.
    beta0 <- logit(mean.psi) # Same on logit scale.
    
    for(k in 1:3){ # 3 terms in detection model.
    alpha[k] ~ dnorm(0, 0.1) # Covariates on logit(detection).
    }
    
    for(k in 1:7){ # 7 terms in occupancy model.
    beta[k] ~ dnorm(0, 0.1) # Covariates on logit(occupancy).
    }
    
    # Likelihood.
    
    for (i in 1:M) { # Loop over sites.
    z[i] ~ dbern(psi[i])
    logit(psi[i]) <- beta0 + # Occupancy (psi) intercept.
    beta[1] * elev[i] + # effect of elev.
    beta[2] * pow(elev[i],2) + # effect of quadratic elev.
    beta[3] * forest[i] + # effect of forest.
    beta[4] * pow(forest[i],2) +  # effect of quadratic forest.
    beta[5] * elev[i] * forest[i] + # elev:forest.
    beta[6] * elev[i] * pow(forest[i],2) + # elev:forest^2.
    beta[7] * pow(elev[i],2) * forest[i] # elev^2:forest.
    
    for (j in 1:J) { # Loop over replicates.
    
    mu.p[i,j]<- z[i] * p[i,j]
    y[i,j] ~ dbern(mu.p[i,j]) # WinBUGS would need 'straw man'!
    logit(p[i,j]) <- alpha0 + # Detection (p) intercept.
    alpha[1] * date[i,j] + # effect of date on p.
    alpha[2] * dur[i,j] + # effect of duration on p.
    alpha[3] * pow(dur[i,j],2) # effect of quadratic duration on p.
    
    # GOF.
    
    ynew[i,j] ~ dbern(mu.p[i,j]) # Create simulated dataset to calculate the Bayesian p-value.
    
    # Pearson residuals.
    
    #d[i,j] <- (y[i,j] - mu.p[i,j])/sqrt((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    #dnew[i,j] <- (ynew[i,j] - mu.p[i,j])/sqrt((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    d[i,j] <- pow(y[i,j] - mu.p[i,j],2)/((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    dnew[i,j] <- pow(ynew[i,j] - mu.p[i,j],2)/((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))    

    #d2[i,j]<- pow(d[i,j],2)
    #dnew2[i,j]<- pow(dnew[i,j],2)
    d2[i,j]<- d[i,j]
    dnew2[i,j]<- dnew[i,j]
    }
    }
    
    # Calculate the discrepancy measure.
    
    pears.fit<-sum(d2[,])
    pears.fitnew<-sum(dnew2[,])
    }
    ",fill=TRUE);

sink();

sink("mod_2.txt");

cat("
    model {
    
    # Priors.
    
    mean.p ~ dunif(0, 1) # Detection intercept on prob. scale.
    alpha0 <- logit(mean.p) # Same on logit scale.
    mean.psi ~ dunif(0, 1) # Occupancy intercept on prob. scale.
    beta0 <- logit(mean.psi) # Same on logit scale.
    
    for(k in 1:3){ # 3 terms in detection model.
    alpha[k] ~ dnorm(0, 0.1) # Covariates on logit(detection).
    }
    
    for(k in 1:2){ # 2 terms in occupancy model.
    beta[k] ~ dnorm(0, 0.1) # Covariates on logit(occupancy).
    }
    
    # Likelihood.
    
    for (i in 1:M) { # Loop over sites.
    z[i] ~ dbern(psi[i])
    logit(psi[i]) <- beta0 + # Occupancy (psi) intercept.
    beta[1] * forest[i] + # effect of forest.
    beta[2] * pow(forest[i],2)  # effect of quadratic forest.
    
    for (j in 1:J) { # Loop over replicates.
    
    mu.p[i,j]<- z[i] * p[i,j]
    y[i,j] ~ dbern(mu.p[i,j]) # WinBUGS would need 'straw man'!
    logit(p[i,j]) <- alpha0 + # Detection (p) intercept.
    alpha[1] * date[i,j] + # effect of date on p.
    alpha[2] * dur[i,j] + # effect of duration on p.
    alpha[3] * pow(dur[i,j],2) # effect of quadratic duration on p.
    
    # GOF.
    
    ynew[i,j] ~ dbern(mu.p[i,j]) # Create simulated dataset to calculate the Bayesian p-value.
    
    # Pearson residuals.
    
    #d[i,j] <- (y[i,j] - mu.p[i,j])/sqrt((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    #dnew[i,j] <- (ynew[i,j] - mu.p[i,j])/sqrt((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    d[i,j] <- pow(y[i,j] - mu.p[i,j],2)/((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    dnew[i,j] <- pow(ynew[i,j] - mu.p[i,j],2)/((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))    

    #d2[i,j]<- pow(d[i,j],2)
    #dnew2[i,j]<- pow(dnew[i,j],2)
    d2[i,j]<- d[i,j]
    dnew2[i,j]<- dnew[i,j]
    }
    }
    
    # Calculate the discrepancy measure.
    
    pears.fit<-sum(d2[,])
    pears.fitnew<-sum(dnew2[,])
    }
    ",fill=TRUE);

sink();

sink("mod_3.txt");

cat("
    model {
    
    # Priors.
    
    mean.p ~ dunif(0, 1) # Detection intercept on prob. scale.
    alpha0 <- logit(mean.p) # Same on logit scale.
    mean.psi ~ dunif(0, 1) # Occupancy intercept on prob. scale.
    beta0 <- logit(mean.psi) # Same on logit scale.
    
    for(k in 1:3){ # 3 terms in detection model.
    alpha[k] ~ dnorm(0, 0.1) # Covariates on logit(detection).
    }
    
    for(k in 1:3){ # 3 terms in occupancy model.
    beta[k] ~ dnorm(0, 0.1) # Covariates on logit(occupancy).
    }
    
    # Likelihood.
    
    for (i in 1:M) { # Loop over sites.
    z[i] ~ dbern(psi[i])
    logit(psi[i]) <- beta0 + # Occupancy (psi) intercept.
    beta[1] * elev[i] + # effect of elev.
    beta[2] * forest[i] + # effect of forest.
    beta[3] * elev[i] * forest[i] # elev:forest.
    
    for (j in 1:J) { # Loop over replicates.
    
    mu.p[i,j]<- z[i] * p[i,j]
    y[i,j] ~ dbern(mu.p[i,j]) # WinBUGS would need 'straw man'!
    logit(p[i,j]) <- alpha0 + # Detection (p) intercept.
    alpha[1] * date[i,j] + # effect of date on p.
    alpha[2] * dur[i,j] + # effect of duration on p.
    alpha[3] * pow(dur[i,j],2) # effect of quadratic duration on p.
    
    # GOF.
    
    ynew[i,j] ~ dbern(mu.p[i,j]) # Create simulated dataset to calculate the Bayesian p-value.
    
    # Pearson residuals.
    
    #d[i,j] <- (y[i,j] - mu.p[i,j])/sqrt((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    #dnew[i,j] <- (ynew[i,j] - mu.p[i,j])/sqrt((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    d[i,j] <- pow(y[i,j] - mu.p[i,j],2)/((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    dnew[i,j] <- pow(ynew[i,j] - mu.p[i,j],2)/((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    
    #d2[i,j]<- pow(d[i,j],2)
    #dnew2[i,j]<- pow(dnew[i,j],2)
    d2[i,j]<- d[i,j]
    dnew2[i,j]<- dnew[i,j]
    }
    }
    
    # Calculate the discrepancy measure.
    
    pears.fit<-sum(d2[,])
    pears.fitnew<-sum(dnew2[,])
    }
    ",fill=TRUE);

sink();

sink("mod_4.txt");

cat("
    model {
    
    # Priors.
    
    mean.p ~ dunif(0, 1) # Detection intercept on prob. scale.
    alpha0 <- logit(mean.p) # Same on logit scale.
    mean.psi ~ dunif(0, 1) # Occupancy intercept on prob. scale.
    beta0 <- logit(mean.psi) # Same on logit scale.
    
    alpha[1] ~ dnorm(0, 0.1) # Covariates on logit(detection).
    
    for(k in 1:7){ # 7 terms in occupancy model.
    beta[k] ~ dnorm(0, 0.1) # Covariates on logit(occupancy).
    }
    
    # Likelihood.
    
    for (i in 1:M) { # Loop over sites.
    z[i] ~ dbern(psi[i])
    logit(psi[i]) <- beta0 + # Occupancy (psi) intercept.
    beta[1] * elev[i] + # effect of elev.
    beta[2] * pow(elev[i],2) + # effect of quadratic elev.
    beta[3] * forest[i] + # effect of forest.
    beta[4] * pow(forest[i],2) +  # effect of quadratic forest.
    beta[5] * elev[i] * forest[i] + # elev:forest.
    beta[6] * elev[i] * pow(forest[i],2) + # elev:forest^2.
    beta[7] * pow(elev[i],2) * forest[i] # elev^2:forest.
    
    for (j in 1:J) { # Loop over replicates.
    
    mu.p[i,j]<- z[i] * p[i,j]
    y[i,j] ~ dbern(mu.p[i,j]) # WinBUGS would need 'straw man'!
    logit(p[i,j]) <- alpha0 + # Detection (p) intercept.
    alpha[1] * date[i,j] # effect of date on p.
    
    # GOF.
    
    ynew[i,j] ~ dbern(mu.p[i,j]) # Create simulated dataset to calculate the Bayesian p-value.
    
    # Pearson residuals.
    
    #d[i,j] <- (y[i,j] - mu.p[i,j])/sqrt((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    #dnew[i,j] <- (ynew[i,j] - mu.p[i,j])/sqrt((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    d[i,j] <- pow(y[i,j] - mu.p[i,j],2)/((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))
    dnew[i,j] <- pow(ynew[i,j] - mu.p[i,j],2)/((mu.p[i,j]+0.001)*(1-mu.p[i,j]-0.001))    

    #d2[i,j]<- pow(d[i,j],2)
    #dnew2[i,j]<- pow(dnew[i,j],2)
    d2[i,j]<- d[i,j]
    dnew2[i,j]<- dnew[i,j]
    }
    }
    
    # Calculate the discrepancy measure.
    
    pears.fit<-sum(d2[,])
    pears.fitnew<-sum(dnew2[,])
    }
    ",fill=TRUE);

sink();

## The diagnostic GOF measure function for the "Swiss Squirrel" data.

occ_diagnostics<-function(mods_rpres,n.sim.boot,umf,s,K,bayes_parms,want.logit=F,bayes.run=T,want.plot=T,save.plot=T)
{
  options(warn=-1);
  
  ## Extract data fromm the saved "umf" object.  
  
  y<-umf@y;
  elev<-umf@siteCovs$elev;
  forest<-umf@siteCovs$forest;
  dur<-matrix(umf@obsCovs$dur,ncol=K,byrow=T);
  date<-matrix(umf@obsCovs$date,ncol=K,byrow=T);
  
  ## Extract models.
  
  m1<-mods_rpres[[1]];
  m2<-mods_rpres[[2]];
  m3<-mods_rpres[[3]];
  m4<-mods_rpres[[4]];
  
  ## AIC values for each of the four models.
  
  aic_values<-c(m1$aic,m2$aic,m3$aic,m4$aic);
  
  ## Compute the MacKenzie-Bailey GOF test via a parametric bootstrap.
  
  if(n.sim.boot==1){MB_crti_val<-c(NA,NA,NA,NA);}
  if(n.sim.boot==1){MB_pvalues<-c(NA,NA,NA,NA);}
  
  if(n.sim.boot>1)
  {
    MB_crti_val<-c(m1$modfit$chi.sq,m2$modfit$chi.sq,m3$modfit$chi.sq,m4$modfit$chi.sq);
    MB_pvalues<-c(m1$modfit$p.value,m2$modfit$p.value,m3$modfit$p.value,m4$modfit$p.value);
  }
  
  ## Bayesian inference (bundle data set for WinBugs/JAGS).
  
  Bayes_pvalues<-c(NA,NA,NA,NA);
  t1<-c(NA);
  
  if(bayes.run==T)
  {
    params<-bayes_parms[[1]];
    ni<-bayes_parms[[2]];
    nt<-bayes_parms[[3]];
    nb<-bayes_parms[[4]];
    nc<-bayes_parms[[5]];
    
    win.data<-list(y=y,M=s,J=K,elev=elev,forest=forest,date=date,dur=dur);
    
    ## Run JAGS and fit each model.
    
    start<-Sys.time(); # Keep a track of the computational times ofr the full model.
    inits1<-function(){list(z=apply(y,1,max,na.rm=T),mean.psi=runif(1),mean.p=runif(1),alpha=rnorm(3),beta=rnorm(7));}
    out1<-try(jags(win.data,inits1,params,"mod_1.txt",n.chains=nc,n.thin=nt,n.iter=ni,n.burnin=nb),silent=TRUE);
    if(class(out1)!="try-error")
    {
      mod1_bayesP_pears.fitnew<-out1$BUGSoutput$sims.list$pears.fitnew;
      mod1_bayesP_pears.fit<-out1$BUGSoutput$sims.list$pears.fit;
    }
    if(class(out1)=="try-error")
    {
      mod1_bayesP_pears.fitnew<-NA;
      mod1_bayesP_pears.fit<-NA;
    }
    end<-Sys.time();
    t1<-difftime(end,start,units="secs");
    
    inits2<-function(){list(z=apply(y,1,max,na.rm=T),mean.psi=runif(1),mean.p=runif(1),alpha=rnorm(3),beta=rnorm(2));}
    out2<-try(jags(win.data,inits2,params,"mod_2.txt",n.chains=nc,n.thin=nt,n.iter=ni,n.burnin=nb),silent=TRUE);
    if(class(out2)!="try-error")
    {
      mod2_bayesP_pears.fitnew<-out2$BUGSoutput$sims.list$pears.fitnew;
      mod2_bayesP_pears.fit<-out2$BUGSoutput$sims.list$pears.fit;
    }
    if(class(out2)=="try-error")
    {
      mod2_bayesP_pears.fitnew<-NA;
      mod2_bayesP_pears.fit<-NA;
    }
    
    inits3<-function(){list(z=apply(y,1,max,na.rm=T),mean.psi=runif(1),mean.p=runif(1),alpha=rnorm(3),beta=rnorm(3));}
    out3<-try(jags(win.data,inits3,params,"mod_3.txt",n.chains=nc,n.thin=nt,n.iter=ni,n.burnin=nb),silent=TRUE);
    if(class(out3)!="try-error")
    {
      mod3_bayesP_pears.fitnew<-out3$BUGSoutput$sims.list$pears.fitnew;
      mod3_bayesP_pears.fit<-out3$BUGSoutput$sims.list$pears.fit;
    }
    if(class(out3)=="try-error")
    {
      mod3_bayesP_pears.fitnew<-NA;
      mod3_bayesP_pears.fit<-NA;
    }
    
    inits4<-function(){list(z=apply(y,1,max,na.rm=T),mean.psi=runif(1),mean.p=runif(1),alpha=rnorm(1),beta=rnorm(7));}
    out4<-try(jags(win.data,inits4,params,"mod_4.txt",n.chains=nc,n.thin=nt,n.iter=ni,n.burnin=nb),silent=TRUE);
    if(class(out4)!="try-error")
    {
      mod4_bayesP_pears.fitnew<-out4$BUGSoutput$sims.list$pears.fitnew;
      mod4_bayesP_pears.fit<-out4$BUGSoutput$sims.list$pears.fit;
    }
    if(class(out4)=="try-error")
    {
      mod4_bayesP_pears.fitnew<-NA;
      mod4_bayesP_pears.fit<-NA;
    }
    
    Bayes_pvalues<-c(mean(mod1_bayesP_pears.fitnew>mod1_bayesP_pears.fit,na.rm=T),   # Save the GOF Bayesian p-values.
                     mean(mod2_bayesP_pears.fitnew>mod2_bayesP_pears.fit,na.rm=T),
                     mean(mod3_bayesP_pears.fitnew>mod3_bayesP_pears.fit,na.rm=T),
                     mean(mod4_bayesP_pears.fitnew>mod4_bayesP_pears.fit,na.rm=T));
  }
  
  ## Make a table of GOF results.
  
  tab_GOF<-cbind(aic_values,MB_crti_val,MB_pvalues,Bayes_pvalues);
  
  rownames(tab_GOF)<-c("Full model", "No Elevation model", "No Quadratics model", "No Duration model");
  colnames(tab_GOF)<-c("AIC","M&B test stat","M&B P-value","Bayesian P-value");
  
  #set.seed(9966)
  
  ## Obtain Dunn-Smyth (DS) residuals for occupancy and detection.
  
  if(want.plot==T)
  {
    start<-Sys.time();
    res1<-residuals.occMod(m1);
    end<-Sys.time();
    t2<-difftime(end,start,units="secs");
    
    m1_res_occ<-res1$occ;
    m1_res_det<-res1$det[is.na(res1$det)==FALSE];
    
    res2<-residuals.occMod(m2);
    m2_res_occ<-res2$occ;
    m2_res_det<-res2$det[is.na(res2$det)==FALSE];
    
    res3<-residuals.occMod(m3);
    m3_res_occ<-res3$occ;
    m3_res_det<-res3$det[is.na(res3$det)==FALSE];
    
    res4<-residuals.occMod(m4);
    m4_res_occ<-res4$occ;
    m4_res_det<-res4$det[is.na(res4$det)==FALSE];
    
    ## Plots of Dunn-Smyth (DS) residuals for occupancy and detection (Figure 1 in ms).
    
    save.plot.name<-paste('example_squirrels1',".png",sep="");
    if(save.plot==TRUE) png(save.plot.name,width=800,height=1000);
    
    layout(matrix(c(1,2,3,4,5,6),ncol=2,nrow=3,byrow=F));
    par(mar=c(4,4,2,0.5));
    
    ## Dunn-Smyth (DS) residuals plots for occupancy for each model.
    
    m2_x_occ<-m2$real$psi[,1];
    if(want.logit==T){m2_x_occ<-Logit(m2_x_occ);}
    
    fig.type<-"Occupancy";
    DS.resid.plot(m2_x_occ,m2_res_occ);
    title(main="Occupancy Dunn-Smyth residuals",cex.main=2);
    title(main="(a)                                                                                 ",cex.main=2.1);
    mtext(text="fitted occupancy values",side=1,las=1,line=2.6,cex=1.2)
    
    qqnorm(m2_res_occ,main="",col="blue",pch=16,cex.axis=1.4,ylab="",xlab="");
    abline(0,1,col="black");
    title(main="(b)                                                                                 ",cex.main=2.1);
    mtext(text="sample quantiles",side=2,line=2.2,cex=1.2);
    
    DS.resid.plot(m2_x_occ,m2_res_occ,c(-0.5,0.5));
    title(main="(c)                                                                                 ",cex.main=2.1);
    mtext(text="fitted occupancy values",side=1,las=1,line=2.6,cex=1.2)
    
    fig.type<-"Detection";
    m2_x_det<-apply(matrix(m2$real$p[,1],ncol=K),1,sum,na.rm=T)[-which(is.na(res2$det))];
    
    DS.resid.plot(m2_x_det,m2_res_det);
    title(main="Detection Dunn-Smyth residuals",cex.main=2);
    mtext(text=Sigma[j]~"fitted detection values",side=1,las=1,line=2.7,cex=1.2)
    
    qqnorm(m2_res_det,main="",col="blue",pch=16,ylab="",xlab="",cex.axis=1.4);
    mtext(text="sample quantiles",side=2,line=2.2,cex=1.2);
    abline(0,1,col="black");
    
    DS.resid.plot(m2_x_det,m2_res_det,c(-1,1));
    mtext(text=Sigma[j]~"fitted detection values",side=1,las=1,line=2.7,cex=1.2)
    
    if(save.plot==TRUE) dev.off();
    
    ## Plots of Dunn-Smyth (DS) residuals for occupancy only (Figure 2 in ms).
    
    save.plot.name<-paste('example_squirrels2',".png",sep="");
    if(save.plot==TRUE) png(save.plot.name,width=1000,height=320);
    
    layout(matrix(c(1,2,3),ncol=3,nrow=1,byrow=F));
    par(mar=c(4,5,2,0.5));
    
    m2_x_occ<-elev;
    DS.resid.plot(m2_x_occ,m2_res_occ,c(-0.5,0.5));
    title(main="(a) No elevation model",adj=0,cex.main=2);
    mtext(text="elevation",side=1,line=2.2,cex=1.2);
    
    m3_x_occ<-elev;
    DS.resid.plot(m3_x_occ,m3_res_occ,c(-0.5,0.5));
    title(main="(b) No quadratic model",adj=0,cex.main=2);
    mtext(text="elevation",side=1,line=2.2,cex=1.2);
    
    m4_x_det<-apply(dur,1,mean)[is.na(res4$det)==FALSE];
    DS.resid.plot(m4_x_det,m4_res_det,c(-1,1));
    title(main="(c) No duration model",adj=0,cex.main=2);
    mtext(text="duration",side=1,line=2.2,cex=1.2);
    
    if(save.plot==TRUE) dev.off();
    
    ## Plots of Dunn-Smyth (DS) residuals for occupancy only (Figure 3 in ms).  
    
    res1<-residuals.occMod(m1);
    m1_res_occ<-res1$occ;
    m1_res_det<-res1$det[is.na(res1$det)==FALSE];
    
    res2<-residuals.occMod(m2);
    m2_res_occ<-res2$occ;
    m2_res_det<-res2$det[is.na(res2$det)==FALSE];
    
    res3<-residuals.occMod(m3);
    m3_res_occ<-res3$occ;
    m3_res_det<-res3$det[is.na(res3$det)==FALSE];
    
    res4<-residuals.occMod(m4);
    m4_res_occ<-res4$occ;
    m4_res_det<-res4$det[is.na(res4$det)==FALSE];
    
    save.plot.name<-paste('example_squirrels3',".png",sep="");
    if(save.plot==TRUE) png(save.plot.name,width=900,height=1080);
    
    layout(matrix(c(1,2,3,4,17,18,5,6,7,8,19,20,9,10,11,12,21,22,13,14,15,16,23,24),ncol=4,nrow=6,byrow=F));
    par(mar=c(4,4.1,1,0.5));
    
    ## Dunn-Smyth (DS) residuals for occupancy for each model.
    
    m1_x_occ<-m1$real$psi[,1];
    if(want.logit==T){m1_x_occ<-Logit(m1_x_occ);}
    
    DS.resid.plot(m1_x_occ,m1_res_occ);
    title(main="Full model",cex.main=1.5);
    mtext(text="(a)",at=2.5,side=2,las=2,line=2.1,cex=1.3);
    
    DS.resid.plot(m1_x_occ,m1_res_occ,c(-0.5,0.5));
    mtext(text="(b)",at=0.5,side=2,las=2,line=2.1,cex=1.3);
    
    plot(m1_x_occ,m1_res_occ,ylim=c(-3.8,3.8),xaxt='n',yaxt='n',ylab="",xlab="",type="n",frame.plot=F);
    mtext(text="(c)",at=4,side=2,las=2,line=2.1,cex=1.3);
    
    qqnorm(m1_res_occ,col="blue",pch=16,ylab="",xlab="",cex.axis=1.5,main="");
    abline(0,1,col="black");
    mtext(text="(d)",at=2.8,side=2,las=2,line=2.1,cex=1.3);
    
    m2_x_occ<-m2$real$psi[,1];
    if(want.logit==T){m2_x_occ<-Logit(m2_x_occ);}
    DS.resid.plot(m2_x_occ,m2_res_occ);
    title(main="No elevation model",cex.main=1.5);
    
    DS.resid.plot(m2_x_occ,m2_res_occ,c(-0.5,0.5));
    
    m2_x_occ<-elev;
    DS.resid.plot(m2_x_occ,m2_res_occ,c(-0.5,0.5));
    mtext(text="elevation",side=1,line=2.4,cex=1.5);
    
    qqnorm(m2_res_occ,col="blue",pch=16,ylab="",xlab="",cex.axis=1.5,main="");
    abline(0,1,col="black");
    
    m3_x_occ<-m3$real$psi[,1];
    if(want.logit==T){m3_x_occ<-Logit(m3_x_occ);}
    DS.resid.plot(m3_x_occ,m3_res_occ,NULL);
    title(main="No quadratic model",cex.main=1.5);
    
    DS.resid.plot(m3_x_occ,m3_res_occ,c(-0.5,0.5));
    
    m3_x_occ<-elev;
    DS.resid.plot(m3_x_occ,m3_res_occ,c(-0.5,0.5));
    mtext(text="elevation",side=1,line=2.4,cex=1.5);
    
    qqnorm(m3_res_occ,col="blue",pch=16,ylab="",xlab="",cex.axis=1.5,main="");
    abline(0,1,col="black");
    
    m4_x_occ<-m4$real$psi[,1];
    if(want.logit==T){m4_x_occ<-Logit(m4_x_occ);}
    DS.resid.plot(m4_x_occ,m4_res_occ);
    title(main="No duration model",cex.main=1.5);
    
    DS.resid.plot(m4_x_occ,m4_res_occ,c(-0.5,0.5));
    
    m4_x_det<-apply(dur,1,mean)[is.na(res4$det)==FALSE];
    DS.resid.plot(m4_x_det,m4_res_det,c(-2,2));
    mtext(text="duration",side=1,line=2.4,cex=1.5);
    
    qqnorm(m4_res_det,col="blue",pch=16,ylab="",xlab="",cex.axis=1.5,main="");
    abline(0,1,col="black");
    
    ## Dunn-Smyth (DS) residuals for detection for each model.
    
    m1_x_det<-apply(matrix(m1$real$p[,1],ncol=K),1,sum,na.rm=T)[is.na(res1$det)==FALSE];
    DS.resid.plot(m1_x_det,m1_res_det,c(-2,2));
    mtext(text="(e)",at=2,side=2,las=2,line=2.1,cex=1.3);
    
    qqnorm(m1_res_det,main=expression(""),col="blue",pch=16,ylab="",xlab="",cex.axis=1.5);
    abline(0,1,col="black");
    mtext(text="(f)",at=2,side=2,las=2,line=2.1,cex=1.3);
    
    m2_x_det<-apply(matrix(m2$real$p[,1],ncol=K),1,sum,na.rm=T)[is.na(res2$det)==FALSE];
    DS.resid.plot(m2_x_det,m2_res_det,c(-2,2));
    
    qqnorm(m2_res_det,main=expression(""),col="blue",pch=16,ylab="",xlab="",cex.axis=1.5);
    abline(0,1,col="black");
    
    m3_x_det<-apply(matrix(m3$real$p[,1],ncol=K),1,sum,na.rm=T)[is.na(res3$det)==FALSE];
    DS.resid.plot(m3_x_det,m3_res_det,c(-2,2));
    
    qqnorm(m3_res_det,main=expression(""),col="blue",pch=16,ylab="",xlab="",cex.axis=1.5);
    abline(0,1,col="black");
    
    m4_x_det<-apply(matrix(m4$real$p[,1],ncol=K),1,sum,na.rm=T)[is.na(res4$det)==FALSE];
    DS.resid.plot(m4_x_det,m4_res_det,c(-2,2));
    
    qqnorm(m4_res_det,main=expression(""),col="blue",pch=16,ylab="",xlab="",cex.axis=1.5);
    abline(0,1,col="black");
    
    if(save.plot==TRUE) dev.off();
  }
  
  ## Make a table of GOF results.
  
  tab_comp.time<-cbind(t1,t2);
  rownames(tab_comp.time)<-c("Comp. time for full model");
  colnames(tab_comp.time)<-c("Bayesian P-value","DS residuals");
  
  gof_res<-list(tab_GOF=tab_GOF,tab_comp.time=tab_comp.time);
  return(gof_res);
}

## Diagnostic GOF measure function for the simulations.

occ_diagnostics_sim<-function(mods_rpres,n.sim.boot,umf_sim,s,K,bayes_parms,n.sim,want.logit=F,bayes.run=T,want.plot=T,save.plot=T)
{
  
  ## Extract data fromm the saved "umf" object.  
  
  y<-umf_sim@y;
  elev<-umf_sim@siteCovs$elev;
  forest<-umf_sim@siteCovs$forest;
  dur<-matrix(umf_sim@obsCovs$dur,ncol=K,byrow=T);
  date<-matrix(umf_sim@obsCovs$date,ncol=K,byrow=T);
  
  ## Extract models.
  
  m1<-mods_rpres[[1]];
  m2<-mods_rpres[[2]];
  m3<-mods_rpres[[3]];
  m4<-mods_rpres[[4]];
  
  ## AIC values for each of the four models.
  
  aic_values<-c(m1$aic,m2$aic,m3$aic,m4$aic);
  
  ## Extract the MacKenzie-Bailey GOF test via a parametric bootstrap.  
  
  if(n.sim.boot==1){MB_pvalues<-c(NA,NA,NA,NA);}
  
  if(n.sim.boot>1)
  {
    MB_crti_val<-c(m1$modfit$chi.sq,m2$modfit$chi.sq,m3$modfit$chi.sq,m4$modfit$chi.sq);
    MB_pvalues<-c(m1$modfit$p.value,m2$modfit$p.value,m3$modfit$p.value,m4$modfit$p.value);
  }
  
  ## Bayesian inference (bundle data set for WinBugs/JAGS).
  
  Bayes_pvalues<-c(NA,NA,NA,NA);
  t1<-c(NA);
  
  if(bayes.run==T)
  {
    params<-bayes_parms[[1]];
    ni<-bayes_parms[[2]];
    nt<-bayes_parms[[3]];
    nb<-bayes_parms[[4]];
    nc<-bayes_parms[[5]];
    
    win.data<-list(y=y,M=s,J=K,elev=elev,forest=forest,date=date,dur=dur);
    
    ## Run JAGS and fit each model.
    
    start<-Sys.time(); # Keep a track of the computational times ofr the full model.
    inits1<-function(){list(z=apply(y,1,max,na.rm=T),mean.psi=runif(1),mean.p=runif(1),alpha=rnorm(3),beta=rnorm(7));}
    out1<-try(jags(win.data,inits1,params,"mod_1.txt",n.chains=nc,n.thin=nt,n.iter=ni,n.burnin=nb),silent=TRUE);
    if(class(out1)!="try-error")
    {
      mod1_bayesP_pears.fitnew<-out1$BUGSoutput$sims.list$pears.fitnew;
      mod1_bayesP_pears.fit<-out1$BUGSoutput$sims.list$pears.fit;
    }
    if(class(out1)=="try-error")
    {
      mod1_bayesP_pears.fitnew<-NA;
      mod1_bayesP_pears.fit<-NA;
    }
    end<-Sys.time();
    t1<-difftime(end,start,units="secs");
    
    inits2<-function(){list(z=apply(y,1,max,na.rm=T),mean.psi=runif(1),mean.p=runif(1),alpha=rnorm(3),beta=rnorm(2));}
    out2<-try(jags(win.data,inits2,params,"mod_2.txt",n.chains=nc,n.thin=nt,n.iter=ni,n.burnin=nb),silent=TRUE);
    if(class(out2)!="try-error")
    {
      mod2_bayesP_pears.fitnew<-out2$BUGSoutput$sims.list$pears.fitnew;
      mod2_bayesP_pears.fit<-out2$BUGSoutput$sims.list$pears.fit;
    }
    if(class(out2)=="try-error")
    {
      mod2_bayesP_pears.fitnew<-NA;
      mod2_bayesP_pears.fit<-NA;
    }
    
    inits3<-function(){list(z=apply(y,1,max,na.rm=T),mean.psi=runif(1),mean.p=runif(1),alpha=rnorm(3),beta=rnorm(3));}
    out3<-try(jags(win.data,inits3,params,"mod_3.txt",n.chains=nc,n.thin=nt,n.iter=ni,n.burnin=nb),silent=TRUE);
    if(class(out3)!="try-error")
    {
      mod3_bayesP_pears.fitnew<-out3$BUGSoutput$sims.list$pears.fitnew;
      mod3_bayesP_pears.fit<-out3$BUGSoutput$sims.list$pears.fit;
    }
    if(class(out3)=="try-error")
    {
      mod3_bayesP_pears.fitnew<-NA;
      mod3_bayesP_pears.fit<-NA;
    }
    
    inits4<-function(){list(z=apply(y,1,max,na.rm=T),mean.psi=runif(1),mean.p=runif(1),alpha=rnorm(1),beta=rnorm(7));}
    out4<-try(jags(win.data,inits4,params,"mod_4.txt",n.chains=nc,n.thin=nt,n.iter=ni,n.burnin=nb),silent=TRUE);
    if(class(out4)!="try-error")
    {
      mod4_bayesP_pears.fitnew<-out4$BUGSoutput$sims.list$pears.fitnew;
      mod4_bayesP_pears.fit<-out4$BUGSoutput$sims.list$pears.fit;
    }
    if(class(out4)=="try-error")
    {
      mod4_bayesP_pears.fitnew<-NA;
      mod4_bayesP_pears.fit<-NA;
    }
    
    ## GOF Bayesian p-values.
    
    Bayes_pvalues<-c(mean(mod1_bayesP_pears.fitnew>mod1_bayesP_pears.fit,na.rm=T),
                     mean(mod2_bayesP_pears.fitnew>mod2_bayesP_pears.fit,na.rm=T),
                     mean(mod3_bayesP_pears.fitnew>mod3_bayesP_pears.fit,na.rm=T),
                     mean(mod4_bayesP_pears.fitnew>mod4_bayesP_pears.fit,na.rm=T));
  }
  
  ## Make a table of GOF results.
  
  tab_GOF<-cbind(aic_values,MB_pvalues,Bayes_pvalues);
  rownames(tab_GOF) <- c("Full model", "No Elevation model", "No Quadratics model", "No Duration model")
  colnames(tab_GOF)<-c("AIC","M & B GOF test P-value","Bayesian P-value");
  
  ## Obtain Dunn-Smyth (DS) residuals for occupancy and detection for the four models.  
  
  if(want.plot==T)
  {
    start<-Sys.time();
    res1<-residuals.occMod(m1);
    end<-Sys.time();
    t2<-difftime(end,start,units="secs");
    m1_res_occ<-res1$occ;
    m1_res_det<-res1$det[-which(is.na(res1$det))];
    
    res2<-residuals.occMod(m2);
    m2_res_occ<-res2$occ;
    m2_res_det<-res2$det[-which(is.na(res2$det))];
    
    res3<-residuals.occMod(m3);
    m3_res_occ<-res3$occ;
    m3_res_det<-res3$det[-which(is.na(res3$det))];
    
    res4<-residuals.occMod(m4);
    m4_res_occ<-res4$occ;
    m4_res_det<-res4$det[-which(is.na(res4$det))];
    
    ## Plots.
    
    save.plot.name<-paste('sim_k',K,'_s',s,'_',n.sim,".png",sep="");
    
    if(save.plot==TRUE) png(save.plot.name,width=900,height=1080);
    
    layout(matrix(c(1,2,3,4,17,18,5,6,7,8,19,20,9,10,11,12,21,22,13,14,15,16,23,24),ncol=4,nrow=6,byrow=F));
    par(mar=c(4,4.1,1,0.5));
    
    ## Dunn-Smyth (DS) residuals for occupancy and detection for the four models.
    
    m1_x_occ<-m1$real$psi[,1];
    if(want.logit==T){m1_x_occ<-Logit(m1_x_occ);}
    
    DS.resid.plot(m1_x_occ,m1_res_occ);
    title(main="Full model",cex.main=1.5);
    mtext(text="(a)",at=2.5,side=2,las=2,line=2.1,cex=1.3);
    
    DS.resid.plot(m1_x_occ,m1_res_occ,c(-0.5,0.5));
    mtext(text="(b)",at=0.5,side=2,las=2,line=2.1,cex=1.3);
    
    plot(m1_x_occ,m1_res_occ,ylim=c(-3.8,3.8),xaxt='n',yaxt='n',ylab="",xlab="",type="n",frame.plot=F);
    mtext(text="(c)",at=4,side=2,las=2,line=2.1,cex=1.3);
    
    qqnorm(m1_res_occ,col="blue",pch=16,ylab="",xlab="",cex.axis=1.5,main="");
    abline(0,1,col="black");
    mtext(text="(d)",at=2.8,side=2,las=2,line=2.1,cex=1.3);
    
    m2_x_occ<-m2$real$psi[,1];
    if(want.logit==T){m2_x_occ<-Logit(m2_x_occ);}
    DS.resid.plot(m2_x_occ,m2_res_occ);
    title(main="No elevation model",cex.main=1.5);
    
    DS.resid.plot(m2_x_occ,m2_res_occ,c(-0.5,0.5));
    
    m2_x_occ<-elev;
    DS.resid.plot(m2_x_occ,m2_res_occ,c(-0.5,0.5));
    mtext(text="elevation",side=1,line=2.4,cex=1.5);
    
    qqnorm(m2_res_occ,col="blue",pch=16,ylab="",xlab="",cex.axis=1.5,main="");
    abline(0,1,col="black");
    
    m3_x_occ<-m3$real$psi[,1];
    if(want.logit==T){m3_x_occ<-Logit(m3_x_occ);}
    DS.resid.plot(m3_x_occ,m3_res_occ,NULL);
    title(main="No quadratic model",cex.main=1.5);
    
    DS.resid.plot(m3_x_occ,m3_res_occ,c(-0.5,0.5));
    
    m3_x_occ<-elev;
    DS.resid.plot(m3_x_occ,m3_res_occ,c(-0.5,0.5));
    mtext(text="elevation",side=1,line=2.4,cex=1.5);
    
    qqnorm(m3_res_occ,col="blue",pch=16,ylab="",xlab="",cex.axis=1.5,main="");
    abline(0,1,col="black");
    
    m4_x_occ<-m4$real$psi[,1];
    if(want.logit==T){m4_x_occ<-Logit(m4_x_occ);}
    DS.resid.plot(m4_x_occ,m4_res_occ);
    title(main="No duration model",cex.main=1.5);
    
    DS.resid.plot(m4_x_occ,m4_res_occ,c(-0.5,0.5));
    
    m4_x_det<-apply(dur,1,mean)[is.na(res4$det)==FALSE];
    DS.resid.plot(m4_x_det,m4_res_det,c(-2,2));
    mtext(text="duration",side=1,line=2.4,cex=1.5);
    
    qqnorm(m4_res_det,col="blue",pch=16,ylab="",xlab="",cex.axis=1.5,main="");
    abline(0,1,col="black");
    
    ## Dunn-Smyth (DS) residuals for detection for each model.
    
    m1_x_det<-apply(matrix(m1$real$p[,1],ncol=K),1,sum,na.rm=T)[is.na(res1$det)==FALSE];
    DS.resid.plot(m1_x_det,m1_res_det,c(-2,2));
    mtext(text="(e)",at=2,side=2,las=2,line=2.1,cex=1.3);
    
    qqnorm(m1_res_det,main=expression(""),col="blue",pch=16,ylab="",xlab="",cex.axis=1.5);
    abline(0,1,col="black");
    mtext(text="(f)",at=2,side=2,las=2,line=2.1,cex=1.3);
    
    m2_x_det<-apply(matrix(m2$real$p[,1],ncol=K),1,sum,na.rm=T)[is.na(res2$det)==FALSE];
    DS.resid.plot(m2_x_det,m2_res_det,c(-2,2));
    
    qqnorm(m2_res_det,main=expression(""),col="blue",pch=16,ylab="",xlab="",cex.axis=1.5);
    abline(0,1,col="black");
    
    m3_x_det<-apply(matrix(m3$real$p[,1],ncol=K),1,sum,na.rm=T)[is.na(res3$det)==FALSE];
    DS.resid.plot(m3_x_det,m3_res_det,c(-2,2));
    
    qqnorm(m3_res_det,main=expression(""),col="blue",pch=16,ylab="",xlab="",cex.axis=1.5);
    abline(0,1,col="black");
    
    m4_x_det<-apply(matrix(m4$real$p[,1],ncol=K),1,sum,na.rm=T)[is.na(res4$det)==FALSE];
    DS.resid.plot(m4_x_det,m4_res_det,c(-2,2));
    
    qqnorm(m4_res_det,main=expression(""),col="blue",pch=16,ylab="",xlab="",cex.axis=1.5);
    abline(0,1,col="black");
    
    if(save.plot==TRUE) dev.off();
  }
  
  tab_comp.time<-cbind(t1,t2);
  rownames(tab_comp.time)<-c("Comp. time for full model");
  colnames(tab_comp.time)<-c("Bayesian P-value","DS residuals");
  
  gof_res<-list(tab_GOF=tab_GOF,tab_comp.time=tab_comp.time);
  return(gof_res);
}

