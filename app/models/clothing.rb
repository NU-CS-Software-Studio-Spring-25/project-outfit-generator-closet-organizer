class Clothing < ApplicationRecord
    has_one_attached :image
    belongs_to :user, optional: true
    has_many :hidden_by_users, through: :hidden_clothings, source: :user
    has_many :hidden_clothings, dependent: :destroy


    before_validation :downcase_article
    validates :article, presence: true, inclusion: {
        in: %w[top bottom],
            message: "%{value} is not valid. Please categorize this item as either a 'top' or 'bottom'"

    }
    validate :image_presence
    validate :acceptable_image

    private

    def downcase_article # make case-insensitive
        self.article = article.to_s.downcase
    end

    def image_presence
        errors.add(:image, "You must add an image of this item.") unless image.attached?
      end

    def acceptable_image
        return unless image.attached?

        acceptable_types = ["image/png", "image/jpeg", "image/jpg", "image/heic"]

        unless acceptable_types.include?(image.content_type)
            errors.add(:image, "must be a PNG, JPG, or HEIC file")
        end
    end
end
