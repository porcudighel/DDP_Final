# App https://porcudighel.shinyapps.io/ddp_final_app/

data("airquality")
str(airquality)
pairs(airquality)

sol <- "Solar.R"
formula <- paste0("Ozone ~ ", sol)
model <- lm(formula, data = airquality)
model_pred <- predict(model, airquality)
with(airquality, plot(Solar.R, Ozone))
with(airquality, abline(model, col = "red", lwd =2))

paste("Ozone ~",NULL, sep = "+")


sol = F
tem = F
win = F

params <- NULL
if (sol){params <- c(params,"Solar.R")}
if (tem){params <- c(params,"Temp")}
if (win){params <- c(params,"Wind")}
form_mod <- paste0("Ozone ~ ",paste(params, collapse = " + "))
model <- lm(form_mod, data = airquality)
model_pred <- predict(model, airquality)
AAA <- list(form_mod,model,model_pred)
AAA[[2]]

with(airquality, plot(Solar.R, Ozone))
with(airquality, points(Solar.R, AAA[[3]], col = "red", lwd =2))
legend("topleft", c("Original", "Predicted"), pch = 16, 
       col = c("blue", "red"), cex = 1.2)

mod_summ <- summary(model)
coeff <- mod_summ$coefficients
colnames(coeff)
row.names(coeff)
TTT <- cbind(row.names(coeff), coeff)
colnames(TTT)
mod_summ$r.squared

as.table(matrix(c(0,0,0,0),ncol = 4))  
