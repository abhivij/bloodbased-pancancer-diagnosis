get_file_path <- function(file_name, dir_name){
  if (dir_name == "") {
    file_path <- file_name
  }
  else {
    file_path <- paste(dir_name, file_name, sep = "/")
  }
  return (file_path)
}