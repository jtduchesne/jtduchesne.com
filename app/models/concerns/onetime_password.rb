# frozen_string_literal: true
module OnetimePassword
  class MinimumLengthError < StandardError; end
  
  MINIMUM_OTP_LENGTH = 4
  ALPHABET = ("A".."Z").to_a
  
  extend ActiveSupport::Concern
  
  class_methods do
    def has_onetime_password(attribute = :otp, length: MINIMUM_OTP_LENGTH)
      if length < MINIMUM_OTP_LENGTH
        raise MinimumLengthError, "One-time password requires a minimum length of #{MINIMUM_OTP_LENGTH} characters."
      end
      
      begin
        require "bcrypt"
      rescue LoadError
        $stderr.puts "You don't have bcrypt installed in your application. Please add it to your Gemfile and run bundle install"
        raise
      end
      require "securerandom"
      
      attr_accessor attribute
      column = "#{attribute}_digest"
      
      define_method("generate_onetime_password") do
        password = self.class.generate_random_letters(length: length)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        update_columns column => BCrypt::Password.create(password, cost: cost)
        public_send("#{attribute}=", password)
      end
      
      define_method("authenticate_#{attribute}") do |unencrypted_password|
        unencrypted_password = unencrypted_password.to_s.upcase
        digest = public_send(column)
        unless digest.nil?
          if unencrypted_password.length == length
            if BCrypt::Password.new(digest).is_password?(unencrypted_password)
              update_columns column => nil
              return self
            else
              errors.add(attribute, :invalid)
            end
          else
            errors.add(attribute, :wrong_length, count: length)
          end
        end
        nil
      end
      alias_method :authenticate, :authenticate_otp if attribute == :otp
    end
    
    def generate_random_letters(length: MINIMUM_OTP_LENGTH)
      SecureRandom.random_bytes(length).unpack("C*").map do |byte|
        idx = byte % 64
        idx = SecureRandom.random_number(26) if idx >= 26
        ALPHABET[idx]
      end.join
    end
  end
end
