class Clothing < ApplicationRecord
    has_one_attached :image
    belongs_to :user, optional: true

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
