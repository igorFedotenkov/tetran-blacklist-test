customers = [{ name: 'Иван Петров', phone: '2128506', description: 'seed customer', blacklist: false},
             { name: 'Петр Иванов', phone: '2128507', description: 'seed customer', blacklist: false},
             { name: 'Олег Серов', phone: '2128508', description: 'seed customer', blacklist: false},
             { name: 'Влад Летов', phone: '2128509', description: 'seed customer', blacklist: false},
             { name: 'Егор Топалов', phone: '2128510', description: 'seed customer', blacklist: false},
             { name: 'Сергей Васильев', phone: '2128511', description: 'seed customer', blacklist: false},]

customers.each do |c|
  Customer.create name: c[:name], phone: c[:phone], description: c[:description], blacklist: c[:blacklist]
end