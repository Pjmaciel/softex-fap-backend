require_relative 'lib/selection_sort'
require_relative 'util/helpers'

numbers = []
index = 1

loop do
  Helpers.clear_screen
  puts "Digite o #{index}º número (ou digite 'sair' para finalizar):"
  input = gets.chomp
  break if input.downcase == 'sair'

  if input.match?(/^-?\d+(\.\d+)?$/)
    numbers << input.to_i
    index += 1
    Helpers.clear_screen
  else
    puts "Entrada inválida. Por favor, digite um número."
    sleep(1)
    Helpers.clear_screen
  end
end

Helpers.clear_screen
puts "Números inseridos: #{numbers.join(', ')}"

if !numbers.empty?
  puts "Deseja ordenar os números? (sim/não)"
  answer = gets.chomp.downcase
  if answer == 'sim'
    Helpers.clear_screen
    sorted_numbers = selection_sort(numbers)
    prank_numbers = Helpers.apply_prank(sorted_numbers.dup)

    puts "Visualizando contagem até os números ordenados..."
    Helpers.visualize_count(prank_numbers)

    loop do
      puts "\nNúmeros ordenados com sucesso! Digite 'sair' para finalizar o programa."
      input = gets.chomp.downcase
      if input == 'sair'
        Helpers.clear_screen
        sleep(1)
        if numbers.size >= 4
          puts "Espera aí, está errado!"
          sleep(1)
          # Mostrar a lista correta
          sorted_numbers = selection_sort(numbers)
          puts "A lista correta é: #{sorted_numbers.join(', ')} "
          sleep(1)
          puts "Agora Sim ;)"
          sleep(0.5)
          puts "Programa finalizado."
        else
          puts "Programa finalizado."
        end
        break
      else
        puts "Você deve digitar 'sair' para finalizar o programa."
      end
    end
  else
    puts "Você escolheu não ordenar os números."
    sleep(1)
    Helpers.clear_screen
  end
else
  puts "Nenhum número foi inserido."
  sleep(1)
  Helpers.clear_screen
end
