#' welcome function
#'
#' Test if package can be used and welcome to this package !
#' @export
welcome <- function(){
  print("You have successfully called welcome function from FEMPipeline R package !")
  print("Welcome aboard !!!")
}

#' tell me about you
#'
#' You are ? Idea is to check if arguments get accepted properly
#' @param name What's your name ?
#' @export
i_am <- function(name){
  print(paste("Hi ", name, ", Glad that you here !", sep = ""))
}