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

    private

    def downcase_article # make case-insensitive
        self.article = article.to_s.downcase
    end
end
