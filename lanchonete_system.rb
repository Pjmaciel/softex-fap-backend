require 'csv'


def add_order(next_id)
  puts "Adicionar novo pedido:"
  print "Nome do cliente: "
  customer_name = gets.chomp

  print "Item consumido: "
  consumed_item = gets.chomp

  print "Valor da compra: "
  purchase_amount = gets.chomp.to_f

  print "Status de pagamento (Pago/Pendura): "
  payment_status = gets.chomp

  [next_id, customer_name, consumed_item, purchase_amount, payment_status]
end

# Função para salvar ou atualizar pedidos no arquivo CSV
def save_order_to_csv(order, file_name = "orders.csv")
  customer_exists = false
  orders = []

  # Certifique-se de que o arquivo CSV exista e tenha um cabeçalho
  unless File.exist?(file_name)
    CSV.open(file_name, "w") do |csv|
      csv << ["ID", "Nome do Cliente", "Item Consumido", "Valor da Compra", "Status de Pagamento"]
    end
  end

  # Carregar pedidos existentes
  CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
    if row[:nome_do_cliente] == order[1]
      customer_exists = true
      row[:item_consumido] += ", #{order[2]}"
      if order[4].downcase == "pendura"  # Only add the amount if the payment status is "Pendura"
        row[:valor_da_compra] = row[:valor_da_compra].to_f + order[3]
      end
    end
    orders << row.to_hash
  end

  unless customer_exists
    orders << {
      id: order[0],
      nome_do_cliente: order[1],
      item_consumido: order[2],
      valor_da_compra: order[3],
      status_de_pagamento: order[4]
    }
  end


  CSV.open(file_name, "w") do |csv|
    # Add the header
    csv << ["ID", "Nome do Cliente", "Item Consumido", "Valor da Compra", "Status de Pagamento"]
    # Add all updated orders
    orders.each { |o| csv << o.values }
  end

  puts "Pedido salvo com sucesso! ✔️"
end

# Function to determine the next ID
def next_id(file_name = "orders.csv")
  return 1 unless File.exist?(file_name)

  ids = []
  CSV.foreach(file_name, headers: true) do |row|
    ids << row["ID"].to_i
  end

  ids.max + 1
end

def lanchonete_system
  puts "Bem-vindo a lanchonete PagueouDev "
  loop do
    puts "Selecione uma opção:"
    puts "1. Adicionar pedido"
    puts "2. Sair"
    print "Opção: "
    option = gets.chomp.to_i

    if option == 1
      id = next_id
      order = add_order(id)
      save_order_to_csv(order)
    elsif option == 2
      puts "Saindo... Obrigado e volte sempre!"
      break
    else
      puts "Opção inválida! Tente novamente❗"
    end
  end
end

# main
lanchonete_system
