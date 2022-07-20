# Note that running with 100 prisoners would require a huuuge sampling_count,
# so I've limited it to 10 prisoners, which should return 0.5**10 = 0.09765625 %
COUNT = 10
PICKS = COUNT/2
SAMPLE_COUNT = 30_000

array = (1..COUNT).to_a.shuffle

def prisoner_finds_himself(prisoner_number, array)
  choices = array.dup
  1.upto(PICKS) do |_|
    pick = rand(0..(choices.size-1))
    return true if choices[pick] == prisoner_number
    choices.delete_at(pick)
  end
  false
end

def all_prisoners_find_themselves(array)
  (1..COUNT).all? do |prisoner_number|
    prisoner_finds_himself(prisoner_number, array)
  end
end

p Time.now
puts "running #{SAMPLE_COUNT} samples with #{COUNT} prisoners, #{PICKS} picks per prisoner"

true_count = 0
SAMPLE_COUNT.times do
  true_count += 1 if all_prisoners_find_themselves(array)
end

puts "They found themselves #{true_count} times out of #{SAMPLE_COUNT}"
puts "That's #{(true_count / SAMPLE_COUNT.to_f) * 100} %"

p Time.now
