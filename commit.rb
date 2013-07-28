require 'date'

file = File.read('pattern.txt')
flat_pattern = file.split("\n").map{|line| line.split(//)}.transpose.map(&:join).join

start_date = Date.new(2012,7,22)
end_date = Date.new(2013,9,1)

dates = start_date.upto(end_date).to_a

commit_dates = []
dates.each_with_index do |date, index|
  if flat_pattern[index] == 'A'
    100.times{|i| commit_dates << date.to_time + (4*3600) + (i * 360)}
  end
end

str_commit_dates = commit_dates.map(&:to_s)

commit_dates.each do |date|
  puts date
  File.open('output.txt', 'w') { |f| f << str_commit_dates.shuffle.first(12).join("\n") }
  `GIT_AUTHOR_DATE="#{date}" GIT_COMMITTER_DATE="#{date}" git commit -am "#{date}"`
end
