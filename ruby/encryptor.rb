class Encryptor
  def cipher(rotation)
    chars = (' '..'z').to_a
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
      letter == ' ' ? ' ' : encrypt_letter(letter, rotation)
    end
    encrypted_letters.join
  end

  def decrypt(string, rotation)
    encrypt(string, -rotation)
  end
end

e = Encryptor.new
puts e.encrypt('Hello World', 13)
