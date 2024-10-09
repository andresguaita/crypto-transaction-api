class AddInitialUsers < ActiveRecord::Migration[6.1]
  def up
    password1 = BCrypt::Password.create('password123')
    password2 = BCrypt::Password.create('password456')
    password3 = BCrypt::Password.create('password789')

    execute <<-SQL
      INSERT INTO users (name, email, password_digest, balance,created_at, updated_at)
      VALUES
        ('John Doe', 'john.doe@example.com', '#{password1}', 1000 ,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
        ('Andres Guzman', 'andres.guzman@example.com', '#{password2}', 1000 ,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
        ('Diego De La Vega', 'diego.delavega@example.com', '#{password3}', 100 ,CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    SQL
  end

  def down
    execute "DELETE FROM users"
  end
end
