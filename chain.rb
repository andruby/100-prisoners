# In the chain run, we can do 100 prisoners since we don't need a high sample_count
COUNT = 100
PICKS = COUNT/2
SAMPLE_COUNT = 1000

def prisoner_finds_himself(prisoner_number, array)
  pick = prisoner_number
  1.upto(PICKS) do |_|
    number_in_box = array[pick-1]
    return true if number_in_box == prisoner_number
    pick = number_in_box
  end
  false
end

def all_prisoners_find_themselves(array)
  (1..COUNT).all? do |prisoner_number|
    prisoner_finds_himself(prisoner_number, array)
  end
end

true_count = 0


p Time.now
puts "running #{SAMPLE_COUNT} samples with #{COUNT} prisoners, #{PICKS} picks per prisoner"

SAMPLE_COUNT.times do
  # We do need to shuffle the array for every sample, because the prisoners strategy is deterministic
  array = (1..COUNT).to_a.shuffle
  true_count += 1 if all_prisoners_find_themselves(array)
end

puts "They found themselves #{true_count} times out of #{SAMPLE_COUNT}"
puts "That's #{(true_count / SAMPLE_COUNT.to_f) * 100} %"

p Time.now
