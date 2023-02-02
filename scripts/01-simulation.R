#### Simulate ####
set.seed(853)
# a seed enables us to always generate the same random data whenever we run the same code.

simulated_shelter_data <-
  tibble(
    date = rep(x = as.Date("2022-02-02") + c(0:364), times = 3),
    # rep() -> repeat something a certain number of times
    shelter = c(
      rep(x = "Shelter 1", times = 365),
      rep(x = "Shelter 2", times = 365),
      rep(x = "Shelter 3", times = 365)
    ),
    number_occupied =
      rpois(
        n = 365 * 3,
        lambda = 30
      ) # Draw 1,095 times from the Poisson distribution
  )

simulated_shelter_data
