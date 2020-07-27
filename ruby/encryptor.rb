class Encryptor
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

  def crack(string)
    (1..91).each { |idx| puts decrypt(string, idx) }
  end
end

e = Encryptor.new
puts e.encrypt('Hello world', 13)
# puts e.encrypt_file('secret.txt', 13)
# puts e.decrypt_file('secret.txt.encrypted', 13)
e.crack('f w)0/6X0// -6C6` ''46j$( ')
