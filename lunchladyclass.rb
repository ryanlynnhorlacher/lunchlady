class Food
	@@total_price = 0
	@@total_fat = 0
	@@total_calories = 0
	@@items_selected = []
	attr_accessor :name, :price, :description, :fat,
				  :calories
	def initialize(name, price, description, fat, calories)
		@name = name
		@price = price
		@description = description
		@fat = fat
		@calories = calories
	end
	def total_price
		@@total_price.to_f
	end
	def user_select
		@@total_price += @price
		@@total_fat += @fat
		@@total_calories += @calories
	end
	def user_remove
		@@total_price -= @price
		@@total_fat -= @fat
		@@total_calories -= @calories
	end
	def order_details
		puts "Total  \$#{@@total_price}"
		puts "Fat: #{@@total_fat}"
		puts "Calories: #{@@total_calories}"
		puts '-----------------'
	end



end

@entrees = [
	Food.new('Hamburger', 3.00, 'Grilled perfection on a toasted bun', 14, 400),
	Food.new('Ribeye', 10.00, 'A ribeye in a lunch room?', 17, 300),
	Food.new('Grilled Cheese', 3.00, 'White bread and pepper jack cheese', 12, 200)
]

@sides = [
	Food.new('Fries', 1.50, 'Golden and crispy', 20, 500),
    Food.new('Fruit', 3.00, 'Apples, strawberries, and blueberries', 2, 180),
    Food.new('Mac and Cheese', 2.00, 'Homemade with a four-cheese blend', 5, 100)
]

@customer_order = []
@wallet = 0
def greeting
	puts ' Welcome to the lunch room!'
	puts '---------------------------'
	puts 'COMMANDS: description, nutrition, view order ,remove item,'
	puts 'check out, new order, or quit'
	puts '---------------------------------------------------'
	puts 'To get started, how much do you have in your wallet?'
	while true
		@wallet = gets.to_f
		@wallet > 0 ? break : puts('Please enter a number larger than 0.')
	end
end

def menu_selection(menu)
	if menu == @entrees
		puts 'Entree menu: Enter selection or command'
		item_number = 1
		@entrees.each do |item|
			puts "#{item_number}. #{item.name}"
			item_number += 1
		end
		user_input = gets.strip
		options(user_input, @entrees)
	else
		puts 'Side menu: Enter selection or command'
		item_number = 1
		@sides.each do |item|
			puts "#{item_number}. #{item.name}"
			item_number += 1
		end
		user_input = gets.strip
		options(user_input, @sides)
	end
end


def add_to_menu(user_input, menu)
	@customer_order.push(menu[user_input.to_i - 1])
	menu[user_input.to_i - 1].user_select
	puts 'Choose your next item. (entree, side, or print for other options)'
	user_input = gets.strip
	options(user_input, menu)
	end



def checkout(menu)
	@customer_order.each do |item|
		puts "#{item.name}. . .\$#{item.price}"
	end
	@entrees[0].order_details
	if @entrees[0].total_price > @wallet
		puts "Oops, your total is \$#{@entrees[0].total_price},"
		puts "but you only have \$#{@wallet.to_f}"
		puts 'Use "remove item" to change your total.'
		user_input = gets.strip
		options(user_input, menu)
	else
		puts 'New order? (y/n)'
		user_input = gets.strip
		case user_input
			when /y.*/
			menu_selection(@entrees)
			customer_order = []
			when /n.*/
			puts 'Thank you, come again!'
			exit(0)
		end
	end
end

def options(user_input, menu)
		case user_input.downcase.strip
			when /des.*/
				puts "Enter item number"
				item = gets.to_i 
				if item > menu.count || item <= 0
					puts 'Not a valid menu choice, please choose a number'
					options('des', menu)
				else
					puts menu[item - 1].description
					puts '--------------------------------'
					menu_selection(menu)
				end
			when /nut.*/
				puts 'Which item?'
				item = gets.to_i
				if item > menu.count || item <= 0
					puts 'Not a valid menu choice, please choose a number'
					options('nut', menu)
				else
					puts "Fat: #{menu[item.to_i - 1].fat}"
					puts "Calories: #{menu[item.to_i - 1].calories}"
					menu_selection(menu)
				end
			when /^che.*/
				checkout(menu)
			when /new.*/
				puts 'New order started:'
				@customer_order = []
				menu_selection(@entrees)
			when /q.*/
				puts 'Thank you for your business!'
				exit(0)
			when /[0-9]/
				add_to_menu(user_input.to_i, menu)
			when /en.*/
				menu_selection(@entrees)
			when /si.*/
				menu_selection(@sides)
			when /pri.*/
				puts '------------------'
				puts 'description'
				puts 'nutrition'
				puts 'checkout'
				puts 'new order'
				puts 'quit'
				puts 'side'
				puts 'entree'
				puts 'view order'
				puts 'remove item'
				puts '------------------'
				menu_selection(menu)
			when /vie.*/
				puts 'Order details:'
				@customer_order.each do |item|
					puts "#{item.name}. . .\$#{item.price}"
				end
				@entrees[0].order_details
				menu_selection(menu)
			when /rem.*/
				@entrees[0].order_details
				puts 'Which item would you like to remove?'
				item_number = 1
				@customer_order.each do |item|
					puts "#{item_number}. #{item.name}. . .\$#{item.price}"
					item_number += 1
				end
				item = gets.strip
				if item.to_i > menu.count || item.to_i <= 0
					puts 'Not a valid menu choice, please choose a number'
					options('rem', menu)
				else
					puts "#{@customer_order[item.to_i - 1].name} removed."
					@customer_order.delete_at(item.to_i - 1)
					@entrees[0].user_remove
					menu_selection(menu)
				end

			else
				puts 'Please enter a valid menu choice'
				user_input = gets.strip
				options(user_input, menu)
		end
end

greeting
menu_selection(@entrees)




