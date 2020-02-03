class User < ApplicationRecord
	has_many :articles, dependent: :destroy
	before_save { self.email = email.downcase }
	

	validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
	has_secure_password
	validate :profile_image_size

	mount_uploader :profile_image, ImageUploader

	private
	def profile_image_size
		if profile_image.size > 5.megabytes
			errors.add(:profile_image, "should be less than 5MB")
		end
	end
end
