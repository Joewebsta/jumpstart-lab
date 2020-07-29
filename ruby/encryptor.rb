class Encryptor
  def run_program
    intro_message
    objective = ask_for_user_objective
    message = ask_for_message
    rotation = ask_for_rotation

    run_encryption(message, rotation) if objective == 1
    run_decryption(message, rotation) if objective == 2
  end

  def intro_message
    puts 'Welcome to the Encryptor program'
  end

  def ask_for_message
    puts 'What is your message?'
    gets.chomp
  end

  def ask_for_rotation
    puts 'What is your rotation value?'
    gets.chomp.to_i
  end

  def ask_for_user_objective
    puts 'What would you like to do? Please select an option:'
    puts '1 - Encrypt a message.'
    puts '2 - Decrypt a message.'
    gets.chomp.to_i
  end

  def run_encryption(message, rotation)
    encrypted_message = encrypt(message, rotation)
    display_results(encrypted_message, 'e')
  end

  def run_decryption(message, rotation)
    decrypted_message = decrypt(message, rotation)
    display_results(decrypted_message, 'd')
  end

  def display_results(message, type)
    message_type = (type == 'e' ? 'encrypted' : 'decrypted')
    puts "Your #{message_type} message is: #{message}"
  end

  def cipher(rotation)
    chars = (' '..'z').to_a
    # chars = ('a'..'z').to_a + ('A'..'Z').to_a
    rotated_chars = chars.rotate(rotation)
    Hash[chars.zip(rotated_chars)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(string, rotation)
    letters = string.split('')
    encrypted_letters = letters.map do |letter|
      # letter == ' ' ? ' ' : encrypt_letter(letter, rotation)
      encrypt_letter(letter, rotation)
    end
    encrypted_letters.join
  end

  def decrypt(string, rotation)
    encrypt(string, -rotation)
  end

  def encrypt_file(filename, rotation)
    file_text = File.open(filename, 'r').read
    output = encrypt(file_text, rotation)

    encrypted_file = File.open(filename + '.encrypted', 'w')
    encrypted_file.write(output)
    encrypted_file.close
  end

  def decrypt_file(filename, rotation)
    file_text = File.open(filename, 'r').read
    output = encrypt(file_text, -rotation)

    output_filename = filename.gsub('encrypted', 'decrypted')
    decrypted_file = File.open(output_filename, 'w')
    decrypted_file.write(output)
    decrypted_file.close
  end

  def supported_characters
    (' '..'z').to_a
  end

  def crack(string)
    supported_characters.length.times.map { |attempt| "Attempt #{attempt + 1}: #{decrypt(string, attempt)}" }
  end
end

e = Encryptor.new
e.run_program

# puts e.encrypt('Hello world', 13)
# puts e.encrypt_file('secret.txt', 13)
# puts e.decrypt_file('secret.txt.encrypted', 13)
# e.crack('f w)0/6X0// -6C6` ''46j$( ')
# puts e.crack('\\qmz&%,N&%%q#,9,Vqxx*,`uyq')
