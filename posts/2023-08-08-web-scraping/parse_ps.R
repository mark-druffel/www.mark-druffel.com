library(tidyverse)
images <- system(glue::glue("echo {Sys.getenv('SUDO_PWD')} | sudo -S docker ps"), ignore.stdout = F, intern = T)
ips <- as_tibble(str_locate(images, pattern = "[0-9]??\\.[0-9]??\\.[0-9]??\\.[0-9]??:"))
ips <- pmap_dfr(list(i = images[2:5], s = ips[2:5, ]$start, e = ips[2:5, ]$end), function(i, s, e){
  ip <- str_sub(i, start = s, end = e-1)
  tibble(ip = ip)
})
names <- as_tibble(str_locate(images, pattern = "selenium.*firefox:[a-z0-9]+(?:[._-][a-z0-9]+)*|selenium.*firefox-debug:[a-z0-9]+(?:[._-][a-z0-9]+)*"))
names <- pmap_dfr(list(i = images[2:5], s = names[2:5, ]$start, e = names[2:5, ]$end), function(i, s, e){
  name <- str_sub(i, start = s, end = e)
  tibble(name = name)-vs
}) 
docker <- bind_cols(names, ips) |> 
  bind_cols(images[2:5]) |> 
  rename("ps" = 3L)
docker |> 
  filter(str_detect(name, pattern = "latest|firefox:4."))
