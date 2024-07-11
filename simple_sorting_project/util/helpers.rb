module Helpers
  def self.clear_screen
    clear_command = Gem.win_platform? ? 'cls' : 'clear'
    sleep(1)
    system(clear_command)
  end

  def self.visualize_count(numbers)
    sorted_numbers = Array.new(numbers.size, 0)

    numbers.each_with_index do |number, index|
      sleep_duration = case number.abs
                       when 0..10
                         0.1
                       when 11..100
                         0.02
                       else
                         0.03
                       end

      if number < 0
        0.downto(number) do |i|
          sorted_numbers[index] = i
          print "\rLista ordenada: [#{sorted_numbers.join(', ')}] "
          sleep(sleep_duration)
        end
      else
        0.upto(number) do |i|
          sorted_numbers[index] = i
          print "\rLista ordenada: [#{sorted_numbers.join(', ')}] "
          sleep(sleep_duration)
        end
      end
    end
    puts
  end

  def self.apply_prank(numbers)
    if numbers.size >= 6
      numbers[3], numbers[-1] = numbers[-1], numbers[3]
    end
    numbers
  end
end
