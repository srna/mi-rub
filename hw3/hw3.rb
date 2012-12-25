require_relative 'bst'

def test 
	bst = BSTSet.new
  # prvni radek me nezajima :-)
	line = gets
	while(line = gets)
	  comm = line.split(' ')
		if(comm[0] == "ADD")
		  i = comm[1].to_i
			puts "ADD #{i}"
			bst << i
			# Zjisti jak hluboko je dany prvek vlozen v BST
			puts "b[#{i}] == #{bst[i]}"
			# Zjisti kolikrat byla hodnota do mnoziny vlozena
			puts "b(#{i}) == #{bst.get_count(i)}"
		else 
			puts "Parse error! #{comm[0]}"
			exit(1)
		end
	end
	puts bst
end

test
