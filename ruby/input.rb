def array_random_n_numbers(n, range = 100_000)
  (1..n).map { |_| rand(range) }
end
